package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.misc.Subhint;
   import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.misc.JsonUtil;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filesystem.File;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import mx.formatters.DateFormatter;
   
   public class SubhintEditorManager
   {
      
      private static var _self:SubhintEditorManager;
      
      public static var subhintDictionary:Dictionary = new Dictionary();
       
      
      private var _log:Logger;
      
      private var _loader:URLLoader;
      
      private var _request:URLRequest;
      
      private var _baseURL:String = "http://docker-dofus:8081/dofus/hints/";
      
      private var _hintToDelete:Object;
      
      private var _hintsToUpdate:Array;
      
      private var _result:Object;
      
      private var _putRequest:Boolean = true;
      
      private var _operation:String;
      
      private var _previousParent:Object;
      
      private var _callback:Function;
      
      public function SubhintEditorManager()
      {
         this._log = Log.getLogger(getQualifiedClassName(SubhintEditorManager));
         this._hintToDelete = {};
         this._hintsToUpdate = [];
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : SubhintEditorManager
      {
         if(!_self)
         {
            _self = new SubhintEditorManager();
         }
         return _self;
      }
      
      public function init() : void
      {
         this.getSubhints();
      }
      
      public function reset() : void
      {
         this._loader = null;
         this._request = null;
         this._hintToDelete = {};
         this._hintsToUpdate = [];
         this._result = null;
         this._previousParent = {};
      }
      
      public function getSubhintById(id:int) : void
      {
         this._request = new URLRequest(this._baseURL + id);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.GET;
         this.loadRequest(this._request,this.onGetByIdRequestComplete);
      }
      
      public function getSubhints() : void
      {
         this._request = new URLRequest(this._baseURL);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.GET;
         this.loadRequest(this._request,this.onGetRequestComplete);
      }
      
      public function postSubhints(data:Object = null) : void
      {
         this._operation = "modify";
         data.user = File.userDirectory.name;
         this._request = new URLRequest(this._baseURL);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.POST;
         this._request.data = JsonUtil.toJson(data);
         this.loadRequest(this._request,this.onPostRequestComplete);
      }
      
      public function putSubhints(data:Object) : void
      {
         this._putRequest = true;
         this._operation = "modify";
         if(data.previousParent)
         {
            this._previousParent = data;
         }
         data.user = File.userDirectory.name;
         this._request = new URLRequest(this._baseURL + data.hint_id);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.PUT;
         this._request.data = JsonUtil.toJson(data);
         this.loadRequest(this._request,this.onPutRequestComplete);
      }
      
      public function moveSubhint(data:Object) : void
      {
         this._operation = "move";
         data.user = File.userDirectory.name;
         this._request = new URLRequest(this._baseURL + data.hint_id);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.PUT;
         this._request.data = JsonUtil.toJson(data);
         this.loadRequest(this._request,this.onMoveRequestComplete);
      }
      
      public function deleteSubhint(data:Object) : void
      {
         this._hintToDelete = data;
         this._operation = "delete";
         data.user = File.userDirectory.name;
         this._request = new URLRequest(this._baseURL + data.hint_id);
         this._request.contentType = "application/json";
         this._request.method = URLRequestMethod.DELETE;
         this._request.data = JsonUtil.toJson(data);
         this.loadRequest(this._request,this.onDeleteRequestComplete);
      }
      
      private function loadRequest(request:URLRequest, callback:Function) : void
      {
         this._callback = callback;
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this._callback);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onStatus);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.load(request);
      }
      
      private function endLoadingRequest() : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this._callback);
         this._loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onStatus);
         this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader = null;
      }
      
      private function onGetByIdRequestComplete(e:Event) : void
      {
         this.endLoadingRequest();
         var loaderComplete:URLLoader = URLLoader(e.currentTarget);
         try
         {
            this._result = JsonUtil.fromJson(loaderComplete.data);
            this.updateHintsAfterOperation();
         }
         catch(e:Error)
         {
            _log.error("Can\'t decode Json subhint file");
         }
         if(this._result == null)
         {
            this._log.error("An error has occured, no file was found");
         }
      }
      
      private function onGetRequestComplete(e:Event) : void
      {
         var result:Object = null;
         this.endLoadingRequest();
         var loaderComplete:URLLoader = URLLoader(e.currentTarget);
         try
         {
            result = JsonUtil.fromJson(loaderComplete.data);
            this.createSubhintDictionary(result);
         }
         catch(e:Error)
         {
            _log.error("Can\'t decode Json subhint file");
         }
         if(result == null)
         {
            this._log.error("An error has occured, no file was found");
         }
      }
      
      private function onPostRequestComplete(e:Event) : void
      {
         var result:Object = null;
         this.endLoadingRequest();
         var loaderComplete:URLLoader = URLLoader(e.currentTarget);
         try
         {
            result = JsonUtil.fromJson(loaderComplete.data);
            if(result == null)
            {
               this._log.error("An error has occured, no file was found");
            }
            else
            {
               this.getSubhintById(result.hint_id);
            }
         }
         catch(e:Error)
         {
            _log.error("Can\'t decode Json subhint file");
         }
      }
      
      private function onPutRequestComplete(e:Event) : void
      {
         this.endLoadingRequest();
         var result:Object = JsonUtil.fromJson(this._request.data.toString());
         try
         {
            if(result == null)
            {
               this._log.error("An error has occured, no file was found");
            }
            else
            {
               this.getSubhintById(result.hint_id);
            }
         }
         catch(e:Error)
         {
            _log.error("error : " + e.name + ", " + e.getStackTrace());
         }
      }
      
      private function onMoveRequestComplete(e:Event) : void
      {
         this.endLoadingRequest();
         var result:Object = JsonUtil.fromJson(this._request.data.toString());
         try
         {
            if(result == null)
            {
               this._log.error("An error has occured, no file was found");
            }
            else
            {
               this.getSubhintById(result.hint_id);
            }
         }
         catch(e:Error)
         {
            _log.error("error : " + e.name + ", " + e.getStackTrace());
         }
      }
      
      private function onDeleteRequestComplete(e:Event) : void
      {
         this.endLoadingRequest();
         this.updateHintsAfterOperation();
      }
      
      private function onPutAfterOperationRequestComplete(e:Event) : void
      {
         this.endLoadingRequest();
         try
         {
            this._hintsToUpdate.shift();
            this.updateSubhintDictionaryAfterOperation();
         }
         catch(e:Error)
         {
            _log.error("error : " + e.name + ", " + e.getStackTrace());
         }
      }
      
      private function onError(e:Event) : void
      {
         this.endLoadingRequest();
      }
      
      private function onStatus(e:HTTPStatusEvent) : void
      {
         this.endLoadingRequest();
         switch(e.status)
         {
            case 400:
               this._log.error("Error 400 : Bad request");
               break;
            case 404:
               if(this._request.method == URLRequestMethod.GET && this._request.url.charAt(this._request.url.length) == "/")
               {
                  this._log.error("Error 404 : Not Found, ID not found or invalid, get data from export");
                  this.createSubhintDictionary(Subhint.getSubhints());
               }
               else if(this._request.method == URLRequestMethod.GET)
               {
                  this._log.error("Error 404 : Not Found, ID not found or invalid");
               }
               else if(this._request.method == URLRequestMethod.DELETE)
               {
                  this._log.error("Error 404 : Subhint not Found, ABORT MISSION !!!");
               }
               else if(this._request.method == URLRequestMethod.POST)
               {
                  this._log.error("Error 404 : Not Found");
               }
               else if(this._request.method == URLRequestMethod.PUT)
               {
                  this._log.error("Error 404 : Not Found");
               }
               break;
            case 500:
               if(this._request.method == URLRequestMethod.GET && this._request.url.charAt(this._request.url.length) == "/")
               {
                  this._log.error("Error 500 : Internal Server Error, get data from export");
                  this.createSubhintDictionary(Subhint.getSubhints());
               }
               else if(this._request.method == URLRequestMethod.GET)
               {
                  this._log.error("Error 404 : Not Found, ID not found or invalid, get data from export");
               }
               else if(this._request.method == URLRequestMethod.DELETE)
               {
                  this._log.error("Error 500 : Internal Server Error");
               }
               else if(this._request.method == URLRequestMethod.POST)
               {
                  this._log.error("Error 500 : Internal Server Error");
               }
               else if(this._request.method == URLRequestMethod.PUT)
               {
                  this._log.error("Error 500 : Internal Server Error");
               }
               break;
            case 200:
               this._log.debug("Status 200: subhints récupérés");
               break;
            case 201:
               this._log.debug("Status 201 : subhint créé");
         }
      }
      
      private function createSubhintDictionary(result:Object) : void
      {
         var subhintWrapper:SubhintWrapper = null;
         var subhint:Object = null;
         subhintDictionary = new Dictionary();
         for each(subhint in result)
         {
            subhint.hint_creation_date = DateFormatter.parseDateString(subhint.hint_tooltip_creation_time).getTime();
            subhintWrapper = SubhintWrapper.create(subhint);
            if(!subhintDictionary[subhint.hint_parent_uid])
            {
               subhintDictionary[subhint.hint_parent_uid] = [];
            }
            subhintDictionary[subhint.hint_parent_uid][subhint.hint_order - 1] = subhintWrapper;
         }
      }
      
      private function updateHintsAfterOperation() : void
      {
         var subhintWrapper:SubhintWrapper = null;
         var i:* = undefined;
         var minOrder:int = 0;
         var maxOrder:int = 0;
         var putOrderChanged:Boolean = false;
         var shw:SubhintWrapper = null;
         var parentChanged:Boolean = false;
         var previousParentOrder:int = 0;
         var sh:SubhintWrapper = null;
         var oldOrder:int = 0;
         switch(this._operation)
         {
            case "modify":
               subhintWrapper = SubhintWrapper.create(this._result);
               putOrderChanged = true;
               parentChanged = false;
               previousParentOrder = 0;
               for each(shw in subhintDictionary[subhintWrapper.hint_parent_uid])
               {
                  if(shw && shw.hint_id == subhintWrapper.hint_id)
                  {
                     oldOrder = shw.hint_order;
                     if(shw.hint_order == subhintWrapper.hint_order)
                     {
                        putOrderChanged = false;
                     }
                     break;
                  }
               }
               if(!subhintDictionary[subhintWrapper.hint_parent_uid])
               {
                  subhintDictionary[subhintWrapper.hint_parent_uid] = [];
               }
               if(this._previousParent && this._previousParent.previousParent != subhintWrapper.hint_parent_uid)
               {
                  for each(shw in subhintDictionary[this._previousParent.previousParent])
                  {
                     if(shw && shw.hint_id == this._previousParent.hint_id)
                     {
                        previousParentOrder = shw.hint_order;
                        subhintDictionary[shw.hint_parent_uid].splice(shw.hint_order - 1,1);
                        parentChanged = true;
                        break;
                     }
                  }
               }
               if(parentChanged)
               {
                  for(i in subhintDictionary[this._previousParent.previousParent])
                  {
                     if(i >= 0 && subhintDictionary[this._previousParent.previousParent][i].hint_order > previousParentOrder)
                     {
                        subhintDictionary[this._previousParent.previousParent][i].hint_order = i + 1;
                        this._hintsToUpdate.push(subhintDictionary[this._previousParent.previousParent][i]);
                     }
                  }
               }
               if(putOrderChanged || parentChanged)
               {
                  if(oldOrder > 0)
                  {
                     minOrder = Math.min(subhintWrapper.hint_order,oldOrder);
                     maxOrder = Math.max(subhintWrapper.hint_order,oldOrder);
                     subhintDictionary[subhintWrapper.hint_parent_uid].splice(oldOrder - 1,1);
                  }
                  else if(subhintWrapper.hint_order == subhintDictionary[subhintWrapper.hint_parent_uid].length - 1)
                  {
                     minOrder = maxOrder = subhintWrapper.hint_order;
                  }
                  else
                  {
                     minOrder = subhintWrapper.hint_order;
                     maxOrder = subhintDictionary[subhintWrapper.hint_parent_uid].length - 1;
                  }
                  subhintDictionary[subhintWrapper.hint_parent_uid].splice(subhintWrapper.hint_order - 1,0,subhintWrapper);
                  if(minOrder != maxOrder)
                  {
                     for(i in subhintDictionary[subhintWrapper.hint_parent_uid])
                     {
                        if(i >= minOrder && i <= maxOrder && subhintDictionary[subhintWrapper.hint_parent_uid][i] != subhintWrapper)
                        {
                           subhintDictionary[subhintWrapper.hint_parent_uid][i].hint_order = i + 1;
                           this._hintsToUpdate.push(subhintDictionary[subhintWrapper.hint_parent_uid][i]);
                        }
                     }
                  }
                  else if(parentChanged)
                  {
                     if(subhintDictionary[this._previousParent.hint_parent_uid].length <= 0)
                     {
                        delete subhintDictionary[this._previousParent.hint_parent_uid];
                     }
                     for(i in subhintDictionary[subhintWrapper.hint_parent_uid])
                     {
                        if(i >= subhintWrapper.hint_order && subhintDictionary[subhintWrapper.hint_parent_uid][i] != subhintWrapper)
                        {
                           subhintDictionary[subhintWrapper.hint_parent_uid][i].hint_order = i + 1;
                           this._hintsToUpdate.push(subhintDictionary[subhintWrapper.hint_parent_uid][i]);
                        }
                     }
                  }
               }
               else
               {
                  subhintDictionary[subhintWrapper.hint_parent_uid][subhintWrapper.hint_order - 1] = subhintWrapper;
                  this._hintsToUpdate = [];
               }
               break;
            case "move":
               subhintWrapper = SubhintWrapper.create(this._result);
               for each(sh in subhintDictionary[subhintWrapper.hint_parent_uid])
               {
                  if(sh && sh.hint_id == subhintWrapper.hint_id)
                  {
                     oldOrder = sh.hint_order;
                  }
               }
               subhintDictionary[subhintWrapper.hint_parent_uid].splice(oldOrder,1);
               subhintDictionary[subhintWrapper.hint_parent_uid].splice(subhintWrapper.hint_order - 1,0,subhintWrapper);
               subhintDictionary[subhintWrapper.hint_parent_uid][oldOrder - 1].hint_order = oldOrder;
               this._hintsToUpdate.push(subhintDictionary[subhintWrapper.hint_parent_uid][oldOrder]);
               break;
            case "delete":
               subhintDictionary[this._hintToDelete.hint_parent_uid].splice(this._hintToDelete.hint_order - 1,1);
               if(subhintDictionary[this._hintToDelete.hint_parent_uid].length <= 0)
               {
                  delete subhintDictionary[this._hintToDelete.hint_parent_uid];
               }
               else
               {
                  for(i in subhintDictionary[this._hintToDelete.hint_parent_uid])
                  {
                     if(i + 1 > this._hintToDelete.hint_order)
                     {
                        subhintDictionary[this._hintToDelete.hint_parent_uid][i].hint_order = i + 1;
                        this._hintsToUpdate.push(subhintDictionary[this._hintToDelete.hint_parent_uid][i]);
                     }
                  }
               }
         }
         this.updateSubhintDictionaryAfterOperation();
      }
      
      private function updateSubhintDictionaryAfterOperation() : void
      {
         var data:Object = null;
         if(this._hintsToUpdate && this._hintsToUpdate.length > 0)
         {
            this._putRequest = false;
            data = this._hintsToUpdate[0].toObject();
            data.user = File.userDirectory.name;
            this._request = new URLRequest(this._baseURL + this._hintsToUpdate[0].hint_id);
            this._request.contentType = "application/json";
            this._request.method = URLRequestMethod.PUT;
            this._request.data = JsonUtil.toJson(data);
            this.loadRequest(this._request,this.onPutAfterOperationRequestComplete);
         }
         else
         {
            this.reset();
            KernelEventsManager.getInstance().processCallback(HookList.SubhintUpdated);
         }
      }
   }
}

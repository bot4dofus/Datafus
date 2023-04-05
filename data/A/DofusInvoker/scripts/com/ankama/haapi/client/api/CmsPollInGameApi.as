package com.ankama.haapi.client.api
{
   import com.ankama.haapi.client.ApiInvokerHelper;
   import com.ankama.haapi.client.model.CmsPollInGame;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.common.OpenApi;
   import org.openapitools.exception.ApiError;
   
   public class CmsPollInGameApi extends OpenApi
   {
      
      public static const event_get:String = "get";
      
      public static const event_mark_as_read:String = "mark_as_read";
       
      
      public function CmsPollInGameApi(apiCredentials:ApiUserCredentials, eventDispatcher:EventDispatcher = null)
      {
         super(apiCredentials,eventDispatcher);
      }
      
      private static function isValidParam(param:*) : Boolean
      {
         if(param is int || param is uint)
         {
            return true;
         }
         if(param is Number)
         {
            return !isNaN(param);
         }
         return param != null;
      }
      
      public function get(site:String, lang:String, page:Number, count:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/PollInGame/Get".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(site))
         {
            throw new ApiError(400,"missing required params : site");
         }
         if(!isValidParam(lang))
         {
            throw new ApiError(400,"missing required params : lang");
         }
         if(!isValidParam(page))
         {
            throw new ApiError(400,"missing required params : page");
         }
         if(!isValidParam(count))
         {
            throw new ApiError(400,"missing required params : count");
         }
         queryParams["site"] = toPathValue(site);
         queryParams["lang"] = toPathValue(lang);
         queryParams["page"] = toPathValue(page);
         queryParams["count"] = toPathValue(count);
         var forceImport_CmsPollInGame:CmsPollInGame = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "get";
            _token.returnType = "com.ankama.haapi.client.model.CmsPollInGame";
         });
      }
      
      public function mark_as_read(item:Number) : ApiInvokerHelper
      {
         var path:String = null;
         var queryParams:Dictionary = null;
         var headerParams:Dictionary = null;
         var postParams:Object = null;
         var contentType:String = null;
         path = "/Ankama/v4/Cms/PollInGame/MarkAsRead".replace(/{format}/g,"xml");
         queryParams = new Dictionary();
         headerParams = new Dictionary();
         postParams = new Object();
         if(!isValidParam(item))
         {
            throw new ApiError(400,"missing required params : item");
         }
         queryParams["item"] = toPathValue(item);
         var forceImport_Boolean:Boolean = undefined;
         var contentTypes:Array = new Array();
         var testFunc:Function = function(item:String, index:int, array:Array):Boolean
         {
            if(item.toLowerCase() == "application/json")
            {
               return true;
            }
            return false;
         };
         contentType = contentTypes.length == 0 || contentTypes.some(testFunc) ? "application/json" : contentTypes[0];
         return new ApiInvokerHelper(function(apiInvokerHelper:EventDispatcher):void
         {
            var _token:* = getNewApiInvoker(apiInvokerHelper).invokeAPI(path,"GET",queryParams,postParams,headerParams,contentType);
            var requestId:* = getUniqueId();
            _token.requestId = requestId;
            _token.completionEventType = "mark_as_read";
            _token.returnType = "com.ankama.haapi.client.model.Boolean";
         });
      }
   }
}

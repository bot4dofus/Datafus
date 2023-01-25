package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class BoneIndexManager extends EventDispatcher
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(BoneIndexManager));
      
      private static var _self:BoneIndexManager;
       
      
      private var _loader:IResourceLoader;
      
      private var _index:Dictionary;
      
      private var _animIndexDirs:Dictionary;
      
      private var _transitions:Dictionary;
      
      private var _animNameModifier:Function;
      
      public function BoneIndexManager()
      {
         this._index = new Dictionary();
         this._animIndexDirs = new Dictionary();
         this._transitions = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
      }
      
      public static function getInstance() : BoneIndexManager
      {
         if(!_self)
         {
            _self = new BoneIndexManager();
         }
         return _self;
      }
      
      public function init(boneIndexPath:String) : void
      {
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onXmlLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onXmlFailed);
         this._loader.load(new Uri(boneIndexPath));
      }
      
      public function setAnimNameModifier(fct:Function) : void
      {
         this._animNameModifier = fct;
      }
      
      public function addTransition(boneId:uint, startAnim:String, endAnim:String, direction:uint, transitionalAnim:String) : void
      {
         if(!this._transitions[boneId])
         {
            this._transitions[boneId] = new Dictionary();
         }
         this._transitions[boneId][startAnim + "_" + endAnim + "_" + direction] = transitionalAnim;
      }
      
      public function hasTransition(boneId:uint, startAnim:String, endAnim:String, direction:uint) : Boolean
      {
         if(this._animNameModifier != null)
         {
            startAnim = this._animNameModifier(boneId,startAnim);
            endAnim = this._animNameModifier(boneId,endAnim);
         }
         var transition:* = startAnim + "_" + endAnim + "_";
         return this._transitions[boneId] && (this._transitions[boneId][transition + direction] != null || this._transitions[boneId][transition + TiphonUtility.getFlipDirection(direction)] != null);
      }
      
      public function getTransition(boneId:uint, startAnim:String, endAnim:String, direction:uint) : String
      {
         if(this._animNameModifier != null)
         {
            startAnim = this._animNameModifier(boneId,startAnim);
            endAnim = this._animNameModifier(boneId,endAnim);
         }
         if(!this._transitions[boneId])
         {
            return null;
         }
         var transition:* = startAnim + "_" + endAnim + "_";
         var transitionAndDirection:String = transition + direction;
         if(this._transitions[boneId][transitionAndDirection])
         {
            return this._transitions[boneId][transitionAndDirection];
         }
         return this._transitions[boneId][transition + TiphonUtility.getFlipDirection(direction)];
      }
      
      public function getBoneFile(boneId:uint, animName:String) : Uri
      {
         if(!this._index[boneId] || !this._index[boneId][animName])
         {
            return new Uri(TiphonConstants.SWF_SKULL_PATH + boneId + ".swl");
         }
         return new Uri(TiphonConstants.SWF_SKULL_PATH + this._index[boneId][animName]);
      }
      
      public function hasAnim(boneId:uint, animName:String, direction:int = 0) : Boolean
      {
         if(!this._index[boneId])
         {
            _log.error("Le bone " + boneId + " ne possède aucune animation");
            return false;
         }
         if(!this._index[boneId][animName])
         {
            _log.error("Le bone " + boneId + " ne possède aucune animation nommée " + animName);
            return false;
         }
         return direction != -1 ? this._animIndexDirs[boneId][animName].indexOf(direction) != -1 : true;
      }
      
      public function hasCustomBone(boneId:uint) : Boolean
      {
         return this._index[boneId];
      }
      
      public function getAllCustomAnimations(boneId:int) : Array
      {
         var anim:* = null;
         var animationsList:Dictionary = this._index[boneId];
         if(!animationsList)
         {
            return null;
         }
         var list:Array = [];
         for(anim in animationsList)
         {
            list.push(anim);
         }
         return list;
      }
      
      public function getAllCustomAnimationDictionary(boneId:int) : Dictionary
      {
         return this._index[boneId];
      }
      
      private function onXmlLoaded(e:ResourceLoadedEvent) : void
      {
         var group:XML = null;
         var uri:Uri = null;
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onXmlLoaded);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onSubXmlLoaded);
         this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllSubXmlLoaded);
         var folder:String = FileUtils.getFilePath(e.uri.uri);
         var xml:XML = e.resource as XML;
         var subXml:Array = [];
         for each(group in xml.child("group"))
         {
            uri = new Uri(folder + "/" + group.@id.toString() + ".xml");
            uri.tag = parseInt(group.@id.toString());
            subXml.push(uri);
         }
         this._loader.load(subXml);
      }
      
      private function onSubXmlLoaded(e:ResourceLoadedEvent) : void
      {
         var className:String = null;
         var file:XML = null;
         var animClass:XML = null;
         var animInfo:Array = null;
         var xml:XML = e.resource as XML;
         for each(file in xml.child("file"))
         {
            for each(animClass in file.child("resource"))
            {
               className = animClass.@name.toString();
               if(className.indexOf("Anim") != -1)
               {
                  if(!this._index[e.uri.tag])
                  {
                     this._index[e.uri.tag] = new Dictionary();
                  }
                  if(this._index[e.uri.tag][className])
                  {
                     _log.error("Already existing anim \'" + className + "\' for bone " + e.uri.tag + " in " + this._index[e.uri.tag][className] + ", will be overwritten with " + file.@name.toString());
                  }
                  this._index[e.uri.tag][className] = file.@name.toString();
                  if(!this._animIndexDirs[e.uri.tag])
                  {
                     this._animIndexDirs[e.uri.tag] = new Dictionary();
                  }
                  if(!this._animIndexDirs[e.uri.tag][className])
                  {
                     this._animIndexDirs[e.uri.tag][className] = [];
                  }
                  this._animIndexDirs[e.uri.tag][className] = animClass.@directions.toString().split(",").map(function(item:*, index:int, arr:Array):int
                  {
                     return parseInt(item);
                  });
                  if(className.indexOf("_to_") != -1)
                  {
                     animInfo = className.split("_");
                     _self.addTransition(e.uri.tag,animInfo[0],animInfo[2],parseInt(animInfo[3]),animInfo[0] + "_to_" + animInfo[2]);
                  }
               }
            }
         }
      }
      
      private function onXmlFailed(e:ResourceErrorEvent) : void
      {
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onXmlLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onXmlFailed);
         _log.error("Impossible de charger ou parser le fichier d\'index d\'animation : " + e.uri);
      }
      
      private function onAllSubXmlLoaded(e:ResourceLoaderProgressEvent) : void
      {
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onXmlFailed);
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onSubXmlLoaded);
         this._loader.removeEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllSubXmlLoaded);
         this._loader = null;
         dispatchEvent(new Event(Event.INIT));
      }
   }
}

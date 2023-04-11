package com.ankamagames.jerakine.lua
{
   import com.ankamagames.jerakine.interfaces.IScriptsPlayer;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import luaAlchemy.LuaAlchemy;
   
   public class LuaPlayer extends EventDispatcher implements IScriptsPlayer
   {
       
      
      private var _luaAlchemy:LuaAlchemy;
      
      private var _dispatchMessages:Boolean;
      
      private var _resetOnComplete:Boolean;
      
      private var _seqApi:Object;
      
      private var _entityApi:Object;
      
      private var _cameraApi:Object;
      
      private var _alwaysShowAuraOnFront:Boolean;
      
      public function LuaPlayer(pDispatchMessages:Boolean = true)
      {
         super();
         this._luaAlchemy = new LuaAlchemy();
         this._dispatchMessages = pDispatchMessages;
         this._resetOnComplete = false;
      }
      
      public function get resetOnComplete() : Boolean
      {
         return this._resetOnComplete;
      }
      
      public function set resetOnComplete(pValue:Boolean) : void
      {
         this._resetOnComplete = pValue;
      }
      
      public function addApi(pApiId:String, pApi:*) : void
      {
         this._luaAlchemy.setGlobal(pApiId,pApi);
         switch(pApiId)
         {
            case "EntityApi":
               this._entityApi = pApi;
               break;
            case "SeqApi":
               this._seqApi = pApi;
               break;
            case "CameraApi":
               this._cameraApi = pApi;
         }
      }
      
      public function playScript(pLuaScript:String) : void
      {
         this.init();
         this._luaAlchemy.doStringAsync(pLuaScript,this.resultCallback);
      }
      
      public function setGlobal(pKey:String, pValue:*) : void
      {
         this._luaAlchemy.setGlobal(pKey,pValue);
      }
      
      public function playFile(pUri:String) : void
      {
         var loader:IResourceLoader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
         loader.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         loader.addEventListener(ResourceErrorEvent.ERROR,this.onFileLoadError);
         loader.load(new Uri(pUri));
      }
      
      public function reset() : void
      {
         if(this._seqApi)
         {
            this._seqApi.clear();
         }
         if(this._entityApi)
         {
            this._entityApi.reset();
         }
         if(this._cameraApi)
         {
            this._cameraApi.reset();
         }
      }
      
      private function init() : void
      {
         if(this._seqApi)
         {
            this._seqApi.clear();
         }
         if(this._entityApi)
         {
            this._entityApi.init();
         }
         this._alwaysShowAuraOnFront = OptionManager.getOptionManager("tiphon").getOption("alwaysShowAuraOnFront");
         OptionManager.getOptionManager("tiphon").setOption("alwaysShowAuraOnFront",false);
      }
      
      private function onFileLoaded(pEvent:ResourceLoadedEvent) : void
      {
         this.removeEventListeners(pEvent);
         this.init();
         var ba:ByteArray = pEvent.resource as ByteArray;
         this._luaAlchemy.doStringAsync(ba.readUTFBytes(ba.bytesAvailable),this.resultCallback);
      }
      
      private function onFileLoadError(pEvent:ResourceErrorEvent) : void
      {
         this.removeEventListeners(pEvent);
         var e:LuaPlayerEvent = new LuaPlayerEvent(LuaPlayerEvent.PLAY_ERROR);
         e.stackTrace = pEvent.errorMsg;
         dispatchEvent(e);
      }
      
      private function resultCallback(pStack:Array) : void
      {
         var lpe:LuaPlayerEvent = null;
         var result:Boolean = pStack.shift();
         if(this._dispatchMessages)
         {
            if(result)
            {
               dispatchEvent(new LuaPlayerEvent(LuaPlayerEvent.PLAY_SUCCESS));
               if(!this._seqApi || !this._seqApi.hasSequences())
               {
                  this.onScriptComplete();
               }
               else if(this._seqApi)
               {
                  this._seqApi.addCompleteCallback(this.onScriptComplete);
               }
            }
            else
            {
               this.reset();
               lpe = new LuaPlayerEvent(LuaPlayerEvent.PLAY_ERROR);
               lpe.stackTrace = pStack[0];
               dispatchEvent(lpe);
            }
         }
      }
      
      private function onScriptComplete() : void
      {
         dispatchEvent(new LuaPlayerEvent(LuaPlayerEvent.PLAY_COMPLETE));
         if(this._resetOnComplete)
         {
            this.reset();
         }
         OptionManager.getOptionManager("tiphon").setOption("alwaysShowAuraOnFront",this._alwaysShowAuraOnFront);
      }
      
      private function removeEventListeners(e:Event) : void
      {
         (e.currentTarget as IResourceLoader).removeEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         (e.currentTarget as IResourceLoader).removeEventListener(ResourceErrorEvent.ERROR,this.onFileLoadError);
      }
   }
}

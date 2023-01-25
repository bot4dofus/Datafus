package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.event.TemplateLoadedEvent;
   import com.ankamagames.berilia.types.template.XmlTemplate;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   
   public class TemplateManager extends EventDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TemplateManager));
      
      private static var _self:TemplateManager;
       
      
      private var _aTemplates:Array;
      
      private var _loader:IResourceLoader;
      
      public function TemplateManager()
      {
         super();
         if(_self != null)
         {
            throw new BeriliaError("TemplateManager is a singleton and should not be instanciated directly.");
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.objectLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
         this.init();
      }
      
      public static function getInstance() : TemplateManager
      {
         if(_self == null)
         {
            _self = new TemplateManager();
         }
         return _self;
      }
      
      public function init() : void
      {
         this._aTemplates = [];
      }
      
      public function getTemplate(sName:String) : XmlTemplate
      {
         var aTmp:Array = sName.split("/");
         var sFileName:* = aTmp[aTmp.length - 1];
         if(-1 == sFileName.indexOf(".xml"))
         {
            sFileName += ".xml";
         }
         return this._aTemplates[sFileName];
      }
      
      public function isRegistered(sPath:String) : Boolean
      {
         var aTmp:Array = sPath.split("/");
         var sFileName:String = aTmp[aTmp.length - 1];
         return this._aTemplates[sFileName] != null;
      }
      
      public function isLoaded(sPath:String) : Boolean
      {
         var aTmp:Array = sPath.split("/");
         var sFileName:String = aTmp[aTmp.length - 1];
         return this._aTemplates[sFileName] is XmlTemplate;
      }
      
      public function areLoaded(aPath:Array) : Boolean
      {
         for(var i:uint = 0; i < aPath.length; i++)
         {
            if(!this.isLoaded(aPath[i]))
            {
               return false;
            }
         }
         return aPath.length != 0;
      }
      
      public function register(sPath:String) : void
      {
         var aTmp:Array = sPath.split("/");
         var sFileName:String = aTmp[aTmp.length - 1];
         if(this.isRegistered(sFileName))
         {
            if(this.isLoaded(sFileName))
            {
               dispatchEvent(new TemplateLoadedEvent(sPath));
            }
            return;
         }
         this._aTemplates[sFileName] = false;
         this._loader.load(new Uri(sPath));
      }
      
      public function objectLoaded(e:ResourceLoadedEvent) : void
      {
         this._aTemplates[e.uri.fileName] = new XmlTemplate(e.resource,e.uri.fileName);
         dispatchEvent(new TemplateLoadedEvent(e.uri.uri));
      }
      
      public function objectLoadedFailed(e:ResourceErrorEvent) : void
      {
         _log.debug("objectLoadedFailed : " + e.uri + " : " + e.errorMsg);
      }
   }
}

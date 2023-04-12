package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.berilia.types.event.CssEvent;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.text.StyleSheet;
   import flash.utils.getQualifiedClassName;
   
   public class CssManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CssManager));
      
      private static const CSS_ARRAY_KEY:String = "cssFilesContents";
      
      private static var _self:CssManager;
      
      private static var _useCache:Boolean = true;
       
      
      private var _aCss:Array;
      
      private var _aWaiting:Array;
      
      private var _aMultiWaiting:Array;
      
      private var _loader:IResourceLoader;
      
      private var _aLoadingFile:Array;
      
      private var _preloaded:Array;
      
      public function CssManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this._aCss = [];
         this._aWaiting = [];
         this._aMultiWaiting = [];
         this._aLoadingFile = [];
         this._preloaded = [];
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.complete);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.error);
      }
      
      public static function getInstance() : CssManager
      {
         if(!_self)
         {
            _self = new CssManager();
         }
         return _self;
      }
      
      public static function set useCache(b:Boolean) : void
      {
         _useCache = b;
         if(!b)
         {
            clear();
         }
      }
      
      public static function get useCache() : Boolean
      {
         return _useCache;
      }
      
      public static function clear(clearCache:Boolean = false) : void
      {
         var url:String = null;
         StoreDataManager.getInstance().clear(BeriliaConstants.DATASTORE_UI_CSS);
         if(clearCache && _self)
         {
            _self._aCss = new Array();
            _self._aWaiting = new Array();
            _self._aMultiWaiting = new Array();
            _self._aLoadingFile = new Array();
            _self._loader.cancel();
            for each(url in _self._preloaded)
            {
               _self.load(url);
            }
         }
      }
      
      public function getLoadedCss() : Array
      {
         return this._aCss;
      }
      
      public function load(oFile:*) : void
      {
         var uri:Uri = null;
         var i:uint = 0;
         var aQueue:Array = new Array();
         if(oFile is String)
         {
            uri = new Uri(oFile);
            if(!this.exists(uri.uri) && !this.inQueue(uri.uri))
            {
               aQueue.push(uri);
               this._aLoadingFile[uri.uri] = true;
            }
         }
         else if(oFile is Array)
         {
            for(i = 0; i < (oFile as Array).length; i++)
            {
               uri = new Uri(oFile[i]);
               if(!this.exists(uri.uri) && !this.inQueue(uri.uri))
               {
                  this._aLoadingFile[uri.uri] = true;
                  aQueue.push(uri);
               }
            }
         }
         if(aQueue.length)
         {
            this._loader.load(aQueue);
         }
      }
      
      public function exists(sUrl:String) : Boolean
      {
         var uri:Uri = new Uri(sUrl);
         return this._aCss[uri.uri] != null;
      }
      
      public function inQueue(sUrl:String) : Boolean
      {
         return this._aLoadingFile[sUrl];
      }
      
      public function askCss(sUrl:String, callback:Callback) : void
      {
         var uri:Uri = null;
         var files:Array = null;
         if(this.exists(sUrl))
         {
            callback.exec();
         }
         else
         {
            uri = new Uri(sUrl);
            if(!this._aWaiting[uri.uri])
            {
               this._aWaiting[uri.uri] = new Array();
            }
            this._aWaiting[uri.uri].push(callback);
            if(sUrl.indexOf(",") != -1)
            {
               files = sUrl.split(",");
               this._aMultiWaiting[uri.uri] = files;
               this.load(files);
            }
            else
            {
               this.load(sUrl);
            }
         }
      }
      
      public function preloadCss(sUrl:String) : void
      {
         if(this._preloaded.indexOf(sUrl) == -1)
         {
            this._preloaded.push(sUrl);
         }
         if(!this.exists(sUrl))
         {
            this.load(sUrl);
         }
      }
      
      public function getCss(sUrl:String) : ExtendedStyleSheet
      {
         var uri:Uri = new Uri(sUrl);
         return this._aCss[uri.uri];
      }
      
      public function merge(aStyleSheet:Array) : ExtendedStyleSheet
      {
         var newCssName:String = "";
         for(var j:uint = 0; j < aStyleSheet.length; j++)
         {
            newCssName += (!!j ? "," : "") + aStyleSheet[j].url;
         }
         if(this.exists(newCssName))
         {
            return this.getCss(newCssName);
         }
         var newEss:ExtendedStyleSheet = new ExtendedStyleSheet(newCssName);
         for(var i:uint = aStyleSheet.length - 1; i - 1 > -1; i--)
         {
            newEss.merge(aStyleSheet[i] as ExtendedStyleSheet);
         }
         this._aCss[newCssName] = newEss;
         return newEss;
      }
      
      protected function init() : void
      {
         var aSavedCss:Array = null;
         var file:* = null;
         if(_useCache)
         {
            aSavedCss = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_CSS,CSS_ARRAY_KEY,new Array());
            for(file in aSavedCss)
            {
               this.parseCss(file,aSavedCss[file]);
            }
         }
      }
      
      private function parseCss(sUrl:String, content:String) : void
      {
         var uri:Uri = new Uri(sUrl);
         var styleSheet:StyleSheet = new ExtendedStyleSheet(uri.uri);
         this._aCss[uri.uri] = styleSheet;
         styleSheet.addEventListener(CssEvent.CSS_PARSED,this.onCssParsed);
         styleSheet.parseCSS(content);
      }
      
      private function updateWaitingMultiUrl(loadedUrl:String) : void
      {
         var ok:Boolean = false;
         var url:* = null;
         var i:uint = 0;
         var files:Array = null;
         var sse:Array = null;
         var k:uint = 0;
         for(url in this._aMultiWaiting)
         {
            if(this._aMultiWaiting[url])
            {
               ok = true;
               for(i = 0; i < this._aMultiWaiting[url].length; i++)
               {
                  if(this._aMultiWaiting[url][i] == loadedUrl)
                  {
                     this._aMultiWaiting[url][i] = true;
                  }
                  ok = ok && this._aMultiWaiting[url][i] === true;
               }
               if(ok)
               {
                  delete this._aMultiWaiting[url];
                  files = url.split(",");
                  sse = new Array();
                  for(k = 0; k < files.length; sse.push(this.getCss(files[k])),k++)
                  {
                  }
                  this.merge(sse);
                  this.dispatchWaitingCallbabk(url);
               }
            }
         }
      }
      
      private function dispatchWaitingCallbabk(url:String) : void
      {
         var i:uint = 0;
         if(this._aWaiting[url])
         {
            for(i = 0; i < this._aWaiting[url].length; i++)
            {
               Callback(this._aWaiting[url][i]).exec();
            }
            delete this._aWaiting[url];
         }
      }
      
      protected function complete(e:ResourceLoadedEvent) : void
      {
         var aSavedCss:Array = null;
         if(_useCache)
         {
            aSavedCss = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_CSS,CSS_ARRAY_KEY,new Array());
            aSavedCss[e.uri.uri] = e.resource;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_CSS,CSS_ARRAY_KEY,aSavedCss);
         }
         this._aLoadingFile[e.uri.uri] = false;
         this.parseCss(e.uri.uri,e.resource);
      }
      
      protected function error(e:ResourceErrorEvent) : void
      {
         ErrorManager.addError("Impossible de trouver la feuille de style (url: " + e.uri + ")");
         this._aLoadingFile[e.uri.uri] = false;
         delete this._aWaiting[e.uri.uri];
      }
      
      private function onCssParsed(e:CssEvent) : void
      {
         e.stylesheet.removeEventListener(CssEvent.CSS_PARSED,this.onCssParsed);
         var uri:Uri = new Uri(e.stylesheet.url);
         this.dispatchWaitingCallbabk(uri.uri);
         this.updateWaitingMultiUrl(uri.uri);
      }
   }
}

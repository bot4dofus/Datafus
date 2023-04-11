package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.FontActiveTypeChangeMessage;
   import com.ankamagames.jerakine.messages.LangAllFilesLoadedMessage;
   import com.ankamagames.jerakine.messages.LangFileLoadedMessage;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.UserFont;
   import com.ankamagames.jerakine.utils.errors.FileTypeError;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class FontManager extends EventDispatcher
   {
      
      public static const DEFAULT_FONT_TYPE:String = "default";
      
      private static var _self:FontManager;
      
      public static var initialized:Boolean = false;
       
      
      private var _log:Logger;
      
      private var _handler:MessageHandler;
      
      private var _loader:IResourceLoader;
      
      private var _data:XML;
      
      private var _lang:String;
      
      private var _activeType:String = "default";
      
      private var _fonts:Dictionary;
      
      private var _processCallback:Callback;
      
      public function FontManager()
      {
         this._log = Log.getLogger(getQualifiedClassName(FontManager));
         super();
         if(_self != null)
         {
            throw new SingletonError("FontManager is a singleton and should not be instanciated directly.");
         }
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
      }
      
      public static function getInstance() : FontManager
      {
         if(_self == null)
         {
            _self = new FontManager();
         }
         return _self;
      }
      
      public function get activeType() : String
      {
         return this._activeType;
      }
      
      public function set activeType(value:String) : void
      {
         if(this._activeType != value)
         {
            this._activeType = value;
            dispatchEvent(new Event(Event.CHANGE));
            this._handler.process(new FontActiveTypeChangeMessage());
            this._processCallback.exec();
         }
      }
      
      public function set handler(value:MessageHandler) : void
      {
         this._handler = value;
      }
      
      public function set processCallback(f:Callback) : void
      {
         this._processCallback = f;
      }
      
      public function loadFile(sUrl:String) : void
      {
         var sExtension:String = FileUtils.getExtension(sUrl);
         this._lang = LangManager.getInstance().getEntry("config.lang.current");
         if(sExtension == null)
         {
            throw new FileTypeError(sUrl + " have no type (no extension found).");
         }
         var uri:Uri = new Uri(sUrl);
         uri.tag = sUrl;
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         this._loader.load(uri);
      }
      
      public function getFontUrlList() : Array
      {
         var o:Dictionary = null;
         var f:UserFont = null;
         var found:Dictionary = new Dictionary();
         var fontList:Array = new Array();
         for each(o in this._fonts)
         {
            for each(f in o)
            {
               if(!found[f.url])
               {
                  fontList.push(f.url);
                  found[f.url] = true;
               }
            }
         }
         return fontList;
      }
      
      public function getFontInfo(fontName:String, useDefaultFont:Boolean = false) : UserFont
      {
         if(!this._fonts[fontName])
         {
            return null;
         }
         if(!useDefaultFont && this._fonts[fontName][this._activeType])
         {
            return this._fonts[fontName][this._activeType];
         }
         return this._fonts[fontName][DEFAULT_FONT_TYPE];
      }
      
      private function onFileLoaded(e:ResourceLoadedEvent) : void
      {
         var xml:XMLList = null;
         var length:int = 0;
         var i:int = 0;
         var name:String = null;
         var entry:* = undefined;
         var f:UserFont = null;
         this.removeLoadListeners();
         this._data = new XML(e.resource);
         this._fonts = new Dictionary();
         xml = this._data.Fonts.(@lang == _lang);
         if(xml.length() == 0)
         {
            xml = this._data.Fonts.(@lang == "");
         }
         length = xml.font.length();
         for(i = 0; i < length; i++)
         {
            name = xml.font[i].@name;
            this._fonts[name] = new Dictionary();
            for each(entry in xml.font[i]..entry)
            {
               f = new UserFont(entry.@realName.toString(),entry.@className.toString(),parseFloat(entry.@sizeMultiplicator.toString()),LangManager.getInstance().replaceKey(entry.@file.toString()),entry.@embedAsCff.toString() == "true",parseInt(entry.@maxSize.toString()),parseInt(entry.@sharpness.toString()),parseFloat(entry.@verticalOffset.toString()),parseFloat(entry.@letterSpacing.toString()));
               this._fonts[name][!!entry.hasOwnProperty("@type") ? entry.@type.toString() : DEFAULT_FONT_TYPE] = f;
            }
         }
         if(this._handler)
         {
            this._handler.process(new LangFileLoadedMessage(e.uri.uri,true,e.uri.uri));
            this._handler.process(new LangAllFilesLoadedMessage(e.uri.uri,true));
         }
         initialized = true;
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void
      {
         this.removeLoadListeners();
         this._handler.process(new LangFileLoadedMessage(e.uri.uri,false,e.uri.uri));
         this._log.warn("can\'t load " + e.uri.uri);
      }
      
      private function removeLoadListeners() : void
      {
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
      }
   }
}

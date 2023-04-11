package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class CustomLoadingScreen
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreen));
      
      private static const date_regexp:RegExp = new RegExp(/\-/g);
       
      
      public var id:int;
      
      public var backgroundImg:ByteArray;
      
      public var foregroundImg:ByteArray;
      
      public var backgroundUrl:String;
      
      public var foregroundUrl:String;
      
      public var linkUrl:String;
      
      public var begin:Date;
      
      public var end:Date;
      
      public var countMax:int = 0;
      
      public var count:int;
      
      public var screen:int = 1;
      
      public var lang:String;
      
      public var dataStore:Object;
      
      private var _backgroundUrlLoader:URLLoader;
      
      private var _foregroundUrlLoader:URLLoader;
      
      public function CustomLoadingScreen()
      {
         super();
      }
      
      public static function recover(dataStore:DataStoreType, id:int) : CustomLoadingScreen
      {
         return StoreDataManager.getInstance().getData(dataStore,"loading_" + id) as CustomLoadingScreen;
      }
      
      public static function toDate(dateStr:String) : Date
      {
         if(dateStr === null)
         {
            return null;
         }
         dateStr = dateStr.replace(date_regexp,"/");
         dateStr = dateStr.replace("T"," ");
         dateStr = dateStr.replace("+"," GMT-");
         dateStr = dateStr.slice(0,dateStr.lastIndexOf(":")) + dateStr.slice(dateStr.lastIndexOf(":") + 1);
         return new Date(Date.parse(dateStr));
      }
      
      public static function loadFromCms(cmsLoadingScreen:Object, lang:String) : CustomLoadingScreen
      {
         var cls:CustomLoadingScreen = new CustomLoadingScreen();
         cls.id = cmsLoadingScreen.id;
         cls.backgroundUrl = cmsLoadingScreen.background;
         cls.foregroundUrl = cmsLoadingScreen.foreground;
         cls.linkUrl = cmsLoadingScreen.url;
         cls.begin = cmsLoadingScreen.begin;
         cls.end = cmsLoadingScreen.end;
         cls.countMax = cmsLoadingScreen.count;
         cls.screen = cmsLoadingScreen.screen;
         cls.count = 0;
         cls.lang = lang;
         return cls;
      }
      
      public function loadData() : void
      {
         if(this.backgroundUrl)
         {
            this._backgroundUrlLoader = new URLLoader();
            this._backgroundUrlLoader.addEventListener(Event.COMPLETE,this.onComplete);
            this._backgroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._backgroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            _log.info("load custom background : " + this.backgroundUrl);
            this._backgroundUrlLoader.load(new URLRequest(this.backgroundUrl));
         }
         if(this.foregroundUrl)
         {
            this._foregroundUrlLoader = new URLLoader();
            this._foregroundUrlLoader.addEventListener(Event.COMPLETE,this.onComplete);
            this._foregroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._foregroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            _log.info("load custom foreground : " + this.foregroundUrl);
            this._foregroundUrlLoader.load(new URLRequest(this.foregroundUrl));
         }
      }
      
      public function store(storeAsCurrent:Boolean = false) : void
      {
         StoreDataManager.getInstance().setData(CustomLoadingScreenManager.getInstance().dataStore,"loading_" + this.id,this);
         if(storeAsCurrent)
         {
            StoreDataManager.getInstance().setData(CustomLoadingScreenManager.getInstance().dataStore,"currentLoadingScreen",this.id);
         }
      }
      
      public function isViewing() : void
      {
         if(this.count < this.countMax)
         {
            ++this.count;
            this.store();
         }
      }
      
      public function canBeRead() : Boolean
      {
         var currentDate:Date = new Date();
         if((!this.begin || this.begin.time < currentDate.time) && (!this.end || this.end.time > currentDate.time) && (this.countMax == -1 || this.countMax == 0 || this.count < this.countMax))
         {
            return true;
         }
         return false;
      }
      
      public function canBeReadOnScreen(beforeLogin:Boolean) : Boolean
      {
         return this.canBeRead() && (this.screen == 3 || beforeLogin && this.screen == 1 || !beforeLogin && this.screen == 2);
      }
      
      private function onComplete(e:Event) : void
      {
         var urlLoader:URLLoader = e.target as URLLoader;
         urlLoader.removeEventListener(Event.COMPLETE,this.onComplete);
         urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         switch(e.target)
         {
            case this._backgroundUrlLoader:
               this.backgroundImg = urlLoader.data;
               this.store();
               break;
            case this._foregroundUrlLoader:
               this.foregroundImg = urlLoader.data;
               this.store();
         }
      }
      
      private function onIOError(e:IOErrorEvent) : void
      {
         var urlLoader:URLLoader = e.target as URLLoader;
         urlLoader.removeEventListener(Event.COMPLETE,this.onComplete);
         urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         _log.error("invalid bitmap : " + e);
      }
   }
}

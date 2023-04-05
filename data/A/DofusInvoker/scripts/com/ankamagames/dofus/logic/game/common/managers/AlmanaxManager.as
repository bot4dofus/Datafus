package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankama.haapi.client.api.AlmanaxApi;
   import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class AlmanaxManager
   {
      
      private static var _self:AlmanaxManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlmanaxManager));
       
      
      private var _calendar:AlmanaxCalendar;
      
      private var _currentEvent:AlmanaxEvent;
      
      private var _currentMonth:AlmanaxMonth;
      
      private var _currentZodiac:AlmanaxZodiac;
      
      public var almanaxApi:AlmanaxApi;
      
      private var _ds:DataStoreType;
      
      public function AlmanaxManager()
      {
         this._ds = new DataStoreType("AlmanaxCache",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         var cacheDate:Date = StoreDataManager.getInstance().getSetData(this._ds,"cacheDate",new Date(2000));
         var currentDate:Date = new Date();
         if(cacheDate.day != currentDate.day || currentDate.time - cacheDate.time > 120000)
         {
            this.getEventFromApi();
         }
         else
         {
            StoreDataManager.getInstance().registerClass(new AlmanaxEvent());
            StoreDataManager.getInstance().registerClass(new AlmanaxMonth());
            StoreDataManager.getInstance().registerClass(new AlmanaxZodiac());
            this._currentEvent = StoreDataManager.getInstance().getData(this._ds,"currentEvent") as AlmanaxEvent;
            this._currentMonth = StoreDataManager.getInstance().getData(this._ds,"currentMonth") as AlmanaxMonth;
            this._currentZodiac = StoreDataManager.getInstance().getData(this._ds,"currentZodiac") as AlmanaxZodiac;
            if(!this._currentEvent || !this._currentMonth || !this._currentZodiac)
            {
               this.getEventFromApi();
            }
            else
            {
               this.checkData();
            }
         }
      }
      
      public static function getInstance() : AlmanaxManager
      {
         if(!_self)
         {
            _self = new AlmanaxManager();
         }
         return _self;
      }
      
      public function get event() : AlmanaxEvent
      {
         return this._currentEvent;
      }
      
      public function get month() : AlmanaxMonth
      {
         return this._currentMonth;
      }
      
      public function get zodiac() : AlmanaxZodiac
      {
         return this._currentZodiac;
      }
      
      public function get calendar() : AlmanaxCalendar
      {
         return this._calendar;
      }
      
      public function set calendar(pCalendar:AlmanaxCalendar) : void
      {
         this._calendar = pCalendar;
      }
      
      private function getEventFromApi() : void
      {
         var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),null);
         this.almanaxApi = new AlmanaxApi(apiCredentials);
         var timeString:String = TimeManager.getInstance().formatDateIRL(TimeManager.getInstance().getUtcTimestamp()).split("/").join("-") + " " + TimeManager.getInstance().formatClock(TimeManager.getInstance().getUtcTimestamp());
         this.almanaxApi.get_event(XmlConfig.getInstance().getEntry("config.lang.current"),timeString).onSuccess(this.onData).call();
      }
      
      private function setDefaultData(pAlmanaxElement:Object) : void
      {
         if(pAlmanaxElement is AlmanaxEvent)
         {
            if(!pAlmanaxElement.bossText)
            {
               pAlmanaxElement.bossText = "ui.almanax.default.boss";
            }
            if(!pAlmanaxElement.ephemeris)
            {
               pAlmanaxElement.ephemeris = "ui.almanax.default.ephemeris";
            }
            pAlmanaxElement.festText = "";
            pAlmanaxElement.name = "";
            pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/jour.jpg");
         }
         else if(pAlmanaxElement is AlmanaxMonth)
         {
            if(!pAlmanaxElement.protectorDescription)
            {
               pAlmanaxElement.protectorDescription = "ui.almanax.default.protector";
            }
            pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/protecteur.jpg");
         }
         else if(pAlmanaxElement is AlmanaxZodiac)
         {
            pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/constellation.jpg");
            if(!pAlmanaxElement.description)
            {
               pAlmanaxElement.description = "ui.almanax.default.zodiac";
            }
         }
      }
      
      private function checkData() : void
      {
         if(!this.isValidImageUrl(this._currentEvent.webImageUrl))
         {
            this.setDefaultData(this._currentEvent);
         }
         if(!this.isValidImageUrl(this._currentMonth.webImageUrl))
         {
            this.setDefaultData(this._currentMonth);
         }
         if(!this.isValidImageUrl(this._currentZodiac.webImageUrl))
         {
            this.setDefaultData(this._currentZodiac);
         }
      }
      
      private function isValidImageUrl(pUrl:String) : Boolean
      {
         return pUrl && pUrl != "false";
      }
      
      private function onData(e:ApiClientEvent) : void
      {
         if(e.response.payload == null)
         {
            _log.error("Couldn\'t find almanax information from haapi : " + e.response.errorMessage);
            return;
         }
         var eventRawData:Object = e.response.payload.event;
         var monthRawData:Object = e.response.payload.month;
         var zodiacRawData:Object = e.response.payload.zodiac;
         this._currentEvent = new AlmanaxEvent();
         this.event.bossText = eventRawData.boss_text;
         this.event.ephemeris = eventRawData.ephemeris;
         this.event.festText = eventRawData.fest_text;
         this.event.id = eventRawData.id;
         this.event.name = eventRawData.name;
         this.event.rubrikabrax = eventRawData.rubrikabrax;
         this.event.webImageUrl = eventRawData.image_url;
         this._currentMonth = new AlmanaxMonth();
         this.month.id = monthRawData.id;
         this.month.monthNum = monthRawData.month;
         this.month.protectorDescription = monthRawData.protector_description;
         this.month.protectorName = monthRawData.protector_name;
         this.month.webImageUrl = monthRawData.protector_image_url;
         this._currentZodiac = new AlmanaxZodiac();
         this.zodiac.id = zodiacRawData.id;
         this.zodiac.name = zodiacRawData.name;
         this.zodiac.webImageUrl = zodiacRawData.image_url;
         this.zodiac.description = zodiacRawData.description;
         this.checkData();
         StoreDataManager.getInstance().setData(this._ds,"currentEvent",this._currentEvent);
         StoreDataManager.getInstance().setData(this._ds,"currentMonth",this._currentMonth);
         StoreDataManager.getInstance().setData(this._ds,"currentZodiac",this._currentZodiac);
         StoreDataManager.getInstance().setData(this._ds,"cacheDate",new Date());
      }
   }
}

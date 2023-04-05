package com.ankamagames.dofus.misc.utils
{
   import com.ankama.haapi.client.api.CmsItemsLoadingscreenApi;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class CustomLoadingScreenManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreenManager));
      
      private static var _singleton:CustomLoadingScreenManager;
       
      
      private const NB_SCREEN_MAX_PER_PAGE:int = 20;
      
      private var HAAPI_BASE_PATH:String;
      
      private var _dataStore:DataStoreType;
      
      private var _loadingScreensApi:CmsItemsLoadingscreenApi;
      
      private var _loadingScreens:Vector.<CustomLoadingScreen>;
      
      private var _initialized:Boolean = false;
      
      public function CustomLoadingScreenManager()
      {
         this._dataStore = new DataStoreType("LoadingScreen",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         this._loadingScreens = new Vector.<CustomLoadingScreen>();
         super();
      }
      
      public static function getInstance() : CustomLoadingScreenManager
      {
         if(!_singleton)
         {
            _singleton = new CustomLoadingScreenManager();
         }
         return _singleton;
      }
      
      public function init() : void
      {
         this.HAAPI_BASE_PATH = XmlConfig.getInstance().getEntry("config.haapiUrlAnkama");
         var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",this.HAAPI_BASE_PATH,null);
         this._loadingScreensApi = new CmsItemsLoadingscreenApi(apiCredentials);
         this._initialized = true;
      }
      
      public function get currentLoadingScreen() : CustomLoadingScreen
      {
         var id:int = StoreDataManager.getInstance().getData(this._dataStore,"currentLoadingScreen") as int;
         var current:CustomLoadingScreen = CustomLoadingScreen.recover(this._dataStore,id);
         var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
         if(!lang)
         {
            lang = StoreDataManager.getInstance().getData(Constants.DATASTORE_LANG_VERSION,"lastLang");
         }
         if(current && !current.canBeRead())
         {
            StoreDataManager.getInstance().setData(this._dataStore,"currentLoadingScreen",null);
            current = null;
         }
         if(current && current.lang != lang)
         {
            StoreDataManager.getInstance().setData(this._dataStore,"currentLoadingScreen",null);
            current = null;
         }
         return current;
      }
      
      public function get dataStore() : DataStoreType
      {
         return this._dataStore;
      }
      
      public function set currentLoadingScreen(loadingScreen:CustomLoadingScreen) : void
      {
         if(loadingScreen)
         {
            StoreDataManager.getInstance().setData(this._dataStore,"currentLoadingScreen",loadingScreen.id);
         }
         else
         {
            StoreDataManager.getInstance().setData(this._dataStore,"currentLoadingScreen",null);
         }
      }
      
      public function loadCustomScreenList(accountId:Number) : void
      {
         if(!this._initialized)
         {
            this.init();
         }
         if(this._loadingScreensApi == null)
         {
            _log.error("Loading Screen API is null...");
            return;
         }
         var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
         if(isNaN(accountId) || accountId <= 0)
         {
            this._loadingScreensApi.get_default(lang).onSuccess(this.onCustomScreensList(lang,1,accountId)).onError(this.onCustomScreensListError(lang,1,accountId)).call();
         }
         else
         {
            this._loadingScreensApi.get(lang,1,this.NB_SCREEN_MAX_PER_PAGE,accountId).onSuccess(this.onCustomScreensList(lang,1,accountId)).onError(this.onCustomScreensListError(lang,1,accountId)).call();
         }
      }
      
      private function onCustomScreensListError(lang:String, page:Number, accountId:Number) : Function
      {
         return function(e:ApiClientEvent):void
         {
            _log.error("Error while retrieving custom loading screens from Haapi with [lang] " + lang + ", [page] " + page + " : " + e.response.errorMessage);
         };
      }
      
      private function onCustomScreensList(lang:String, page:Number, accountId:Number) : Function
      {
         return function(e:ApiClientEvent):void
         {
            var loadingScreenData:* = undefined;
            var maxPage:* = undefined;
            var loadingScreen:* = undefined;
            var i:* = undefined;
            var oldLoadingScreen:* = undefined;
            var payload:* = e.response.payload;
            if(payload == null)
            {
               processCallError("Error: CustomLoadingScreens requested data corrupted : " + e.response.errorMessage);
               return;
            }
            var firstTimeLoadingScreen:* = isNaN(accountId) || accountId <= 0;
            var loadingScreens:* = new Vector.<CustomLoadingScreen>();
            for each(loadingScreenData in payload.loadingscreens)
            {
               loadingScreens.push(CustomLoadingScreen.loadFromCms(loadingScreenData,lang));
            }
            maxPage = 1;
            if(!firstTimeLoadingScreen && payload.total_count)
            {
               maxPage = Math.ceil(int(payload.total_count) / NB_SCREEN_MAX_PER_PAGE);
               if(page == 1)
               {
                  for(i = 2; i <= maxPage; i++)
                  {
                     _loadingScreensApi.get(lang,i,NB_SCREEN_MAX_PER_PAGE,accountId).onSuccess(onCustomScreensList(lang,i,accountId)).onError(onCustomScreensListError(lang,i,accountId)).call();
                  }
               }
            }
            for(i = 0; i < loadingScreens.length; i++)
            {
               _loadingScreens.push(loadingScreens[i]);
            }
            if(page != maxPage)
            {
               return;
            }
            var selected:* = null;
            for each(loadingScreen in _loadingScreens)
            {
               oldLoadingScreen = CustomLoadingScreen.recover(_dataStore,loadingScreen.id);
               if(oldLoadingScreen)
               {
                  loadingScreen.count = oldLoadingScreen.count;
               }
               if(!oldLoadingScreen || loadingScreen.backgroundUrl != oldLoadingScreen.backgroundUrl || !oldLoadingScreen.backgroundImg || loadingScreen.foregroundUrl != oldLoadingScreen.foregroundUrl || oldLoadingScreen.foregroundUrl && !oldLoadingScreen.foregroundImg)
               {
                  loadingScreen.loadData();
               }
               else
               {
                  loadingScreen.backgroundImg = oldLoadingScreen.backgroundImg;
                  loadingScreen.foregroundImg = oldLoadingScreen.foregroundImg;
                  loadingScreen.store();
               }
               if(!selected && loadingScreen.canBeRead())
               {
                  selected = loadingScreen;
               }
            }
            if(selected)
            {
               currentLoadingScreen = selected;
            }
         };
      }
      
      private function processCallError(error:*) : void
      {
         _log.error(error);
         StoreDataManager.getInstance().setData(this._dataStore,"currentLoadingScreen",null);
      }
   }
}

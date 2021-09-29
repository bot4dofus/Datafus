package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankama.haapi.client.api.MoneyApi;
   import com.ankama.haapi.client.api.ShopApi;
   import com.ankama.haapi.client.model.ShopBuyResult;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.kernel.zaap.IZaapMessageHandler;
   import com.ankamagames.dofus.kernel.zaap.ZaapApi;
   import com.ankamagames.dofus.kernel.zaap.messages.IZaapInputMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapCloseOverlayMessage;
   import com.ankamagames.dofus.kernel.zaap.messages.impl.ZaapResetOgrinesMessage;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopArticle;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopCategory;
   import com.ankamagames.dofus.logic.game.common.types.DofusShopHighlight;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import flash.utils.Dictionary;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class DofusShopManager implements IZaapMessageHandler
   {
      
      private static const _log:Logger = Log.getLogger("DofusShopManager");
      
      private static const TEMPORIS_CATEGORY:int = 694;
      
      private static var _self:DofusShopManager;
       
      
      public var shopApi:ShopApi;
      
      public var moneyApi:MoneyApi;
      
      private var _zaapApi:ZaapApi;
      
      private var _key:String;
      
      private var _articlesTemp:Dictionary;
      
      public function DofusShopManager()
      {
         this._articlesTemp = new Dictionary();
         super();
      }
      
      public static function getInstance() : DofusShopManager
      {
         if(!_self)
         {
            _self = new DofusShopManager();
            _self._zaapApi = new ZaapApi(_self);
         }
         return _self;
      }
      
      public function init(key:String, forceReleaseGameService:Boolean = false) : void
      {
         this._key = key;
         var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),this._key);
         this.shopApi = new ShopApi(apiCredentials);
         this.moneyApi = new MoneyApi(apiCredentials);
         this.shopApi.home().onSuccess(this.onHome).onError(this.onHomeError).call();
         this.update();
      }
      
      private function update() : void
      {
         this.moneyApi.ogrins_account(false).onSuccess(this.onLinkedOgrines).onError(this.onLinkedOgrinesError).call();
      }
      
      public function getMoney() : void
      {
         this.moneyApi.ogrins_amount().onSuccess(this.onMoney).onError(this.onMoneyError).call();
      }
      
      public function buyArticle(articleId:int, currency:String, amount:Number, quantity:int = 1) : void
      {
         this.shopApi.simple_buy(articleId,quantity,amount,currency).onSuccess(this.onBuyArticle(articleId)).onError(this.onBuyArticleError(articleId)).call();
      }
      
      public function getArticlesList(category:int, size:int = 20) : void
      {
         this._articlesTemp[category] = [];
         this.shopApi.articles_list_by_category(category,1,size).onSuccess(this.onArticlesList(category,1)).onError(this.onArticleListError(category,1)).call();
      }
      
      public function searchForArticles(criteria:String, size:int = 20) : void
      {
         this._articlesTemp[-1] = [];
         this.shopApi.articles_list_search(criteria,[],1,size).onSuccess(this.onSearchArticles(1,criteria)).onError(this.onSearchArticlesError(1,criteria)).call();
      }
      
      public function updateAfterExpiredArticle(articleId:int) : void
      {
         this.shopApi.articles_list_by_ids([articleId]).onSuccess(this.onRefreshArticle([articleId])).onError(this.onRefreshArticleError(articleId)).call();
      }
      
      public function overlayBuyArticle(articleId:int) : void
      {
         var mod:UiModule = null;
         if(ZaapApi.isConnected())
         {
            mod = UiModuleManager.getInstance().getModule("Ankama_GameUiCore");
            this._zaapApi.payArticle(this._key,articleId);
            Berilia.getInstance().loadUi(mod,mod.uis["modalCover"],"modalCover",null,false,StrataEnum.STRATA_TOP);
         }
         else
         {
            mod = UiModuleManager.getInstance().getModule("Ankama_Web");
            Berilia.getInstance().loadUi(mod,mod.uis["shopPopupOverlayWarning"],"shopPopupOverlayWarning",null,false,StrataEnum.STRATA_TOP);
         }
      }
      
      private function onMoney(e:ApiClientEvent) : void
      {
         if(e.response.payload == null)
         {
            this.processCallError("Error: Money requested data corrupted");
            return;
         }
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,e.response.payload.amount);
      }
      
      public function onMoneyError(e:ApiClientEvent) : void
      {
         _log.error("Can\'t Retrieve Money ammount from Haapi");
      }
      
      private function onLinkedOgrines(e:ApiClientEvent) : void
      {
         if(e.response.payload == null)
         {
            this.processCallError("Error: LinkedOgrines requested data corrupted");
            return;
         }
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakLinkedOgrines,e.response.payload);
      }
      
      private function onLinkedOgrinesError(e:ApiClientEvent) : void
      {
         _log.error("Could not get linked ogrines ammoun from haapi");
      }
      
      private function onHome(e:ApiClientEvent) : void
      {
         var data:Object = null;
         var article:DofusShopArticle = null;
         var payload:* = e.response.payload;
         if(!payload)
         {
            this.processCallError("Error: Home requested data corrupted : " + e.response.errorMessage);
            return;
         }
         var categories:Array = [];
         var gondolaArticles:Array = [];
         var highlightCarousel:Array = [];
         this.getMoney();
         if(payload.categories)
         {
            for each(data in payload.categories)
            {
               if(!(data.id == TEMPORIS_CATEGORY && PlayerManager.getInstance().server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS))
               {
                  categories.push(new DofusShopCategory(data));
               }
            }
         }
         if(payload.gondolahead_article)
         {
            for each(data in payload.gondolahead_article)
            {
               article = new DofusShopArticle(data);
               if(!article.hasExpired && !(article.category == TEMPORIS_CATEGORY && PlayerManager.getInstance().server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS))
               {
                  gondolaArticles.push(article);
               }
            }
         }
         if(payload.hightlight_carousel)
         {
            for each(data in payload.hightlight_carousel)
            {
               if(!(PlayerManager.getInstance().server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS && (data.type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY && data.external_category && data.external_category.id == TEMPORIS_CATEGORY || data.type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE && data.external_article && data.external_article.most_precise_category_id == TEMPORIS_CATEGORY)))
               {
                  highlightCarousel.push(new DofusShopHighlight(data));
               }
            }
         }
         KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopHome,categories,gondolaArticles,highlightCarousel);
      }
      
      private function onHomeError(e:ApiClientEvent) : void
      {
         _log.error("Error while retrieving Shop Home from Haapi : " + e.response.errorMessage);
      }
      
      private function onArticlesList(categoryId:Number, page:Number) : Function
      {
         return function(e:ApiClientEvent):void
         {
            var articleData:* = undefined;
            var article:* = undefined;
            var maxPage:* = undefined;
            var i:* = undefined;
            var payload:* = e.response.payload;
            if(payload == null)
            {
               processCallError("Error: ArticlesList requested data corrupted : " + e.response.errorMessage);
               return;
            }
            var articles:* = new Array();
            for each(articleData in payload.articles)
            {
               article = new DofusShopArticle(articleData);
               if(!article.hasExpired)
               {
                  articles.push(article);
               }
            }
            maxPage = 1;
            if(payload.total_count)
            {
               maxPage = Math.ceil(int(payload.total_count) / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
               if(page == 1)
               {
                  for(i = 2; i <= maxPage; i++)
                  {
                     shopApi.articles_list_by_category(categoryId,i,DofusShopEnum.MAX_ARTICLES_PER_PAGE).onSuccess(onArticlesList(categoryId,i)).onError(onArticleListError(categoryId,i)).call();
                  }
               }
            }
            _articlesTemp[categoryId].insertAt(page - 1,articles);
            for(i = 0; i < maxPage; i++)
            {
               if(!_articlesTemp[categoryId][i])
               {
                  return;
               }
            }
            var resultArray:* = [];
            for(i = 0; i < maxPage; i++)
            {
               resultArray = resultArray.concat(_articlesTemp[categoryId][i]);
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesList,resultArray,categoryId);
         };
      }
      
      private function onArticleListError(categoryId:Number, page:Number) : Function
      {
         return function(e:ApiClientEvent):void
         {
            _log.error("Error while retrieving article list from Haapi with [category] " + categoryId + ", [page] " + page + " : " + e.response.errorMessage);
         };
      }
      
      private function onSearchArticles(page:int, text:String) : Function
      {
         return function(e:ApiClientEvent):void
         {
            var articleData:* = undefined;
            var article:* = undefined;
            var maxPage:* = undefined;
            var i:* = undefined;
            var payload:* = e.response.payload;
            if(payload == null)
            {
               processCallError("Error: SearchArticles requested data corrupted : " + e.response.errorMessage);
               return;
            }
            var articles:* = new Array();
            for each(articleData in payload.articles)
            {
               article = new DofusShopArticle(articleData);
               if(!article.hasExpired)
               {
                  articles.push(article);
               }
            }
            maxPage = 1;
            if(payload.total_count)
            {
               maxPage = Math.ceil(int(payload.total_count) / DofusShopEnum.MAX_ARTICLES_PER_PAGE);
               if(page == 1)
               {
                  for(i = 2; i <= maxPage; i++)
                  {
                     shopApi.articles_list_search(text,[],i,DofusShopEnum.MAX_ARTICLES_PER_PAGE).onSuccess(onSearchArticles(i,text)).onError(onSearchArticlesError(i,text)).call();
                  }
               }
            }
            _articlesTemp[-1].insertAt(page - 1,articles);
            for(i = 0; i < maxPage; i++)
            {
               if(!_articlesTemp[-1][i])
               {
                  return;
               }
            }
            var resultArray:* = [];
            for(i = 0; i < maxPage; i++)
            {
               resultArray = resultArray.concat(_articlesTemp[-1][i]);
            }
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopArticlesSearchList,resultArray);
         };
      }
      
      private function onSearchArticlesError(page:int, text:String) : Function
      {
         return function(e:ApiClientEvent):void
         {
            _log.error("Error while searching articles from Haapi with [criteria] " + text + ", [page] " + page + " : " + e.response.errorMessage);
         };
      }
      
      private function onBuyArticle(articleId:int) : Function
      {
         return function(e:ApiClientEvent):void
         {
            var payload:* = e.response.payload;
            if(payload == null)
            {
               processCallError("Error: BuyArticle requested data corrupted : " + e.response.errorMessage);
               return;
            }
            if(payload.balance)
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopMoney,payload.balance[0].amount);
            }
            if(payload.order_status == ShopBuyResult.OrderStatusEnum_PROCESSED)
            {
               shopApi.articles_list_by_ids([articleId]).onSuccess(onRefreshArticle([articleId])).onError(onRefreshArticleError(articleId)).call();
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopBuySuccess);
            }
         };
      }
      
      private function onBuyArticleError(id:int) : Function
      {
         return function(e:ApiClientEvent):void
         {
            _log.error("Can\'t Buy article [id]" + id + " : " + e.response.errorMessage);
         };
      }
      
      private function onRefreshArticle(ids:Array) : Function
      {
         return function(e:ApiClientEvent):void
         {
            if(e.response.payload == null)
            {
               processCallError("Error: RefreshArticle requested data corrupted : " + e.response.errorMessage);
               return;
            }
            if(e.response.payload.articles.length == 0)
            {
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopDeleteArticle,ids);
            }
         };
      }
      
      private function onRefreshArticleError(id:Number) : Function
      {
         return function(e:ApiClientEvent):void
         {
            _log.error("Error while refreshing article [id] " + id);
         };
      }
      
      private function processCallError(error:*) : void
      {
         _log.error(error);
         if(error is ErrorEvent && error.type == IOErrorEvent.NETWORK_ERROR)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_REQUEST_TIMED_OUT);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.shop.errorApi"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         }
      }
      
      public function handleConnectionOpened() : void
      {
      }
      
      public function handleMessage(msg:IZaapInputMessage) : void
      {
         if(msg is ZaapCloseOverlayMessage)
         {
            Berilia.getInstance().unloadUi("modalCover");
         }
         else if(msg is ZaapResetOgrinesMessage)
         {
            this.getMoney();
            this.update();
         }
      }
      
      public function handleConnectionClosed() : void
      {
      }
   }
}

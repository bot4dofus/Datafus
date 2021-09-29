package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeMultipleKardAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeSimpleKardAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiBufferKamasListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiCancelBidRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConfirmationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConsumeBufferKamasRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiValidationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenBakRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenCodesAndGiftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.RefreshBakOffersAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopArticlesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopSearchRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.UpdateGiftListRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.CodesAndGiftManager;
   import com.ankamagames.dofus.logic.game.common.managers.DofusBakManager;
   import com.ankamagames.dofus.logic.game.common.managers.DofusShopManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.BidActionEnum;
   import com.ankamagames.dofus.network.enums.BidValidationEnum;
   import com.ankamagames.dofus.network.enums.HaapiAuthTypeEnum;
   import com.ankamagames.dofus.network.enums.HavenBagRoomActionEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagPackListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagRoomUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageKamasUpdateMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiAuthErrorMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiBufferListMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiBufferListRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiBuyValidationMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiCancelBidRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiConfirmationMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiConfirmationRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiConsumeBufferRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiShopApiKeyMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiShopApiKeyRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiTokenMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiTokenRequestMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiValidationMessage;
   import com.ankamagames.dofus.network.messages.web.haapi.HaapiValidationRequestMessage;
   import com.ankamagames.dofus.network.types.game.havenbag.HavenBagRoomPreviewInformation;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ExternalGameFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalGameFrame));
       
      
      private const BAK_INTERFACE_NAME:String = "bakTab";
      
      private var _tokenRequestCallback:Array;
      
      private var _tokenRequestTimeoutTimer:BenchmarkTimer;
      
      private var _tokenRequestHasTimedOut:Boolean = false;
      
      private var _haapiKeyRequestCallback:Array;
      
      private var _haapiKeyRequestTimeoutTimer:BenchmarkTimer;
      
      private var _haapiKeyRequestHasTimedOut:Boolean = false;
      
      public function ExternalGameFrame()
      {
         this._tokenRequestCallback = [];
         this._haapiKeyRequestCallback = [];
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         this.clearTokenRequestTimer();
         this._tokenRequestCallback.length = 0;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var skumsg:StorageKamasUpdateMessage = null;
         var owsa:OpenWebServiceAction = null;
         var haem:HaapiAuthErrorMessage = null;
         var hsakm:HaapiShopApiKeyMessage = null;
         var htm:HaapiTokenMessage = null;
         var hblrm2:HaapiBufferListRequestMessage = null;
         var hcbkrm:HaapiConsumeBufferRequestMessage = null;
         var hcbra:HaapiCancelBidRequestAction = null;
         var hcbrm:HaapiCancelBidRequestMessage = null;
         var hvra:HaapiValidationRequestAction = null;
         var hvrm:HaapiValidationRequestMessage = null;
         var hcra:HaapiConfirmationRequestAction = null;
         var hcrm:HaapiConfirmationRequestMessage = null;
         var hvm:HaapiValidationMessage = null;
         var salra:ShopArticlesListRequestAction = null;
         var sbra:ShopBuyRequestAction = null;
         var ssra:ShopSearchRequestAction = null;
         var socbra:ShopOverlayBuyRequestAction = null;
         var hbrum:HavenBagRoomUpdateMessage = null;
         var hbplmsg:HavenBagPackListMessage = null;
         var validThemes:Vector.<int> = null;
         var commonThemeIndex:int = 0;
         var hblm:HaapiBufferListMessage = null;
         var hcm:HaapiConfirmationMessage = null;
         var transactionParams:Dictionary = null;
         var hbvm:HaapiBuyValidationMessage = null;
         var hblrm:HaapiBufferListRequestMessage = null;
         var commonMod:Object = null;
         var currentList:Vector.<HavenBagRoomPreviewInformation> = null;
         var j:int = 0;
         var found:Boolean = false;
         var i:int = 0;
         switch(true)
         {
            case msg is StorageKamasUpdateMessage:
               skumsg = msg as StorageKamasUpdateMessage;
               InventoryManager.getInstance().bankInventory.kamas = skumsg.kamasTotal;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.StorageKamasUpdate,skumsg.kamasTotal);
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakKamasAmount,skumsg.kamasTotal + InventoryManager.getInstance().inventory.kamas);
               return true;
            case msg is OpenWebServiceAction:
               owsa = msg as OpenWebServiceAction;
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.OpenWebService,owsa.uiName,owsa.uiParams);
               return true;
            case msg is HaapiAuthErrorMessage:
               if(this._tokenRequestHasTimedOut)
               {
                  return true;
               }
               haem = msg as HaapiAuthErrorMessage;
               if(haem.type == HaapiAuthTypeEnum.HAAPI_TOKEN)
               {
                  if(this._tokenRequestCallback.length)
                  {
                     this.clearTokenRequestTimer();
                     this.callOnTokenFunctions("");
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthError);
                  }
               }
               return true;
               break;
            case msg is HaapiShopApiKeyMessage:
               if(this._haapiKeyRequestHasTimedOut)
               {
                  return true;
               }
               hsakm = msg as HaapiShopApiKeyMessage;
               if(this._haapiKeyRequestCallback.length)
               {
                  this.clearHaapiKeyRequestTimer();
                  this.callOnHaapiKeyFunctions(hsakm.token);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthToken,hsakm.token);
               }
               return true;
               break;
            case msg is HaapiTokenMessage:
               if(this._tokenRequestHasTimedOut)
               {
                  return true;
               }
               htm = msg as HaapiTokenMessage;
               if(this._tokenRequestCallback.length)
               {
                  this.clearTokenRequestTimer();
                  this.callOnTokenFunctions(htm.token);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.HaapiAuthToken,htm.token);
               }
               return true;
               break;
            case msg is HaapiBufferKamasListRequestAction:
               hblrm2 = new HaapiBufferListRequestMessage();
               ConnectionsHandler.getConnection().send(hblrm2);
               return true;
            case msg is HaapiBufferListMessage:
               if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
               {
                  hblm = msg as HaapiBufferListMessage;
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakKamasBufferList,hblm.buffers);
               }
               return true;
            case msg is HaapiConsumeBufferKamasRequestAction:
               hcbkrm = new HaapiConsumeBufferRequestMessage();
               ConnectionsHandler.getConnection().send(hcbkrm);
               return true;
            case msg is HaapiCancelBidRequestAction:
               hcbra = msg as HaapiCancelBidRequestAction;
               hcbrm = new HaapiCancelBidRequestMessage();
               hcbrm.initHaapiCancelBidRequestMessage(hcbra.id,hcbra.type);
               ConnectionsHandler.getConnection().send(hcbrm);
               return true;
            case msg is HaapiValidationRequestAction:
               hvra = msg as HaapiValidationRequestAction;
               hvrm = new HaapiValidationRequestMessage();
               hvrm.initHaapiValidationRequestMessage(hvra.transactionId);
               ConnectionsHandler.getConnection().send(hvrm);
               return true;
            case msg is HaapiConfirmationRequestAction:
               hcra = msg as HaapiConfirmationRequestAction;
               hcrm = new HaapiConfirmationRequestMessage();
               hcrm.initHaapiConfirmationRequestMessage(hcra.kamas,hcra.ogrines,hcra.rate,hcra.actionType);
               ConnectionsHandler.getConnection().send(hcrm);
               return true;
            case msg is HaapiConfirmationMessage:
               if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
               {
                  hcm = msg as HaapiConfirmationMessage;
                  transactionParams = new Dictionary();
                  transactionParams["kamas"] = hcm.kamas;
                  transactionParams["ogrines"] = hcm.amount;
                  transactionParams["rate"] = hcm.rate;
                  transactionParams["transaction"] = hcm.transaction;
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakConfirmation,transactionParams,hcm.action);
               }
               return true;
            case msg is HaapiBuyValidationMessage:
               if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
               {
                  hbvm = msg as HaapiBuyValidationMessage;
                  if(hbvm.code != BidValidationEnum.VALIDATION_SUCCESS)
                  {
                     _log.warn("Erreur Validation d\'achat : " + hbvm.code);
                     KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakError,hbvm.code,hbvm.action);
                  }
                  else
                  {
                     KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakBuyValidation,hbvm.amount,hbvm.action,hbvm.email);
                     DofusBakManager.getInstance().refreshMoney();
                     DofusBakManager.getInstance().refreshOffers();
                  }
               }
               return true;
            case msg is HaapiValidationMessage:
               hvm = msg as HaapiValidationMessage;
               switch(hvm.action)
               {
                  case BidActionEnum.CONSUME_BUFF:
                     if(hvm.code == BidValidationEnum.VALIDATION_SUCCESS)
                     {
                        NotificationManager.getInstance().showNotification(I18n.getUiText("ui.bak.notificationTransferOver"),I18n.getUiText("ui.bak.notificationTransferSuccess"),NotificationTypeEnum.TUTORIAL);
                        if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
                        {
                           KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakTransferSuccess);
                        }
                     }
                     else
                     {
                        NotificationManager.getInstance().showNotification(I18n.getUiText("ui.bak.notificationTransferFail"),I18n.getUiText("ui.bak.notificationTransferRetry"),NotificationTypeEnum.WARNING);
                        _log.warn("Erreur consommation du buffer de kamas : " + hvm.code);
                     }
                     break;
                  case BidActionEnum.CANCEL:
                     if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
                     {
                        if(hvm.code != BidValidationEnum.VALIDATION_SUCCESS)
                        {
                           _log.warn("Erreur annulation d\'offre : " + hvm.code);
                        }
                        else
                        {
                           DofusBakManager.getInstance().refreshMoney();
                           DofusBakManager.getInstance().refreshOffers();
                           DofusBakManager.getInstance().refreshAccountBids();
                           hblrm = new HaapiBufferListRequestMessage();
                           ConnectionsHandler.getConnection().send(hblrm);
                        }
                     }
                     break;
                  case BidActionEnum.CREATE_OGRINE:
                  case BidActionEnum.CREATE_KAMA:
                     if(Berilia.getInstance().getUi(this.BAK_INTERFACE_NAME))
                     {
                        if(hvm.code != BidValidationEnum.VALIDATION_SUCCESS)
                        {
                           _log.warn("Erreur création d\'offre : " + hvm.code);
                        }
                        else
                        {
                           DofusBakManager.getInstance().refreshMoney();
                           DofusBakManager.getInstance().refreshOffers();
                           DofusBakManager.getInstance().refreshAccountBids();
                           KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakCreateBidSuccess);
                        }
                     }
               }
               if(hvm.code != BidValidationEnum.VALIDATION_SUCCESS)
               {
                  KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakError,hvm.code,hvm.action);
               }
               return true;
            case msg is ShopAuthentificationRequestAction:
               if(XmlConfig.getInstance().getEntry("config.dev.shopIceToken") == "true")
               {
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  commonMod.openInputPopup("ICE Authentication","To access the Release shop, please enter a valid ICE Token.\nClose this message to access the Local shop.",this.onTokenInput,this.onCancel);
               }
               else
               {
                  this.getHaapiKey(this.openShop);
               }
               return true;
            case msg is ShopArticlesListRequestAction:
               salra = msg as ShopArticlesListRequestAction;
               DofusShopManager.getInstance().getArticlesList(salra.categoryId);
               return true;
            case msg is ShopBuyRequestAction:
               sbra = msg as ShopBuyRequestAction;
               DofusShopManager.getInstance().buyArticle(sbra.articleId,sbra.currency,sbra.amount,sbra.quantity);
               return true;
            case msg is ShopSearchRequestAction:
               ssra = msg as ShopSearchRequestAction;
               DofusShopManager.getInstance().searchForArticles(ssra.text);
               return true;
            case msg is ShopOverlayBuyRequestAction:
               socbra = msg as ShopOverlayBuyRequestAction;
               DofusShopManager.getInstance().overlayBuyArticle(socbra.articleId);
               return true;
            case msg is HavenBagRoomUpdateMessage:
               hbrum = msg as HavenBagRoomUpdateMessage;
               if(hbrum != null && hbrum.roomsPreview != null)
               {
                  if(hbrum.action == HavenBagRoomActionEnum.HAVEN_BAG_ROOM_DISPATCH)
                  {
                     PlayedCharacterManager.getInstance().currentHavenbagRooms = hbrum.roomsPreview;
                     PlayerManager.getInstance().havenbagAvailableRooms = hbrum.roomsPreview;
                     KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableRoomsUpdate,hbrum.roomsPreview);
                  }
                  else
                  {
                     currentList = PlayedCharacterManager.getInstance().currentHavenbagRooms;
                     for(j = 0; j < hbrum.roomsPreview.length; j++)
                     {
                        found = false;
                        for(i = 0; i < currentList.length; i++)
                        {
                           if(currentList[i].roomId == hbrum.roomsPreview[j].roomId)
                           {
                              found = true;
                              currentList[i].themeId = hbrum.roomsPreview[j].themeId;
                              break;
                           }
                        }
                        if(!found)
                        {
                           currentList.push(hbrum.roomsPreview[j]);
                        }
                     }
                     PlayedCharacterManager.getInstance().currentHavenbagRooms = currentList;
                     PlayerManager.getInstance().havenbagAvailableRooms = currentList;
                     KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableRoomsUpdate,currentList);
                  }
               }
               return true;
            case msg is HavenBagPackListMessage:
               hbplmsg = msg as HavenBagPackListMessage;
               validThemes = hbplmsg.packIds;
               commonThemeIndex = validThemes.indexOf(-1);
               if(commonThemeIndex != -1)
               {
                  validThemes.splice(commonThemeIndex,1);
               }
               PlayerManager.getInstance().havenbagAvailableThemes = validThemes;
               KernelEventsManager.getInstance().processCallback(HookList.HavenbagAvailableThemesUpdate,hbplmsg.packIds);
               return true;
            case msg is OpenBakRequestAction:
               this.getHaapiKey(this.openBak);
               return true;
            case msg is RefreshBakOffersAction:
               DofusBakManager.getInstance().refreshOffers();
               return true;
            case msg is OpenCodesAndGiftRequestAction:
               this.getHaapiKey(this.openCodesAndGift);
               return true;
            case msg is ConsumeCodeAction:
               CodesAndGiftManager.getInstance().consumeCode((msg as ConsumeCodeAction).code);
               return true;
            case msg is ConsumeSimpleKardAction:
               CodesAndGiftManager.getInstance().consumeKard((msg as ConsumeSimpleKardAction).id);
               return true;
            case msg is UpdateGiftListRequestAction:
               CodesAndGiftManager.getInstance().updatePurchaseList();
               return true;
            case msg is ConsumeMultipleKardAction:
               CodesAndGiftManager.getInstance().consumeKardMultiple((msg as ConsumeMultipleKardAction).id);
               return true;
            default:
               return false;
         }
      }
      
      public function getIceToken(callback:Function = null) : void
      {
         this._tokenRequestHasTimedOut = false;
         if(callback != null)
         {
            this._tokenRequestCallback.push(callback);
         }
         var htrm:HaapiTokenRequestMessage = new HaapiTokenRequestMessage();
         ConnectionsHandler.getConnection().send(htrm);
         this._tokenRequestTimeoutTimer = new BenchmarkTimer(10000,1,"ExternalGameFrame._tokenRequestTimeoutTimer");
         this._tokenRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTokenRequestTimeout);
         this._tokenRequestTimeoutTimer.start();
      }
      
      public function getHaapiKey(callback:Function = null) : void
      {
         this._haapiKeyRequestHasTimedOut = false;
         if(callback != null)
         {
            this._haapiKeyRequestCallback.push(callback);
         }
         var hsakrm:HaapiShopApiKeyRequestMessage = new HaapiShopApiKeyRequestMessage();
         ConnectionsHandler.getConnection().send(hsakrm);
         this._haapiKeyRequestTimeoutTimer = new BenchmarkTimer(10000,1,"ExternalGameFrame._haapiKeyRequestTimeoutTimer");
         this._haapiKeyRequestTimeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onHaapiKeyRequestTimeout);
         this._haapiKeyRequestTimeoutTimer.start();
      }
      
      private function openShop(token:String) : void
      {
         if(!token)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
            return;
         }
         DofusShopManager.getInstance().init(token);
      }
      
      private function openCodesAndGift(apiKey:String) : void
      {
         if(!apiKey)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusShopError,DofusShopEnum.ERROR_AUTHENTICATION_FAILED);
            return;
         }
         CodesAndGiftManager.getInstance().init(apiKey);
      }
      
      private function openBak(token:String) : void
      {
         if(!token)
         {
            KernelEventsManager.getInstance().processCallback(ExternalGameHookList.BakTimeout);
            return;
         }
         DofusBakManager.getInstance().init(token);
      }
      
      private function onTokenRequestTimeout(event:TimerEvent) : void
      {
         this._tokenRequestHasTimedOut = true;
         this.clearTokenRequestTimer();
         this.callOnTokenFunctions("");
      }
      
      private function onHaapiKeyRequestTimeout(event:TimerEvent) : void
      {
         this._haapiKeyRequestHasTimedOut = true;
         this.clearHaapiKeyRequestTimer();
         this.callOnHaapiKeyFunctions("");
      }
      
      private function callOnTokenFunctions(token:String) : void
      {
         var fct:Function = null;
         if(this._tokenRequestCallback.length)
         {
            for each(fct in this._tokenRequestCallback)
            {
               fct(token);
            }
            this._tokenRequestCallback.length = 0;
         }
      }
      
      private function callOnHaapiKeyFunctions(token:String) : void
      {
         var fct:Function = null;
         if(this._haapiKeyRequestCallback.length)
         {
            for each(fct in this._haapiKeyRequestCallback)
            {
               fct(token);
            }
            this._haapiKeyRequestCallback.length = 0;
         }
      }
      
      private function clearTokenRequestTimer() : void
      {
         if(this._tokenRequestTimeoutTimer)
         {
            this._tokenRequestTimeoutTimer.stop();
            this._tokenRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTokenRequestTimeout);
            this._tokenRequestTimeoutTimer = null;
         }
      }
      
      private function clearHaapiKeyRequestTimer() : void
      {
         if(this._haapiKeyRequestTimeoutTimer)
         {
            this._haapiKeyRequestTimeoutTimer.stop();
            this._haapiKeyRequestTimeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onHaapiKeyRequestTimeout);
            this._haapiKeyRequestTimeoutTimer = null;
         }
      }
      
      private function onTokenInput(value:String) : void
      {
         DofusShopManager.getInstance().init(value,true);
      }
      
      private function onCancel() : void
      {
         this.getHaapiKey(this.openShop);
      }
   }
}

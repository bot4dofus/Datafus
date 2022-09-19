package Ankama_Web.ui
{
   import Ankama_Web.enum.WebTabEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.StartupActionObjectTypeEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   
   public class WebBase
   {
      
      public static var currentTabUi:String;
      
      public static var isShopAvailable:Boolean = false;
      
      public static var isCodesAndGiftsAvailable:Boolean = true;
      
      public static const blurFilter:BlurFilter = new BlurFilter(10,10);
      
      public static const SECURE_MODE_ICON:String = "secureModeIcon";
      
      public static const SECURE_MODE:String = "secureMode";
      
      public static const possibleTabs:Array = [WebTabEnum.SHOP_TAB,WebTabEnum.BAK_TAB,WebTabEnum.CODES_AND_GIFTS_TAB];
       
      
      private var _serverHeroicActivated:Boolean = false;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SecurityApi")]
      public var securityApi:SecurityApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var uiCtr:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabShop:ButtonContainer;
      
      public var btn_tabOgrines:ButtonContainer;
      
      public var btn_tabCodesAndGifts:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var tx_line:Texture;
      
      public var tx_horizontalBar1:Texture;
      
      public var tx_horizontalBar2:Texture;
      
      public var tx_notifGift:Texture;
      
      public var tx_warning:Texture;
      
      public var ctr_linemask:GraphicContainer;
      
      public function WebBase()
      {
         super();
      }
      
      public function main(oParams:* = null) : void
      {
         var gift:Object = null;
         var lastTab:String = null;
         this._serverHeroicActivated = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER);
         this.uiApi.me().restoreSnapshotAfterLoading = false;
         this.tx_line.mask = this.ctr_linemask;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_tabOgrines,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabCodesAndGifts,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_tabShop,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(ExternalGameHookList.CodesAndGiftNotificationValue,this.onCodesAndGiftNotificationValue);
         this.sysApi.addHook(ExternalGameHookList.CodesAndGiftEOSWarning,this.onCodesAndGiftEOSWarning);
         this.sysApi.addHook(RoleplayHookList.GiftsWaitingAllocation,this.onCodesAndGiftNotificationValue);
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.tx_notifGift.visible = this.sysApi.getData("giftNotification");
         var giftCount:int = 0;
         for each(gift in this.playerApi.getWaitingGifts())
         {
            if(gift.actionType == StartupActionObjectTypeEnum.OBJECT_GIFT)
            {
               giftCount++;
            }
         }
         if(giftCount > 0)
         {
            this.tx_warning.visible = true;
            this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OUT);
         }
         if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.WEB_SHOP))
         {
            isShopAvailable = true;
         }
         currentTabUi = null;
         this.btn_tabOgrines.visible = this.sysApi.getCurrentServer().gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS && !this._serverHeroicActivated;
         this.btn_tabShop.visible = isShopAvailable && !this._serverHeroicActivated;
         this.btn_tabCodesAndGifts.visible = isCodesAndGiftsAvailable && !this._serverHeroicActivated;
         if(oParams && oParams is Array && oParams[0])
         {
            this.openTab(oParams[0],oParams[1]);
         }
         else
         {
            lastTab = this.sysApi.getSetData("shopLastOpenedTab",WebTabEnum.SHOP_TAB);
            if((this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS || this._serverHeroicActivated) && lastTab == WebTabEnum.BAK_TAB)
            {
               lastTab = WebTabEnum.SHOP_TAB;
            }
            if(!isShopAvailable && lastTab == WebTabEnum.SHOP_TAB || !isCodesAndGiftsAvailable && lastTab == WebTabEnum.CODES_AND_GIFTS_TAB)
            {
               lastTab = WebTabEnum.BAK_TAB;
            }
            if(isCodesAndGiftsAvailable && lastTab == WebTabEnum.VET_RWDS_TAB)
            {
               lastTab = WebTabEnum.CODES_AND_GIFTS_TAB;
            }
            if(possibleTabs.indexOf(lastTab) == -1)
            {
               lastTab = WebTabEnum.SHOP_TAB;
            }
            this.openTab(lastTab);
         }
      }
      
      public function unload() : void
      {
         if(currentTabUi)
         {
            this.uiApi.unloadUi(currentTabUi);
         }
         if(this.uiApi.getUi(SECURE_MODE))
         {
            this.uiApi.unloadUi(SECURE_MODE);
         }
         currentTabUi = null;
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_tabShop:
               this.openTab(WebTabEnum.SHOP_TAB);
               break;
            case this.btn_tabOgrines:
               this.openTab(WebTabEnum.BAK_TAB);
               break;
            case this.btn_tabCodesAndGifts:
               this.openTab(WebTabEnum.CODES_AND_GIFTS_TAB);
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.uiApi.me().childUiRoot.uiClass.showTabHints();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_warning:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.gift.someGiftsWillBeLost")),target,false,"standard",LocationEnum.POINT_RIGHT,LocationEnum.POINT_LEFT,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function openTab(uiName:String = null, uiParams:Object = null) : void
      {
         this.tx_horizontalBar1.visible = uiName != "webBak";
         this.tx_horizontalBar2.visible = uiName != "webBak";
         var shieldUp:* = this.uiApi.getUi(SECURE_MODE_ICON) == null;
         if(!shieldUp)
         {
            if(!this.uiApi.getUi(SECURE_MODE))
            {
               if(currentTabUi)
               {
                  this.uiApi.getUi(currentTabUi).filters = [blurFilter];
                  this.uiApi.getUi(currentTabUi).disabled = true;
               }
               this.uiApi.loadUiInside("Ankama_Common::secureMode",this.uiCtr,SECURE_MODE,{
                  "reboot":false,
                  "callBackOnSecured":this.onSecureConfirmed,
                  "callBackOnSecuredParams":[uiName,uiParams],
                  "callBackOnCancelled":this.onSecureRequestCancelled,
                  "offset":new Point(-550,-430)
               });
               this.updateSelectedTab(uiName);
            }
            return;
         }
         if(uiName == currentTabUi)
         {
            return;
         }
         if(this.uiApi.getUi(SECURE_MODE))
         {
            this.uiApi.unloadUi(SECURE_MODE);
         }
         if(currentTabUi == WebTabEnum.SHOP_TAB)
         {
            this.sysApi.dispatchHook(ExternalGameHookList.DofusShopSwitchTab,null);
         }
         if(currentTabUi)
         {
            this.uiApi.unloadUi(currentTabUi);
         }
         currentTabUi = uiName;
         this.sysApi.setData("shopLastOpenedTab",currentTabUi);
         this.updateSelectedTab();
         this.uiApi.loadUiInside(currentTabUi,this.uiCtr,currentTabUi,uiParams);
      }
      
      private function onSecureConfirmed(params:Array) : void
      {
         this.openTab(params[0],params[1]);
      }
      
      private function onSecureRequestCancelled() : void
      {
         if(currentTabUi)
         {
            this.uiApi.getUi(currentTabUi).filters = null;
            this.uiApi.getUi(currentTabUi).disabled = false;
            this.updateSelectedTab();
         }
      }
      
      private function updateSelectedTab(uiName:String = "") : void
      {
         if(!uiName)
         {
            uiName = currentTabUi;
         }
         switch(uiName)
         {
            case WebTabEnum.SHOP_TAB:
               this.btn_tabShop.selected = true;
               break;
            case WebTabEnum.BAK_TAB:
               this.btn_tabOgrines.selected = true;
               break;
            case WebTabEnum.CODES_AND_GIFTS_TAB:
               this.btn_tabCodesAndGifts.selected = true;
         }
      }
      
      private function onCodesAndGiftNotificationValue(show:Boolean) : void
      {
         this.tx_notifGift.visible = show;
      }
      
      private function onCodesAndGiftEOSWarning(show:Boolean) : void
      {
         if(this.tx_warning.visible != show)
         {
            this.tx_warning.visible = show;
            if(show)
            {
               this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               this.uiApi.removeComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(this.tx_warning,ComponentHookList.ON_ROLL_OUT);
            }
         }
      }
   }
}

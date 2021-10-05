package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PopupApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class PayZone
   {
      
      public static const PAY_ZONE_MODE:String = "payzone";
      
      public static const PAY_ZONE_JOB_MODE:String = "payzone_job";
      
      public static const PAY_ZONE_HAVENBAG_MODE:String = "payzone_havenbag";
      
      private static const POPUP_PAYZONE_HAVENBAG_ID:uint = 22;
      
      private static const POPUP_PAYZONE_JOB_ID:uint = 16;
      
      private static const POPUP_PAYZONE_MAP_ID:uint = 21;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PopupApi")]
      public var popupApi:PopupApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _mode:String;
      
      private var _title:String;
      
      private var _popupId:uint;
      
      private var _buttonText:String;
      
      private var _popupName:String;
      
      public var btn_topLeft:ButtonContainer;
      
      public var bgTexturebtn_topLeft:Texture;
      
      public function PayZone()
      {
         super();
      }
      
      public function main(args:Array) : void
      {
         this.sysApi.addHook(HookList.NonSubscriberPopup,this.onNonSubscriberPopup);
         this.sysApi.addHook(HookList.SubscriptionZone,this.onSubscriptionZone);
         this.sysApi.addHook(HookList.GuestLimitationPopup,this.onGuestLimitationPopup);
         this.sysApi.addHook(HookList.GuestMode,this.onGuestMode);
         this.uiApi.addComponentHook(this.btn_topLeft,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_topLeft,ComponentHookList.ON_ROLL_OUT);
         this._mode = args[0];
         this.bgTexturebtn_topLeft.uri = this.uiApi.createUri(this.uiApi.me().getConstant("uri_payzone"));
         this._title = this.uiApi.getText("ui.payzone.title");
         this._buttonText = this.uiApi.getText("ui.header.subscribe");
         this.updateDescriptionAccordingToMode();
         if(args.length > 1)
         {
            this.showPopup(args[1]);
         }
         if(args.length > 2)
         {
            this.btn_topLeft.visible = args[2];
         }
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi(this._popupName);
      }
      
      private function showPopup(show:Boolean) : void
      {
         if(show && !this.uiApi.getUi(this._popupName))
         {
            this.popupApi.showPopup(this._popupId);
         }
         else if(!show)
         {
            this.uiApi.unloadUi(this._popupName);
         }
      }
      
      private function updateDescriptionAccordingToMode() : void
      {
         if(this._mode == PAY_ZONE_MODE)
         {
            this._popupId = POPUP_PAYZONE_MAP_ID;
         }
         else if(this._mode == PAY_ZONE_JOB_MODE)
         {
            this._popupId = POPUP_PAYZONE_JOB_ID;
         }
         else if(this._mode == PAY_ZONE_HAVENBAG_MODE)
         {
            this._popupId = POPUP_PAYZONE_HAVENBAG_ID;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_topLeft)
         {
            this.showPopup(true);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         switch(target)
         {
            case this.btn_topLeft:
               tooltipText = this._title;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,10,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onGuestLimitationPopup() : void
      {
         this.showPopup(true);
      }
      
      private function onGuestMode(active:Boolean) : void
      {
         if(active)
         {
            this.btn_topLeft.visible = true;
            this.showPopup(true);
         }
         else if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onNonSubscriberPopup(payZonePopupMode:String = "payzone") : void
      {
         this._mode = payZonePopupMode;
         this.updateDescriptionAccordingToMode();
         this.showPopup(true);
      }
      
      private function onSubscriptionZone(active:Boolean) : void
      {
         var payZonePopupAlreadySeen:Boolean = false;
         if(active)
         {
            this._mode = PAY_ZONE_MODE;
            this.updateDescriptionAccordingToMode();
            this.btn_topLeft.visible = true;
            payZonePopupAlreadySeen = this.sysApi.getData("payZonePopupAlreadySeen",DataStoreEnum.BIND_COMPUTER);
            if(!payZonePopupAlreadySeen)
            {
               this.showPopup(true);
            }
            this.sysApi.setData("payZonePopupAlreadySeen",true,DataStoreEnum.BIND_COMPUTER);
         }
         else if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
   }
}

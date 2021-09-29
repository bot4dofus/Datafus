package Ankama_Web.ui
{
   import Ankama_Web.enum.BakPopupTypeEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class BakPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var tx_topPinMark:Texture;
      
      public var tx_botPinMark:Texture;
      
      public var tx_money1:Texture;
      
      public var tx_money2:Texture;
      
      public var tx_rate:Texture;
      
      public var lbl_title_ctr_popupWindow:Label;
      
      public var lbl_top1:Label;
      
      public var lbl_top2:Label;
      
      public var lbl_top3:Label;
      
      public var lbl_bottom1:Label;
      
      public var lbl_bottom2:Label;
      
      public var btn_lbl_btn_main:Label;
      
      public var lbl_money1:Label;
      
      public var lbl_money2:Label;
      
      public var lbl_for:Label;
      
      public var lbl_btnCancel:Label;
      
      public var ctr_popupMain:GraphicContainer;
      
      public var ctr_blockContent:GraphicContainer;
      
      public var blk_moneyBlock:GraphicContainer;
      
      public var btn_close_ctr_popupWindow:ButtonContainer;
      
      public var btn_cancel:ButtonContainer;
      
      public var btn_main:ButtonContainer;
      
      private var _params:Object;
      
      public function BakPopup()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this.uiApi.addComponentHook(this.btn_close_ctr_popupWindow,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_cancel,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_botPinMark,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_botPinMark,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_topPinMark,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_topPinMark,ComponentHookList.ON_ROLL_OUT);
         this._params = params;
         this.switchPopupType(this._params.type);
         this.updatePopupHeight();
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      private function resizeLabels() : void
      {
         this.lbl_top1.fullSize(this.uiApi.me().getConstant("popWidth"));
         this.lbl_top2.fullSize(this.uiApi.me().getConstant("popWidth"));
         this.lbl_top3.fullSize(this.uiApi.me().getConstant("popWidth"));
         this.lbl_bottom1.fullSize(this.uiApi.me().getConstant("popWidth"));
         this.lbl_bottom2.fullSize(this.uiApi.me().getConstant("popWidth"));
         if(this.lbl_top1.textWidth < this.lbl_top1.width)
         {
            this.lbl_top1.fullWidthAndHeight(0,10);
         }
         if(this.lbl_top2.textWidth < this.lbl_top2.width)
         {
            this.lbl_top2.fullWidthAndHeight(0,10);
         }
         if(this.lbl_top3.textWidth < this.lbl_top3.width)
         {
            this.lbl_top3.fullWidthAndHeight(0,10);
         }
         if(this.lbl_bottom1.textWidth < this.lbl_bottom1.width)
         {
            this.lbl_bottom1.fullWidthAndHeight(0,10);
         }
         if(this.lbl_bottom2.textWidth < this.lbl_bottom2.width)
         {
            this.lbl_bottom2.fullWidthAndHeight(0,10);
         }
         this.lbl_money1.fullWidthAndHeight();
         this.lbl_money2.fullWidthAndHeight();
         this.lbl_for.fullWidthAndHeight();
      }
      
      private function hideLabel(label:Label) : void
      {
         label.text = "";
         label.height = 0;
      }
      
      private function updatePopupHeight() : void
      {
         this.ctr_popupMain.height = parseInt(this.uiApi.me().getConstant("popHeight")) + this.lbl_top1.height + this.lbl_top2.height + this.lbl_top3.height + this.lbl_bottom1.height + this.lbl_bottom2.height + this.blk_moneyBlock.height;
      }
      
      private function switchPopupType(type:String) : void
      {
         switch(type)
         {
            case BakPopupTypeEnum.BUY_OGRINES:
            case BakPopupTypeEnum.SUBMIT_OFFER_OGRINES:
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.confirm");
               this.lbl_top1.text = this.uiApi.getText(type == BakPopupTypeEnum.BUY_OGRINES ? "ui.bak.popupWillBuy" : "ui.bak.popupWillOffer");
               this.hideLabel(this.lbl_top2);
               this.hideLabel(this.lbl_top3);
               this.lbl_money1.text = this.utilApi.kamasToString(this._params.additionalParams["ogrines"],"");
               this.lbl_money2.text = this.utilApi.kamasToString(this._params.additionalParams["kamas"],"");
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupAtRate",this.utilApi.kamasToString(this._params.additionalParams["rate"],""));
               this.hideLabel(this.lbl_bottom2);
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.bak.popupConfirm");
               this.btn_cancel.visible = true;
               this.tx_money1.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri_big"));
               this.tx_money2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("kam_uri_shad"));
               this.ctr_blockContent.x = -12;
               this.resizeLabels();
               break;
            case BakPopupTypeEnum.BUY_OGRINES_VALIDATED:
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.congratulation");
               this.lbl_top1.text = this.uiApi.getText("ui.bak.popupPurchaseValidated");
               this.lbl_top2.text = this.uiApi.getText("ui.bak.popupOgrinesCredited");
               this.lbl_top3.text = this.uiApi.getText("ui.bak.popupOgrinesLinked");
               this.tx_topPinMark.visible = true;
               this.lbl_money1.text = this.utilApi.kamasToString(this._params.additionalParams["amount"],"");
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupMailSent");
               this.lbl_bottom2.text = this._params.additionalParams["email"];
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.common.ok");
               this.tx_money1.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri_big"));
               this.hideLabel(this.lbl_for);
               this.hideLabel(this.lbl_money2);
               this.tx_rate.width = 0;
               this.resizeLabels();
               break;
            case BakPopupTypeEnum.BUY_KAMAS:
            case BakPopupTypeEnum.SUBMIT_OFFER_KAMAS:
               if(type == BakPopupTypeEnum.BUY_KAMAS)
               {
                  this.lbl_top1.text = this.uiApi.getText("ui.bak.popupWillBuy");
                  if(this._params.additionalParams["kamas"] - this._params.additionalParams["initialKamas"] > 0)
                  {
                     this.tx_botPinMark.visible = true;
                     this.lbl_bottom2.text = this.uiApi.getText("ui.bak.popupRounding",this.utilApi.kamasToString(this._params.additionalParams["kamas"] - this._params.additionalParams["initialKamas"],""),this.utilApi.kamasToString(this._params.additionalParams["kamas"],""));
                  }
                  else
                  {
                     this.hideLabel(this.lbl_bottom2);
                  }
               }
               else
               {
                  this.lbl_top1.text = this.uiApi.getText("ui.bak.popupWillOffer");
                  this.hideLabel(this.lbl_bottom2);
                  this.tx_botPinMark.visible = false;
               }
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.confirm");
               this.hideLabel(this.lbl_top2);
               this.hideLabel(this.lbl_top3);
               this.lbl_money1.text = this.utilApi.kamasToString(this._params.additionalParams["kamas"],"");
               this.lbl_money2.text = this.utilApi.kamasToString(this._params.additionalParams["ogrines"],"");
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupAtRate",this.utilApi.kamasToString(this._params.additionalParams["rate"],""));
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.bak.popupConfirm");
               this.btn_cancel.visible = true;
               this.tx_money2.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ogr_uri_big"));
               this.tx_money1.uri = this.uiApi.createUri(this.uiApi.me().getConstant("kam_uri_shad"));
               this.ctr_blockContent.x = -12;
               this.resizeLabels();
               this.tx_botPinMark.x = Math.abs(this.lbl_bottom2.textWidth - this.uiApi.getTextSize(this.lbl_bottom2.text,this.lbl_bottom2.css,this.lbl_bottom2.cssClass).width) / 2 + 5;
               break;
            case BakPopupTypeEnum.BUY_KAMAS_VALIDATED:
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.congratulation");
               this.lbl_top1.text = this.uiApi.getText("ui.bak.popupPurchaseValidated");
               this.lbl_top2.text = this.uiApi.getText("ui.bak.popupKamasCredited");
               this.hideLabel(this.lbl_top3);
               this.lbl_money1.text = this.utilApi.kamasToString(this._params.additionalParams["amount"],"");
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupMailSent");
               this.lbl_bottom2.text = this._params.additionalParams["email"];
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.common.ok");
               this.tx_money1.uri = this.uiApi.createUri(this.uiApi.me().getConstant("kam_uri_shad"));
               this.hideLabel(this.lbl_for);
               this.hideLabel(this.lbl_money2);
               this.tx_rate.width = 0;
               this.resizeLabels();
               break;
            case BakPopupTypeEnum.VALIDATE_OFFER:
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.congratulation");
               this.hideLabel(this.lbl_top1);
               this.lbl_top2.text = this.uiApi.getText("ui.bak.popupConfirmOffer");
               this.blk_moneyBlock.height = 0;
               this.blk_moneyBlock.visible = false;
               this.ctr_blockContent.visible = false;
               this.hideLabel(this.lbl_top3);
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupOfferDelay");
               this.hideLabel(this.lbl_bottom2);
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.common.ok");
               this.tx_rate.width = 0;
               this.resizeLabels();
               break;
            case BakPopupTypeEnum.CANCEL_OFFER_KAMAS:
            case BakPopupTypeEnum.CANCEL_OFFER_OGRINES:
               this.lbl_title_ctr_popupWindow.text = this.uiApi.getText("ui.common.confirm");
               this.lbl_top1.text = this.uiApi.getText("ui.bak.popupCancelOffer");
               this.hideLabel(this.lbl_top2);
               this.hideLabel(this.lbl_top3);
               this.lbl_bottom1.text = this.uiApi.getText("ui.bak.popupAtRate",this.utilApi.kamasToString(this._params.additionalParams["bid"].rate,""));
               this.lbl_bottom2.text = this.uiApi.getText("ui.bak.popupPartialCancel");
               this.btn_lbl_btn_main.text = this.uiApi.getText("ui.bak.popupCancelOfferBtn");
               this.lbl_btnCancel.text = this.uiApi.getText("ui.bak.popupKeepOffer");
               this.btn_cancel.visible = true;
               this.lbl_money1.text = this.utilApi.kamasToString(this._params.additionalParams["bid"].sale_quantity,"");
               this.lbl_money2.text = this.utilApi.kamasToString(this._params.additionalParams["bid"].exchange_quantity,"");
               this.tx_money1.uri = this.uiApi.createUri(this.uiApi.me().getConstant(type == BakPopupTypeEnum.CANCEL_OFFER_OGRINES ? "ogr_uri_big" : "kam_uri_shad"));
               this.tx_money2.uri = this.uiApi.createUri(this.uiApi.me().getConstant(type == BakPopupTypeEnum.CANCEL_OFFER_OGRINES ? "kam_uri_shad" : "ogr_uri_big"));
               this.ctr_blockContent.x = -12;
               this.resizeLabels();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_main && this._params.buttonCallback)
         {
            this._params.buttonCallback.apply();
         }
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.tx_topPinMark:
               text = this.uiApi.getText("ui.bak.linkedOgrines");
               break;
            case this.tx_botPinMark:
               text = this.uiApi.getText("ui.bak.toolTipPopupRounding");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}

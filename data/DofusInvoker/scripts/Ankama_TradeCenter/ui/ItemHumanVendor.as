package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeBuyAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   
   public class ItemHumanVendor extends BasicItemCard
   {
      
      private static var _self:ItemHumanVendor;
       
      
      private var _popup:String;
      
      public function ItemHumanVendor()
      {
         super();
      }
      
      public static function getInstance() : ItemHumanVendor
      {
         if(_self == null)
         {
            return null;
         }
         return _self;
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         sysApi.addHook(ExchangeHookList.ClickItemShopHV,this.onClickItemShopHV);
         uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         sysApi.addHook(ExchangeHookList.BuyOk,this.onBuyOk);
         _self = this;
         ctr_inputPrice.visible = false;
         btn_lbl_btn_valid.text = uiApi.getText("ui.common.buy");
      }
      
      override public function unload() : void
      {
         if(this._popup)
         {
            uiApi.unloadUi(this._popup);
         }
         this._popup = null;
         super.unload();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btn_valid:
               if(utilApi.stringToKamas(input_quantity.text,"") > _currentObject.quantity || utilApi.stringToKamas(input_quantity.text,"") == 0)
               {
                  if(this._popup == null)
                  {
                     this._popup = modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.invalidQuantity"),[uiApi.getText("ui.common.ok")],[this.onCancel],this.onCancel,this.onCancel);
                  }
                  break;
               }
               if(this._popup == null)
               {
                  this._popup = modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUBuyItemBigStore",input_quantity.text + " x " + _currentObject.name,utilApi.kamasToString(_currentPrice),utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,""))),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmBuyObject,this.onCancel],this.onConfirmBuyObject,this.onCancel);
               }
               break;
         }
      }
      
      private function onConfirmBuyObject() : void
      {
         this._popup = null;
         sysApi.sendAction(new ExchangeBuyAction([_currentObject.objectUID,utilApi.stringToKamas(input_quantity.text,"")]));
      }
      
      private function onCancel() : void
      {
         this._popup = null;
      }
      
      public function onClickItemShopHV(pItem:Object, pPrice:Number = 0, method:int = 0) : void
      {
         if(method != SelectMethodEnum.FIRST_ITEM)
         {
            _currentPrice = pPrice;
            onObjectSelected(pItem);
            lbl_price.text = utilApi.kamasToString(_currentPrice,"");
            input_quantity.text = "1";
            input_quantity.setSelection(0,8388607);
            input_quantity.focus();
            lbl_totalPrice.text = utilApi.kamasToString(_currentPrice,"");
         }
         else
         {
            sysApi.dispatchHook(ChatHookList.TextInformation,uiApi.getText("ui.humanVendor.alreadyBought",_currentObject.name),666,timeApi.getTimestamp());
            this.unload();
            mainCtr.visible = false;
         }
      }
      
      public function onShortcut(pShortcut:String) : Boolean
      {
         switch(pShortcut)
         {
            case ShortcutHookListEnum.VALID_UI:
               if(input_quantity.haveFocus)
               {
                  this.onRelease(btn_valid);
                  return true;
               }
               break;
         }
         return false;
      }
      
      override public function onChange(target:GraphicContainer) : void
      {
         if(target == input_quantity)
         {
            if(utilApi.stringToKamas(input_quantity.text,"") > _currentObject.quantity)
            {
               lbl_totalPrice.text = utilApi.kamasToString(_currentPrice * _currentObject.quantity,"");
               input_quantity.text = utilApi.kamasToString(_currentObject.quantity,"");
            }
            else
            {
               lbl_totalPrice.text = utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,""),"");
            }
            super.checkPlayerFund(utilApi.stringToKamas(input_quantity.text));
         }
      }
      
      private function onBuyOk() : void
      {
         hideCard();
      }
   }
}

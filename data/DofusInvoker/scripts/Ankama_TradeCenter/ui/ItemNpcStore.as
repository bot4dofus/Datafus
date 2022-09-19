package Ankama_TradeCenter.ui
{
   import Ankama_TradeCenter.TradeCenter;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeSellAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class ItemNpcStore extends BasicItemCard
   {
       
      
      private var _mode:Boolean;
      
      private var _token:int;
      
      public function ItemNpcStore()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         super.main(params);
         sysApi.addHook(ExchangeHookList.ClickItemStore,this.onClickItemStore);
         sysApi.addHook(ExchangeHookList.ClickItemInventory,this.onClickItemInventory);
         sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         sysApi.addHook(ExchangeHookList.SellOk,this.onSellOk);
         sysApi.addHook(ExchangeHookList.BuyOk,this.onBuyOk);
         super.tx_inputQuantity.visible = true;
         super.input_quantity.numberMax = 999999999;
         if(this._token != 0)
         {
            super.tx_kama.visible = false;
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var r:RegExp = null;
         var tokenName:String = null;
         switch(target)
         {
            case btn_valid:
               r = /^\s*(.*?)\s*$/g;
               input_quantity.text = input_quantity.text.replace(r,"$1");
               input_price.text = input_price.text.replace(r,"$1");
               tokenName = "";
               if(this._token)
               {
                  tokenName = "x " + dataApi.getItemName(this._token);
               }
               if(this._mode)
               {
                  if(utilApi.stringToKamas(input_quantity.text,"") <= 0 || utilApi.stringToKamas(input_quantity.text,"") > _currentObject.quantity)
                  {
                     modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.invalidQuantity"),[uiApi.getText("ui.common.ok")]);
                     break;
                  }
                  if(!tokenName)
                  {
                     modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUSellItemWithoutTax",input_quantity.text + " x " + _currentObject.name,utilApi.kamasToString(_currentPrice),utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,"")),utilApi.kamasToString(0)),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmSellObject,this.onCancel],this.onConfirmSellObject,this.onCancel);
                  }
                  else
                  {
                     modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUSellItemWithoutTax",input_quantity.text + " x " + _currentObject.name,utilApi.kamasToString(_currentPrice,tokenName),utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,""),tokenName),utilApi.kamasToString(0)),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmSellObject,this.onCancel],this.onConfirmSellObject,this.onCancel);
                  }
               }
               else
               {
                  if(utilApi.stringToKamas(input_quantity.text,"") <= 0)
                  {
                     modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.invalidQuantity"),[uiApi.getText("ui.common.ok")]);
                     break;
                  }
                  if(tokenName == "")
                  {
                     modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUBuyItemBigStore",input_quantity.text + " x " + _currentObject.name,utilApi.kamasToString(_currentPrice),utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,""))),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmBuyObject,this.onCancel],this.onConfirmBuyObject,this.onCancel);
                  }
                  else
                  {
                     modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.bidhouse.doUBuyItemBigStore",input_quantity.text + " x " + _currentObject.name,utilApi.kamasToString(_currentPrice,tokenName),utilApi.kamasToString(_currentPrice * utilApi.stringToKamas(input_quantity.text,""),tokenName)),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmBuyObject,this.onCancel],this.onConfirmBuyObject,this.onCancel);
                  }
               }
         }
      }
      
      private function onConfirmSellObject() : void
      {
         sysApi.sendAction(new ExchangeSellAction([_currentObject.objectUID,utilApi.stringToKamas(input_quantity.text,"")]));
      }
      
      private function onConfirmBuyObject() : void
      {
         sysApi.sendAction(new ExchangeBuyAction([_currentObject.objectGID,utilApi.stringToKamas(input_quantity.text,"")]));
      }
      
      private function onCancel() : void
      {
      }
      
      public function onObjectDeleted(pObject:Object) : void
      {
         if(_currentObject.objectUID == pObject.objectUID)
         {
            _currentObject = null;
            super.hideCard();
         }
      }
      
      public function onClickItemStore(pItem:Object, token:int) : void
      {
         this._mode = false;
         onObjectSelected(pItem.itemWrapper);
         ctr_inputPrice.visible = false;
         btn_lbl_btn_valid.text = uiApi.getText("ui.common.buy");
         var item:Object = dataApi.getItem(pItem.itemWrapper.objectGID);
         _currentPrice = pItem.price;
         this._token = token;
         if(this._token != 0)
         {
            tx_kama.visible = false;
         }
         if(token)
         {
            lbl_price.text = utilApi.kamasToString(_currentPrice,"");
         }
         else
         {
            lbl_price.text = utilApi.kamasToString(_currentPrice);
         }
         input_quantity.text = "1";
         input_quantity.focus();
         input_quantity.setSelection(0,8388607);
         if(token)
         {
            lbl_totalPrice.text = utilApi.kamasToString(_currentPrice,"");
         }
         else
         {
            lbl_totalPrice.text = utilApi.kamasToString(_currentPrice,"");
         }
      }
      
      public function onClickItemInventory(pItem:Object = null) : void
      {
         var item:Object = null;
         var price:Number = NaN;
         this._mode = true;
         if(this._token == 0)
         {
            sysApi.log(2,"clic inventaire");
            onObjectSelected(pItem);
            ctr_inputPrice.visible = false;
            btn_lbl_btn_valid.text = uiApi.getText("ui.common.sell");
            if(pItem != null)
            {
               item = dataApi.getItem(pItem.objectGID);
               price = 0;
               _currentPrice = item.price;
               if(_currentPrice > 0)
               {
                  if(_currentPrice / TradeCenter.SELLING_RATIO < 1)
                  {
                     price = 1;
                  }
                  else
                  {
                     price = Math.floor(_currentPrice / TradeCenter.SELLING_RATIO);
                  }
               }
               _currentPrice = price;
               lbl_price.text = utilApi.kamasToString(_currentPrice);
               input_quantity.text = "1";
               input_quantity.focus();
               input_quantity.setSelection(0,8388607);
               lbl_totalPrice.text = utilApi.kamasToString(_currentPrice,"");
            }
         }
      }
      
      override public function onChange(target:GraphicContainer) : void
      {
         var quantity:int = 0;
         if(target == input_quantity)
         {
            quantity = utilApi.stringToKamas(input_quantity.text);
            if(this._mode)
            {
               if(quantity > _currentObject.quantity)
               {
                  input_quantity.text = _currentObject.quantity;
                  quantity = _currentObject.quantity;
               }
            }
            if(this._token)
            {
               lbl_totalPrice.text = utilApi.kamasToString(_currentPrice * quantity,"");
            }
            else
            {
               lbl_totalPrice.text = utilApi.kamasToString(_currentPrice * quantity,"");
            }
            if(!this._mode)
            {
               super.checkPlayerFund(quantity,this._token);
            }
            else
            {
               super.checkPlayerFund(0);
            }
         }
      }
      
      private function onSellOk() : void
      {
         hideCard();
      }
      
      private function onBuyOk() : void
      {
         hideCard();
      }
   }
}

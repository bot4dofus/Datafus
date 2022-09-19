package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentAddAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   
   public class ItemMyselfVendor extends BasicItemCard
   {
      
      public static const SELL_MOD:String = "sell_mod";
      
      public static const MODIFY_REMOVE_MOD:String = "modify_remove_mod";
      
      private static var _self:ItemMyselfVendor;
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      private var _currentMod:String;
      
      public var ctr_error:GraphicContainer;
      
      public var ctr_bg:GraphicContainer;
      
      public var lbl_error:Label;
      
      public function ItemMyselfVendor()
      {
         super();
      }
      
      public static function getInstance() : ItemMyselfVendor
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
         btn_valid.soundId = SoundEnum.MERCHANT_SELL_BUTTON;
         btn_remove.soundId = SoundEnum.MERCHANT_REMOVE_SELL_BUTTON;
         sysApi.addHook(ExchangeHookList.ClickItemInventory,this.onClickItemInventory);
         sysApi.addHook(ExchangeHookList.ClickItemShopHV,this.onClickItemShopHV);
         sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         sysApi.addHook(ExchangeHookList.ExchangeShopStockUpdate,this.onExchangeShopStockUpdate);
         uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         _self = this;
         lbl_price.visible = false;
         btn_lbl_btn_valid.text = uiApi.getText("ui.common.putOnSell");
      }
      
      private function switchMode(value:Boolean) : void
      {
         btn_valid.visible = value;
         btn_modify.visible = !value;
         btn_remove.visible = !value;
      }
      
      private function displayObject(item:Object) : void
      {
         onObjectSelected(item);
         if(item && item.isSaleable)
         {
            if(_currentPrice > 0)
            {
               input_price.text = utilApi.kamasToString(_currentPrice,"");
            }
            else
            {
               input_price.text = "0";
            }
            input_quantity.text = utilApi.kamasToString(_currentObject.quantity,"");
            input_price.focus();
            input_price.setSelection(0,8388607);
            lbl_totalPrice.text = utilApi.kamasToString(_currentPrice * item.quantity,"");
            this.ctr_error.visible = false;
            this.ctr_bg.visible = true;
            tx_kama.visible = true;
         }
         else if(item && !item.isSaleable)
         {
            this.lbl_error.text = uiApi.getText("ui.bidhouse.notSaleable");
            this.ctr_error.visible = true;
            this.ctr_bg.visible = false;
            btn_valid.visible = false;
            btn_modify.visible = false;
            btn_remove.visible = false;
            tx_kama.visible = false;
         }
      }
      
      private function checkQuantity() : Boolean
      {
         var r:RegExp = /^\s*(.*?)\s*$/g;
         input_quantity.text = input_quantity.text.replace(r,"$1");
         input_price.text = input_price.text.replace(r,"$1");
         if(input_quantity.text == "" || input_price.text == "")
         {
            modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.allFieldsRequired"),[uiApi.getText("ui.common.ok")]);
            return false;
         }
         if(utilApi.stringToKamas(input_quantity.text,"") <= 0)
         {
            modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.invalidQuantity"),[uiApi.getText("ui.common.ok")]);
            return false;
         }
         if(utilApi.stringToKamas(input_price.text,"") <= 0)
         {
            modCommon.openPopup(uiApi.getText("ui.common.error"),uiApi.getText("ui.error.invalidPrice"),[uiApi.getText("ui.common.ok")]);
            return false;
         }
         return true;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var quantityChanged:* = false;
         var priceChanged:* = false;
         switch(target)
         {
            case btn_valid:
               if(this.checkQuantity())
               {
                  sysApi.sendAction(new ExchangeShopStockMouvmentAddAction([_currentObject.objectUID,utilApi.stringToKamas(input_quantity.text,""),utilApi.stringToKamas(input_price.text,"")]));
               }
               break;
            case btn_modify:
               quantityChanged = utilApi.stringToKamas(input_quantity.text,"") != _currentObject.quantity;
               priceChanged = utilApi.stringToKamas(input_price.text,"") != _currentPrice;
               if(this.checkQuantity())
               {
                  if(quantityChanged && priceChanged)
                  {
                     sysApi.sendAction(new ExchangeObjectModifyPricedAction([_currentObject.objectUID,int(input_quantity.text),utilApi.stringToKamas(input_price.text,"")]));
                  }
                  else
                  {
                     if(quantityChanged)
                     {
                        sysApi.sendAction(new ExchangeObjectModifyPricedAction([_currentObject.objectUID,utilApi.stringToKamas(input_quantity.text,""),0]));
                     }
                     if(priceChanged)
                     {
                        sysApi.sendAction(new ExchangeObjectModifyPricedAction([_currentObject.objectUID,0,utilApi.stringToKamas(input_price.text,"")]));
                     }
                  }
               }
               break;
            case btn_remove:
               sysApi.sendAction(new ExchangeShopStockMouvmentRemoveAction([_currentObject.objectUID,utilApi.stringToKamas(input_quantity.text,"")]));
         }
      }
      
      override public function onChange(target:GraphicContainer) : void
      {
         var itemQuantityInInventory:uint = 0;
         var itemQuantityInStock:uint = 0;
         var price:Number = NaN;
         if(target == input_quantity)
         {
            itemQuantityInInventory = this.inventoryApi.getItemQty(_currentObject.objectGID);
            itemQuantityInStock = _currentObject.quantity;
            switch(this._currentMod)
            {
               case SELL_MOD:
                  if(utilApi.stringToKamas(input_quantity.text,"") > itemQuantityInStock)
                  {
                     input_quantity.text = utilApi.kamasToString(itemQuantityInStock,"");
                  }
                  break;
               case MODIFY_REMOVE_MOD:
                  if(utilApi.stringToKamas(input_quantity.text,"") > itemQuantityInInventory + itemQuantityInStock)
                  {
                     input_quantity.text = utilApi.kamasToString(itemQuantityInInventory + itemQuantityInStock,"");
                  }
            }
            lbl_totalPrice.text = utilApi.kamasToString(utilApi.stringToKamas(input_price.text,"") * utilApi.stringToKamas(input_quantity.text,""),"");
         }
         else if(target == input_price)
         {
            price = utilApi.stringToKamas(input_price.text,"");
            if(price > ProtocolConstantsEnum.MAX_KAMA)
            {
               price = ProtocolConstantsEnum.MAX_KAMA;
            }
            lbl_totalPrice.text = utilApi.kamasToString(price * utilApi.stringToKamas(input_quantity.text,""),"");
         }
      }
      
      public function onObjectDeleted(pObject:Object) : void
      {
         if(_currentObject.objectUID == pObject.objectUID)
         {
            hideCard();
         }
      }
      
      public function onClickItemShopHV(pItem:Object, pPrice:Number = 0, method:int = 0) : void
      {
         if(!uiVisible)
         {
            this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
         }
         this._currentMod = MODIFY_REMOVE_MOD;
         _currentPrice = pPrice;
         this.switchMode(false);
         this.displayObject(pItem);
      }
      
      public function onClickItemInventory(pItem:Object) : void
      {
         if(!uiVisible)
         {
            this.soundApi.playSound(SoundTypeEnum.MERCHANT_TRANSFERT_OPEN);
         }
         this._currentMod = SELL_MOD;
         _currentPrice = 0;
         this.switchMode(true);
         this.displayObject(pItem);
      }
      
      protected function onExchangeShopStockUpdate(itemList:Object, newItem:Object = null) : void
      {
         if(newItem && newItem.objectGID == _currentObject.objectGID && newItem.objectUID == _currentObject.objectUID)
         {
            _currentObject = newItem;
         }
      }
      
      public function onShortcut(pShortcut:String) : Boolean
      {
         switch(pShortcut)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               break;
            case ShortcutHookListEnum.VALID_UI:
               if(this._currentMod == SELL_MOD)
               {
                  this.onRelease(btn_valid);
               }
               else if(input_price.haveFocus || input_quantity.haveFocus)
               {
                  this.onRelease(btn_modify);
               }
               return true;
         }
         return false;
      }
   }
}

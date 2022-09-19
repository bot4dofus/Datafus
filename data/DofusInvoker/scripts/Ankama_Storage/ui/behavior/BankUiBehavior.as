package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.BankUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class BankUiBehavior implements IStorageBehavior
   {
       
      
      protected var _bank:BankUi;
      
      private var _objectToExchange:Object;
      
      public function BankUiBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return data.position == 63;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         var quantityMax:uint = 0;
         var weightLeft:uint = 0;
         if(this.dropValidator(target,data,source))
         {
            if(data.quantity > 1)
            {
               this._objectToExchange = data;
               quantityMax = data.quantity;
               if(this._bank.getWeightMax() > 0)
               {
                  weightLeft = this._bank.getWeightMax() - this._bank.getWeight();
                  if(data.realWeight * data.quantity > weightLeft)
                  {
                     quantityMax = Math.floor(weightLeft / data.realWeight);
                  }
               }
               Api.common.openQuantityPopup(1,quantityMax,quantityMax,this.onValidQty);
            }
            else
            {
               Api.system.sendAction(new ExchangeObjectMoveAction([data.objectUID,1]));
            }
         }
      }
      
      private function onValidNegativeQty(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,-qty]));
      }
      
      public function onValidQtyDrop(qty:Number) : void
      {
      }
      
      private function onValidQty(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,qty]));
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this._bank.lbl_kamas:
               this._bank.uiApi.hideTooltip();
               if(this._bank.kamas > 0)
               {
                  Api.common.openQuantityPopup(1,this._bank.kamas,this._bank.kamas,this.onValidQtyKama);
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedItem:Object = null;
         var weight:uint = 0;
         var maxWeight:uint = 0;
         var quantityMax:uint = 0;
         var weightLeft:uint = 0;
         switch(target)
         {
            case this._bank.grid:
               selectedItem = this._bank.grid.selectedItem;
               if(selectMethod == SelectMethodEnum.CLICK)
               {
                  Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,selectedItem);
               }
               else if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  if(this.bankContainItem(selectedItem.objectUID))
                  {
                     Api.system.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-1]));
                  }
               }
               else if(selectMethod == SelectMethodEnum.CTRL_DOUBLE_CLICK)
               {
                  if(this.bankContainItem(selectedItem.objectUID))
                  {
                     weight = Api.player.inventoryWeight();
                     maxWeight = Api.player.inventoryWeightMax();
                     quantityMax = selectedItem.quantity;
                     weightLeft = maxWeight - weight;
                     if(selectedItem.realWeight * selectedItem.quantity > weightLeft)
                     {
                        quantityMax = Math.floor(weightLeft / selectedItem.realWeight);
                     }
                     Api.system.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-quantityMax]));
                  }
               }
               else if(selectMethod == SelectMethodEnum.ALT_DOUBLE_CLICK)
               {
                  this._objectToExchange = (target as Grid).selectedItem;
                  Api.common.openQuantityPopup(1,(target as Grid).selectedItem.quantity,(target as Grid).selectedItem.quantity,this.onValidNegativeQty);
               }
         }
      }
      
      public function onDisplayAssociatedRunes(item:ItemWrapper, onClickOnItem:Boolean) : void
      {
         if(onClickOnItem && item == null)
         {
            this._bank.onRelease(this._bank.getButtonFromCategory(this._bank.categoryFilter));
            return;
         }
         if(this._bank.categoryFilter == ItemCategoryEnum.RESOURCES_CATEGORY || this._bank.categoryFilter == ItemCategoryEnum.ALL_CATEGORY)
         {
            if(this._bank.displayAssociatedRunes(item,onClickOnItem))
            {
               Api.storage.enableBankAssociatedRunesFilter(item);
               Api.storage.releaseBankHooks();
            }
         }
         else
         {
            if(onClickOnItem)
            {
               return;
            }
            if(this._bank.displayAssociatedRunes(item,false))
            {
               Api.storage.enableBankAssociatedRunesFilter(item);
               Api.storage.releaseBankHooks();
            }
         }
      }
      
      public function attach(bankUi:AbstractStorageUi) : void
      {
         if(!(bankUi is BankUi))
         {
            throw new Error("Can\'t attach a BankUiBehavior to a non BankUi storage");
         }
         this._bank = bankUi as BankUi;
         this._bank.questVisible = false;
         this._bank.btn_moveAllToRight.visible = true;
         this._bank.lbl_kamas.mouseEnabled = true;
         this._bank.lbl_kamas.handCursor = true;
         Api.system.addHook(ExchangeHookList.DisplayAssociatedRunes,this.onDisplayAssociatedRunes);
      }
      
      public function detach() : void
      {
         this._bank.questVisible = true;
         this._bank.btn_moveAllToRight.visible = false;
         Api.system.removeHook(ExchangeHookList.DisplayAssociatedRunes);
      }
      
      public function onUnload() : void
      {
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.BANK_UI;
      }
      
      public function getName() : String
      {
         return StorageState.BANK_UI_MOD;
      }
      
      public function get replacable() : Boolean
      {
         return false;
      }
      
      private function onValidQtyKama(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveKamaAction([-qty]));
      }
      
      private function bankContainItem(uid:uint) : Boolean
      {
         var i:int = 0;
         var dataProvider:* = this._bank.grid.dataProvider;
         var len:int = dataProvider.length;
         for(i = 0; i < len; i++)
         {
            if(dataProvider[i].objectUID == uid)
            {
               return true;
            }
         }
         return false;
      }
      
      public function transfertAll() : void
      {
         this._bank.itemWithAssociatedRunesDisplayed = null;
         Api.storage.disableBankAssociatedRunesFilter();
         Api.system.sendAction(new ExchangeObjectTransfertAllToInvAction([]));
      }
      
      public function transfertList() : void
      {
         this._bank.itemWithAssociatedRunesDisplayed = null;
         Api.storage.disableBankAssociatedRunesFilter();
         Api.system.sendAction(new ExchangeObjectTransfertListToInvAction([this._bank.itemsDisplayed]));
      }
      
      public function transfertExisting() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertExistingToInvAction([]));
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
   }
}

package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class ExchangeBehavior implements IStorageBehavior
   {
       
      
      private var _storage:StorageUi;
      
      private var _objectToExchange:Object;
      
      public function ExchangeBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         if(data is ItemWrapper && this._storage.categoryFilter != ItemCategoryEnum.QUEST_CATEGORY && target.getUi().name != source.getUi().name)
         {
            return true;
         }
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         if(data.quantity > 1)
         {
            this._objectToExchange = data;
            Api.common.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQtyDrop);
         }
         else
         {
            Api.system.sendAction(new ExchangeObjectMoveAction([data.objectUID,-data.quantity]));
         }
      }
      
      public function onValidQtyDrop(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,-qty]));
      }
      
      private function onValidQty(qty:Number) : void
      {
         this.transfertObject(this._objectToExchange.objectUID,qty);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,item);
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     Api.ui.hideTooltip();
                     if(Api.inventory.getItem(item.objectUID))
                     {
                        Api.system.dispatchHook(HookList.DoubleClickItemInventory,item,1);
                     }
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     if(Api.inventory.getItem(item.objectUID))
                     {
                        Api.system.dispatchHook(HookList.DoubleClickItemInventory,item,item.quantity);
                     }
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     this._objectToExchange = (target as Grid).selectedItem;
                     Api.common.openQuantityPopup(1,(target as Grid).selectedItem.quantity,(target as Grid).selectedItem.quantity,this.onValidQty);
               }
         }
      }
      
      public function main(params:Object) : void
      {
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a ExchangeBehavior to a non StorageUi storage");
         }
         this._storage = storageUi as StorageUi;
         this._storage.questVisible = false;
         this._storage.btn_moveAllToLeft.visible = true;
      }
      
      public function detach() : void
      {
         this._storage.questVisible = true;
         Api.ui.unloadUi(UIEnum.EXCHANGE_UI);
      }
      
      public function onUnload() : void
      {
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.EXCHANGE_MOD;
      }
      
      public function get replacable() : Boolean
      {
         return false;
      }
      
      public function transfertAll() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertAllFromInvAction([]));
      }
      
      public function transfertList() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertListFromInvAction([this._storage.itemsDisplayed]));
      }
      
      public function transfertExisting() : void
      {
         Api.system.sendAction(new ExchangeObjectTransfertExistingFromInvAction([]));
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
      
      private function transfertObject(pObjectUID:uint, pQuantity:int) : void
      {
         Api.system.dispatchHook(ExchangeHookList.AskExchangeMoveObject,pObjectUID,pQuantity);
         Api.system.sendAction(new ExchangeObjectMoveAction([pObjectUID,pQuantity]));
      }
   }
}

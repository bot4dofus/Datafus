package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   
   public class BankBehavior implements IStorageBehavior
   {
       
      
      protected var _storage:AbstractStorageUi;
      
      private var _objectToExchange:Object;
      
      public function BankBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return true;
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
               weightLeft = this._storage.getWeightMax() - this._storage.getWeight();
               if(data.realWeight * data.quantity > weightLeft)
               {
                  quantityMax = Math.floor(weightLeft / data.realWeight);
               }
               Api.common.openQuantityPopup(1,quantityMax,quantityMax,this.onValidNegativQty);
            }
            else
            {
               Api.system.sendAction(new ExchangeObjectMoveAction([data.objectUID,-1]));
            }
         }
      }
      
      private function onValidNegativQty(qty:Number) : void
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
      
      private function onValidQtyKama(qty:Number) : void
      {
         Api.system.sendAction(new ExchangeObjectMoveKamaAction([qty]));
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var kamas:Number = NaN;
         var bankUiKamaVisible:Boolean = false;
         switch(target)
         {
            case this._storage.lbl_kamas:
               Api.ui.hideTooltip();
               kamas = Api.player.characteristics().kamas;
               bankUiKamaVisible = this._storage.uiApi.getUi(UIEnum.BANK_UI).uiClass.isCtrKamaVisible();
               if(kamas > 0 && bankUiKamaVisible)
               {
                  Api.common.openQuantityPopup(1,kamas,kamas,this.onValidQtyKama);
               }
         }
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
                     if(Api.ui.getUiByName(UIEnum.BANK_UI) != null && item is ItemWrapper && item.isEquipment)
                     {
                        if(item.enhanceable)
                        {
                           Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,item,true);
                        }
                        else
                        {
                           Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,null,true);
                        }
                     }
                     else if(Api.ui.getUiByName(UIEnum.BANK_UI) != null && item is ItemWrapper && !item.isEquipment)
                     {
                        Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,null,true);
                     }
                     if(!Api.system.getOption("displayTooltips","dofus"))
                     {
                        Api.system.dispatchHook(ChatHookList.ShowObjectLinked,item);
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     Api.ui.hideTooltip();
                     if(Api.inventory.getItem(item.objectUID))
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,1]));
                     }
                     break;
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                     if(Api.inventory.getItem(item.objectUID))
                     {
                        Api.system.sendAction(new ExchangeObjectMoveAction([item.objectUID,item.quantity]));
                     }
                     break;
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     this._objectToExchange = (target as Grid).selectedItem;
                     Api.common.openQuantityPopup(1,(target as Grid).selectedItem.quantity,(target as Grid).selectedItem.quantity,this.onValidQty);
               }
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         this._storage = storageUi;
         Api.system.disableWorldInteraction();
         this._storage.questVisible = false;
         this._storage.btn_moveAllToLeft.visible = true;
         var kamas:Number = Api.player.characteristics().kamas;
         if(kamas > 0)
         {
            this._storage.lbl_kamas.mouseEnabled = true;
            this._storage.lbl_kamas.handCursor = true;
         }
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         this._storage.questVisible = true;
         this._storage.btn_moveAllToLeft.visible = false;
      }
      
      public function onUnload() : void
      {
         Api.ui.unloadUi(UIEnum.BANK_UI);
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.BANK_MOD;
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
   }
}

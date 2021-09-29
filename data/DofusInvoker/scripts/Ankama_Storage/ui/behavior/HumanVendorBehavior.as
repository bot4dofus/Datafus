package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class HumanVendorBehavior implements IStorageBehavior
   {
       
      
      private var _storage:StorageUi;
      
      private var _objectToExchange:Object;
      
      public function HumanVendorBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         if(data is ItemWrapper && this._storage.categoryFilter != ItemCategoryEnum.QUEST_CATEGORY)
         {
            if(data.position != 63)
            {
               return true;
            }
         }
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,data);
      }
      
      public function onValidQtyDrop(qty:Number) : void
      {
      }
      
      private function onValidQty(qty:Number) : void
      {
         Api.system.dispatchHook(ExchangeHookList.AskExchangeMoveObject,this._objectToExchange.objectUID,qty);
         Api.system.sendAction(new ExchangeObjectMoveAction([this._objectToExchange.objectUID,qty]));
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         var exchangeOk:Boolean = false;
         var effect:* = undefined;
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               exchangeOk = true;
               if(item is ItemWrapper)
               {
                  for each(effect in item.effects)
                  {
                     if(effect.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE || effect.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)
                     {
                        exchangeOk = false;
                     }
                  }
               }
               else
               {
                  exchangeOk = false;
               }
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     if(exchangeOk)
                     {
                        Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,item);
                     }
                     else
                     {
                        Api.system.dispatchHook(ExchangeHookList.ClickItemInventory,null);
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                     if(exchangeOk)
                     {
                        Api.ui.hideTooltip();
                        if(item && item.category != 0 && item.hasOwnProperty("isCertificate") && item.isCertificate)
                        {
                           Api.system.sendAction(new MountInfoRequestAction([item]));
                        }
                     }
               }
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a BidHouseBehavior to a non StorageUi storage");
         }
         this._storage = storageUi as StorageUi;
         this._storage.setDropAllowed(false,"behavior");
         this._storage.questVisible = false;
         this._storage.btn_moveAllToLeft.visible = false;
      }
      
      public function detach() : void
      {
         this._storage.setDropAllowed(true,"behavior");
         this._storage.questVisible = true;
         this._storage.btn_moveAllToLeft.visible = true;
         Api.ui.unloadUi(UIEnum.HUMAN_VENDOR_STOCK);
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
         return StorageState.HUMAN_VENDOR_MOD;
      }
      
      public function get replacable() : Boolean
      {
         return false;
      }
      
      public function transfertAll() : void
      {
      }
      
      public function transfertList() : void
      {
      }
      
      public function transfertExisting() : void
      {
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
   }
}

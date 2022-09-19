package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.utils.getTimer;
   
   public class SmithMagicBehavior implements IStorageBehavior
   {
       
      
      protected var _storage:StorageUi;
      
      protected var _uiName:String;
      
      protected var _objectToExchange:Object;
      
      protected var _filter:Boolean = false;
      
      protected var _smithMagicUi:Object = null;
      
      public var timer:int;
      
      public function SmithMagicBehavior()
      {
         this.timer = getTimer();
         super();
      }
      
      public function get smithMagicUi() : Object
      {
         var smUi:UiRootContainer = null;
         if(!this._smithMagicUi)
         {
            smUi = Api.ui.getUi(this.getMainUiName());
            if(smUi)
            {
               this._smithMagicUi = smUi.uiClass;
            }
         }
         return this._smithMagicUi;
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
         Api.system.setData("filterSmithMagicStorage",this._storage.btn_itemsFilter.selected);
         this.refreshFilter();
      }
      
      public function get filterEnabled() : Boolean
      {
         return false;
      }
      
      public function getMainUiName() : String
      {
         return UIEnum.SMITH_MAGIC;
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return true;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         Api.ui.getUi(this.getMainUiName()).uiClass.processDropToInventory(target,data,source);
      }
      
      private function onValidQtyDrop(qty:Number) : void
      {
         Api.ui.getUi("smithMagic").uiClass.unfillSelectedSlot(qty);
      }
      
      private function onValidQty(qty:Number) : void
      {
         Api.system.dispatchHook(HookList.DoubleClickItemInventory,this._objectToExchange,qty);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:Object = null;
         if(!this._storage)
         {
            return;
         }
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               switch(selectMethod)
               {
                  case SelectMethodEnum.DOUBLE_CLICK:
                     if(Api.inventory.getItem(item.objectUID))
                     {
                        Api.ui.hideTooltip();
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
                     this._objectToExchange = item;
                     Api.common.openQuantityPopup(1,item.quantity,item.quantity,this.onValidQty);
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
         Api.system.disableWorldInteraction();
         this._storage.mainCtr.x = 944;
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.questVisible = false;
         this._storage.showFilter(Api.ui.getText("ui.craft.smithMagicFilter"),Api.system.getData("filterSmithMagicStorage"));
         if(this.smithMagicUi)
         {
            this.refreshFilter();
         }
      }
      
      public function detach() : void
      {
         this._storage.btn_moveAllToLeft.visible = true;
         this._storage.questVisible = true;
         this._storage.hideFilter();
         Api.system.sendAction(new CloseInventoryAction([]));
      }
      
      public function onUnload() : void
      {
         Api.storage.disableSmithMagicFilter();
         Api.system.removeHook(ExchangeHookList.ExchangeLeave);
         Api.ui.unloadUi("smithMagic");
      }
      
      public function onUiLoaded(name:String) : void
      {
         switch(name)
         {
            case "smithMagic":
               this._storage.updateInventory();
               this.refreshFilter();
         }
      }
      
      private function refreshFilter() : void
      {
         if(this._storage.btn_itemsFilter.selected)
         {
            Api.storage.enableSmithMagicFilter(this.smithMagicUi.skill);
         }
         else
         {
            Api.storage.disableSmithMagicFilter();
         }
         Api.storage.updateStorageView();
         Api.storage.releaseHooks();
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.SMITH_MAGIC_MOD;
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

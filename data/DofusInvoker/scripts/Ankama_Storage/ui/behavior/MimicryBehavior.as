package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class MimicryBehavior implements IStorageBehavior
   {
       
      
      private var _storage:StorageUi;
      
      private var _waitingObject:Object;
      
      private var _mimicryUi:Object;
      
      protected var _showFilter:Boolean = true;
      
      public function MimicryBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function get mimicryUi() : Object
      {
         if(!this._mimicryUi)
         {
            this._mimicryUi = Api.ui.getUi("mimicry").uiClass;
         }
         return this._mimicryUi;
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return true;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         this.mimicryUi.processDropToInventory(target,data,source);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var item:ItemWrapper = null;
         var myItem:ItemWrapper = null;
         switch(target)
         {
            case this._storage.grid:
               item = this._storage.grid.selectedItem;
               if(!item)
               {
                  return;
               }
               myItem = Api.data.getItemWrapper(item.objectGID,item.position,item.objectUID,1,item.effectsList);
               switch(selectMethod)
               {
                  case SelectMethodEnum.CLICK:
                     if(!Api.system.getOption("displayTooltips","dofus"))
                     {
                        Api.system.dispatchHook(InventoryHookList.ObjectSelected,{"data":myItem});
                     }
                     break;
                  case SelectMethodEnum.DOUBLE_CLICK:
                  case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                  case SelectMethodEnum.ALT_DOUBLE_CLICK:
                     if(Api.inventory.getItem(myItem.objectUID) && myItem.category == 0)
                     {
                        Api.ui.hideTooltip();
                        this.mimicryUi.fillAutoSlot(myItem);
                     }
               }
               break;
         }
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a MimicryBehavior to a non StorageUi storage");
         }
         this._storage = storageUi as StorageUi;
         Api.system.disableWorldInteraction();
         this._storage.categoryFilter = 0;
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.questVisible = false;
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         this._storage.btn_moveAllToLeft.visible = true;
         this._storage.questVisible = true;
      }
      
      public function onUnload() : void
      {
         if(Api.ui.getUi("mimicry"))
         {
            Api.ui.unloadUi("mimicry");
         }
      }
      
      public function isDefaultBehavior() : Boolean
      {
         return false;
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.MIMICRY_MOD;
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

package Ankama_Storage.ui.behavior
{
   import Ankama_Job.ui.ItemEffectsModifierUi;
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class ItemEffectsModifierBehavior implements IStorageBehavior
   {
       
      
      private var _storage:StorageUi;
      
      private var _itemEffectsModifierUi:ItemEffectsModifierUi;
      
      private var _initialSaveCategoryValue:Boolean;
      
      public function ItemEffectsModifierBehavior()
      {
         super();
      }
      
      public function get itemEffectsModifierUi() : Object
      {
         if(!this._itemEffectsModifierUi)
         {
            this._itemEffectsModifierUi = Api.ui.getUi(UIEnum.ITEM_EFFECTS_MODIFIER).uiClass;
         }
         return this._itemEffectsModifierUi;
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return true;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         this.itemEffectsModifierUi.processDropToInventory(target,data,source);
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a ItemEffectsModifierBehavior to a non StorageUi storage");
         }
         this._storage = storageUi as StorageUi;
         Api.system.disableWorldInteraction();
         this._initialSaveCategoryValue = this._storage.saveCategory;
         this._storage.saveCategory = false;
         this._storage.categoryFilter = ItemCategoryEnum.EQUIPMENT_CATEGORY;
         this._storage.subFilter = DataEnum.ITEM_TYPE_MINOUKI;
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.questVisible = false;
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         this._storage.saveCategory = this._initialSaveCategoryValue;
         this._storage.btn_moveAllToLeft.visible = true;
         this._storage.questVisible = true;
      }
      
      public function onUnload() : void
      {
         if(Api.ui.getUi(UIEnum.ITEM_EFFECTS_MODIFIER))
         {
            Api.ui.unloadUi(UIEnum.ITEM_EFFECTS_MODIFIER);
         }
      }
      
      private function refreshFilter() : void
      {
         Api.storage.updateStorageView();
         Api.storage.releaseHooks();
      }
      
      public function setSubFilter(subFilter:int) : void
      {
         this._storage.subFilter = subFilter;
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String
      {
         return StorageState.ITEM_EFFECTS_MODIFIER_UI_MOD;
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
                     if(Api.inventory.getItem(myItem.objectUID) && (myItem.typeId == DataEnum.ITEM_TYPE_MINOUKI || myItem.typeId == DataEnum.ITEM_TYPE_ECAFLIP_CARD))
                     {
                        Api.ui.hideTooltip();
                        this.itemEffectsModifierUi.fillAutoSlot(myItem);
                     }
               }
               break;
         }
      }
      
      public function get replacable() : Boolean
      {
         return false;
      }
      
      public function doubleClickGridItem(pItem:Object) : void
      {
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
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
   }
}

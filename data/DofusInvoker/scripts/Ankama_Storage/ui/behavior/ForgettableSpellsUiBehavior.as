package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.AbstractStorageUi;
   import Ankama_Storage.ui.InventoryUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class ForgettableSpellsUiBehavior implements IStorageBehavior
   {
       
      
      protected var _storage:InventoryUi;
      
      protected var _inventoryUI:UiRootContainer;
      
      protected var _defaultSetOnTopOnClick:Boolean;
      
      public function ForgettableSpellsUiBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
         Api.system.setData(this.filterStatusDataKey,enabled);
         this.refreshFilter();
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function attach(storageUi:AbstractStorageUi) : void
      {
         if(!(storageUi is InventoryUi))
         {
            throw new Error("Can\'t attach a ForgettableSpellsUiBehavior to a non-InventoryUi storage");
         }
         if(this._storage === storageUi)
         {
            return;
         }
         this._storage = storageUi as InventoryUi;
         Api.system.addHook(HookList.SearchForgettableSpellScroll,this.onSearchForgettableSpellScroll);
         Api.system.disableWorldInteraction();
         this._inventoryUI = Api.ui.getUi(UIEnum.STORAGE_UI);
         if(this._inventoryUI !== null)
         {
            this._defaultSetOnTopOnClick = this._inventoryUI.setOnTopOnClick;
            this._inventoryUI.setOnTopOnClick = false;
         }
         this._storage.questVisible = false;
         this._storage.ignoreSubFilterInMain = true;
         this._storage.saveCategory = true;
         this._storage.categoryFilter = ItemCategoryEnum.CONSUMABLES_CATEGORY;
         this._storage.setDropAllowed(false,"behavior");
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.forceCategory(this.forcedCategory);
         this._storage.btn_checkCraft.visible = false;
         this._storage.showFilter(Api.ui.getText(this.filterTextKey),Api.system.getData(this.filterStatusDataKey));
         this.refreshFilter();
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         this.disableFilters();
         if(this._inventoryUI !== null)
         {
            this._inventoryUI.setOnTopOnClick = this._defaultSetOnTopOnClick;
         }
         this._storage.unforceCategory();
         this._storage.questVisible = true;
         this._storage.setDropAllowed(true,"behavior");
         this._storage.hideFilter();
         this._storage.btn_moveAllToLeft.visible = true;
      }
      
      public function onUnload() : void
      {
         var forgettableSpellsUi:UiRootContainer = Api.ui.getUi(this.attachedUiName);
         if(forgettableSpellsUi !== null)
         {
            Api.ui.unloadUi(this.attachedUiName);
         }
      }
      
      protected function refreshFilter() : void
      {
         this.enableFiltersFunction.call(null,this.allowedTypes,this._storage.btn_itemsFilter.selected);
         Api.storage.updateStorageView();
         Api.storage.releaseHooks();
      }
      
      public function getStorageUiName() : String
      {
         return UIEnum.INVENTORY_UI;
      }
      
      public function getName() : String
      {
         return StorageState.FORGETTABLE_SPELLS_UI_MOD;
      }
      
      protected function get attachedUiName() : String
      {
         return UIEnum.FORGETTABLE_SPELLS_UI;
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
      
      public function onSearchForgettableSpellScroll(scrollSearch:String) : void
      {
         if(this._storage.inp_search === null)
         {
            return;
         }
         this._storage.inp_search.text = scrollSearch;
         this._storage.search(scrollSearch);
      }
      
      public function doubleClickGridItem(item:Object) : void
      {
         if(item !== null && (item.usable || item.targetable))
         {
            this._storage.useItem(item);
         }
      }
      
      protected function get allowedTypes() : Array
      {
         return [DataEnum.ITEM_TYPE_FORGETTABLE_SPELL_SCROLL,DataEnum.ITEM_TYPE_FORGETTABLE_HIDDEN_SPELL];
      }
      
      protected function get enableFiltersFunction() : Function
      {
         return Api.storage.enableForgettableSpellsFilter;
      }
      
      protected function disableFilters() : void
      {
         Api.storage.disableForgettableSpellsFilter();
      }
      
      protected function get filterTextKey() : String
      {
         return "ui.temporis.hideLearnedSpells";
      }
      
      protected function get forcedCategory() : int
      {
         return DataEnum.ITEM_TYPE_FORGETTABLE_SPELL_SCROLL;
      }
      
      protected function get filterStatusDataKey() : String
      {
         return "filterForgettableSpellsUiStorage";
      }
   }
}

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
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.LeaveShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.types.enums.AuctionHouseTypeEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class BidHouseBehavior implements IStorageBehavior
   {
       
      
      private var _storage:StorageUi;
      
      public function BidHouseBehavior()
      {
         super();
      }
      
      public function filterStatus(enabled:Boolean) : void
      {
         Api.system.setData("filterBidHouseStorage",enabled);
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
         var selectedItem:Object = null;
         switch(target)
         {
            case this._storage.grid:
               selectedItem = this._storage.grid.selectedItem;
               if(selectMethod == SelectMethodEnum.CLICK && Api.ui.getUi("itemBidHouseSell"))
               {
                  Api.ui.getUi("itemBidHouseSell").uiClass.onSelectItemFromInventory(selectedItem);
               }
               else if(selectMethod == SelectMethodEnum.CLICK && Api.ui.getUi("auctionHouseSell"))
               {
                  Api.ui.getUi("auctionHouseSell").uiClass.onSelectItemFromInventory(selectedItem);
               }
               else if(selectMethod == SelectMethodEnum.CLICK && Api.ui.getUi("auctionHouseBuy"))
               {
                  Api.ui.getUi("auctionHouseBuy").uiClass.onSelectItemFromInventory(selectedItem,false,true);
               }
               else if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  Api.ui.hideTooltip();
                  if(selectedItem && selectedItem.category != 0 && selectedItem.hasOwnProperty("isCertificate") && selectedItem.isCertificate)
                  {
                     Api.system.sendAction(new MountInfoRequestAction([selectedItem]));
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
         if(this._storage == storageUi)
         {
            return;
         }
         this._storage = storageUi as StorageUi;
         Api.system.disableWorldInteraction();
         this._storage.questVisible = false;
         var ui:UiRootContainer = Api.ui.getUi("auctionHouseBuy");
         var uiroot:* = !!ui ? ui.uiClass : null;
         if(uiroot)
         {
            switch(uiroot.currentType)
            {
               case AuctionHouseTypeEnum.EQUIPMENT_CATEGORY:
               case AuctionHouseTypeEnum.CREATURE_CATEGORY:
                  this._storage.categoryFilter = ItemCategoryEnum.EQUIPMENT_CATEGORY;
                  break;
               case AuctionHouseTypeEnum.CONSUMABLE_CATEGORY:
                  this._storage.categoryFilter = ItemCategoryEnum.CONSUMABLES_CATEGORY;
                  break;
               case AuctionHouseTypeEnum.RESOURCE_CATEGORY:
               case AuctionHouseTypeEnum.RUNE_CATEGORY:
                  this._storage.categoryFilter = ItemCategoryEnum.RESOURCES_CATEGORY;
                  break;
               case AuctionHouseTypeEnum.SOUL_CATEGORY:
                  this._storage.categoryFilter = ItemCategoryEnum.ALL_CATEGORY;
                  break;
               case AuctionHouseTypeEnum.COSMETIC_CATEGORY:
                  this._storage.categoryFilter = ItemCategoryEnum.COSMETICS_CATEGORY;
            }
         }
         this._storage.setDropAllowed(false,"behavior");
         this._storage.btn_moveAllToLeft.visible = false;
         this._storage.showFilter(Api.ui.getText("ui.bidhouse.bigStoreFilter"),Api.system.getData("filterBidHouseStorage"));
         this.refreshFilter();
      }
      
      public function detach() : void
      {
         Api.system.enableWorldInteraction();
         Api.storage.disableBidHouseFilter();
         this._storage.questVisible = true;
         this._storage.setDropAllowed(true,"behavior");
         this._storage.hideFilter();
         this._storage.btn_moveAllToLeft.visible = true;
      }
      
      public function onUnload() : void
      {
         if(Api.ui.getUi(UIEnum.AUCTIONHOUSE) && !Api.ui.getUi(UIEnum.AUCTIONHOUSE).uiClass.isSwitching())
         {
            Api.system.sendAction(new LeaveShopStockAction([]));
            Api.ui.unloadUi(UIEnum.AUCTIONHOUSE);
         }
      }
      
      private function refreshFilter() : void
      {
         var uiRoot:UiRootContainer = null;
         var uiclass:Object = null;
         var info:Object = null;
         if(this._storage.btn_itemsFilter.selected && Api.ui.getUi("itemBidHouseSell") && Api.ui.getUi("itemBidHouseSell").uiClass)
         {
            uiRoot = Api.ui.getUi("itemBidHouseSell");
            uiclass = uiRoot.uiClass;
            info = uiclass.sellerDescriptor;
            Api.storage.enableBidHouseFilter(info.types,info.maxItemLevel);
         }
         else
         {
            if(Api.ui.getUi("auctionHouseSell") && Api.ui.getUi("auctionHouseSell").uiClass)
            {
               uiRoot = Api.ui.getUi("auctionHouseSell");
            }
            else if(Api.ui.getUi("auctionHouseBuy") && Api.ui.getUi("auctionHouseBuy").uiClass)
            {
               uiRoot = Api.ui.getUi("auctionHouseBuy");
            }
            if(this._storage.btn_itemsFilter.selected && uiRoot)
            {
               uiclass = uiRoot.uiClass;
               info = uiclass.sellerDescriptor;
               if(info == null)
               {
                  Api.system.log(16,"Class " + uiclass + " doesn\'t have a sellerDescriptor");
                  Api.storage.disableBidHouseFilter();
               }
               else
               {
                  Api.storage.enableBidHouseFilter(info.types,info.maxItemLevel);
               }
            }
            else
            {
               Api.storage.disableBidHouseFilter();
            }
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
         return StorageState.BID_HOUSE_MOD;
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

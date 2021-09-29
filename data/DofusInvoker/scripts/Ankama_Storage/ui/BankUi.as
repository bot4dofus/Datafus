package Ankama_Storage.ui
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class BankUi extends AbstractStorageUi
   {
       
      
      public var entityDisplayer:EntityDisplayer;
      
      public function BankUi()
      {
         super();
      }
      
      override public function main(param:Object) : void
      {
         var behavior:String = null;
         param.storageMod = "bankUi";
         super.main(param);
         sysApi.addHook(InventoryHookList.BankViewContent,onInventoryUpdate);
         sysApi.addHook(InventoryHookList.StorageKamasUpdate,onKamasUpdate);
         sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         sysApi.addHook(SocialHookList.AllianceMembershipUpdated,this.onAllianceMembershipUpdated);
         this.categoryFilter = ItemCategoryEnum.ALL_CATEGORY;
         _hasSlot = false;
         _exchangeType = param.exchangeType;
         switch(_exchangeType)
         {
            case ExchangeTypeEnum.TAXCOLLECTOR:
               lbl_title.text = uiApi.getText("ui.common.taxCollector");
               sysApi.addHook(ExchangeHookList.ExchangeWeight,onInventoryWeight);
               behavior = StorageState.TAXCOLLECTOR_MOD;
               break;
            case ExchangeTypeEnum.MOUNT:
               lbl_title.text = uiApi.getText("ui.common.inventory");
               ctr_kamas.visible = false;
               tx_weightBar.visible = true;
               sysApi.addHook(ExchangeHookList.ExchangeWeight,onInventoryWeight);
               behavior = StorageState.MOUNT_MOD;
               break;
            case ExchangeTypeEnum.STORAGE:
            case ExchangeTypeEnum.HAVENBAG:
               lbl_title.text = uiApi.getText("ui.common.storage");
               if(!playerApi.isInHavenbag())
               {
                  _hasSlot = true;
                  _slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
                  tx_weightBar.visible = _slotsMax != 0;
               }
               else
               {
                  sysApi.addHook(ExchangeHookList.ExchangeWeight,onInventoryWeight);
               }
               lbl_kamas.handCursor = !playerApi.hasDebt();
               lbl_kamas.useHandCursor = !playerApi.hasDebt();
               if(_exchangeType == ExchangeTypeEnum.STORAGE)
               {
                  ctr_kamas.visible = false;
               }
               behavior = StorageState.BANK_MOD;
               break;
            case ExchangeTypeEnum.BANK:
               lbl_title.text = uiApi.getText("ui.common.bank");
               _hasSlot = true;
               _slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
               tx_weightBar.visible = _slotsMax != 0;
               lbl_kamas.handCursor = !playerApi.hasDebt();
               behavior = StorageState.BANK_MOD;
               break;
            case ExchangeTypeEnum.TRASHBIN:
               lbl_title.text = uiApi.getText("ui.common.bin");
               _hasSlot = true;
               _slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
               ctr_kamas.visible = false;
               tx_weightBar.visible = _slotsMax != 0;
               behavior = StorageState.BANK_MOD;
               break;
            case ExchangeTypeEnum.ALLIANCE_PRISM:
               lbl_title.text = uiApi.getText("ui.zaap.prism");
               _hasSlot = true;
               _slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
               tx_weightBar.visible = _slotsMax != 0;
               behavior = StorageState.BANK_MOD;
               break;
            default:
               lbl_title.text = uiApi.getText("ui.common.storage");
               behavior = StorageState.BANK_MOD;
         }
         mainCtr.x = 16;
         mainCtr.y = 1024 - (mainCtr.height + 155);
         if(param.inventory && param.kamas)
         {
            onInventoryUpdate(param.inventory,param.kamas);
         }
         this.subFilter = -1;
         storageApi.releaseBankHooks();
         sysApi.sendAction(new OpenInventoryAction([behavior]));
      }
      
      public function isCtrKamaVisible() : Boolean
      {
         return ctr_kamas.visible;
      }
      
      override protected function getStorageTypes(categoryFilter:int) : Array
      {
         return storageApi.getBankStorageTypes(categoryFilter);
      }
      
      override public function set categoryFilter(category:int) : void
      {
         super.categoryFilter = category;
         storageApi.setDisplayedBankCategory(categoryFilter);
      }
      
      override public function set subFilter(filter:int) : void
      {
         var cb_category:Object = null;
         updateSubFilter(this.getStorageTypes(categoryFilter));
         var hasFilter:Boolean = false;
         for each(cb_category in super.cb_category.dataProvider)
         {
            if(cb_category.filterType == filter)
            {
               hasFilter = true;
               break;
            }
         }
         if(!hasFilter)
         {
            filter = -1;
         }
         if(!itemWithAssociatedRunesDisplayed)
         {
            storageApi.setBankStorageFilter(filter);
         }
         super.subFilter = filter;
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case btn_moveAllToLeft:
            case btn_moveAllToRight:
               text = uiApi.getText("ui.storage.advancedTransferts");
               if(text)
               {
                  uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
               }
               else
               {
                  super.onRollOver(target);
               }
               return;
            default:
               super.onRollOver(target);
               return;
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         switch(target)
         {
            case btn_moveAllToLeft:
            case btn_moveAllToRight:
               contextMenu = [modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getAll"),_storageBehavior.transfertAll,null,false,null,false,true),modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getVisible"),_storageBehavior.transfertList,null,false,null,false,true),modContextMenu.createContextMenuItemObject(uiApi.getText("ui.storage.getExisting"),_storageBehavior.transfertExisting,null,false,null,false,true)];
               modContextMenu.createContextMenu(contextMenu);
         }
         super.onRelease(target);
      }
      
      override public function unload() : void
      {
         super.unload();
         sysApi.removeHook(InventoryHookList.BankViewContent);
         sysApi.removeHook(InventoryHookList.StorageKamasUpdate);
         sysApi.removeHook(ExchangeHookList.ExchangeLeave);
         var mountInfo:UiRootContainer = uiApi.getUi(UIEnum.MOUNT_INFO);
         if(mountInfo)
         {
            mountInfo.visible = true;
         }
         Api.system.sendAction(new LeaveDialogRequestAction([]));
         sysApi.sendAction(new CloseInventoryAction([]));
      }
      
      override protected function releaseHooks() : void
      {
         storageApi.releaseBankHooks();
      }
      
      override protected function sortOn(property:int, numeric:Boolean = false) : void
      {
         storageApi.resetBankSort();
         this.addSort(property);
      }
      
      override protected function addSort(property:int) : void
      {
         storageApi.sortBank(property,false);
         this.releaseHooks();
      }
      
      override protected function getSortFields() : Array
      {
         return storageApi.getSortBankFields();
      }
      
      public function onExchangeLeave(success:Boolean) : void
      {
         uiApi.unloadUi(uiApi.me().name);
      }
      
      private function onAllianceMembershipUpdated(hasAlliance:Boolean) : void
      {
         if(!hasAlliance && _exchangeType == ExchangeTypeEnum.ALLIANCE_PRISM)
         {
            this.unload();
         }
      }
      
      public function displayAssociatedRunes(itemW:ItemWrapper, onClickOnItem:Boolean) : Boolean
      {
         var category:Object = null;
         if(!cb_category)
         {
            return false;
         }
         if(!itemW)
         {
            this.onRelease(btn_closeSearch);
            onReleaseCategoryFilter(btnRessources);
            return false;
         }
         if(onClickOnItem && cb_category.selectedItem.filterType != DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
         {
            return false;
         }
         this.onRelease(btnRessources);
         if(!onClickOnItem && cb_category.selectedItem.filterType != DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
         {
            for each(category in cb_category.dataProvider)
            {
               if(category.filterType == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
               {
                  cb_category.value = category;
                  subFilterIndex[btnRessources.name] = category.filterType;
                  this.subFilter = category.filterType;
                  break;
               }
            }
         }
         itemWithAssociatedRunesDisplayed = itemW;
         inp_search.text = uiApi.getText("ui.item.runes") + itemW.name;
         btn_closeSearch.visible = true;
         inp_search.disabled = true;
         return true;
      }
   }
}

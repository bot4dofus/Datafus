package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.datacenter.mounts.RideFood;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.SimpleTextureWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.MountFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class StorageApi implements IApi
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageApi));
      
      private static var _lastItemPosition:Array = [];
      
      public static const ITEM_TYPE_TO_SERVER_POSITION:Array = [[],[0],[1],[2,4],[3],[5],[],[15],[1],[],[6],[7],[8],[9,10,11,12,13,14],[],[20],[21],[22,23],[24,25],[26],[27],[16],[],[28],[8,16],[30]];
      
      public static const ITEM_REAL_TYPE_TO_SERVER_POSITION:Dictionary = new Dictionary();
      
      {
         ITEM_REAL_TYPE_TO_SERVER_POSITION[DataEnum.ITEM_TYPE_PRYSMARADITE] = [9];
         ITEM_REAL_TYPE_TO_SERVER_POSITION[DataEnum.ITEM_TYPE_MINOUKI] = [10];
      }
      
      public function StorageApi()
      {
         super();
      }
      
      public function itemSuperTypeToServerPosition(superTypeId:uint) : Array
      {
         return ITEM_TYPE_TO_SERVER_POSITION[superTypeId];
      }
      
      public function itemTypeToServerPosition(typeId:uint) : Array
      {
         return ITEM_REAL_TYPE_TO_SERVER_POSITION[typeId];
      }
      
      public function serverPositionsToItemSuperType(position:int) : Array
      {
         var superTypes:Array = [];
         var i:int = 0;
         for(var typesCount:int = ITEM_TYPE_TO_SERVER_POSITION.length; i < typesCount; )
         {
            if(ITEM_TYPE_TO_SERVER_POSITION[i].length && ITEM_TYPE_TO_SERVER_POSITION[i].indexOf(position) != -1)
            {
               superTypes.push(i);
            }
            i++;
         }
         return superTypes;
      }
      
      public function getInventoryItemsForSuperType(id:int) : Vector.<ItemWrapper>
      {
         var itemList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("storage").content;
         var itemsCount:int = inventory.length;
         for(var i:int = 0; i < itemsCount; )
         {
            if((inventory[i] as ItemWrapper).type.superTypeId == id)
            {
               itemList.push(inventory[i]);
            }
            i++;
         }
         return itemList;
      }
      
      public function getLivingObjectFood(itemType:int) : Vector.<ItemWrapper>
      {
         var item:ItemWrapper = null;
         var itemList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("storage").content;
         var nb:int = inventory.length;
         for(var i:int = 0; i < nb; i++)
         {
            item = inventory[i];
            if(!item.isLivingObject && item.type.id == itemType)
            {
               itemList.push(item);
            }
         }
         return itemList;
      }
      
      public function getRideFoodsFor(familyId:int) : Array
      {
         var rideFood:RideFood = null;
         var item:ItemWrapper = null;
         var it:Item = null;
         var itemList:Array = [];
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("storage").content;
         var rideFoods:Array = RideFood.getRideFoods();
         var gids:Array = [];
         var typeIds:Array = [];
         for each(rideFood in rideFoods)
         {
            if(rideFood.familyId == familyId)
            {
               if(rideFood.gid != 0)
               {
                  gids.push(rideFood.gid);
               }
               if(rideFood.typeId != 0)
               {
                  typeIds.push(rideFood.typeId);
               }
            }
         }
         for each(item in inventory)
         {
            it = Item.getItemById(item.objectGID);
            if(gids.indexOf(item.objectGID) != -1 || typeIds.indexOf(it.typeId) != -1)
            {
               itemList.push(item);
            }
         }
         return itemList;
      }
      
      public function getViewContent(name:String, watch:Boolean = false) : Vector.<ItemWrapper>
      {
         var view:IInventoryView = !!watch ? InventoryManager.getWatchInstance().inventory.getView(name) : InventoryManager.getInstance().inventory.getView(name);
         if(view)
         {
            return view.content;
         }
         return null;
      }
      
      public function getShortcutBarContent(barType:uint) : Array
      {
         if(barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
         {
            return InventoryManager.getInstance().shortcutBarItems;
         }
         if(barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
         {
            return InventoryManager.getInstance().shortcutBarSpells;
         }
         return [];
      }
      
      public function getFakeItemMount() : MountWrapper
      {
         if(PlayedCharacterManager.getInstance().mount)
         {
            return MountWrapper.create();
         }
         return null;
      }
      
      public function getFakeItemMountOrRedCross() : Object
      {
         if(PlayedCharacterManager.getInstance().mount)
         {
            return MountWrapper.create();
         }
         var emptyUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "bitmap/failureSlot.png");
         return SimpleTextureWrapper.create(emptyUri);
      }
      
      public function getBestEquipablePosition(item:ItemWrapper) : int
      {
         var cat:int = 0;
         var itemType:ItemType = null;
         var equipement:Vector.<ItemWrapper> = null;
         var freeSlot:int = 0;
         var pos:int = 0;
         var lastIndex:int = 0;
         var superTypeId:int = item.type.superTypeId;
         if(item && (item.isLivingObject || item.isWrapperObject))
         {
            cat = 0;
            if(item.isLivingObject)
            {
               cat = item.livingObjectCategory;
            }
            else
            {
               cat = item.wrapperObjectCategory;
            }
            itemType = ItemType.getItemTypeById(cat);
            if(itemType)
            {
               superTypeId = itemType.superTypeId;
            }
         }
         var possiblePosition:Array = this.itemTypeToServerPosition(item.typeId);
         if(possiblePosition == null)
         {
            possiblePosition = this.itemSuperTypeToServerPosition(superTypeId);
         }
         if(possiblePosition && possiblePosition.length)
         {
            equipement = this.getViewContent("equipment");
            freeSlot = -1;
            for each(pos in possiblePosition)
            {
               if(equipement[pos] && equipement[pos].objectGID == item.objectGID && (item.typeId != 9 || item.belongsToSet))
               {
                  freeSlot = pos;
                  break;
               }
            }
            if(freeSlot == -1)
            {
               for each(pos in possiblePosition)
               {
                  if(!equipement[pos])
                  {
                     freeSlot = pos;
                     break;
                  }
               }
            }
            if(freeSlot == -1)
            {
               if(!_lastItemPosition[item.type.superTypeId])
               {
                  _lastItemPosition[item.type.superTypeId] = 0;
               }
               lastIndex = ++_lastItemPosition[item.type.superTypeId];
               if(lastIndex >= possiblePosition.length)
               {
                  lastIndex = 0;
               }
               _lastItemPosition[item.type.superTypeId] = lastIndex;
               freeSlot = possiblePosition[lastIndex];
            }
         }
         return freeSlot;
      }
      
      public function addItemMask(itemUID:int, name:String, quantity:int) : void
      {
         InventoryManager.getInstance().inventory.addItemMask(itemUID,name,quantity);
      }
      
      public function removeItemMask(itemUID:int, name:String) : void
      {
         InventoryManager.getInstance().inventory.removeItemMask(itemUID,name);
      }
      
      public function removeAllItemMasks(name:String) : void
      {
         InventoryManager.getInstance().inventory.removeAllItemMasks(name);
      }
      
      public function releaseHooks() : void
      {
         InventoryManager.getInstance().inventory.releaseHooks();
      }
      
      public function releaseBankHooks() : void
      {
         InventoryManager.getInstance().bankInventory.releaseHooks();
      }
      
      public function dracoTurkyInventoryWeight() : uint
      {
         var mf:MountFrame = Kernel.getWorker().getFrame(MountFrame) as MountFrame;
         return mf.inventoryWeight;
      }
      
      public function dracoTurkyMaxInventoryWeight() : uint
      {
         var mf:MountFrame = Kernel.getWorker().getFrame(MountFrame) as MountFrame;
         return mf.inventoryMaxWeight;
      }
      
      public function getStorageTypes(category:int) : Array
      {
         var entry:Object = null;
         var array:Array = [];
         var dict:Dictionary = StorageOptionManager.getInstance().getCategoryTypes(category);
         if(!dict)
         {
            return null;
         }
         for each(entry in dict)
         {
            array.push(entry);
         }
         array.sort(this.sortStorageTypes);
         return array;
      }
      
      private function sortStorageTypes(a:Object, b:Object) : int
      {
         return -StringUtils.noAccent(b.name).localeCompare(StringUtils.noAccent(a.name));
      }
      
      public function getBankStorageTypes(category:int) : Array
      {
         var entry:Object = null;
         var array:Array = [];
         var dict:Dictionary = StorageOptionManager.getInstance().getBankCategoryTypes(category);
         if(!dict)
         {
            return null;
         }
         for each(entry in dict)
         {
            array.push(entry);
         }
         array.sort(this.sortStorageTypes);
         return array;
      }
      
      public function setDisplayedCategory(category:int) : void
      {
         StorageOptionManager.getInstance().category = category;
      }
      
      public function setDisplayedBankCategory(category:int) : void
      {
         StorageOptionManager.getInstance().bankCategory = category;
      }
      
      public function getDisplayedCategory() : int
      {
         return StorageOptionManager.getInstance().category;
      }
      
      public function getDisplayedBankCategory() : int
      {
         return StorageOptionManager.getInstance().bankCategory;
      }
      
      public function setStorageFilter(typeId:int) : void
      {
         StorageOptionManager.getInstance().filter = typeId;
      }
      
      public function setBankStorageFilter(typeId:int) : void
      {
         StorageOptionManager.getInstance().bankFilter = typeId;
      }
      
      public function getStorageFilter() : int
      {
         return StorageOptionManager.getInstance().filter;
      }
      
      public function getBankStorageFilter() : int
      {
         return StorageOptionManager.getInstance().bankFilter;
      }
      
      public function updateStorageView() : void
      {
         StorageOptionManager.getInstance().updateStorageView();
      }
      
      public function updateBankStorageView() : void
      {
         StorageOptionManager.getInstance().updateBankStorageView();
      }
      
      public function sort(sortField:int, revert:Boolean) : void
      {
         StorageOptionManager.getInstance().sortRevert = revert;
         StorageOptionManager.getInstance().sortField = sortField;
      }
      
      public function resetSort() : void
      {
         StorageOptionManager.getInstance().resetSort();
      }
      
      public function sortBank(sortField:int, revert:Boolean) : void
      {
         StorageOptionManager.getInstance().sortBankRevert = revert;
         StorageOptionManager.getInstance().sortBankField = sortField;
      }
      
      public function resetBankSort() : void
      {
         StorageOptionManager.getInstance().resetBankSort();
      }
      
      public function getSortFields() : Array
      {
         return StorageOptionManager.getInstance().sortFields;
      }
      
      public function getSortBankFields() : Array
      {
         return StorageOptionManager.getInstance().sortBankFields;
      }
      
      public function unsort() : void
      {
         StorageOptionManager.getInstance().sortField = StorageOptionManager.SORT_FIELD_NONE;
      }
      
      public function unsortBank() : void
      {
         StorageOptionManager.getInstance().sortBankField = StorageOptionManager.SORT_FIELD_NONE;
      }
      
      public function enableBidHouseFilter(allowedTypes:Object, maxItemLevel:uint) : void
      {
         var entry:uint = 0;
         var vtypes:Vector.<uint> = new Vector.<uint>();
         for each(entry in allowedTypes)
         {
            vtypes.push(entry);
         }
         StorageOptionManager.getInstance().enableBidHouseFilter(vtypes,maxItemLevel);
      }
      
      public function disableBidHouseFilter() : void
      {
         StorageOptionManager.getInstance().disableBidHouseFilter();
      }
      
      public function getIsBidHouseFilterEnabled() : Boolean
      {
         return StorageOptionManager.getInstance().getIsBidHouseFilterEnabled();
      }
      
      public function enableSmithMagicFilter(skill:Skill) : void
      {
         StorageOptionManager.getInstance().enableSmithMagicFilter(skill);
      }
      
      public function disableSmithMagicFilter() : void
      {
         StorageOptionManager.getInstance().disableSmithMagicFilter();
      }
      
      public function getIsCraftFilterEnabled() : Boolean
      {
         return StorageOptionManager.getInstance().getIsCraftFilterEnabled();
      }
      
      public function enableCraftFilter(skill:Object, jobLevel:int) : void
      {
         StorageOptionManager.getInstance().enableCraftFilter(skill as Skill,jobLevel);
      }
      
      public function disableCraftFilter() : void
      {
         StorageOptionManager.getInstance().disableCraftFilter();
      }
      
      public function getIsSmithMagicFilterEnabled() : Boolean
      {
         return StorageOptionManager.getInstance().getIsSmithMagicFilterEnabled();
      }
      
      public function getItemMaskCount(objectUID:int, mask:String) : int
      {
         return InventoryManager.getInstance().inventory.getItemMaskCount(objectUID,mask);
      }
      
      public function enableForgettableSpellsFilter(allowedTypes:Object, isHideLearnedSpells:Boolean) : void
      {
         var entry:uint = 0;
         var vtypes:Vector.<uint> = new Vector.<uint>();
         for each(entry in allowedTypes)
         {
            vtypes.push(entry);
         }
         StorageOptionManager.getInstance().enableForgettableSpellsFilter(vtypes,isHideLearnedSpells);
      }
      
      public function disableForgettableSpellsFilter() : void
      {
         StorageOptionManager.getInstance().disableForgettableSpellsFilter();
      }
      
      public function enableBankAssociatedRunesFilter(item:ItemWrapper) : void
      {
         StorageOptionManager.getInstance().enableBankAssociatedRunesFilter(item);
      }
      
      public function disableBankAssociatedRunesFilter() : void
      {
         StorageOptionManager.getInstance().disableBankAssociatedRunesFilter();
      }
   }
}

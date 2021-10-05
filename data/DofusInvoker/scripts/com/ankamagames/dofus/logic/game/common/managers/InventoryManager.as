package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.misc.Inventory;
   import com.ankamagames.dofus.logic.game.common.misc.PlayerInventory;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankConsumablesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankEquipementView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankFilteredView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankMinoukiFilteredView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankMinoukiView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankQuestView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankRessourcesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.BankView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.CertificateView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.EquipmentView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.RealView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.RoleplayBuffView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageConsumablesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageEquipmentView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageFilteredView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageMinoukiFilteredView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageMinoukiView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageQuestCategory;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageResourcesView;
   import com.ankamagames.dofus.logic.game.common.misc.inventoryView.StorageView;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class InventoryManager
   {
      
      private static var _self:InventoryManager;
      
      private static var _watchSelf:InventoryManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryManager));
       
      
      private var _inventory:Inventory;
      
      private var _bankInventory:Inventory;
      
      private var _shortcutBarSpells:Array;
      
      private var _shortcutBarItems:Array;
      
      private var _builds:Array;
      
      private var _currentBuildId:int = -1;
      
      private var _maxBuildCount:int;
      
      private var _presetsItemPositionsOrder:Array;
      
      public function InventoryManager()
      {
         this._presetsItemPositionsOrder = [CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT,CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE,CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT,CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS,CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET,CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT,CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT,CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME,CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON,CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD,CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY,CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5,CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6];
         super();
         this._maxBuildCount = ProtocolConstantsEnum.MAX_PRESET_COUNT;
         this._inventory = new PlayerInventory();
         this._builds = new Array();
         this._shortcutBarItems = new Array();
         this._shortcutBarSpells = new Array();
         this.inventory.addView(new RealView(this.inventory.hookLock));
         this.inventory.addView(new EquipmentView(this.inventory.hookLock));
         this.inventory.addView(new RoleplayBuffView(this.inventory.hookLock));
         this.inventory.addView(new CertificateView(this.inventory.hookLock));
         this.inventory.addView(new StorageView(this.inventory.hookLock));
         this.inventory.addView(new StorageEquipmentView(this.inventory.hookLock));
         this.inventory.addView(new StorageConsumablesView(this.inventory.hookLock));
         this.inventory.addView(new StorageResourcesView(this.inventory.hookLock));
         this.inventory.addView(new StorageMinoukiView(this.inventory.hookLock));
         this.inventory.addView(new StorageMinoukiFilteredView(this.inventory.hookLock));
         this.inventory.addView(new StorageQuestCategory(this.inventory.hookLock));
         this.inventory.addView(new StorageFilteredView(this.inventory.hookLock));
      }
      
      public static function getInstance() : InventoryManager
      {
         if(!_self)
         {
            _self = new InventoryManager();
         }
         return _self;
      }
      
      public static function getWatchInstance() : InventoryManager
      {
         if(!_watchSelf)
         {
            _watchSelf = new InventoryManager();
         }
         return _watchSelf;
      }
      
      public function init() : void
      {
         this._inventory.initialize(new Vector.<ItemWrapper>());
         this._builds = new Array();
         this._shortcutBarItems = new Array();
         this._shortcutBarSpells = new Array();
      }
      
      public function get inventory() : Inventory
      {
         return this._inventory;
      }
      
      public function get realInventory() : Vector.<ItemWrapper>
      {
         return this._inventory.getView("real").content;
      }
      
      public function get builds() : Array
      {
         return this._builds;
      }
      
      public function set builds(builds:Array) : void
      {
         this._builds = builds;
      }
      
      public function get bankInventory() : Inventory
      {
         if(!this._bankInventory)
         {
            this._bankInventory = new Inventory();
            this._bankInventory.addView(new BankView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankEquipementView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankConsumablesView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankRessourcesView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankQuestView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankMinoukiView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankMinoukiFilteredView(this._bankInventory.hookLock));
            this._bankInventory.addView(new BankFilteredView(this._bankInventory.hookLock));
         }
         return this._bankInventory;
      }
      
      public function get shortcutBarItems() : Array
      {
         return this._shortcutBarItems;
      }
      
      public function set shortcutBarItems(aItems:Array) : void
      {
         this._shortcutBarItems = aItems;
      }
      
      public function get shortcutBarSpells() : Array
      {
         return this._shortcutBarSpells;
      }
      
      public function set shortcutBarSpells(aSpells:Array) : void
      {
         this._shortcutBarSpells = aSpells;
      }
      
      public function getMaxItemsCountForPreset() : int
      {
         return this._presetsItemPositionsOrder.length;
      }
      
      public function getPositionForPresetItemIndex(index:int) : int
      {
         return this._presetsItemPositionsOrder[index];
      }
      
      public function get currentBuildId() : int
      {
         return this._currentBuildId;
      }
      
      public function set currentBuildId(value:int) : void
      {
         this._currentBuildId = value;
      }
   }
}

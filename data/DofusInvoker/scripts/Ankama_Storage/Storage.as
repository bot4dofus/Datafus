package Ankama_Storage
{
   import Ankama_Common.Common;
   import Ankama_Storage.ui.BankUi;
   import Ankama_Storage.ui.EquipmentUi;
   import Ankama_Storage.ui.InventoryUi;
   import Ankama_Storage.ui.LivingObject;
   import Ankama_Storage.ui.Mimicry;
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.WatchEquipmentUi;
   import Ankama_Storage.ui.enum.StorageState;
   import Ankama_Storage.util.StorageBehaviorManager;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.ClientUITypeEnum;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Storage extends Sprite
   {
       
      
      private var include_StorageUi:StorageUi = null;
      
      private var include_BankUi:BankUi = null;
      
      private var include_EquipmentUi:EquipmentUi = null;
      
      private var include_livingObject:LivingObject = null;
      
      private var include_mimicry:Mimicry = null;
      
      private var include_WatchEquipmentUi:WatchEquipmentUi = null;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _inventory:Object;
      
      private var _kamas:Number = 0;
      
      private var _weight:uint;
      
      private var _weightMax:uint;
      
      public function Storage()
      {
         super();
      }
      
      public function main() : void
      {
         Api.common = this.modCommon;
         Api.menu = this.menuApi;
         Api.sound = this.soundApi;
         Api.storage = this.storageApi;
         Api.system = this.sysApi;
         Api.ui = this.uiApi;
         Api.data = this.dataApi;
         Api.player = this.playerApi;
         Api.inventory = this.inventoryApi;
         Api.jobs = this.jobsApi;
         this.sysApi.addHook(HookList.OpenInventory,this.onOpenInventory);
         this.sysApi.addHook(HookList.CloseInventory,this.onCloseInventory);
         this.sysApi.addHook(ExchangeHookList.ExchangeStartedType,this.onExchangeStartedType);
         this.sysApi.addHook(ExchangeHookList.ExchangeBankStarted,this.onExchangeBankStarted);
         this.sysApi.addHook(InventoryHookList.ObjectAdded,this.onObjectAdded);
         this.sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         this.sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         this.sysApi.addHook(InventoryHookList.OpenLivingObject,this.onOpenLivingObject);
         this.sysApi.addHook(ExchangeHookList.ExchangeBankStartedWithStorage,this.onExchangeStartedWithStorage);
         this.sysApi.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         this.sysApi.addHook(MountHookList.MountRiding,this.onMountRiding);
         this.sysApi.addHook(CustomUiHookList.ClientUIOpened,this.onClientUIOpened);
      }
      
      private function onExchangeStartedType(exchangeType:int) : void
      {
         var mountInfo:UiRootContainer = null;
         switch(exchangeType)
         {
            case ExchangeTypeEnum.STORAGE:
               if(!this.uiApi.getUi(UIEnum.BANK_UI))
               {
                  this.uiApi.loadUi(UIEnum.BANK_UI,UIEnum.BANK_UI,{"exchangeType":exchangeType});
               }
               break;
            case ExchangeTypeEnum.MOUNT:
               mountInfo = this.uiApi.getUi(UIEnum.MOUNT_INFO);
               if(mountInfo)
               {
                  mountInfo.visible = false;
               }
         }
      }
      
      private function onExchangeStartedWithStorage(exchangeType:int, maxSlots:uint) : void
      {
         switch(exchangeType)
         {
            case ExchangeTypeEnum.STORAGE:
            case ExchangeTypeEnum.BANK:
            case ExchangeTypeEnum.TRASHBIN:
            case ExchangeTypeEnum.ALLIANCE_PRISM:
            case ExchangeTypeEnum.HAVENBAG:
               if(!this.uiApi.getUi(UIEnum.BANK_UI))
               {
                  this.uiApi.loadUi(UIEnum.BANK_UI,UIEnum.BANK_UI,{
                     "exchangeType":exchangeType,
                     "maxSlots":maxSlots
                  });
               }
         }
      }
      
      private function onExchangeBankStarted(exchangeType:int, objects:Object, kamas:Number) : void
      {
         var mountInfo:UiRootContainer = null;
         var behavior:String = StorageState.BANK_MOD;
         switch(exchangeType)
         {
            case ExchangeTypeEnum.MOUNT:
               mountInfo = this.uiApi.getUi(UIEnum.MOUNT_INFO);
               if(mountInfo)
               {
                  mountInfo.visible = false;
               }
               behavior = StorageState.MOUNT_MOD;
               break;
            case ExchangeTypeEnum.TAXCOLLECTOR:
               behavior = StorageState.TAXCOLLECTOR_MOD;
         }
         if(!this.uiApi.getUi(UIEnum.BANK_UI))
         {
            this.uiApi.loadUi(UIEnum.BANK_UI,UIEnum.BANK_UI,{
               "inventory":objects,
               "kamas":kamas,
               "exchangeType":exchangeType
            });
         }
      }
      
      private function onOpenInventory(behaviorName:String, realUiName:String) : void
      {
         if(!this.playerApi.characteristics() || this.uiApi.getUi(UIEnum.CHINQ_UI))
         {
            return;
         }
         this._inventory = this.storageApi.getViewContent("storage");
         this._kamas = this.playerApi.characteristics().kamas;
         this._weight = this.playerApi.inventoryWeight();
         this._weightMax = this.playerApi.inventoryWeightMax();
         var load:Boolean = false;
         var unload:Boolean = false;
         var uiName:String = StorageBehaviorManager.makeBehavior(behaviorName).getStorageUiName();
         var storageUi:UiRootContainer = this.uiApi.getUi(realUiName);
         if(storageUi)
         {
            if(storageUi.uiClass is EquipmentUi && uiName == UIEnum.EQUIPMENT_UI || storageUi.uiClass is InventoryUi && uiName == UIEnum.INVENTORY_UI || !(storageUi.uiClass is EquipmentUi) && !(storageUi.uiClass is InventoryUi) && uiName == UIEnum.STORAGE_UI)
            {
               load = false;
            }
            else
            {
               unload = true;
               load = true;
            }
         }
         else
         {
            load = true;
         }
         if(unload)
         {
            this.uiApi.unloadUi(realUiName);
         }
         if(load)
         {
            this.uiApi.loadUi(uiName,realUiName,{"storageMod":behaviorName},1);
         }
         else if(storageUi.uiClass && storageUi.uiClass.currentStorageBehavior && storageUi.uiClass.currentStorageBehavior.replacable)
         {
            storageUi.uiClass.switchBehavior(behaviorName);
         }
      }
      
      private function onCloseInventory(uiName:String = "storage") : void
      {
         if(this.uiApi.getUi(uiName))
         {
            this.uiApi.unloadUi(uiName);
         }
      }
      
      private function onOpenLivingObject(item:Object) : void
      {
         this.uiApi.unloadUi("livingObject");
         if(item)
         {
            this.uiApi.loadUi("livingObject","livingObject",{"item":item});
         }
      }
      
      private function onClientUIOpened(type:uint, uid:uint) : void
      {
         if(type == ClientUITypeEnum.CLIENT_UI_OBJECT_MIMICRY)
         {
            if(!this.uiApi.getUi("mimicry"))
            {
               this.uiApi.loadUi("mimicry","mimicry",uid);
            }
            this.sysApi.dispatchHook(HookList.OpenInventory,"mimicry",UIEnum.STORAGE_UI);
         }
      }
      
      private function playItemMovedSound() : void
      {
         if(this.uiApi.getUi(UIEnum.STORAGE_UI))
         {
            this.soundApi.playSound(SoundTypeEnum.MOVE_ITEM_TO_BAG);
         }
      }
      
      private function onObjectAdded(pItem:Object) : void
      {
         this.playItemMovedSound();
      }
      
      private function onObjectDeleted(pItem:Object) : void
      {
         this.playItemMovedSound();
      }
      
      private function onObjectModified(pItem:Object) : void
      {
         this.playItemMovedSound();
      }
      
      public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int) : void
      {
         if(!pItemWrapper || pItemWrapper.position > CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD)
         {
            return;
         }
         switch(pItemWrapper.position)
         {
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_NECKLACE);
               break;
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BUCKLER);
               break;
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CIRCLE);
               break;
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_CLOTHES);
               break;
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_BOOT);
               break;
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_WEAPON);
               break;
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
               break;
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
               this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_DOFUS);
         }
      }
      
      public function onMountRiding(isRidding:Boolean) : void
      {
         this.soundApi.playSound(SoundTypeEnum.EQUIPMENT_PET);
      }
   }
}

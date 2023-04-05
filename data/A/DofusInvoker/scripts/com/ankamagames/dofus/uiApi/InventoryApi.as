package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.QuantifiedItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.SimpleTextureWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PointCellFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.enum.CharacterBuildType;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class InventoryApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function InventoryApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(InventoryApi));
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getStorageObjectGID(pObjectGID:uint, quantity:uint = 1) : Array
      {
         var iw:ItemWrapper = null;
         var returnItems:Array = new Array();
         var numberReturn:uint = 0;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(iw in inventory)
         {
            if(!(iw.objectGID != pObjectGID || iw.position < 63 || iw.linked))
            {
               if(iw.quantity >= quantity - numberReturn)
               {
                  returnItems.push({
                     "objectUID":iw.objectUID,
                     "quantity":quantity - numberReturn
                  });
                  numberReturn = quantity;
                  return returnItems;
               }
               returnItems.push({
                  "objectUID":iw.objectUID,
                  "quantity":iw.quantity
               });
               numberReturn += iw.quantity;
            }
         }
         return null;
      }
      
      public function getStorageObjectsByType(objectType:uint) : Array
      {
         var iw:ItemWrapper = null;
         var returnItems:Array = new Array();
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(iw in inventory)
         {
            if(!(iw.typeId != objectType || iw.position < 63))
            {
               returnItems.push(iw);
            }
         }
         return returnItems;
      }
      
      public function getItemQty(pObjectGID:uint, pObjectUID:uint = 0) : uint
      {
         var item:ItemWrapper = null;
         var quantity:uint = 0;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(item in inventory)
         {
            if(!(item.position < 63 || item.objectGID != pObjectGID || pObjectUID > 0 && item.objectUID != pObjectUID))
            {
               quantity += item.quantity;
            }
         }
         return quantity;
      }
      
      public function getItemByGID(objectGID:uint) : ItemWrapper
      {
         var item:ItemWrapper = null;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(item in inventory)
         {
            if(!(item.position < 63 || item.objectGID != objectGID))
            {
               return item;
            }
         }
         return null;
      }
      
      public function getItemFromInventoryByUID(objectUID:uint) : ItemWrapper
      {
         var item:ItemWrapper = null;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         for each(item in inventory)
         {
            if(item.objectUID == objectUID)
            {
               return item;
            }
         }
         return null;
      }
      
      public function getQuantifiedItemByGIDInInventoryOrMakeUpOne(objectGID:uint) : QuantifiedItemWrapper
      {
         var qiw:QuantifiedItemWrapper = null;
         var item:ItemWrapper = null;
         var inventory:Vector.<ItemWrapper> = InventoryManager.getInstance().realInventory;
         var iw:ItemWrapper = null;
         for each(item in inventory)
         {
            if(!(item.position < 63 || item.objectGID != objectGID))
            {
               iw = item;
            }
         }
         if(iw)
         {
            qiw = QuantifiedItemWrapper.create(iw.position,iw.objectUID,objectGID,iw.quantity,iw.effectsList,false);
         }
         else
         {
            qiw = QuantifiedItemWrapper.create(0,0,objectGID,0,new Vector.<ObjectEffect>(),false);
         }
         return qiw;
      }
      
      public function getItem(objectUID:uint) : ItemWrapper
      {
         return InventoryManager.getInstance().inventory.getItem(objectUID);
      }
      
      public function getEquipementItemByPosition(pPosition:uint) : ItemWrapper
      {
         if(pPosition > CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD && pPosition != CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY && pPosition != CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME)
         {
            return null;
         }
         var equipementList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         return equipementList[pPosition];
      }
      
      public function getEquipement() : Vector.<ItemWrapper>
      {
         return InventoryManager.getInstance().inventory.getView("equipment").content;
      }
      
      public function getEquipementForPreset() : Array
      {
         var emptyUri:Uri = null;
         var pos:int = 0;
         var objExists:Boolean = false;
         var item:ItemWrapper = null;
         var mountFakeItemWrapper:MountWrapper = null;
         var itemsCount:int = InventoryManager.getInstance().getMaxItemsCountForPreset();
         var equipmentList:Vector.<ItemWrapper> = InventoryManager.getInstance().inventory.getView("equipment").content;
         var equipmentPreset:Array = new Array(itemsCount);
         for(var i:int = 0; i < itemsCount; i++)
         {
            pos = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
            objExists = false;
            for each(item in equipmentList)
            {
               if(item && item.position == pos)
               {
                  equipmentPreset[i] = item;
                  objExists = true;
               }
               else if(pos == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && PlayedCharacterManager.getInstance().isRidding)
               {
                  mountFakeItemWrapper = MountWrapper.create();
                  equipmentPreset[i] = mountFakeItemWrapper;
                  objExists = true;
               }
            }
            if(!objExists)
            {
               emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/slot/tx_slot_" + this.getSlotNameByPositionId(i) + ".png");
               equipmentPreset[i] = SimpleTextureWrapper.create(emptyUri);
            }
         }
         return equipmentPreset;
      }
      
      private function getSlotNameByPositionId(i:int) : String
      {
         var pos:int = InventoryManager.getInstance().getPositionForPresetItemIndex(i);
         switch(pos)
         {
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_AMULET:
               return "collar";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON:
               return "weapon";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_LEFT:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_RING_RIGHT:
               return "ring";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BELT:
               return "belt";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_BOOTS:
               return "shoe";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_HAT:
               return "helmet";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_CAPE:
               return "cape";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS:
               return "pet";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_1:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_2:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_3:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_4:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_5:
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_DOFUS_6:
               return "dofus";
            case CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD:
               return "shield";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY:
               return "companon";
            case CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME:
               return "costume";
            default:
               return "companon";
         }
      }
      
      public function getVoidItemForPreset(index:int) : SimpleTextureWrapper
      {
         var emptyUri:Uri = null;
         emptyUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "texture/slot/tx_slot_" + this.getSlotNameByPositionId(index) + ".png");
         return SimpleTextureWrapper.create(emptyUri);
      }
      
      public function getMaxItemsCountForPreset() : int
      {
         return InventoryManager.getInstance().getMaxItemsCountForPreset();
      }
      
      public function getPositionForPresetItemIndex(index:int) : int
      {
         return InventoryManager.getInstance().getPositionForPresetItemIndex(index);
      }
      
      public function getInvisibleEquipmentPositions() : Array
      {
         var invisiblePositions:Array = new Array();
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_MUTATION);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_MALUS);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_MALUS);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_ROLEPLAY_BUFFER);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_FOLLOWER);
         invisiblePositions.push(CharacterInventoryPositionEnum.ACCESSORY_POSITION_RIDE_HARNESS);
         invisiblePositions.push(CharacterInventoryPositionEnum.INVENTORY_POSITION_NOT_EQUIPED);
         return invisiblePositions;
      }
      
      public function getCurrentWeapon() : ItemWrapper
      {
         return this.getEquipementItemByPosition(CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON) as ItemWrapper;
      }
      
      public function getBuilds(buildType:int = -1) : Array
      {
         var maxBuildCount:int = 0;
         var index:uint = 0;
         if(buildType === -1)
         {
            buildType = CharacterBuildType.CHARACTER_TYPE;
         }
         var builds:Array = InventoryManager.getInstance().builds;
         maxBuildCount = builds.length;
         var emptyUri:Uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
         var displayablesBuilds:Array = new Array();
         for(index = 0; index < maxBuildCount; index++)
         {
            if(builds[index])
            {
               if(builds[index].buildType === buildType)
               {
                  displayablesBuilds.push(builds[index]);
               }
            }
            else
            {
               displayablesBuilds.push(SimpleTextureWrapper.create(emptyUri));
            }
         }
         if(buildType === CharacterBuildType.CHARACTER_TYPE)
         {
            index = displayablesBuilds.length;
            while(index < ProtocolConstantsEnum.MAX_PRESET_COUNT)
            {
               displayablesBuilds.push(SimpleTextureWrapper.create(emptyUri));
               index++;
            }
         }
         return displayablesBuilds;
      }
      
      public function getBuildNumber(buildType:int = -1) : uint
      {
         var index:uint = 0;
         var count:uint = 0;
         var currentBuild:BuildWrapper = null;
         var builds:Array = InventoryManager.getInstance().builds;
         if(builds !== null)
         {
            for(index = 0; index < builds.length; index++)
            {
               currentBuild = builds[index];
               if(currentBuild !== null && currentBuild.buildType === buildType)
               {
                  count++;
               }
            }
         }
         return count;
      }
      
      public function setBuildId(id:int) : void
      {
         InventoryManager.getInstance().currentBuildId = id;
      }
      
      public function getBuildId() : int
      {
         return InventoryManager.getInstance().currentBuildId;
      }
      
      public function removeSelectedItem() : Boolean
      {
         if(!Kernel.getWorker().contains(PointCellFrame))
         {
            return false;
         }
         PointCellFrame.getInstance().cancelShow();
         return true;
      }
   }
}

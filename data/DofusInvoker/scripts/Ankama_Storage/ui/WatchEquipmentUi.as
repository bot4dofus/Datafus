package Ankama_Storage.ui
{
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   
   public class WatchEquipmentUi extends StorageUi
   {
       
      
      private var _slotCollection:Array;
      
      private var _availableEquipmentPositions:Array;
      
      private var _currentEquipmentItemsByPos:Array;
      
      public var tx_cross:Texture;
      
      public var slot_0:Slot;
      
      public var slot_1:Slot;
      
      public var slot_2:Slot;
      
      public var slot_3:Slot;
      
      public var slot_4:Slot;
      
      public var slot_5:Slot;
      
      public var slot_6:Slot;
      
      public var slot_7:Slot;
      
      public var slot_8:Slot;
      
      public var slot_9:Slot;
      
      public var slot_10:Slot;
      
      public var slot_11:Slot;
      
      public var slot_12:Slot;
      
      public var slot_13:Slot;
      
      public var slot_14:Slot;
      
      public var slot_15:Slot;
      
      public var slot_28:Slot;
      
      public var slot_30:Slot;
      
      public var btn_idols:ButtonContainer;
      
      public var equipmentUi:GraphicContainer;
      
      public function WatchEquipmentUi()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         super.main(params);
         sysApi.removeHook(InventoryHookList.StorageViewContent);
         this._currentEquipmentItemsByPos = [];
         soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
         uiApi.addComponentHook(this.equipmentUi,ComponentHookList.ON_RELEASE);
         uiApi.addShortcutHook("closeUi",onShortCut);
         this.btn_idols.disabled = true;
         this.equipementSlotInit();
         var equipmentItems:Vector.<ItemWrapper> = storageApi.getViewContent("equipment",true);
         this.fillEquipement(equipmentItems);
         var storageItems:Vector.<ItemWrapper> = storageApi.getViewContent("storage",true);
         onInventoryUpdate(storageItems,InventoryManager.getWatchInstance().inventory.kamas);
      }
      
      override public function unload() : void
      {
         uiApi.unloadUi("itemBox");
         uiApi.unloadUi("itemsList");
         super.unload();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btnAll:
            case btnEquipable:
            case btnConsumables:
            case btnRessources:
            case btnCosmetics:
            case btnQuest:
            case btnMinouki:
               ctr_storageContent.visible = true;
         }
         super.onRelease(target);
      }
      
      override public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != SelectMethodEnum.AUTO)
         {
            switch(target)
            {
               case cb_category:
                  super.onSelectItem(target,selectMethod,isNewSelection);
            }
         }
      }
      
      override protected function displayItemTooltip(target:GraphicContainer, item:Object, settings:Object = null) : void
      {
         if(!settings)
         {
            settings = {};
         }
         super.displayItemTooltip(target,item,settings);
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target is Slot && (target as Slot).data)
         {
            if((target as Slot).data is MountWrapper)
            {
               uiApi.showTooltip((target as Slot).data,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,{
                  "noBg":false,
                  "uiName":uiApi.me().name
               },"ItemInfo");
               return;
            }
            this.displayItemTooltip(target,(target as Slot).data);
            return;
         }
         if(!text)
         {
            switch(target)
            {
               case this.btn_idols:
                  text = uiApi.getText("ui.shortcuts.openIdols");
                  break;
               case this.slot_0:
                  text = uiApi.getText("ui.common.inventoryType1");
                  break;
               case this.slot_15:
                  if(this.tx_cross.visible)
                  {
                     text = uiApi.getText("ui.common.inventoryTwoHandsWarning");
                  }
                  else
                  {
                     text = uiApi.getText("ui.common.inventoryType7");
                  }
                  break;
               case this.slot_4:
               case this.slot_2:
                  text = uiApi.getText("ui.common.inventoryType3");
                  break;
               case this.slot_3:
                  text = uiApi.getText("ui.common.inventoryType4");
                  break;
               case this.slot_5:
                  text = uiApi.getText("ui.common.inventoryType5");
                  break;
               case this.slot_28:
                  text = uiApi.getText("ui.common.inventoryType23");
                  break;
               case this.slot_6:
                  text = uiApi.getText("ui.common.inventoryType10");
                  break;
               case this.slot_1:
                  text = uiApi.getText("ui.common.inventoryType2");
                  break;
               case this.slot_7:
                  text = uiApi.getText("ui.common.inventoryType11");
                  break;
               case this.slot_8:
                  text = uiApi.getText("ui.common.inventoryType8");
                  break;
               case this.slot_30:
                  text = uiApi.getText("ui.common.inventoryType25");
                  break;
               case this.slot_14:
               case this.slot_13:
               case this.slot_12:
               case this.slot_11:
               case this.slot_10:
                  text = uiApi.getText("ui.common.inventoryType13");
                  break;
               case this.slot_9:
                  text = uiApi.getText("ui.common.inventoryType13Slot1");
                  break;
               default:
                  super.onRollOver(target);
                  return;
            }
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         var position:Number = NaN;
         if(target is Slot && (target as Slot).data)
         {
            data = (target as Slot).data;
            position = Number(target.name.split("slot_")[1]);
            if(position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && data.objectUID == 0 && data.hasOwnProperty("mountId"))
            {
               contextMenu = menuApi.create(data,"mount");
            }
            else
            {
               contextMenu = menuApi.create(data,"item",[{"ownedItem":true}]);
            }
            if(contextMenu.content.length > 0)
            {
               modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
      }
      
      private function equipementSlotInit() : void
      {
         var slot:Slot = null;
         this._slotCollection = [];
         this._availableEquipmentPositions = [];
         this._slotCollection[0] = this.slot_0;
         this._slotCollection[1] = this.slot_1;
         this._slotCollection[2] = this.slot_2;
         this._slotCollection[3] = this.slot_3;
         this._slotCollection[4] = this.slot_4;
         this._slotCollection[5] = this.slot_5;
         this._slotCollection[6] = this.slot_6;
         this._slotCollection[7] = this.slot_7;
         this._slotCollection[8] = this.slot_8;
         this._slotCollection[9] = this.slot_9;
         this._slotCollection[10] = this.slot_10;
         this._slotCollection[11] = this.slot_11;
         this._slotCollection[12] = this.slot_12;
         this._slotCollection[13] = this.slot_13;
         this._slotCollection[14] = this.slot_14;
         this._slotCollection[15] = this.slot_15;
         this._slotCollection[28] = this.slot_28;
         this._slotCollection[30] = this.slot_30;
         for each(slot in this._slotCollection)
         {
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
            this._availableEquipmentPositions.push(int(slot.name.split("_")[1]));
         }
      }
      
      private function fillEquipement(equipment:Object) : void
      {
         var item:Object = null;
         var slot:Slot = null;
         var pos:uint = 0;
         this._currentEquipmentItemsByPos = [];
         for each(item in equipment)
         {
            if(item)
            {
               this._currentEquipmentItemsByPos[item.position] = item;
            }
         }
         if(this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON] && this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON].twoHanded)
         {
            this.tx_cross.visible = true;
            this.tx_cross.alpha = 0.5;
         }
         for each(slot in this._slotCollection)
         {
            pos = parseInt(slot.name.split("_")[1]);
            slot.data = this._currentEquipmentItemsByPos[pos];
         }
      }
   }
}

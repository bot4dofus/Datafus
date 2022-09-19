package Ankama_Storage.ui
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.behavior.IStorageBehavior;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class InventoryUi extends StorageUi
   {
       
      
      private var _slotCollection:Array;
      
      private var _currentEquipmentItemsByPos:Array;
      
      private var _delayDoubleClickTimer:BenchmarkTimer;
      
      private var _itemWaitingForPopupDisplay:Object;
      
      private var _itemWaitingForPopupDisplayQty:uint;
      
      private var _itemWaitingForPopupDisplayPosition:Number;
      
      private var _slotClickedNoDragAllowed:Slot;
      
      private var _popupName:String;
      
      private var _draggedItem:ItemWrapper;
      
      public var equipmentUi:GraphicContainer;
      
      public function InventoryUi()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         super.main(params);
         this._currentEquipmentItemsByPos = [];
         soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
         sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         uiApi.addComponentHook(this.equipmentUi,ComponentHookList.ON_RELEASE);
         uiApi.addShortcutHook("closeUi",onShortCut);
         var equipmentItems:Vector.<ItemWrapper> = storageApi.getViewContent("equipment");
         this.fillEquipement(equipmentItems);
         this._delayDoubleClickTimer = new BenchmarkTimer(500,1,"InventoryUi._delayDoubleClickTimer");
         this._delayDoubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
      }
      
      override public function unload() : void
      {
         this._delayDoubleClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
         this._delayDoubleClickTimer = null;
         uiApi.unloadUi("itemsList");
         uiApi.unloadUi(this._popupName);
         uiApi.unloadUi("quantityPopup");
         uiApi.unloadUi("preset");
         super.unload();
      }
      
      private function blockDragDropOnSlot(slot:Slot) : void
      {
         this._slotClickedNoDragAllowed = slot;
         if(this._slotClickedNoDragAllowed != null)
         {
            this._slotClickedNoDragAllowed.allowDrag = false;
            this._delayDoubleClickTimer.start();
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         var position:uint = 0;
         if(target is Slot && (target as Slot).data && !this._delayDoubleClickTimer.running)
         {
            uiApi.unloadUi("itemsList");
            this.blockDragDropOnSlot(target as Slot);
            position = target.name.split("slot_")[1] as uint;
            if(position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && (target as Slot).data.objectUID == 0 && (target as Slot).data.hasOwnProperty("mountId"))
            {
               sysApi.sendAction(new MountToggleRidingRequestAction([]));
            }
            else
            {
               sysApi.sendAction(new ObjectSetPositionAction([(target as Slot).data.objectUID,63,1]));
            }
         }
      }
      
      private function getExperienceFromItem(foodItem:ItemWrapper, quantity:int, evolutiveTypeToFeed:EvolutiveItemType) : Number
      {
         var experience:Number = 0;
         if(foodItem.givenExperienceAsSuperFood > 0)
         {
            experience = quantity * foodItem.givenExperienceAsSuperFood;
         }
         else if(foodItem.basicExperienceAsFood > 0)
         {
            experience = quantity * foodItem.basicExperienceAsFood * evolutiveTypeToFeed.experienceBoost;
         }
         return experience;
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
               break;
            case btn_help:
               hintsApi.showSubHints();
               btnHelpClickAlreadyTreated = true;
         }
         uiApi.unloadUi("itemsList");
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
                  break;
               default:
                  if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                  {
                     if(_storageBehavior)
                     {
                        Api.ui.hideTooltip();
                        if(!this._delayDoubleClickTimer.running)
                        {
                           (_storageBehavior as IStorageBehavior).doubleClickGridItem(grid.selectedItem);
                           if(grid != null)
                           {
                              this.blockDragDropOnSlot(grid.selectedSlot as Slot);
                           }
                        }
                     }
                  }
                  return;
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
         var text:* = null;
         var evolutiveType:EvolutiveItemType = null;
         var targetIsMaxLevel:* = false;
         var effect:EffectInstance = null;
         var xp:Number = NaN;
         var roundXp:int = 0;
         var experienceToReachMaxLevel:int = 0;
         var xpText:String = null;
         var itemToFeed:ItemWrapper = null;
         var futurItemExperience:int = 0;
         var futurLevel:int = 0;
         var effects:Array = null;
         var levelsCount:int = 0;
         var color:String = null;
         var ei:EffectInstance = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         var targetData:* = target is Slot ? (target as Slot).data : null;
         if(targetData)
         {
            if(targetData is MountWrapper)
            {
               uiApi.showTooltip(targetData,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,{
                  "noBg":false,
                  "uiName":uiApi.me().name
               },"ItemInfo");
               return;
            }
            if(this._draggedItem && targetData && targetData.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET)
            {
               evolutiveType = targetData.type.evolutiveType;
               if(!evolutiveType)
               {
                  return;
               }
               if(!targetData.isEvolutive())
               {
                  return;
               }
               if(this._draggedItem.category != ItemCategoryEnum.RESOURCES_CATEGORY)
               {
                  return;
               }
               targetIsMaxLevel = targetData.evolutiveLevel == evolutiveType.maxLevel;
               if(targetIsMaxLevel && targetData.itemHasLockedLegendarySpell)
               {
                  text = uiApi.getText("ui.evolutive.pet.errorCantEatAnythingAnymore");
               }
               else if(this._draggedItem.canBeUsedForAutoPiloting(targetData as ItemWrapper))
               {
                  text = null;
               }
               else if(targetIsMaxLevel != this._draggedItem.itemHasLegendaryEffect || targetIsMaxLevel && targetData.itemHoldsLegendaryStatus == this._draggedItem.itemHoldsLegendaryStatus)
               {
                  text = uiApi.getText("ui.evolutive.pet.errorCantEatRightNow");
               }
               else if(targetIsMaxLevel && this._draggedItem.itemHasLegendaryEffect)
               {
                  for each(effect in this._draggedItem.effects)
                  {
                     if(text && text != "" && effect.description != "")
                     {
                        text += "\n";
                     }
                     text = "+ " + effect.description;
                  }
               }
               else if(targetIsMaxLevel)
               {
                  text = uiApi.getText("ui.mount.maxLevel");
               }
               else
               {
                  xp = 0;
                  if(this._draggedItem.givenExperienceAsSuperFood > 0)
                  {
                     xp = this._draggedItem.givenExperienceAsSuperFood * this._draggedItem.quantity;
                  }
                  else if(this._draggedItem.basicExperienceAsFood > 0)
                  {
                     xp = this._draggedItem.basicExperienceAsFood * this._draggedItem.quantity * evolutiveType.experienceBoost;
                  }
                  roundXp = Math.floor(xp);
                  experienceToReachMaxLevel = evolutiveType.experienceByLevel[evolutiveType.maxLevel] - targetData.experiencePoints;
                  if(experienceToReachMaxLevel < roundXp)
                  {
                     roundXp = experienceToReachMaxLevel;
                  }
                  xpText = utilApi.kamasToString(roundXp,"");
                  itemToFeed = targetData;
                  text = uiApi.getText("ui.tooltip.monsterXpAlone","+ " + xpText);
                  futurItemExperience = roundXp + itemToFeed.experiencePoints;
                  futurLevel = dataApi.getEvolutiveItemLevelByExperiencePoints(itemToFeed,futurItemExperience);
                  if(futurLevel > itemToFeed.evolutiveLevel)
                  {
                     levelsCount = futurLevel - itemToFeed.evolutiveLevel;
                     text += "\n+ " + uiApi.processText(uiApi.getText("ui.evolutive.levelsCount",levelsCount),"m",levelsCount == 1,levelsCount == 0);
                  }
                  effects = dataApi.getEvolutiveEffectInstancesByExperienceBoost(itemToFeed,roundXp);
                  if(effects.length)
                  {
                     color = (sysApi.getConfigEntry("colors.tooltip.bonus") as String).replace("0x","#");
                     text += "<font color=\'" + color + "\'>";
                     for each(ei in effects)
                     {
                        if(ei)
                        {
                           text += "\n+ " + ei.description;
                        }
                     }
                     text += "</font>";
                  }
               }
               if(text !== null)
               {
                  uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,{"displayWhenMouseDown":true},"TextInfo");
               }
               return;
            }
            this.displayItemTooltip(target,targetData);
            return;
         }
         if(!text)
         {
            super.onRollOver(target);
            return;
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      override protected function fillContextMenu(contextMenu:Array, data:Object, disabled:Boolean, target:GraphicContainer) : void
      {
         var behavior:* = modContextMenu.getBehavior();
         if(data)
         {
            if(data.usable && data.quantity > 1 && data.isOkForMultiUse)
            {
               contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.multipleUse"),this.useItemQuantity,[data,target],disabled));
            }
            if(data.usable)
            {
               contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.use"),this.useItem,[data],disabled));
            }
            if(data.targetable && !data.nonUsableOnAnother)
            {
               contextMenu.unshift(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.target"),this.useItemOnCell,[data],disabled));
            }
            if(data.isEquipment)
            {
               contextMenu.unshift(modContextMenu.createContextMenuItemObject(data.isWrapperObject || data.isLivingObject ? uiApi.getText("ui.common.associate") : uiApi.getText("ui.common.equip"),this.equipItem,[data],disabled));
            }
         }
         super.fillContextMenu(contextMenu,data,disabled,target);
         if(data)
         {
            contextMenu.push(modContextMenu.createContextMenuSeparatorObject());
            contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.destroyThisItem"),this.askDeleteItem,[data],disabled || !data.isDestructible || behavior && !behavior.canDestroyItem(data)));
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
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
      
      public function onMountSet() : void
      {
         var mount:MountWrapper = storageApi.getFakeItemMount();
         this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
         this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
      }
      
      public function useItem(item:Object) : void
      {
         if(!item.usable && item.targetable)
         {
            sysApi.sendAction(new ObjectUseAction([item.objectUID,1,true]));
            uiApi.unloadUi(uiApi.me().name);
         }
         else
         {
            sysApi.sendAction(new ObjectUseAction([item.objectUID,1,false]));
         }
      }
      
      public function useItemQuantity(item:Object, target:GraphicContainer) : void
      {
         this._itemWaitingForPopupDisplay = item;
         modCommon.openQuantityPopup(1,item.quantity,1,this.onValidItemQuantityUse,null,false,target);
      }
      
      public function onValidItemQuantityUse(qty:Number) : void
      {
         sysApi.sendAction(new ObjectUseAction([this._itemWaitingForPopupDisplay.objectUID,qty,false]));
         this._itemWaitingForPopupDisplay = null;
      }
      
      public function onValidItemQuantitySetPosition(qty:Number) : void
      {
         sysApi.sendAction(new ObjectSetPositionAction([this._itemWaitingForPopupDisplay.objectUID,this._itemWaitingForPopupDisplayPosition,qty]));
         this._itemWaitingForPopupDisplay = null;
         this._itemWaitingForPopupDisplayPosition = 0;
      }
      
      public function equipItem(item:ItemWrapper) : void
      {
         var freeSlot:int = 0;
         var equipement:Vector.<ItemWrapper> = null;
         var pos:int = 0;
         var possiblePosition:Array = storageApi.itemSuperTypeToServerPosition(item.type.superTypeId);
         if(possiblePosition && possiblePosition.length)
         {
            equipement = storageApi.getViewContent("equipment");
            freeSlot = -1;
            for each(pos in possiblePosition)
            {
               if(!equipement[pos])
               {
                  freeSlot = pos;
                  break;
               }
            }
            if(freeSlot == -1)
            {
               freeSlot = possiblePosition[0];
            }
            sysApi.sendAction(new ObjectSetPositionAction([item.objectUID,freeSlot,1]));
         }
         else if(item && (item.isWrapperObject || item.isLivingObject))
         {
            if(item.category == 0)
            {
               freeSlot = storageApi.getBestEquipablePosition(item);
               if(freeSlot > -1)
               {
                  Api.system.sendAction(new ObjectSetPositionAction([item.objectUID,freeSlot,1]));
               }
            }
         }
      }
      
      public function useItemOnCell(item:Object) : void
      {
         sysApi.sendAction(new ObjectUseAction([item.objectUID,1,true]));
         uiApi.unloadUi(uiApi.me().name);
      }
      
      public function askDeleteItem(item:Object) : void
      {
         this._itemWaitingForPopupDisplay = item;
         if(item.quantity == 1)
         {
            this.askDeleteConfirm(1);
         }
         else
         {
            modCommon.openQuantityPopup(1,item.quantity,item.quantity,this.askDeleteConfirm);
         }
      }
      
      private function getItemSuperType(item:Object) : int
      {
         var cat:int = 0;
         var itemType:ItemType = null;
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
            itemType = dataApi.getItemType(cat);
            if(itemType)
            {
               return itemType.superTypeId;
            }
            return 0;
         }
         if(item is ItemWrapper && item.type)
         {
            return (item as ItemWrapper).type.superTypeId;
         }
         if(item is ShortcutWrapper)
         {
            if((item as ShortcutWrapper).type == 0)
            {
               return ((item as ShortcutWrapper).realItem as ItemWrapper).type.superTypeId;
            }
         }
         return 0;
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
         if((!this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] || this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] == null) && playerApi.isRidding())
         {
            this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = storageApi.getFakeItemMount();
         }
         for each(slot in this._slotCollection)
         {
            pos = parseInt(slot.name.split("_")[1]);
            slot.data = this._currentEquipmentItemsByPos[pos];
         }
      }
      
      private function askDeleteConfirm(qty:uint) : void
      {
         if(this._popupName)
         {
            return;
         }
         this._itemWaitingForPopupDisplayQty = qty;
         this._popupName = modCommon.openPopup(uiApi.getText("ui.common.delete.item"),uiApi.getText("ui.common.doYouDestroy",qty,this._itemWaitingForPopupDisplay.name),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.deleteItem,this.emptyFct],this.deleteItem,this.emptyFct);
      }
      
      private function onDelayDoubleClickTimer(pEvt:TimerEvent) : void
      {
         this._delayDoubleClickTimer.stop();
         if(this._slotClickedNoDragAllowed != null)
         {
            this._slotClickedNoDragAllowed.allowDrag = true;
            this._slotClickedNoDragAllowed = null;
         }
      }
      
      private function deleteItem() : void
      {
         sysApi.sendAction(new DeleteObjectAction([this._itemWaitingForPopupDisplay.objectUID,this._itemWaitingForPopupDisplayQty]));
         this._popupName = null;
      }
      
      private function emptyFct(... args) : void
      {
         this._popupName = null;
      }
   }
}

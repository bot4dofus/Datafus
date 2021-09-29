package Ankama_Storage.ui
{
   import Ankama_Storage.Api;
   import Ankama_Storage.ui.behavior.StorageClassicBehavior;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   
   public class EquipmentUi extends StorageUi
   {
       
      
      private var _slotCollection:Array;
      
      private var _availableEquipmentPositions:Array;
      
      private var _currentCharacterDirection:int = 2;
      
      private var _currentEquipmentItemsByPos:Array;
      
      private var _delayDoubleClickTimer:BenchmarkTimer;
      
      private var _itemWaitingForPopupDisplay:Object;
      
      private var _itemWaitingForPopupDisplayQty:uint;
      
      private var _itemWaitingForPopupDisplayPosition:Number;
      
      private var _slotClickedNoDragAllowed:Slot;
      
      private var _popupName:String;
      
      private var _selectedItem:ItemWrapper;
      
      private var _draggedItem:ItemWrapper;
      
      private var _positionClicked:int = -1;
      
      private var _equippedItemClicked:int = -1;
      
      public var tx_breedSymbol:Texture;
      
      public var tx_cross:Texture;
      
      public var tx_base:Texture;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
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
      
      public var slot_default:Slot;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var btn_idols:ButtonContainer;
      
      public var equipmentUi:GraphicContainer;
      
      public function EquipmentUi()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         super.main(params);
         this._currentEquipmentItemsByPos = [];
         soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
         sysApi.addHook(BeriliaHookList.DropStart,this.onEquipementDropStart);
         sysApi.addHook(BeriliaHookList.DropEnd,this.onEquipementDropEnd);
         sysApi.addHook(HookList.PlayedCharacterLookChange,this.updateLook);
         sysApi.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         sysApi.addHook(MountHookList.MountRiding,this.onMountRiding);
         sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_idols,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.equipmentUi,ComponentHookList.ON_RELEASE);
         uiApi.addShortcutHook("closeUi",onShortCut);
         this.btn_idols.disabled = playerApi.isInTutorialArea();
         this.equipementSlotInit();
         var characterInfos:Object = playerApi.getPlayedCharacterInfo();
         this.tx_breedSymbol.uri = uiApi.createUri(uiApi.me().getConstant("breedIllus") + characterInfos.breed.toString() + ".png");
         var equipmentItems:Vector.<ItemWrapper> = storageApi.getViewContent("equipment");
         this.fillEquipement(equipmentItems);
         this._delayDoubleClickTimer = new BenchmarkTimer(500,1,"EquipmentUi._delayDoubleClickTimer");
         this._delayDoubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
         this._currentCharacterDirection = 1;
         var look:TiphonEntityLook = utilApi.getRealTiphonEntityLook(characterInfos.id,true);
         if(look.getBone() == 2)
         {
            look.setBone(1);
         }
         this.updateLook(look);
      }
      
      override public function unload() : void
      {
         this._delayDoubleClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelayDoubleClickTimer);
         this._delayDoubleClickTimer = null;
         uiApi.unloadUi("itemBox");
         uiApi.unloadUi("itemsList");
         uiApi.unloadUi(this._popupName);
         uiApi.unloadUi("quantityPopup");
         uiApi.unloadUi("preset");
         super.unload();
      }
      
      private function wheelChara(sens:int) : void
      {
         this._currentCharacterDirection = (this._currentCharacterDirection + sens + 8) % 8;
         this.entityDisplayer.direction = this._currentCharacterDirection;
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
         var id:int = 0;
         var superTypesForThisSlot:Array = null;
         var allItemsOfTheRightSuperType:Vector.<ItemWrapper> = null;
         var i:int = 0;
         var itemsCount:int = 0;
         var superType:int = 0;
         var inventoryItems:Vector.<ItemWrapper> = null;
         var positions:Object = null;
         switch(target)
         {
            case btnAll:
            case btnEquipable:
            case btnConsumables:
            case btnRessources:
            case btnQuest:
            case btnMinouki:
               ctr_storageContent.visible = true;
               break;
            case this.btn_idols:
               if(!uiApi.getUi("idolsTab"))
               {
                  sysApi.sendAction(new OpenIdolsAction([]));
               }
               else
               {
                  sysApi.sendAction(new OpenBookAction(["idolsTab"]));
               }
               break;
            case this.btn_leftArrow:
               this.wheelChara(-1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(1);
               break;
            case btn_help:
               hintsApi.showSubHints();
               btnHelpClickAlreadyTreated = true;
         }
         if(target.name.indexOf("slot_") == 0)
         {
            id = int(target.name.split("slot_")[1]);
            this._positionClicked = id;
            superTypesForThisSlot = storageApi.serverPositionsToItemSuperType(id);
            allItemsOfTheRightSuperType = new Vector.<ItemWrapper>();
            this._equippedItemClicked = -1;
            if((target as Slot).data && (target as Slot).data is ItemWrapper)
            {
               this._equippedItemClicked = ((target as Slot).data as ItemWrapper).objectUID;
            }
            for each(superType in superTypesForThisSlot)
            {
               inventoryItems = storageApi.getInventoryItemsForSuperType(superType);
               itemsCount = inventoryItems.length;
               for(i = 0; i < itemsCount; i++)
               {
                  positions = storageApi.itemTypeToServerPosition(inventoryItems[i].type.id);
                  if(!(positions && positions.length > 0 && positions.indexOf(id) === -1))
                  {
                     allItemsOfTheRightSuperType.push(inventoryItems[i]);
                  }
               }
            }
            if(allItemsOfTheRightSuperType.length > 0)
            {
               uiApi.hideTooltip();
               sysApi.dispatchHook(HookList.OpenItemsList,this._equippedItemClicked,allItemsOfTheRightSuperType,uiApi.getText("ui.common.equip"),this.equipObject);
            }
         }
         else
         {
            uiApi.unloadUi("itemsList");
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
                  break;
               default:
                  if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
                  {
                     if(_storageBehavior)
                     {
                        Api.ui.hideTooltip();
                        if(!this._delayDoubleClickTimer.running)
                        {
                           (_storageBehavior as StorageClassicBehavior).doubleClickGridItem(grid.selectedItem);
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
      
      private function dropValidatorFunction(target:GraphicContainer, data:Object, source:Object) : Boolean
      {
         var superType:uint = 0;
         var superTypeId:int = 0;
         var slotId:Number = Number(target.name.split("slot_")[1]);
         var itemWrapper:ItemWrapper = data as ItemWrapper;
         var targetData:Object = (target as Slot).data;
         if(target == this.slot_default)
         {
            return true;
         }
         if(targetData && targetData.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET)
         {
            if(!data || !data.type)
            {
               return false;
            }
            if(data.type.superTypeId == DataEnum.ITEM_SUPERTYPE_MOUNT_EQUIPMENT)
            {
               return false;
            }
            if(data.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET)
            {
               return true;
            }
            if(itemWrapper.canBeUsedForAutoPiloting(targetData as ItemWrapper) || rpApi.resourceIsFood(itemWrapper))
            {
               return rpApi.canPetEatThisFood((target as Slot).data as ItemWrapper,data as ItemWrapper);
            }
         }
         var possibilities:Array = storageApi.itemTypeToServerPosition(data.typeId);
         if(possibilities == null)
         {
            superTypeId = this.getItemSuperType(data);
            if(superTypeId == 0)
            {
               return false;
            }
            possibilities = storageApi.itemSuperTypeToServerPosition(superTypeId);
         }
         for each(superType in possibilities)
         {
            if(superType == slotId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function processDropFunction(target:GraphicContainer, data:Object, source:Object) : void
      {
         var position:Number = NaN;
         var maxQuantity:int = 0;
         var quantity:int = 0;
         var evolutiveType:EvolutiveItemType = null;
         var experienceToReachMaxLevel:int = 0;
         var experienceByItem:Number = NaN;
         if(target == this.slot_default)
         {
            (_storageBehavior as StorageClassicBehavior).doubleClickGridItem(data);
            return;
         }
         if(this.dropValidatorFunction(target,data,source))
         {
            position = Number(target.name.split("slot_")[1]);
            if((target as Slot).data && (target as Slot).data.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET && data && data.category == ItemCategoryEnum.RESOURCES_CATEGORY && (data.basicExperienceAsFood > 0 || data.givenExperienceAsSuperFood > 0) && data.quantity > 1)
            {
               this._itemWaitingForPopupDisplay = data;
               this._itemWaitingForPopupDisplayPosition = position;
               if(data.itemHasLegendaryEffect)
               {
                  if(this._popupName)
                  {
                     return;
                  }
                  this._popupName = modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.evolutive.pet.confirmFeedLegendary",data.name),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.confirmFeedLegendary,this.emptyFct],this.confirmFeedLegendary,this.emptyFct);
                  return;
               }
               if(!data.itemHasLegendaryEffect)
               {
                  evolutiveType = (target as Slot).data.type.evolutiveType;
                  experienceToReachMaxLevel = evolutiveType.experienceByLevel[evolutiveType.maxLevel] - (target as Slot).data.experiencePoints;
                  experienceByItem = this.getExperienceFromItem(data as ItemWrapper,1,evolutiveType);
                  maxQuantity = Math.ceil(experienceToReachMaxLevel / experienceByItem);
                  quantity = Math.min(data.quantity,maxQuantity);
               }
               modCommon.openQuantityPopup(1,quantity,quantity,this.onValidItemQuantitySetPosition);
            }
            else if(data.itemHasLegendaryEffect)
            {
               if(this._popupName)
               {
                  return;
               }
               this._itemWaitingForPopupDisplay = data;
               this._itemWaitingForPopupDisplayPosition = position;
               this._popupName = modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.evolutive.pet.confirmFeedLegendary",data.name),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.confirmFeedLegendary,this.emptyFct],this.confirmFeedLegendary,this.emptyFct);
            }
            else
            {
               sysApi.sendAction(new ObjectSetPositionAction([data.objectUID,position,1]));
            }
         }
      }
      
      public function confirmFeedLegendary() : void
      {
         sysApi.sendAction(new ObjectSetPositionAction([this._itemWaitingForPopupDisplay.objectUID,this._itemWaitingForPopupDisplayPosition,1]));
         this._itemWaitingForPopupDisplay = null;
         this._itemWaitingForPopupDisplayPosition = 0;
         this._popupName = null;
      }
      
      public function equipObject(objectUID:int) : void
      {
         if(this._positionClicked != -1)
         {
            if(objectUID == -1)
            {
               sysApi.sendAction(new ObjectSetPositionAction([this._equippedItemClicked,63,1]));
            }
            else
            {
               sysApi.sendAction(new ObjectSetPositionAction([objectUID,this._positionClicked,1]));
            }
            this._positionClicked = -1;
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
      
      private function blockDragDropOnSlot(slot:Slot) : void
      {
         this._slotClickedNoDragAllowed = slot;
         if(this._slotClickedNoDragAllowed != null)
         {
            this._slotClickedNoDragAllowed.allowDrag = false;
            this._delayDoubleClickTimer.start();
         }
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
      
      private function onEquipementDropStart(src:GraphicContainer) : void
      {
         var slot:Slot = null;
         if(!(src as Slot).data || !((src as Slot).data is ItemWrapper))
         {
            return;
         }
         this._draggedItem = (src as Slot).data as ItemWrapper;
         if(src.getUi() == uiApi.me())
         {
            sysApi.disableWorldInteraction();
         }
         for each(slot in this._slotCollection)
         {
            if(this.dropValidatorFunction(slot,(src as Slot).data,null))
            {
               slot.selected = true;
            }
         }
      }
      
      private function onEquipementDropEnd(src:Object, target:Object) : void
      {
         var slot:Slot = null;
         this._draggedItem = null;
         if(src.getUi() == uiApi.me())
         {
            sysApi.enableWorldInteraction();
         }
         for each(slot in this._slotCollection)
         {
            slot.selected = false;
         }
      }
      
      public function onObjectModified(item:Object) : void
      {
         var slot:Slot = null;
         var pos:uint = 0;
         if(this._availableEquipmentPositions.indexOf(item.position) != -1)
         {
            this._currentEquipmentItemsByPos[item.position] = item;
            for each(slot in this._slotCollection)
            {
               pos = parseInt(slot.name.split("_")[1]);
               slot.data = this._currentEquipmentItemsByPos[pos];
            }
         }
      }
      
      public function onEquipmentObjectMove(pItemWrapper:Object, oldPosition:int) : void
      {
         if(oldPosition != -1 && (!this._slotCollection[oldPosition] || !this._slotCollection[oldPosition].data))
         {
            return;
         }
         if(oldPosition != -1 && this._availableEquipmentPositions.indexOf(oldPosition) != -1 && (!pItemWrapper || !this._slotCollection[oldPosition].data || pItemWrapper.objectUID == this._slotCollection[oldPosition].data.objectUID))
         {
            this._slotCollection[oldPosition].data = null;
            this._currentEquipmentItemsByPos[oldPosition] = null;
         }
         if(!pItemWrapper && oldPosition == 1)
         {
            this.tx_cross.visible = false;
            this.slot_15.alpha = 1;
            return;
         }
         if(!pItemWrapper || this._availableEquipmentPositions.indexOf(pItemWrapper.position) == -1)
         {
            return;
         }
         if(pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && playerApi.isRidding())
         {
            this._slotCollection[pItemWrapper.position].data = storageApi.getFakeItemMount();
            this._currentEquipmentItemsByPos[pItemWrapper.position] = storageApi.getFakeItemMount();
         }
         else
         {
            this._slotCollection[pItemWrapper.position].data = pItemWrapper;
            this._currentEquipmentItemsByPos[pItemWrapper.position] = pItemWrapper;
         }
         if(pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_WEAPON)
         {
            if(pItemWrapper.twoHanded)
            {
               this.tx_cross.visible = true;
               this.tx_cross.alpha = 0.5;
            }
            else
            {
               this.tx_cross.visible = false;
               this.tx_cross.alpha = 1;
            }
         }
         else if(pItemWrapper.position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS && this.slot_8.data.objectUID == pItemWrapper.objectUID && !pItemWrapper.linked && pItemWrapper.forcedBackGroundIconUri && pItemWrapper.forcedBackGroundIconUri.fileName.indexOf("linkedSlot") != -1)
         {
            pItemWrapper.forcedBackGroundIconUri = null;
            this.slot_8.refresh();
         }
      }
      
      public function onMountRiding(isRidding:Boolean) : void
      {
         var mount:MountWrapper = null;
         if(isRidding)
         {
            mount = storageApi.getFakeItemMount();
            this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
            this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
         }
         else
         {
            this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = null;
            this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = null;
         }
      }
      
      public function onMountSet() : void
      {
         var mount:MountWrapper = null;
         if(PlayedCharacterManager.getInstance().isRidding)
         {
            mount = storageApi.getFakeItemMount();
            this._slotCollection[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].data = mount;
            this._currentEquipmentItemsByPos[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] = mount;
         }
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
         this.slot_default.dropValidator = this.dropValidatorFunction as Function;
         this.slot_default.processDrop = this.processDropFunction as Function;
         for each(slot in this._slotCollection)
         {
            slot.dropValidator = this.dropValidatorFunction as Function;
            slot.processDrop = this.processDropFunction as Function;
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
            this._availableEquipmentPositions.push(int(slot.name.split("_")[1]));
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
      
      private function updateLook(pLook:Object) : void
      {
         this.entityDisplayer.centerPos = this.tx_base.parent.localToGlobal(new Point(this.tx_base.x + this.tx_base.width / 2,this.tx_base.y + this.tx_base.height / 2));
         var look:TiphonEntityLook = utilApi.getRealTiphonEntityLook(playerApi.getPlayedCharacterInfo().id,true);
         if(look.getBone() == 2)
         {
            look.setBone(1);
         }
         this.entityDisplayer.direction = this._currentCharacterDirection;
         this.entityDisplayer.look = look;
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
      
      private function askDeleteConfirm(qty:uint) : void
      {
         if(this._popupName)
         {
            return;
         }
         this._itemWaitingForPopupDisplayQty = qty;
         this._popupName = modCommon.openPopup(uiApi.getText("ui.common.delete.item"),uiApi.getText("ui.common.doYouDestroy",qty,this._itemWaitingForPopupDisplay.name),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.deleteItem,this.emptyFct],this.deleteItem,this.emptyFct);
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

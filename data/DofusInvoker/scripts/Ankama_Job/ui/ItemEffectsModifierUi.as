package Ankama_Job.ui
{
   import Ankama_Storage.ui.StorageUi;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.enums.CraftResultEnum;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class ItemEffectsModifierUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var slot_modifiedObject:Slot;
      
      public var slot_ingredient_1:Slot;
      
      public var slot_ingredient_2:Slot;
      
      public var slot_ingredient_3:Slot;
      
      public var slot_item_preview:Slot;
      
      public var tx_modifiedObject:Texture;
      
      public var tx_ingredient_1:Texture;
      
      public var tx_ingredient_2:Texture;
      
      public var tx_ingredient_3:Texture;
      
      public var tx_item_preview:Texture;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_ingredient:GraphicContainer;
      
      public var blk_ingredient:GraphicContainer;
      
      public var ctr_equal:GraphicContainer;
      
      public var ctr_slotModifiedObject:GraphicContainer;
      
      public var ctr_slotIngredient1:GraphicContainer;
      
      public var ctr_slotIngredient2:GraphicContainer;
      
      public var ctr_slotIngredient3:GraphicContainer;
      
      public var ctr_item_preview:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_merge:ButtonContainer;
      
      public var lbl_info:Label;
      
      private var _slots:Array;
      
      private var _slotTypeRestrictions:Dictionary;
      
      private var _effectParamRestrictions:Dictionary;
      
      private var _currentSlotWithSuperEffect:Slot;
      
      private var _canUseSuperCard:Boolean = true;
      
      private var _errorText:String;
      
      private var _errorTarget:Slot;
      
      private var _storageUi:StorageUi;
      
      public function ItemEffectsModifierUi()
      {
         this._slotTypeRestrictions = new Dictionary();
         this._effectParamRestrictions = new Dictionary();
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var slot:* = undefined;
         this.sysApi.disableWorldInteraction();
         this.sysApi.addHook(HookList.OpenInventory,this.onOpenInventory);
         this.sysApi.addHook(CraftHookList.ExchangeCraftResult,this.onExchangeCraftResult);
         this.sysApi.addHook(BeriliaHookList.DropEnd,this.onDropEnd);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addComponentHook(this.btn_merge,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_merge,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_merge,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_slotModifiedObject,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slotModifiedObject,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slotIngredient1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slotIngredient1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slotIngredient2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slotIngredient2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slotIngredient3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slotIngredient3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_modifiedObject,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_modifiedObject,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_ingredient_1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_ingredient_1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_ingredient_2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_ingredient_2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_ingredient_3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_ingredient_3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_item_preview,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_item_preview,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_ROLL_OUT);
         this._effectParamRestrictions[DataEnum.LOCATION_BONUS_CUSTOM_EFFECT_ID] = DataEnum.CARD_BONUS_CUSTOM_EFFECT_ID;
         this._effectParamRestrictions[DataEnum.LOCATION_HEART_CUSTOM_EFFECT_ID] = DataEnum.CARD_HEART_CUSTOM_EFFECT_ID;
         this._effectParamRestrictions[DataEnum.LOCATION_DIAMOND_CUSTOM_EFFECT_ID] = DataEnum.CARD_DIAMOND_CUSTOM_EFFECT_ID;
         this._effectParamRestrictions[DataEnum.LOCATION_SPADE_CUSTOM_EFFECT_ID] = DataEnum.CARD_SPADE_CUSTOM_EFFECT_ID;
         this._effectParamRestrictions[DataEnum.LOCATION_CLUB_CUSTOM_EFFECT_ID] = DataEnum.CARD_CLUB_CUSTOM_EFFECT_ID;
         this._slots = [this.slot_modifiedObject,this.slot_ingredient_1,this.slot_ingredient_2,this.slot_ingredient_3];
         this._slotTypeRestrictions[this.slot_modifiedObject] = new SlotRestrictions([DataEnum.ITEM_TYPE_MINOUKI],[]);
         this._slotTypeRestrictions[this.slot_ingredient_1] = new SlotRestrictions([],[]);
         this._slotTypeRestrictions[this.slot_ingredient_2] = new SlotRestrictions([],[]);
         this._slotTypeRestrictions[this.slot_ingredient_3] = new SlotRestrictions([],[]);
         for each(slot in this._slots)
         {
            this.registerSlot(slot);
         }
         this.btn_merge.disabled = true;
      }
      
      public function unload() : void
      {
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         this.sysApi.sendAction(new CloseInventoryAction([]));
         this.sysApi.enableWorldInteraction();
      }
      
      private function setIngredientSlots(item:ItemWrapper) : void
      {
         var effectInstance:EffectInstance = null;
         var effectParam:int = 0;
         this.resetIngredientSlots();
         var effects:Vector.<EffectInstance> = new Vector.<EffectInstance>();
         var effectCount:uint = 0;
         for each(effectInstance in item.effects)
         {
            if(effectInstance.effectId != ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               continue;
            }
            effectParam = int(effectInstance.parameter2);
            switch(effectParam)
            {
               case DataEnum.MINOUKI_SUPER_EFFECT_ID:
                  this._canUseSuperCard = false;
                  break;
               case DataEnum.LOCATION_BONUS_CUSTOM_EFFECT_ID:
               case DataEnum.LOCATION_HEART_CUSTOM_EFFECT_ID:
               case DataEnum.LOCATION_DIAMOND_CUSTOM_EFFECT_ID:
               case DataEnum.LOCATION_SPADE_CUSTOM_EFFECT_ID:
               case DataEnum.LOCATION_CLUB_CUSTOM_EFFECT_ID:
                  effects.push(effectInstance);
                  effectCount++;
                  this.setIngredientSlotsRestriction(effectCount,effectParam);
                  break;
            }
         }
         this.resizeWindow(effectCount);
      }
      
      private function setIngredientSlotsRestriction(slotId:uint, effectParam:uint) : void
      {
         this["tx_ingredient_" + slotId].visible = true;
         this["tx_ingredient_" + slotId].uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "card_" + effectParam + ".png");
         this._slotTypeRestrictions[this["slot_ingredient_" + slotId]].pushType(DataEnum.ITEM_TYPE_ECAFLIP_CARD);
         this._slotTypeRestrictions[this["slot_ingredient_" + slotId]].pushEffect(this._effectParamRestrictions[effectParam]);
      }
      
      private function clearAllSlots() : void
      {
         this._errorText = "";
         this._errorTarget = null;
         this.lbl_info.visible = false;
         this.clearModifiedObjectSlot();
         this.clearIngredientSlots();
         this.clearObjectPreviewSlot();
         this.resizeWindow(3);
      }
      
      private function clearModifiedObjectSlot() : void
      {
         this._slotTypeRestrictions[this.slot_modifiedObject].reset();
         this.slot_modifiedObject.data = null;
         this._slotTypeRestrictions[this.slot_modifiedObject].pushType(DataEnum.ITEM_TYPE_MINOUKI);
         this.tx_ingredient_1.visible = false;
         this.tx_ingredient_2.visible = false;
         this.tx_ingredient_3.visible = false;
      }
      
      private function clearIngredientSlots() : void
      {
         this._slotTypeRestrictions[this.slot_ingredient_1].reset();
         this._slotTypeRestrictions[this.slot_ingredient_2].reset();
         this._slotTypeRestrictions[this.slot_ingredient_3].reset();
         this.slot_ingredient_1.data = null;
         this.slot_ingredient_2.data = null;
         this.slot_ingredient_3.data = null;
      }
      
      private function clearObjectPreviewSlot() : void
      {
         this.slot_item_preview.data = null;
      }
      
      private function resetIngredientSlots() : void
      {
         this._errorText = "";
         this._errorTarget = null;
         this.lbl_info.visible = false;
         this._canUseSuperCard = true;
         this._slotTypeRestrictions[this.slot_ingredient_1].reset();
         this._slotTypeRestrictions[this.slot_ingredient_2].reset();
         this._slotTypeRestrictions[this.slot_ingredient_3].reset();
         this.tx_ingredient_1.visible = false;
         this.tx_ingredient_2.visible = false;
         this.tx_ingredient_3.visible = false;
         this.unfillSlot(this.slot_ingredient_1);
         this.unfillSlot(this.slot_ingredient_2);
         this.unfillSlot(this.slot_ingredient_3);
         this.clearObjectPreviewSlot();
         this.resizeWindow(3);
      }
      
      private function registerSlot(slot:Slot) : void
      {
         slot.dropValidator = this.dropValidatorFunction as Function;
         slot.processDrop = this.processDropFunction as Function;
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
      }
      
      private function resizeWindow(nbSlot:uint) : void
      {
         for(var i:uint = 1; i < 4; i++)
         {
            this["ctr_slotIngredient" + i].visible = i <= nbSlot;
            this["slot_ingredient_" + i].disabled = i > nbSlot;
         }
         var diff:int = (3 - nbSlot) * this.ctr_slotIngredient1.width;
         this.mainCtr.width = 565 - diff;
         this.ctr_ingredient.width = 525 - diff;
         this.blk_ingredient.width = 521 - diff;
         this.ctr_item_preview.x = 394 - diff;
         this.ctr_equal.x = 376 - diff;
         this.lbl_info.width = 480 - diff;
         this.btn_merge.x = 152 - diff / 2;
         this.uiApi.me().render();
      }
      
      private function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         this._errorText = "";
         this._errorTarget = null;
         this.lbl_info.visible = false;
         if(!data || source.id.indexOf("storage") == -1 && source.id.indexOf("slot_ingredient") == -1)
         {
            return false;
         }
         switch(target)
         {
            case this.slot_modifiedObject:
               if(this.checkAllowedType(target as Slot,data.typeId))
               {
                  if(this.hasCustomEffect(data as ItemWrapper))
                  {
                     return true;
                  }
                  this._errorTarget = target as Slot;
                  this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningResetMinouki.minouki");
               }
               else
               {
                  this._errorTarget = target as Slot;
                  this._errorText = this.uiApi.getText("ui.itemEffectsModifier.mustPlaceMinouki.minouki");
               }
               break;
            case this.slot_ingredient_1:
            case this.slot_ingredient_2:
            case this.slot_ingredient_3:
               if(this.slot_modifiedObject.data == null)
               {
                  this._errorTarget = target as Slot;
                  this._errorText = this.uiApi.getText("ui.itemEffectsModifier.minoukiBeforeCard.minouki");
                  return false;
               }
               if(this.checkAllowedType(target as Slot,data.typeId))
               {
                  if(this._canUseSuperCard || !this.hasCustomEffect(data as ItemWrapper,DataEnum.CARD_SUPER_EFFECT_ID))
                  {
                     if(this.checkAllowedEffectId(target as Slot,data as ItemWrapper))
                     {
                        if(!this.hasSameEffect(target as Slot,data as ItemWrapper))
                        {
                           return true;
                        }
                        this._errorTarget = target as Slot;
                        this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSameEffect.minouki");
                     }
                     else
                     {
                        this._errorTarget = target as Slot;
                        this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningCardType.minouki");
                     }
                  }
                  else
                  {
                     this._errorTarget = target as Slot;
                     this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSuperEffect.minouki");
                  }
               }
               else
               {
                  this._errorTarget = target as Slot;
                  this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningItemType.minouki");
               }
               break;
         }
         return false;
      }
      
      private function processDropFunction(target:Object, d:Object, source:Object) : void
      {
         var myItem:ItemWrapper = null;
         var targetItem:ItemWrapper = null;
         this.lbl_info.visible = false;
         if(this.dropValidatorFunction(target,d,source))
         {
            myItem = this.dataApi.getItemWrapper(d.objectGID,d.position,d.objectUID,1,d.effectsList);
            targetItem = target.data;
            this.fillSlot(target,myItem);
         }
      }
      
      public function processDropToInventory(target:Object, d:Object, source:Object) : void
      {
         if(this._slots.indexOf(source as Slot) != -1)
         {
            this.unfillSlot(source as Slot);
         }
      }
      
      private function fillSlot(slot:Object, item:ItemWrapper) : void
      {
         var currentSlot:Slot = null;
         if(this._currentSlotWithSuperEffect && (this.hasCustomEffect(item,DataEnum.CARD_SUPER_EFFECT_ID) || slot && slot.id == this._currentSlotWithSuperEffect.id))
         {
            this.unfillSlot(this._currentSlotWithSuperEffect);
         }
         for each(currentSlot in this._slots)
         {
            if(currentSlot != null && currentSlot.data != null && item && currentSlot.data.objectUID == item.objectUID)
            {
               this.unfillSlot(currentSlot);
            }
         }
         if(slot != null && slot.data != null && item && slot.data.objectUID == item.objectUID)
         {
            this.unfillSlot(slot);
         }
         else
         {
            if(slot.data != null)
            {
               this.sysApi.sendAction(new ExchangeObjectMoveAction([slot.data.objectUID,-1]));
            }
            slot.data = item;
            this.sysApi.sendAction(new ExchangeObjectMoveAction([item.objectUID,1]));
            switch(slot)
            {
               case this.slot_modifiedObject:
                  this.setIngredientSlots(item);
                  break;
               case this.slot_ingredient_1:
               case this.slot_ingredient_2:
               case this.slot_ingredient_3:
                  if(this.hasCustomEffect(item,DataEnum.CARD_SUPER_EFFECT_ID))
                  {
                     this._currentSlotWithSuperEffect = slot as Slot;
                  }
                  this.createItemPreview();
            }
         }
         this.btn_merge.disabled = !(this.slot_ingredient_1.data || this.slot_ingredient_2.data || this.slot_ingredient_3.data);
      }
      
      private function unfillSlot(slot:Object) : void
      {
         if(slot == null || slot.data == null)
         {
            return;
         }
         var tempItemData:ItemWrapper = slot.data;
         this.sysApi.sendAction(new ExchangeObjectMoveAction([tempItemData.objectUID,-1]));
         slot.data = null;
         switch(slot)
         {
            case this.slot_modifiedObject:
               this.resetIngredientSlots();
               break;
            case this.slot_ingredient_1:
            case this.slot_ingredient_2:
            case this.slot_ingredient_3:
               if(this.hasCustomEffect(tempItemData,DataEnum.CARD_SUPER_EFFECT_ID))
               {
                  this._currentSlotWithSuperEffect = null;
               }
               if(this.slot_ingredient_1.data != null || this.slot_ingredient_2.data != null || this.slot_ingredient_3.data != null)
               {
                  this.createItemPreview();
               }
               else
               {
                  this.clearObjectPreviewSlot();
               }
         }
         this.btn_merge.disabled = !(this.slot_ingredient_1.data || this.slot_ingredient_2.data || this.slot_ingredient_3.data);
      }
      
      public function fillAutoSlot(item:ItemWrapper, force:Boolean = false) : void
      {
         var foundAnEmptySlot:Boolean = false;
         var slot:Slot = null;
         this._errorText = "";
         this._errorTarget = null;
         this.lbl_info.visible = false;
         if(item.typeId == DataEnum.ITEM_TYPE_MINOUKI)
         {
            if(this.checkAllowedType(this.slot_modifiedObject,item.typeId))
            {
               if(this.hasCustomEffect(item))
               {
                  this.fillSlot(this.slot_modifiedObject,item);
               }
               else
               {
                  this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningResetMinouki.minouki");
               }
            }
            else
            {
               this._errorText = this.uiApi.getText("ui.itemEffectsModifier.mustPlaceMinouki.minouki");
            }
         }
         else if(item.typeId == DataEnum.ITEM_TYPE_ECAFLIP_CARD)
         {
            if(this.slot_modifiedObject.data == null)
            {
               this._errorText = this.uiApi.getText("ui.itemEffectsModifier.minoukiBeforeCard.minouki");
            }
            else
            {
               for each(slot in this._slots)
               {
                  if(!(slot == this.slot_modifiedObject || slot.disabled))
                  {
                     if(!slot.data)
                     {
                        if(this.checkAllowedType(slot,item.typeId))
                        {
                           if(this._canUseSuperCard || !this.hasCustomEffect(item,DataEnum.CARD_SUPER_EFFECT_ID))
                           {
                              if(this.checkAllowedEffectId(slot,item))
                              {
                                 if(!this.hasSameEffect(slot,item))
                                 {
                                    this.fillSlot(slot,item);
                                    foundAnEmptySlot = true;
                                    this._errorText = "";
                                    break;
                                 }
                                 this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSameEffect.minouki");
                              }
                              else
                              {
                                 this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningCardType.minouki");
                              }
                           }
                           else
                           {
                              this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSuperEffect.minouki");
                           }
                        }
                        else
                        {
                           this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningItemType.minouki");
                        }
                     }
                  }
               }
               if(!foundAnEmptySlot)
               {
                  for each(slot in this._slots)
                  {
                     if(!(slot == this.slot_modifiedObject || slot.disabled))
                     {
                        if(this.checkAllowedType(slot,item.typeId))
                        {
                           if(this._canUseSuperCard || !this.hasCustomEffect(item,DataEnum.CARD_SUPER_EFFECT_ID))
                           {
                              if(this.checkAllowedEffectId(slot,item))
                              {
                                 if(!this.hasSameEffect(slot,item))
                                 {
                                    this.fillSlot(slot,item);
                                    this._errorText = "";
                                    break;
                                 }
                                 this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSameEffect.minouki");
                              }
                              else
                              {
                                 this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningCardType.minouki");
                              }
                           }
                           else
                           {
                              this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningHasSuperEffect.minouki");
                           }
                        }
                        else
                        {
                           this._errorText = this.uiApi.getText("ui.itemEffectsModifier.warningItemType.minouki");
                        }
                     }
                  }
               }
            }
         }
         if(this._errorText != "")
         {
            this.lbl_info.text = this._errorText;
            this.lbl_info.visible = true;
            this._errorText = "";
         }
      }
      
      private function createItemPreview() : void
      {
         var objectEffect:ObjectEffect = null;
         var slotData:ItemWrapper = null;
         var addCustomEffect:Boolean = false;
         var superEffect:ObjectEffectDice = null;
         var i:uint = 0;
         var slot:Slot = null;
         if(!this.slot_modifiedObject.data)
         {
            return;
         }
         var modifiedObject:ItemWrapper = this.slot_modifiedObject.data as ItemWrapper;
         var slots:Vector.<Slot> = new Vector.<Slot>();
         slots.push(this.slot_ingredient_1,this.slot_ingredient_2,this.slot_ingredient_3);
         var objectEffects:Vector.<ObjectEffect> = new Vector.<ObjectEffect>();
         var objectCustomEffects:Vector.<ObjectEffect> = new Vector.<ObjectEffect>();
         for each(objectEffect in modifiedObject.effectsList)
         {
            if(objectEffect.actionId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               objectCustomEffects.push(objectEffect);
            }
            else
            {
               objectEffects.push(objectEffect);
            }
         }
         superEffect = null;
         for(i = 0; i < objectCustomEffects.length; i++)
         {
            addCustomEffect = true;
            for each(slot in slots)
            {
               slotData = slot.data;
               if(slotData != null)
               {
                  if(this.hasRightCardEffect(objectCustomEffects[i] as ObjectEffectDice,slotData))
                  {
                     for each(objectEffect in slotData.effectsList)
                     {
                        if(objectEffect.actionId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT && (objectEffect as ObjectEffectDice).diceConst == DataEnum.CARD_SUPER_EFFECT_ID)
                        {
                           superEffect = new ObjectEffectDice();
                           superEffect.actionId = ActionIds.ACTION_ITEM_CUSTOM_EFFECT;
                           superEffect.diceConst = DataEnum.MINOUKI_SUPER_EFFECT_ID;
                           superEffect.diceSide = (objectEffect as ObjectEffectDice).diceSide;
                           superEffect.diceNum = (objectEffect as ObjectEffectDice).diceNum;
                        }
                        else if(objectEffect.actionId != ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
                        {
                           objectEffects.push(objectEffect);
                           addCustomEffect = false;
                        }
                     }
                     slots.splice(slots.indexOf(slot),1);
                  }
               }
            }
            if(addCustomEffect)
            {
               objectEffects.push(objectCustomEffects[i]);
            }
         }
         if(superEffect)
         {
            objectEffects.push(superEffect);
         }
         var itemPreview:ItemWrapper = ItemWrapper.create(modifiedObject.position,0,modifiedObject.objectGID,1,objectEffects,false);
         this.slot_item_preview.data = itemPreview;
      }
      
      private function hasRightCardEffect(objectEffect:ObjectEffectDice, itemWrapper:ItemWrapper) : Boolean
      {
         var effect:ObjectEffect = null;
         for each(effect in itemWrapper.effectsList)
         {
            if(effect.actionId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT && int((effect as ObjectEffectDice).diceConst) == this._effectParamRestrictions[objectEffect.diceConst])
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkAllowedType(slot:Slot, typeId:uint) : Boolean
      {
         var id:uint = 0;
         if(this._slotTypeRestrictions[slot].types == null || this._slotTypeRestrictions[slot].types.length == 0)
         {
            return true;
         }
         for each(id in this._slotTypeRestrictions[slot].types)
         {
            if(id == typeId)
            {
               return true;
            }
         }
         return false;
      }
      
      private function checkAllowedEffectId(slot:Slot, item:ItemWrapper) : Boolean
      {
         var id:uint = 0;
         var effectInstance:EffectInstance = null;
         if(this._slotTypeRestrictions[slot].effectIds == null || this._slotTypeRestrictions[slot].effectIds.length == 0)
         {
            return true;
         }
         for each(id in this._slotTypeRestrictions[slot].effectIds)
         {
            for each(effectInstance in item.effects)
            {
               if(effectInstance.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT && int(effectInstance.parameter2) == id)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function hasSameEffect(sourceSlot:Slot, itemWrapper:ItemWrapper) : Boolean
      {
         var targetItem:ItemWrapper = null;
         var slot:Slot = null;
         var targetEffectInstance:EffectInstance = null;
         var sourceEffectInstance:EffectInstance = null;
         if(!this.hasCustomEffect(itemWrapper,DataEnum.CARD_BONUS_CUSTOM_EFFECT_ID))
         {
            return false;
         }
         for each(slot in this._slots)
         {
            if(slot != sourceSlot)
            {
               targetItem = slot.data as ItemWrapper;
               if(targetItem != null)
               {
                  if(targetItem.objectUID == itemWrapper.objectUID)
                  {
                     return false;
                  }
                  for each(targetEffectInstance in targetItem.effects)
                  {
                     for each(sourceEffectInstance in itemWrapper.effects)
                     {
                        if(targetEffectInstance.effectId == sourceEffectInstance.effectId && targetEffectInstance.effectId != ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
                        {
                           return true;
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      private function hasCustomEffect(item:ItemWrapper, effectId:int = -1) : Boolean
      {
         var effectInstance:EffectInstance = null;
         for each(effectInstance in item.effects)
         {
            if(effectId != -1)
            {
               if(effectInstance.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT && int(effectInstance.parameter2) == effectId)
               {
                  return true;
               }
            }
            else if(effectInstance.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT && int(effectInstance.parameter2) != DataEnum.MINOUKI_SUPER_EFFECT_ID)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onOpenInventory(behaviorName:String, realUiName:String) : void
      {
         if(behaviorName != StorageState.ITEM_EFFECTS_MODIFIER_UI_MOD)
         {
            return;
         }
         var storageUi:UiRootContainer = this.uiApi.getUi(realUiName);
         if(storageUi)
         {
            this._storageUi = storageUi.uiClass;
         }
      }
      
      protected function onExchangeCraftResult(result:uint, item:ItemWrapper) : void
      {
         switch(result)
         {
            case CraftResultEnum.CRAFT_SUCCESS:
               this.clearAllSlots();
               this.btn_merge.disabled = true;
               if(this._storageUi)
               {
                  this._storageUi.categoryFilter = ItemCategoryEnum.EQUIPMENT_CATEGORY;
                  this._storageUi.subFilter = DataEnum.ITEM_TYPE_MINOUKI;
               }
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_merge:
               this.sysApi.sendAction(new ExchangeReadyAction([true]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var settings:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var setting:String = null;
         var objVariables:* = undefined;
         var text:String = null;
         var slotId:int = 0;
         if(target is Slot && (target as Slot).data)
         {
            settings = {};
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(itemTooltipSettings == null)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each(setting in objVariables)
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            settings.noFooter = true;
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,settings);
         }
         else
         {
            switch(target)
            {
               case this.slot_modifiedObject:
                  text = this.uiApi.getText("ui.itemEffectsModifier.emptySlotModifiedItem.minouki");
                  break;
               case this.slot_item_preview:
                  text = this.uiApi.getText("ui.itemEffectsModifier.emptySlotPreviewItem.minouki");
                  break;
               case this.slot_ingredient_1:
               case this.slot_ingredient_2:
               case this.slot_ingredient_3:
                  text = this._slotTypeRestrictions[target].slotText;
                  break;
               case this.tx_modifiedObject:
                  text = this.uiApi.getText("ui.itemEffectsModifier.iconModifiedItem.minouki");
                  break;
               case this.tx_item_preview:
                  text = this.uiApi.getText("ui.itemEffectsModifier.iconPreviewItem.minouki");
                  break;
               case this.tx_ingredient_1:
               case this.tx_ingredient_2:
               case this.tx_ingredient_3:
                  slotId = target.name.split("_")[2];
                  text = this._slotTypeRestrictions[this["slot_ingredient_" + slotId]].iconText;
                  break;
               case this.btn_merge:
                  text = this.uiApi.getText("ui.itemEffectsModifier.merge.minouki");
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if((target as Slot).data)
         {
            this.unfillSlot(target);
         }
      }
      
      private function onDropEnd(src:Object, target:Object) : void
      {
         if(target == this._errorTarget)
         {
            if(this._errorText)
            {
               this.lbl_info.visible = true;
               this.lbl_info.text = this._errorText;
               this._errorText = "";
               this._errorTarget = null;
            }
         }
      }
   }
}

import com.ankamagames.jerakine.data.I18n;

class SlotRestrictions
{
    
   
   public var types:Array;
   
   public var effectIds:Array;
   
   public var iconText:String;
   
   public var slotText:String;
   
   function SlotRestrictions(pTypes:Array, pEffectIds:Array)
   {
      super();
      this.types = pTypes;
      this.effectIds = pEffectIds;
   }
   
   public function reset() : void
   {
      this.types = [];
      this.effectIds = [];
      this.iconText = "";
      this.slotText = "";
   }
   
   public function pushType(typeId:uint) : void
   {
      if(this.types.indexOf(typeId) == -1)
      {
         this.types.push(typeId);
      }
   }
   
   public function pushEffect(effectId:uint) : void
   {
      if(this.effectIds.indexOf(effectId) == -1)
      {
         this.effectIds.push(effectId);
         this.setText(effectId);
      }
   }
   
   private function setText(effectId:uint) : void
   {
      this.iconText = I18n.getUiText("ui.customEffect." + effectId);
      this.slotText = I18n.getUiText("ui.itemEffectsModifier.cardToPlace.minouki",[I18n.getUiText("ui.customEffect." + effectId)]);
   }
}

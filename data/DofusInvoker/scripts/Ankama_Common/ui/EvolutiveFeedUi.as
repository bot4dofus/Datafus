package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class EvolutiveFeedUi
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private const MAX_FOOD_ITEMS:int = 50;
      
      private const MAX_FOOD_ITEMS_VISIBLE:int = 4;
      
      private const LOCK_MAX_FOOD_ITEMS_REACHED:int = 0;
      
      private const LOCK_MAX_EXPERIENCE_REACHED:int = 1;
      
      private const LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY:int = 2;
      
      private const LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY:int = 3;
      
      private const LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY:int = 4;
      
      private const LOCK_WRONG_FOOD_CATEGORY:int = 5;
      
      private const LOCK_ITEM_IS_NOT_FOOD:int = 6;
      
      private var _itemToFeed:ItemWrapper;
      
      private var _evolutiveTypeToFeed:EvolutiveItemType;
      
      private var _foodItemsList:Array;
      
      private var _experienceToReachMaxLevel:int = 0;
      
      private var _experienceToDisplay:int;
      
      private var _dropLocks:Array;
      
      private var _compInteractiveList:Dictionary;
      
      private var _visibleFoodItemsCount:int = 0;
      
      private var _quantityTimer:BenchmarkTimer;
      
      private var _quantityModifiedTarget:Input;
      
      private var _yBottomCtrWithoutFood:int;
      
      private var _heightWindowWithoutFood:int;
      
      private var _heightFoodBlockWithoutFood:int;
      
      public var lbl_choseQuantity:Label;
      
      public var ctr_feed:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_feedOk:ButtonContainer;
      
      public var ctr_food:GraphicContainer;
      
      public var gd_food:Grid;
      
      public var ctr_bottom:GraphicContainer;
      
      public var btn_ctrDrop:ButtonContainer;
      
      public var ctr_invisibleDropLock:GraphicContainer;
      
      public var ctr_drop:GraphicContainer;
      
      public var ctr_dropError:GraphicContainer;
      
      public var lbl_dropError:Label;
      
      public var tx_dropBorderOver:TextureBitmap;
      
      public var tx_dropBorderSelected:TextureBitmap;
      
      public var tx_dropBorderError:TextureBitmap;
      
      public var slot_itemToFeed:Slot;
      
      public var lbl_petLevel:Label;
      
      public var lbl_xpResult:Label;
      
      public var lbl_levelResult:Label;
      
      public var gd_statResult:Grid;
      
      public function EvolutiveFeedUi()
      {
         this._compInteractiveList = new Dictionary(true);
         this._quantityTimer = new BenchmarkTimer(200,1,"EvolutiveFeedUi._quantityTimer");
         super();
      }
      
      public function main(param:Object) : void
      {
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.sysApi.addHook(InventoryHookList.ObjectQuantity,this.onObjectQuantity);
         this.sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         this.sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         this.sysApi.addHook(BeriliaHookList.DropStart,this.onEquipementDropStart);
         this.sysApi.addHook(BeriliaHookList.DropEnd,this.onEquipementDropEnd);
         this.uiApi.addComponentHook(this.btn_feedOk,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.slot_itemToFeed,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_itemToFeed,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_ctrDrop,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_ctrDrop,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_dropError,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_dropError,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.btn_ctrDrop.dropValidator = this.dropValidatorFunction as Function;
         this.btn_ctrDrop.processDrop = this.processDropFunction as Function;
         this.btn_ctrDrop.removeDropSource = this.removeDropSourceFunction as Function;
         this._dropLocks = [];
         this._itemToFeed = param.itemToFeed;
         this._evolutiveTypeToFeed = this._itemToFeed.type.evolutiveType;
         if(this._itemToFeed.evolutiveEffectIds && this._itemToFeed.evolutiveEffectIds.length > 0)
         {
            this._experienceToReachMaxLevel = this._evolutiveTypeToFeed.experienceByLevel[this._evolutiveTypeToFeed.maxLevel] - this._itemToFeed.experiencePoints;
         }
         this.slot_itemToFeed.data = this._itemToFeed;
         this.lbl_petLevel.text = this.uiApi.getText("ui.common.short.level") + this._itemToFeed.displayedLevel;
         this._yBottomCtrWithoutFood = int(this.uiApi.me().getConstant("y_bottom_no_food"));
         this._heightWindowWithoutFood = int(this.uiApi.me().getConstant("height_window_no_food"));
         this._heightFoodBlockWithoutFood = int(this.uiApi.me().getConstant("height_block_no_food"));
         if(this._foodItemsList && this._foodItemsList.length)
         {
            this.gd_food.dataProvider = this._foodItemsList;
         }
         else
         {
            this._foodItemsList = new Array();
            this.btn_feedOk.softDisabled = true;
         }
         this.updateExperienceFromFood();
         this.updateWindowHeight();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function updateFoodItemLine(data:*, components:*, selected:Boolean) : void
      {
         if(!this._compInteractiveList[components.ctr_foodLine.name])
         {
            this.uiApi.addComponentHook(components.ctr_foodLine,ComponentHookList.ON_DOUBLE_CLICK);
         }
         this._compInteractiveList[components.ctr_foodLine.name] = data;
         if(!this._compInteractiveList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.slot_item.name] = data;
         if(!this._compInteractiveList[components.inp_itemQuantity.name])
         {
            this.uiApi.addComponentHook(components.inp_itemQuantity,ComponentHookList.ON_CHANGE);
         }
         this._compInteractiveList[components.inp_itemQuantity.name] = data;
         if(!this._compInteractiveList[components.btn_itemRemove.name])
         {
            this.uiApi.addComponentHook(components.btn_itemRemove,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_itemRemove,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_itemRemove,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.btn_itemRemove.name] = data;
         if(data)
         {
            components.slot_item.data = data.item;
            components.lbl_itemName.text = data.item.shortName;
            components.inp_itemQuantity.text = data.quantity;
            if(data.item.shortName == this._compInteractiveList[components.btn_itemRemove.name].item.shortName && !this._compInteractiveList[components.btn_itemRemove.name].quantityInBags || data.item.shortName == this._compInteractiveList[components.btn_itemRemove.name].item.shortName && this._compInteractiveList[components.btn_itemRemove.name].quantityInBags && this._compInteractiveList[components.btn_itemRemove.name].quantityInBags < data.quantity || data.item.shortName != this._compInteractiveList[components.btn_itemRemove.name].item.shortName)
            {
               this._compInteractiveList[components.btn_itemRemove.name].quantityInBags = data.quantity;
            }
            components.inp_itemQuantity.restrictChars = "0-9  ";
         }
         else
         {
            components.lbl_itemName.text = "";
            components.slot_item.data = null;
            components.inp_itemQuantity.text = "";
         }
      }
      
      private function updateFoodList() : void
      {
         var visibleItemsCount:int = this._foodItemsList.length;
         if(visibleItemsCount > 0)
         {
            this.lbl_choseQuantity.text = this.uiApi.getText("ui.evolutive.pet.choseResourcesQuantity");
         }
         else
         {
            this.lbl_choseQuantity.text = "";
         }
         if(visibleItemsCount > this.MAX_FOOD_ITEMS_VISIBLE)
         {
            visibleItemsCount = this.MAX_FOOD_ITEMS_VISIBLE;
         }
         if(this._visibleFoodItemsCount != visibleItemsCount)
         {
            this._visibleFoodItemsCount = visibleItemsCount;
            this.updateWindowHeight();
            if(this._visibleFoodItemsCount == 0)
            {
               this.btn_feedOk.softDisabled = true;
            }
            else
            {
               this.btn_feedOk.softDisabled = false;
            }
         }
         if(this._foodItemsList.length >= this.MAX_FOOD_ITEMS)
         {
            this.lockDrop(this.LOCK_MAX_FOOD_ITEMS_REACHED);
         }
         else
         {
            this.unlockDrop(this.LOCK_MAX_FOOD_ITEMS_REACHED);
         }
         this.gd_food.dataProvider = this._foodItemsList;
      }
      
      private function updateWindowHeight() : void
      {
         var foodBlockHeight:int = 0;
         if(this._visibleFoodItemsCount > 0)
         {
            this.gd_food.height = this._visibleFoodItemsCount * this.gd_food.slotHeight;
            this.ctr_food.height = this.gd_food.height + this._heightFoodBlockWithoutFood;
            this.ctr_food.visible = true;
            foodBlockHeight = this.gd_food.height + this._heightFoodBlockWithoutFood + this.lbl_choseQuantity.height;
         }
         else
         {
            this.ctr_food.visible = false;
         }
         this.ctr_bottom.y = this._yBottomCtrWithoutFood + foodBlockHeight;
         this.ctr_feed.height = this._heightWindowWithoutFood + foodBlockHeight;
         this.uiApi.me().render();
      }
      
      private function getExperienceFromItem(foodItem:ItemWrapper, quantity:int) : Number
      {
         if(foodItem.itemHasLegendaryEffect)
         {
            return 0;
         }
         var experience:Number = 0;
         if(foodItem.givenExperienceAsSuperFood > 0)
         {
            experience = quantity * foodItem.givenExperienceAsSuperFood;
         }
         else if(foodItem.basicExperienceAsFood > 0)
         {
            experience = quantity * foodItem.basicExperienceAsFood * this._evolutiveTypeToFeed.experienceBoost;
         }
         return experience;
      }
      
      private function updateExperienceFromFood() : void
      {
         var itemWrapper:ItemWrapper = null;
         var levelsCount:int = 0;
         var totalExperience:Number = 0;
         var foodItemsCount:int = this._foodItemsList.length;
         for(var i:int = 0; i < foodItemsCount; )
         {
            itemWrapper = this._foodItemsList[i].item;
            totalExperience += this.getExperienceFromItem(itemWrapper,this._foodItemsList[i].quantity);
            i++;
         }
         this._experienceToDisplay = Math.floor(totalExperience);
         if(this._experienceToDisplay >= this._experienceToReachMaxLevel)
         {
            this.lockDrop(this.LOCK_MAX_EXPERIENCE_REACHED);
            this._experienceToDisplay = this._experienceToReachMaxLevel;
         }
         else
         {
            this.unlockDrop(this.LOCK_MAX_EXPERIENCE_REACHED);
         }
         if(foodItemsCount > 0)
         {
            this.lbl_xpResult.text = this.uiApi.getText("ui.tooltip.monsterXpAlone","+ " + this.utilApi.kamasToString(this._experienceToDisplay,""));
         }
         else
         {
            this.lbl_xpResult.text = "";
         }
         var futurItemExperience:int = this._experienceToDisplay + this._itemToFeed.experiencePoints;
         var futurLevel:int = this.dataApi.getEvolutiveItemLevelByExperiencePoints(this._itemToFeed,futurItemExperience);
         if(futurLevel <= this._itemToFeed.evolutiveLevel)
         {
            this.lbl_levelResult.text = "";
         }
         else
         {
            levelsCount = futurLevel - this._itemToFeed.evolutiveLevel;
            this.lbl_levelResult.text = "+ " + this.uiApi.processText(this.uiApi.getText("ui.evolutive.levelsCount",levelsCount),"m",levelsCount == 1,levelsCount == 0);
         }
         this.updateUnlockedEffects();
      }
      
      private function updateUnlockedEffects() : void
      {
         var ei:EffectInstance = null;
         var effects:Array = this.dataApi.getEvolutiveEffectInstancesByExperienceBoost(this._itemToFeed,this._experienceToDisplay);
         var effectsDescriptions:Array = [];
         for each(ei in effects)
         {
            if(ei)
            {
               effectsDescriptions.push("+ " + ei.description);
            }
         }
         this.gd_statResult.dataProvider = effectsDescriptions;
      }
      
      private function getMaximumQuantityBeforeMaxLevel(foodItem:ItemWrapper, requestedQuantity:int) : int
      {
         if(foodItem.itemHasLegendaryEffect)
         {
            return 1;
         }
         var maxQuantity:int = requestedQuantity;
         var experienceLeftToReachMaxLevel:int = this._experienceToReachMaxLevel - this._experienceToDisplay;
         var experienceWithRequestedQuantity:Number = this.getExperienceFromItem(foodItem,requestedQuantity);
         if(experienceWithRequestedQuantity <= experienceLeftToReachMaxLevel)
         {
            return maxQuantity;
         }
         var experienceByItem:Number = this.getExperienceFromItem(foodItem,1);
         maxQuantity = Math.ceil(experienceLeftToReachMaxLevel / experienceByItem);
         if(maxQuantity < 0)
         {
            maxQuantity = 0;
         }
         return maxQuantity;
      }
      
      private function lockDrop(lockReason:int) : void
      {
         this._dropLocks[lockReason] = true;
         if(lockReason == this.LOCK_MAX_EXPERIENCE_REACHED)
         {
            if(this._foodItemsList.length > 0 && !this._foodItemsList[0].item.itemHasLegendaryEffect)
            {
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorMaximumExperienceReached");
               this.tx_dropBorderError.visible = true;
               this.btn_ctrDrop.softDisabled = true;
               this.btn_ctrDrop.handCursor = false;
            }
            else if(!this._itemToFeed.itemHoldsLegendaryStatus)
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = true;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.evolveToLegendary");
            }
            else if(this._itemToFeed.itemHasLockedLegendarySpell)
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = true;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorCantEatAnythingAnymore");
            }
            else
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = true;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.giveLegendarySpell");
            }
            this.ctr_drop.visible = false;
            this.ctr_dropError.visible = true;
         }
         else
         {
            if(lockReason == this.LOCK_MAX_FOOD_ITEMS_REACHED)
            {
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorMaximumResourcesCountReached",this.MAX_FOOD_ITEMS);
            }
            else if(lockReason == this.LOCK_WRONG_FOOD_CATEGORY)
            {
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorOnlyResources");
            }
            else if(lockReason == this.LOCK_ITEM_IS_NOT_FOOD)
            {
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorResourceIsNotFood");
            }
            this.tx_dropBorderError.visible = true;
            this.btn_ctrDrop.softDisabled = true;
            this.btn_ctrDrop.handCursor = false;
            this.ctr_drop.visible = false;
            this.ctr_dropError.visible = true;
         }
      }
      
      private function unlockDrop(lockReason:int) : void
      {
         this._dropLocks[lockReason] = false;
         if(lockReason == this.LOCK_MAX_EXPERIENCE_REACHED)
         {
            this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
            this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
            this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
         }
         if(this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED])
         {
            if(this._foodItemsList.length > 0 && !this._foodItemsList[0].item.itemHasLegendaryEffect)
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorMaximumExperienceReached");
            }
            else if(!this._itemToFeed.itemHoldsLegendaryStatus)
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = true;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.evolveToLegendary");
            }
            else if(this._itemToFeed.itemHasLockedLegendarySpell)
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = true;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorCantEatAnythingAnymore");
            }
            else
            {
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] = false;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] = true;
               this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] = false;
               this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.giveLegendarySpell");
            }
            return;
         }
         if(this._dropLocks[this.LOCK_MAX_FOOD_ITEMS_REACHED])
         {
            this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorMaximumResourcesCountReached",this.MAX_FOOD_ITEMS);
            return;
         }
         if(this._dropLocks[this.LOCK_WRONG_FOOD_CATEGORY])
         {
            this.lbl_dropError.text = this.uiApi.getText("ui.evolutive.pet.errorOnlyResources");
            return;
         }
         this.tx_dropBorderError.visible = false;
         this.btn_ctrDrop.softDisabled = false;
         this.btn_ctrDrop.handCursor = true;
         this.ctr_drop.visible = true;
         this.ctr_dropError.visible = false;
      }
      
      private function onConfirmFeed() : void
      {
         var itemWrapper:ItemWrapper = null;
         var foodItemsCount:int = this._foodItemsList.length;
         var i:int = 0;
         for(var meal:Vector.<Object> = new Vector.<Object>(); i < foodItemsCount; )
         {
            itemWrapper = this._foodItemsList[i].item;
            meal.push({
               "objectUID":itemWrapper.objectUID,
               "quantity":this._foodItemsList[i].quantity
            });
            i++;
         }
         this.sysApi.sendAction(new LivingObjectFeedAction([this._itemToFeed.objectUID,meal]));
         this._foodItemsList = [];
         this.updateFoodList();
         this.updateExperienceFromFood();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var foodItemsCount:int = 0;
         var i:int = 0;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_feedOk:
               this.onConfirmFeed();
         }
         if(target.name.indexOf("btn_itemRemove") != -1)
         {
            data = this._compInteractiveList[target.name];
            foodItemsCount = this._foodItemsList.length;
            for(i = 0; i < foodItemsCount; )
            {
               if(this._foodItemsList[i].item.objectUID == data.item.objectUID)
               {
                  break;
               }
               i++;
            }
            this._foodItemsList.splice(i,1);
            this.updateFoodList();
            this.updateExperienceFromFood();
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var foodItemsCount:int = 0;
         var i:int = 0;
         if(target.name.indexOf("ctr_foodLine") != -1)
         {
            data = this._compInteractiveList[target.name];
            foodItemsCount = this._foodItemsList.length;
            for(i = 0; i < foodItemsCount; )
            {
               if(this._foodItemsList[i].item.objectUID == data.item.objectUID)
               {
                  break;
               }
               i++;
            }
            this._foodItemsList.splice(i,1);
            this.updateFoodList();
            this.updateExperienceFromFood();
         }
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         var data:Object = null;
         var startValue:int = 0;
         var value:Number = NaN;
         if(target.name.indexOf("inp_itemQuantity") != -1)
         {
            this._quantityModifiedTarget = target as Input;
            data = this._compInteractiveList[this._quantityModifiedTarget.name];
            startValue = int(this._quantityModifiedTarget.text);
            if(!data || data.quantity == startValue)
            {
               return;
            }
            if(data.item.itemHasLegendaryEffect)
            {
               this._quantityModifiedTarget.text = "1";
               return;
            }
            value = startValue;
            if(value < 1)
            {
               value = 1;
            }
            if(value > data.quantityInBags)
            {
               value = data.quantityInBags;
            }
            if(value != startValue)
            {
               this._quantityModifiedTarget.text = value.toString();
            }
            this._quantityTimer.reset();
            this._quantityTimer.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
            this._quantityTimer.start();
         }
      }
      
      private function onTimerEnd(e:TimerEvent) : void
      {
         var newQuantity:int = 0;
         this._quantityTimer.removeEventListener(TimerEvent.TIMER,this.onTimerEnd);
         var data:Object = this._compInteractiveList[this._quantityModifiedTarget.name];
         if(!data || data.quantity.toString() == this._quantityModifiedTarget.text)
         {
            return;
         }
         var writtenQuantity:int = int(this._quantityModifiedTarget.text);
         if(!writtenQuantity || writtenQuantity < 1)
         {
            newQuantity = 1;
         }
         else
         {
            if(writtenQuantity > data.item.quantity)
            {
               newQuantity = data.item.quantity;
            }
            else
            {
               newQuantity = writtenQuantity;
            }
            if(newQuantity > data.quantity)
            {
               newQuantity = this.getMaximumQuantityBeforeMaxLevel(data.item,newQuantity - data.quantity) + data.quantity;
            }
         }
         if(writtenQuantity != newQuantity)
         {
            this._quantityModifiedTarget.text = newQuantity + "";
         }
         if(data.quantity != newQuantity)
         {
            data.quantity = newQuantity;
            this.updateExperienceFromFood();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var tooltipData:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var settings:* = undefined;
         var setting:String = null;
         var objVariables:Vector.<String> = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         if(target == this.btn_ctrDrop)
         {
            if(!this.tx_dropBorderSelected.visible && !this.tx_dropBorderError.visible)
            {
               this.tx_dropBorderOver.visible = true;
            }
         }
         if(target.name.indexOf("btn_itemRemove") != -1)
         {
            text = this.uiApi.getText("ui.common.remove");
         }
         else if(target.name.indexOf("slot_item") != -1)
         {
            if(target == this.slot_itemToFeed)
            {
               tooltipData = this._itemToFeed;
            }
            else
            {
               tooltipData = this._compInteractiveList[target.name].item;
            }
            if(!tooltipData)
            {
               return;
            }
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            settings = new Object();
            objVariables = this.sysApi.getObjectVariables(itemTooltipSettings);
            for each(setting in objVariables)
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            settings["description"] = false;
            settings["averagePrice"] = false;
            this.uiApi.showTooltip(tooltipData,target,false,"standard",LocationEnum.POINT_RIGHT,LocationEnum.POINT_LEFT,3,"itemName",null,settings,"ItemInfo");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         if(target == this.btn_ctrDrop)
         {
            if(this.tx_dropBorderOver.visible)
            {
               this.tx_dropBorderOver.visible = false;
            }
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            case "validUi":
               if(this._foodItemsList.length)
               {
                  this.onRelease(this.btn_feedOk);
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         return !this.btn_ctrDrop.softDisabled && this.rpApi.canPetEatThisFood(this._itemToFeed,data as ItemWrapper);
      }
      
      public function removeDropSourceFunction(target:Object) : void
      {
      }
      
      public function processDropFunction(target:Object, data:Object, source:Object) : void
      {
         var itemFound:Boolean = false;
         var foodItemsCount:int = 0;
         var i:int = 0;
         var newQuantity:int = 0;
         var quantity:int = 0;
         if(this.dropValidatorFunction(target,data,source))
         {
            itemFound = false;
            foodItemsCount = this._foodItemsList.length;
            for(i = 0; i < foodItemsCount; )
            {
               if(this._foodItemsList[i].item.objectUID == data.objectUID)
               {
                  itemFound = true;
                  newQuantity = this._foodItemsList[i].quantity + this.getMaximumQuantityBeforeMaxLevel(data as ItemWrapper,data.quantity);
                  if(newQuantity > data.quantity)
                  {
                     newQuantity = data.quantity;
                  }
                  this._foodItemsList[i].quantity = newQuantity;
                  this.gd_food.updateItem(i);
                  break;
               }
               i++;
            }
            if(!itemFound)
            {
               quantity = this.getMaximumQuantityBeforeMaxLevel(data as ItemWrapper,data.quantity);
               this._foodItemsList.unshift({
                  "item":data,
                  "quantity":quantity
               });
               this.updateFoodList();
            }
            this.updateExperienceFromFood();
         }
      }
      
      private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int) : void
      {
         if(!item || !this._foodItemsList)
         {
            return;
         }
         var foodItemsCount:int = this._foodItemsList.length;
         for(var i:int = 0; i < foodItemsCount; )
         {
            if(this._foodItemsList[i].item.objectUID == item.objectUID)
            {
               if(this._foodItemsList[i].quantity > quantity)
               {
                  this._foodItemsList[i].quantity = quantity;
                  this.gd_food.updateItem(i);
                  this.updateExperienceFromFood();
                  break;
               }
            }
            i++;
         }
      }
      
      private function onObjectDeleted(item:Object) : void
      {
         if(!item || !this._foodItemsList)
         {
            return;
         }
         var foodItemsCount:int = this._foodItemsList.length;
         for(var i:int = 0; i < foodItemsCount; )
         {
            if(this._foodItemsList[i].item.objectUID == item.objectUID)
            {
               this._foodItemsList.splice(i,1);
               this.updateFoodList();
               this.updateExperienceFromFood();
               break;
            }
            i++;
         }
      }
      
      public function onObjectModified(item:Object) : void
      {
         if(!item || item.objectUID != this._itemToFeed.objectUID)
         {
            return;
         }
         this._itemToFeed = item as ItemWrapper;
         this._evolutiveTypeToFeed = this._itemToFeed.type.evolutiveType;
         if(this._itemToFeed.evolutiveEffectIds && this._itemToFeed.evolutiveEffectIds.length > 0)
         {
            this._experienceToReachMaxLevel = this._evolutiveTypeToFeed.experienceByLevel[this._evolutiveTypeToFeed.maxLevel] - this._itemToFeed.experiencePoints;
         }
         this.slot_itemToFeed.data = this._itemToFeed;
         this.lbl_petLevel.text = this.uiApi.getText("ui.common.short.level") + this._itemToFeed.displayedLevel;
         this.updateExperienceFromFood();
      }
      
      private function onEquipementDropStart(src:Object) : void
      {
         if(this._dropLocks[this.LOCK_MAX_FOOD_ITEMS_REACHED] || this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_SPECIAL_LEGENDARY] || !src.data || !(src.data is ItemWrapper))
         {
            return;
         }
         var draggedItem:ItemWrapper = src.data as ItemWrapper;
         if(this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_ISNT_LEGENDARY] && !draggedItem.itemHoldsLegendaryStatus)
         {
            return;
         }
         if(this._dropLocks[this.LOCK_MAX_EXPERIENCE_REACHED_IS_LEGENDARY] && !draggedItem.itemHoldsLegendaryPower)
         {
            return;
         }
         this.ctr_invisibleDropLock.visible = false;
         if(this.rpApi.resourceIsFood(draggedItem))
         {
            this.tx_dropBorderSelected.visible = true;
         }
         else if(draggedItem.category == ItemCategoryEnum.RESOURCES_CATEGORY && draggedItem.basicExperienceAsFood <= 0 && draggedItem.givenExperienceAsSuperFood <= 0 && !draggedItem.itemHasLegendaryEffect)
         {
            this.lockDrop(this.LOCK_ITEM_IS_NOT_FOOD);
         }
         else
         {
            this.lockDrop(this.LOCK_WRONG_FOOD_CATEGORY);
         }
      }
      
      private function onEquipementDropEnd(src:Object, target:Object) : void
      {
         this.tx_dropBorderSelected.visible = false;
         this.unlockDrop(this.LOCK_WRONG_FOOD_CATEGORY);
         this.ctr_invisibleDropLock.visible = true;
      }
   }
}

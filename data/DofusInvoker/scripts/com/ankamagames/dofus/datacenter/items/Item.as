package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.datacenter.appearance.Appearance;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.data.CensoredContentManager;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.GameDataFileAccessor;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.IPostInit;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Item implements IPostInit, IDataCenter
   {
      
      public static const MODULE:String = "Items";
      
      private static const SUPERTYPE_NOT_EQUIPABLE:Array = [DataEnum.ITEM_SUPERTYPE_RESOURCES,DataEnum.ITEM_SUPERTYPE_QUEST_ITEMS,DataEnum.ITEM_SUPERTYPE_MUTATIONS,DataEnum.ITEM_SUPERTYPE_FOODS,DataEnum.ITEM_SUPERTYPE_BLESSINGS,DataEnum.ITEM_SUPERTYPE_CURSES,DataEnum.ITEM_SUPERTYPE_CONSUMABLE,DataEnum.ITEM_SUPERTYPE_ROLEPLAY_BUFFS,DataEnum.ITEM_SUPERTYPE_FOLLOWERS,DataEnum.ITEM_SUPERTYPE_MOUNTS,DataEnum.ITEM_SUPERTYPE_CATCHING_ITEMS,DataEnum.ITEM_SUPERTYPE_LIVING_ITEMS];
      
      public static const MAX_JOB_LEVEL_GAP:int = 100;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Item));
      
      private static var _censoredIcons:Dictionary;
      
      public static var idAccessors:IdAccessors = new IdAccessors(getItemById,getItems);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var typeId:uint;
      
      public var descriptionId:uint;
      
      public var iconId:uint;
      
      public var level:uint;
      
      public var realWeight:uint;
      
      public var cursed:Boolean;
      
      public var useAnimationId:int;
      
      public var usable:Boolean;
      
      public var targetable:Boolean;
      
      public var exchangeable:Boolean;
      
      public var price:Number;
      
      public var twoHanded:Boolean;
      
      public var etheral:Boolean;
      
      public var itemSetId:int;
      
      public var criteria:String;
      
      public var criteriaTarget:String;
      
      public var hideEffects:Boolean;
      
      public var enhanceable:Boolean;
      
      public var nonUsableOnAnother:Boolean;
      
      public var appearanceId:uint;
      
      public var isColorable:Boolean;
      
      public var secretRecipe:Boolean;
      
      public var dropMonsterIds:Vector.<uint>;
      
      public var dropTemporisMonsterIds:Vector.<uint>;
      
      public var recipeSlots:uint;
      
      public var recipeIds:Vector.<uint>;
      
      public var objectIsDisplayOnWeb:Boolean;
      
      public var bonusIsSecret:Boolean;
      
      public var possibleEffects:Vector.<EffectInstance>;
      
      public var evolutiveEffectIds:Vector.<uint>;
      
      public var favoriteSubAreas:Vector.<uint>;
      
      public var favoriteSubAreasBonus:uint;
      
      public var craftXpRatio:int;
      
      public var craftVisible:String;
      
      public var craftConditional:String;
      
      public var craftFeasible:String;
      
      public var needUseConfirm:Boolean;
      
      public var isDestructible:Boolean;
      
      public var isLegendary:Boolean;
      
      public var isSaleable:Boolean;
      
      public var recyclingNuggets:Number;
      
      public var favoriteRecyclingSubareas:Vector.<uint>;
      
      public var containerIds:Vector.<uint>;
      
      public var resourcesBySubarea:Vector.<Vector.<int>>;
      
      public var visibility:String;
      
      public var importantNoticeId:uint;
      
      public var changeVersion:String;
      
      public var tooltipExpirationDate:Number = NaN;
      
      private var _name:String;
      
      private var _undiatricalName:String;
      
      private var _description:String;
      
      private var _type:ItemType;
      
      private var _weight:uint;
      
      private var _itemSet:ItemSet;
      
      private var _appearance:TiphonEntityLook;
      
      private var _conditions:GroupItemCriterion;
      
      private var _conditionsTarget:GroupItemCriterion;
      
      private var _craftVisibleConditions:GroupItemCriterion;
      
      private var _craftConditions:GroupItemCriterion;
      
      private var _craftFeasibleConditions:GroupItemCriterion;
      
      private var _recipes:Array;
      
      private var _craftXpByJobLevel:Dictionary;
      
      private var _basicExperienceAsFood:Number = 0;
      
      private var _importantNotice:String = null;
      
      private var _processedImportantNotice:String = null;
      
      private const BOSS_BONUS:Number = 5.0;
      
      private const CRAFT_BONUS:Number = 1.5;
      
      public function Item()
      {
         super();
      }
      
      public static function getItemById(id:uint, returnDefaultItemIfNull:Boolean = true) : Item
      {
         var item:Item = GameData.getObject(MODULE,id) as Item;
         if(item || !returnDefaultItemIfNull)
         {
            return item;
         }
         _log.error("Impossible de trouver l\'objet " + id + ", remplacement par l\'objet 666");
         return GameData.getObject(MODULE,666) as Item;
      }
      
      public static function getItems() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getItemsByIds(ids:Vector.<uint>) : Vector.<Item>
      {
         var id:* = undefined;
         var item:* = undefined;
         var items:Vector.<Item> = new Vector.<Item>();
         for each(id in ids)
         {
            item = GameDataFileAccessor.getInstance().getObject(MODULE,id);
            if(item)
            {
               items.push(item);
            }
         }
         return items;
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get undiatricalName() : String
      {
         if(!this._undiatricalName)
         {
            this._undiatricalName = I18n.getUnDiacriticalText(this.nameId);
         }
         return this._undiatricalName;
      }
      
      public function get description() : String
      {
         if(!this._description)
         {
            if(this.etheral)
            {
               this._description = I18n.getUiText("ui.common.etherealWeaponDescription");
            }
            else
            {
               this._description = I18n.getText(this.descriptionId);
            }
         }
         return this._description;
      }
      
      public function get importantNotice() : String
      {
         if(!this._importantNotice)
         {
            this._importantNotice = I18n.getText(this.importantNoticeId);
         }
         return this._importantNotice;
      }
      
      public function get processedImportantNotice() : String
      {
         if(this._processedImportantNotice !== null)
         {
            return this._processedImportantNotice;
         }
         if(!this.importantNotice)
         {
            return null;
         }
         this._processedImportantNotice = HyperlinkMapPosition.parseMapLinks(this.importantNotice);
         return this._processedImportantNotice;
      }
      
      public function get weight() : uint
      {
         return this._weight;
      }
      
      public function set weight(n:uint) : void
      {
         this._weight = n;
      }
      
      public function get type() : Object
      {
         if(!this._type)
         {
            this._type = ItemType.getItemTypeById(this.typeId);
         }
         return this._type;
      }
      
      public function get isWeapon() : Boolean
      {
         return false;
      }
      
      public function get itemSet() : ItemSet
      {
         if(!this._itemSet)
         {
            this._itemSet = ItemSet.getItemSetById(this.itemSetId);
         }
         return this._itemSet;
      }
      
      public function get appearance() : TiphonEntityLook
      {
         var appearance:Appearance = null;
         if(!this._appearance)
         {
            appearance = Appearance.getAppearanceById(this.appearanceId);
            if(appearance)
            {
               this._appearance = TiphonEntityLook.fromString(appearance.data);
            }
         }
         return this._appearance;
      }
      
      public function get recipes() : Array
      {
         var numRecipes:int = 0;
         var i:int = 0;
         var recipe:Recipe = null;
         var it:Item = null;
         var gic:GroupItemCriterion = null;
         if(!this._recipes)
         {
            numRecipes = this.recipeIds.length;
            this._recipes = new Array();
            for(i = 0; i < numRecipes; i++)
            {
               recipe = Recipe.getRecipeByResultId(this.recipeIds[i]);
               if(recipe)
               {
                  it = Item.getItemById(recipe.resultId);
                  gic = !!it ? it.craftVisibleConditions : null;
                  if(!gic || gic.isRespected)
                  {
                     this._recipes.push(recipe);
                  }
               }
            }
         }
         return this._recipes;
      }
      
      public function get category() : uint
      {
         if(this.typeId == 0 || !this.type)
         {
            return ItemCategoryEnum.OTHER_CATEGORY;
         }
         return this.type.categoryId;
      }
      
      public function get conditions() : GroupItemCriterion
      {
         if(!this.criteria)
         {
            return null;
         }
         if(!this._conditions)
         {
            this._conditions = new GroupItemCriterion(this.criteria);
         }
         return this._conditions;
      }
      
      public function get targetConditions() : GroupItemCriterion
      {
         if(!this.criteriaTarget)
         {
            return null;
         }
         if(!this._conditionsTarget)
         {
            this._conditionsTarget = new GroupItemCriterion(this.criteriaTarget);
         }
         return this._conditionsTarget;
      }
      
      public function get craftVisibleConditions() : GroupItemCriterion
      {
         if(!this.craftVisible)
         {
            return null;
         }
         if(!this._craftVisibleConditions)
         {
            this._craftVisibleConditions = new GroupItemCriterion(this.craftVisible);
         }
         return this._craftVisibleConditions;
      }
      
      public function get craftConditions() : GroupItemCriterion
      {
         if(!this.craftConditional)
         {
            return null;
         }
         if(!this._craftConditions)
         {
            this._craftConditions = new GroupItemCriterion(this.craftConditional);
         }
         return this._craftConditions;
      }
      
      public function get craftFeasibleConditions() : GroupItemCriterion
      {
         if(!this.craftFeasible)
         {
            return null;
         }
         if(!this._craftFeasibleConditions)
         {
            this._craftFeasibleConditions = new GroupItemCriterion(this.craftFeasible);
         }
         return this._craftFeasibleConditions;
      }
      
      public function getCraftXpByJobLevel(jobLevel:int) : int
      {
         var xp:int = 0;
         var xpWithRatio:Number = NaN;
         var basicXp:Number = NaN;
         if(!this._craftXpByJobLevel)
         {
            this._craftXpByJobLevel = new Dictionary();
         }
         if(!this._craftXpByJobLevel[jobLevel])
         {
            if(jobLevel - MAX_JOB_LEVEL_GAP > this.level)
            {
               this._craftXpByJobLevel[jobLevel] = 0;
               return this._craftXpByJobLevel[jobLevel];
            }
            basicXp = 20 * this.level / (Math.pow(jobLevel - this.level,1.1) / 10 + 1);
            if(this.craftXpRatio > -1)
            {
               xpWithRatio = basicXp * (this.craftXpRatio / 100);
            }
            else if(this.type.craftXpRatio > -1)
            {
               xpWithRatio = basicXp * (this.type.craftXpRatio / 100);
            }
            else
            {
               xpWithRatio = basicXp;
            }
            this._craftXpByJobLevel[jobLevel] = Math.floor(xpWithRatio);
         }
         return this._craftXpByJobLevel[jobLevel];
      }
      
      public function get basicExperienceAsFood() : Number
      {
         var itemWrapper:ItemWrapper = null;
         var allRessources:Dictionary = null;
         var recipe:Recipe = null;
         var nuggets:Number = NaN;
         var experienceInt:int = 0;
         if(this._basicExperienceAsFood == 0)
         {
            itemWrapper = ItemWrapper.create(0,0,this.id,1,null,false);
            allRessources = new Dictionary();
            allRessources = this.getAllResources(itemWrapper,allRessources);
            recipe = Recipe.getRecipeByResultId(itemWrapper.objectGID);
            nuggets = this.getNuggetsQuantity(allRessources,recipe != null);
            this._basicExperienceAsFood = nuggets;
            experienceInt = Math.floor(this._basicExperienceAsFood * 100000);
            this._basicExperienceAsFood = experienceInt / 100000;
         }
         return this._basicExperienceAsFood;
      }
      
      private function getAllResources(itemWrapper:ItemWrapper, resources:Dictionary) : Dictionary
      {
         var iw:ItemWrapper = null;
         var i:uint = 0;
         var recipe:Recipe = Recipe.getRecipeByResultId(itemWrapper.objectGID);
         if(recipe)
         {
            for each(iw in recipe.ingredients)
            {
               for(i = 0; i < itemWrapper.quantity; i++)
               {
                  resources = this.getAllResources(iw,resources);
               }
            }
         }
         else if(resources[itemWrapper.objectGID] != null)
         {
            resources[itemWrapper.objectGID] += itemWrapper.quantity;
         }
         else
         {
            resources[itemWrapper.objectGID] = itemWrapper.quantity;
         }
         return resources;
      }
      
      private function getNuggetsQuantity(resources:Dictionary, isCraft:Boolean) : Number
      {
         var item:ItemWrapper = null;
         var resourceId:* = null;
         var bonus:Number = NaN;
         var totalNuggets:Number = 0;
         for(resourceId in resources)
         {
            item = ItemWrapper.create(0,0,int(resourceId),resources[resourceId],new Vector.<ObjectEffect>());
            if(item)
            {
               bonus = this.getBonus(item,isCraft);
               totalNuggets += item.recyclingNuggets * item.quantity * bonus;
            }
         }
         return totalNuggets;
      }
      
      private function getBonus(itemWrapper:ItemWrapper, isCraft:Boolean) : Number
      {
         var bossBonus:Number = !!this.isBossResource(itemWrapper) ? Number(this.BOSS_BONUS) : Number(1);
         var craftBonus:Number = !!isCraft ? Number(this.CRAFT_BONUS) : Number(1);
         return bossBonus * craftBonus;
      }
      
      private function isBossResource(itemWrapper:ItemWrapper) : Boolean
      {
         var monster:Monster = null;
         var monsterId:uint = 0;
         if(itemWrapper.dropMonsterIds.length <= 0)
         {
            return false;
         }
         for each(monsterId in itemWrapper.dropMonsterIds)
         {
            monster = Monster.getMonsterById(monsterId);
            if(monster && !monster.isBoss)
            {
               return false;
            }
         }
         return true;
      }
      
      public function copy(from:Item, to:Item) : void
      {
         to.id = from.id;
         to.nameId = from.nameId;
         to.typeId = from.typeId;
         to.descriptionId = from.descriptionId;
         to.iconId = from.iconId;
         to.level = from.level;
         to.realWeight = from.realWeight;
         to.weight = from.weight;
         to.cursed = from.cursed;
         to.useAnimationId = from.useAnimationId;
         to.usable = from.usable;
         to.targetable = from.targetable;
         to.price = from.price;
         to.twoHanded = from.twoHanded;
         to.etheral = from.etheral;
         to.enhanceable = from.enhanceable;
         to.nonUsableOnAnother = from.nonUsableOnAnother;
         to.itemSetId = from.itemSetId;
         to.criteria = from.criteria;
         to.criteriaTarget = from.criteriaTarget;
         to.hideEffects = from.hideEffects;
         to.appearanceId = from.appearanceId;
         to.isColorable = from.isColorable;
         to.recipeIds = from.recipeIds;
         to.recipeSlots = from.recipeSlots;
         to.secretRecipe = from.secretRecipe;
         to.bonusIsSecret = from.bonusIsSecret;
         to.objectIsDisplayOnWeb = from.objectIsDisplayOnWeb;
         to.possibleEffects = from.possibleEffects;
         to.evolutiveEffectIds = from.evolutiveEffectIds;
         to.favoriteSubAreas = from.favoriteSubAreas;
         to.favoriteSubAreasBonus = from.favoriteSubAreasBonus;
         to.dropMonsterIds = from.dropMonsterIds;
         to.dropTemporisMonsterIds = from.dropTemporisMonsterIds;
         to.resourcesBySubarea = from.resourcesBySubarea;
         to.exchangeable = from.exchangeable;
         to.craftXpRatio = from.craftXpRatio;
         to.needUseConfirm = from.needUseConfirm;
         to.isDestructible = from.isDestructible;
         to.isLegendary = from.isLegendary;
         to.isSaleable = from.isSaleable;
         to.craftVisible = from.craftVisible;
         to.craftConditional = from.craftConditional;
         to.craftFeasible = from.craftFeasible;
         to.recyclingNuggets = from.recyclingNuggets;
         to.favoriteRecyclingSubareas = from.favoriteRecyclingSubareas;
         to.containerIds = from.containerIds;
         to.visibility = from.visibility;
         to.importantNoticeId = from.importantNoticeId;
         to.changeVersion = from.changeVersion;
         to.tooltipExpirationDate = from.tooltipExpirationDate;
      }
      
      public function postInit() : void
      {
         if(!_censoredIcons)
         {
            _censoredIcons = CensoredContentManager.getInstance().getCensoredIndex(1);
         }
         if(_censoredIcons[this.iconId])
         {
            this.iconId = _censoredIcons[this.iconId];
         }
         this.name;
         this.undiatricalName;
      }
      
      public function isEvolutive() : Boolean
      {
         return this.evolutiveEffectIds && this.evolutiveEffectIds.length > 0;
      }
      
      public function get visible() : Boolean
      {
         if(!this.visibility)
         {
            return true;
         }
         var gic:GroupItemCriterion = new GroupItemCriterion(this.visibility);
         return gic.isRespected;
      }
   }
}

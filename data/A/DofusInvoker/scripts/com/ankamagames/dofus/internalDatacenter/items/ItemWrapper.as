package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.items.LegendaryPowerCategory;
   import com.ankamagames.dofus.datacenter.livingObjects.LivingObjectSkinJntMood;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
   import com.ankamagames.dofus.datacenter.optionalFeatures.Modster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import com.ankamagames.jerakine.utils.display.spellZone.ZoneEffect;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ItemWrapper extends Item implements ISlotData, ICellZoneProvider, IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemWrapper));
      
      private static const LEVEL_STEP:Array = [0,10,21,33,46,60,75,91,108,126,145,165,186,208,231,255,280,306,333,361];
      
      private static const COSMETIC_WRAPPER_TEXTURE_URI:String = "texture/slot/blueSlot_40.png";
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private static var _cache:Dictionary = new Dictionary();
      
      private static var _cacheGId:Dictionary = new Dictionary();
      
      private static var _errorIconUri:Uri;
      
      private static var _fullSizeErrorIconUri:Uri;
      
      private static var _uriLoaderContext:LoaderContext;
      
      private static var _uniqueIndex:int;
      
      private static var cosmecticWrapperBlueBorderUri:Uri = null;
       
      
      private var _uriPngMode:Uri;
      
      private var _backGroundIconUri:Uri;
      
      private var _forcedBackGroundIconUri:Uri;
      
      private var _active:Boolean = true;
      
      private var _uri:Uri;
      
      private var _shortName:String;
      
      private var _nameWithoutAccent:String;
      
      private var _mimicryItemSkinGID:int;
      
      private var _wrapperItemSkinGID:int;
      
      private var _setCount:int = 0;
      
      private var _searchContent:String;
      
      private var _possiblePositions:Vector.<int> = null;
      
      public var position:uint = 63;
      
      public var sortOrder:uint = 0;
      
      public var objectUID:uint = 0;
      
      public var objectGID:uint = 0;
      
      public var quantity:uint = 0;
      
      public var effects:Vector.<EffectInstance>;
      
      public var effectsList:Vector.<ObjectEffect>;
      
      public var livingObjectId:uint;
      
      public var livingObjectMood:uint;
      
      public var livingObjectSkin:uint;
      
      public var livingObjectCategory:uint;
      
      public var livingObjectXp:uint;
      
      public var livingObjectMaxXp:uint;
      
      public var livingObjectLevel:uint;
      
      public var livingObjectFoodDate:String;
      
      public var wrapperObjectCategory:uint;
      
      private var _isObjectWrapped:Boolean;
      
      public var presetIcon:int = -1;
      
      public var exchangeAllowed:Boolean;
      
      public var isPresetObject:Boolean;
      
      public var isOkForMultiUse:Boolean;
      
      public var givenExperienceAsSuperFood:Number = 0;
      
      public var experiencePoints:int = 0;
      
      public var evolutiveLevel:int = 0;
      
      public var customTextureUri:Uri;
      
      public var dropPriority:int = 0;
      
      public function ItemWrapper()
      {
         this.effects = new Vector.<EffectInstance>();
         super();
      }
      
      public static function create(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>, useCache:Boolean = true, dropPriority:int = 0) : ItemWrapper
      {
         var item:ItemWrapper = null;
         var effect:EffectInstance = null;
         var refItem:Item = Item.getItemById(objectGID);
         var cachedItem:ItemWrapper = objectUID > 0 ? _cache[objectUID] : _cacheGId[objectGID];
         if(!cachedItem || !useCache)
         {
            if(refItem.isWeapon)
            {
               item = new WeaponWrapper();
            }
            else
            {
               item = new ItemWrapper();
            }
            item.objectUID = objectUID;
            if(useCache)
            {
               if(objectUID > 0)
               {
                  _cache[objectUID] = item;
               }
               else
               {
                  _cacheGId[objectGID] = item;
               }
            }
         }
         else
         {
            item = cachedItem;
         }
         MEMORY_LOG[item] = 1;
         item._nameWithoutAccent = StringUtils.noAccent(refItem.name);
         item.effectsList = newEffects;
         item.isPresetObject = objectGID == DataEnum.ITEM_GID_PRESET_SHORTCUT;
         if(item.objectGID != objectGID)
         {
            item._uri = null;
            item._uriPngMode = null;
         }
         refItem.copy(refItem,item);
         item.position = position;
         item.objectGID = objectGID;
         item.quantity = quantity;
         ++_uniqueIndex;
         item.sortOrder = _uniqueIndex;
         item.livingObjectCategory = 0;
         item.wrapperObjectCategory = 0;
         item.effects = new Vector.<EffectInstance>();
         item.exchangeAllowed = true;
         item.updateEffects(newEffects);
         if(item.isWrapperObject || item.isLivingObject || item.isHarness || item.isCosmetic)
         {
            if(cosmecticWrapperBlueBorderUri == null)
            {
               cosmecticWrapperBlueBorderUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + COSMETIC_WRAPPER_TEXTURE_URI);
            }
            item.customTextureUri = cosmecticWrapperBlueBorderUri;
         }
         else
         {
            item.customTextureUri = null;
         }
         for each(effect in item.effects)
         {
            if(effect.effectId == ActionIds.ACTION_SUPERFOOD_EXPERIENCE)
            {
               item.givenExperienceAsSuperFood += (effect as EffectInstanceInteger).value;
            }
         }
         item.dropPriority = dropPriority;
         item.initPossiblePositions();
         return item;
      }
      
      public static function createFromServer(itemFromServer:ObjectItem, useCache:Boolean = true) : ItemWrapper
      {
         var item:ItemWrapper = null;
         var refItem:Item = Item.getItemById(itemFromServer.objectGID);
         var cachedItem:ItemWrapper = itemFromServer.objectUID > 0 ? _cache[itemFromServer.objectUID] : _cacheGId[itemFromServer.objectGID];
         if(!cachedItem || !useCache)
         {
            if(refItem.isWeapon)
            {
               item = new WeaponWrapper();
            }
            else
            {
               item = new ItemWrapper();
            }
            item.objectUID = itemFromServer.objectUID;
            if(useCache)
            {
               if(item.objectUID > 0)
               {
                  _cache[itemFromServer.objectUID] = item;
               }
               else
               {
                  _cacheGId[itemFromServer.objectGID] = item;
               }
            }
         }
         else
         {
            item = cachedItem;
         }
         MEMORY_LOG[item] = 1;
         item._nameWithoutAccent = StringUtils.noAccent(refItem.name);
         item.effectsList = itemFromServer.effects;
         item.isPresetObject = itemFromServer.objectGID == DataEnum.ITEM_GID_PRESET_SHORTCUT;
         if(item.objectGID != itemFromServer.objectGID)
         {
            item._uri = null;
            item._uriPngMode = null;
         }
         refItem.copy(refItem,item);
         item.position = itemFromServer.position;
         item.objectGID = itemFromServer.objectGID;
         item.quantity = itemFromServer.quantity;
         ++_uniqueIndex;
         item.sortOrder = _uniqueIndex;
         item.livingObjectCategory = 0;
         item.wrapperObjectCategory = 0;
         item.effects = new Vector.<EffectInstance>();
         item.exchangeAllowed = true;
         item.updateEffects(item.effectsList);
         item.initPossiblePositions();
         return item;
      }
      
      public static function clearCache() : void
      {
         _cache = new Dictionary();
         _cacheGId = new Dictionary();
      }
      
      public function get iconUri() : Uri
      {
         return this.getIconUri(true);
      }
      
      override public function get weight() : uint
      {
         var i:EffectInstance = null;
         for each(i in this.effects)
         {
            if(i.effectId == ActionIds.ACTION_ITEM_EXTRA_PODS)
            {
               return realWeight + i.parameter0;
            }
         }
         return realWeight;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this.getIconUri(false);
      }
      
      public function get backGroundIconUri() : Uri
      {
         if(this.linked)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/linkedSlot.png"));
         }
         if(!this._backGroundIconUri)
         {
            this._backGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/emptySlot.png"));
         }
         return this._backGroundIconUri;
      }
      
      public function set backGroundIconUri(bgUri:Uri) : void
      {
         this._backGroundIconUri = bgUri;
      }
      
      [Uri]
      public function get forcedBackGroundIconUri() : Uri
      {
         if(this.linked)
         {
            this._forcedBackGroundIconUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/slot/linkedSlot.png"));
         }
         return this._forcedBackGroundIconUri;
      }
      
      [Uri]
      public function set forcedBackGroundIconUri(bgUri:Uri) : void
      {
         this._forcedBackGroundIconUri = bgUri;
      }
      
      public function get errorIconUri() : Uri
      {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat("error.png"));
         }
         return _errorIconUri;
      }
      
      public function get fullSizeErrorIconUri() : Uri
      {
         if(!_fullSizeErrorIconUri)
         {
            _fullSizeErrorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat("error.swf"));
         }
         return _fullSizeErrorIconUri;
      }
      
      public function get isSpeakingObject() : Boolean
      {
         var effect:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return true;
         }
         for each(effect in this.effectsList)
         {
            if(effect.actionId == ActionIds.ACTION_SPEAKING_ITEM)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isLivingObject() : Boolean
      {
         return this.livingObjectCategory != 0;
      }
      
      public function get isWrapperObject() : Boolean
      {
         return this.wrapperObjectCategory != 0;
      }
      
      public function get isHarness() : Boolean
      {
         return type.id == DataEnum.ITEM_TYPE_HARNESS_MOUNT || type.id == DataEnum.ITEM_TYPE_HARNESS_MULDO || type.id == DataEnum.ITEM_TYPE_HARNESS_FLYHORN;
      }
      
      public function get isObjectWrapped() : Boolean
      {
         var effect:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return false;
         }
         for each(effect in this.effectsList)
         {
            if(effect.actionId == ActionIds.ACTION_ITEM_WRAPPER_LOOK_OBJ_GID)
            {
               this._wrapperItemSkinGID = (effect as ObjectEffectInteger).value;
               return true;
            }
         }
         return false;
      }
      
      public function get isMimicryObject() : Boolean
      {
         var effect:ObjectEffect = null;
         if(this.isLivingObject)
         {
            return false;
         }
         for each(effect in this.effectsList)
         {
            if(effect.actionId == ActionIds.ACTION_ITEM_MIMICRY_OBJ_GID)
            {
               this._mimicryItemSkinGID = (effect as ObjectEffectInteger).value;
               return true;
            }
         }
         return false;
      }
      
      public function get isCompanion() : Boolean
      {
         return type.id == DataEnum.ITEM_TYPE_COMPANION;
      }
      
      public function get info1() : String
      {
         return this.quantity > 1 ? this.quantity.toString() : null;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set active(b:Boolean) : void
      {
         this._active = b;
      }
      
      public function set minimalRange(pMinRange:uint) : void
      {
      }
      
      public function get minimalRange() : uint
      {
         return !!hasOwnProperty("minRange") ? uint(this["minRange"]) : uint(0);
      }
      
      public function set maximalRange(pRange:uint) : void
      {
      }
      
      public function get maximalRange() : uint
      {
         return !!hasOwnProperty("range") ? uint(this["range"]) : uint(0);
      }
      
      public function set castZoneInLine(pCastInLine:Boolean) : void
      {
      }
      
      public function get castZoneInLine() : Boolean
      {
         return !!hasOwnProperty("castInLine") ? Boolean(this["castInLine"]) : Boolean(0);
      }
      
      public function set castZoneInDiagonal(pCastInDiagonal:Boolean) : void
      {
      }
      
      public function get castZoneInDiagonal() : Boolean
      {
         return !!hasOwnProperty("castInDiagonal") ? Boolean(this["castInDiagonal"]) : Boolean(0);
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape>
      {
         var i:EffectInstance = null;
         var zone:ZoneEffect = null;
         var spellEffects:Vector.<IZoneShape> = new Vector.<IZoneShape>();
         for each(i in this.effects)
         {
            zone = new ZoneEffect(uint(i.zoneSize),i.zoneShape);
            spellEffects.push(zone);
         }
         return spellEffects;
      }
      
      public function toString() : String
      {
         return "[ItemWrapper#" + this.objectUID + "_" + this.name + "]";
      }
      
      public function get isCertificate() : Boolean
      {
         var itbt:Item = Item.getItemById(this.objectGID);
         return itbt && (itbt.typeId == DataEnum.ITEM_TYPE_DRAGOTURKEY_CERTIFICATE || itbt.typeId == DataEnum.ITEM_TYPE_MULDO_CERTIFICATE || itbt.typeId == DataEnum.ITEM_TYPE_FLYHORN_CERTIFICATE);
      }
      
      public function get isEquipment() : Boolean
      {
         return category == ItemCategoryEnum.EQUIPMENT_CATEGORY;
      }
      
      public function get isCosmetic() : Boolean
      {
         return category == ItemCategoryEnum.COSMETICS_CATEGORY;
      }
      
      public function get isUsable() : Boolean
      {
         var itbt:Item = Item.getItemById(this.objectGID);
         return itbt && (itbt.usable || itbt.targetable);
      }
      
      public function get belongsToSet() : Boolean
      {
         var itbt:Item = Item.getItemById(this.objectGID);
         return itbt && itbt.itemSetId != -1;
      }
      
      public function get favoriteEffect() : Vector.<EffectInstance>
      {
         var saO:Object = null;
         var itbt:Item = null;
         var boostedEffect:EffectInstance = null;
         var effect:EffectInstance = null;
         var result:Vector.<EffectInstance> = new Vector.<EffectInstance>();
         if(PlayedCharacterManager.getInstance() && this.objectGID > 0)
         {
            saO = PlayedCharacterManager.getInstance().currentSubArea;
            itbt = Item.getItemById(this.objectGID);
            if(saO && itbt.favoriteSubAreas.indexOf(saO.id) != -1)
            {
               if(itbt.favoriteSubAreas && itbt.favoriteSubAreas.length && itbt.favoriteSubAreasBonus)
               {
                  for each(effect in this.effects)
                  {
                     if(effect is EffectInstanceInteger && effect.bonusType == 1)
                     {
                        boostedEffect = effect.clone();
                        EffectInstanceInteger(boostedEffect).value = Math.floor(EffectInstanceInteger(boostedEffect).value * itbt.favoriteSubAreasBonus / 100);
                        if(EffectInstanceInteger(boostedEffect).value)
                        {
                           result.push(boostedEffect);
                        }
                     }
                  }
               }
            }
         }
         return result;
      }
      
      public function get setCount() : int
      {
         return this._setCount;
      }
      
      override public function get name() : String
      {
         if(this.shortName == super.name)
         {
            return super.name;
         }
         switch(this.objectGID)
         {
            case DataEnum.ITEM_GID_SOULSTONE_MINIBOSS:
               return I18n.getUiText("ui.item.miniboss") + I18n.getUiText("ui.common.colon") + this.shortName;
            case DataEnum.ITEM_GID_SOULSTONE_BOSS:
               return I18n.getUiText("ui.item.boss") + I18n.getUiText("ui.common.colon") + this.shortName;
            case DataEnum.ITEM_GID_SOULSTONE:
               return I18n.getUiText("ui.item.soul") + I18n.getUiText("ui.common.colon") + this.shortName;
            default:
               return super.name;
         }
      }
      
      public function get nameWithoutAccent() : String
      {
         if(!this._nameWithoutAccent)
         {
            this._nameWithoutAccent = StringUtils.noAccent(this.name);
         }
         return this._nameWithoutAccent;
      }
      
      public function get shortName() : String
      {
         var bestLevel:int = 0;
         var bestName:String = null;
         var miniboss:Array = null;
         var boss:Array = null;
         var effect:EffectInstance = null;
         var monster:Monster = null;
         var gradeId:int = 0;
         var grade:MonsterGrade = null;
         if(!this._shortName)
         {
            switch(this.objectGID)
            {
               case DataEnum.ITEM_GID_SOULSTONE:
                  bestLevel = 0;
                  bestName = null;
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if(monster)
                     {
                        gradeId = int(effect.parameter0);
                        if(gradeId < 1 || gradeId > monster.grades.length)
                        {
                           gradeId = monster.grades.length;
                        }
                        grade = monster.grades[gradeId - 1];
                        if(grade && grade.level > bestLevel)
                        {
                           bestLevel = grade.level;
                           bestName = monster.name;
                        }
                     }
                  }
                  this._shortName = bestName;
                  break;
               case DataEnum.ITEM_GID_SOULSTONE_MINIBOSS:
                  miniboss = new Array();
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if(monster && monster.isMiniBoss)
                     {
                        miniboss.push(monster.name);
                     }
                  }
                  if(miniboss.length)
                  {
                     this._shortName = miniboss.join(", ");
                  }
                  break;
               case DataEnum.ITEM_GID_SOULSTONE_BOSS:
                  boss = new Array();
                  for each(effect in this.effects)
                  {
                     monster = Monster.getMonsterById(int(effect.parameter2));
                     if(monster && monster.isBoss)
                     {
                        boss.push(monster.name);
                     }
                  }
                  if(boss.length)
                  {
                     this._shortName = boss.join(", ");
                  }
            }
         }
         if(!this._shortName)
         {
            this._shortName = super.name;
         }
         return this._shortName;
      }
      
      public function get realName() : String
      {
         return super.name;
      }
      
      public function get linked() : Boolean
      {
         return !exchangeable || !this.exchangeAllowed;
      }
      
      public function get searchContent() : String
      {
         var effect:Object = null;
         var monster:Monster = null;
         if(!this._searchContent)
         {
            this._searchContent = "";
            switch(this.objectGID)
            {
               case DataEnum.ITEM_GID_SOULSTONE:
               case DataEnum.ITEM_GID_SOULSTONE_BOSS:
               case DataEnum.ITEM_GID_SOULSTONE_MINIBOSS:
                  for each(effect in this.effectsList)
                  {
                     if(effect.actionId == ActionIds.ACTION_CHARACTER_SUMMON_MONSTER_GROUP)
                     {
                        monster = Monster.getMonsterById(effect.diceConst);
                        if(monster)
                        {
                           this._searchContent += monster.undiatricalName;
                        }
                     }
                  }
            }
         }
         return this._searchContent;
      }
      
      public function get isMimiCryWithWrapperObject() : Boolean
      {
         var effectInstance:EffectInstance = null;
         if(!this._mimicryItemSkinGID)
         {
            return false;
         }
         var mimicryItem:Item = Item.getItemById(this._mimicryItemSkinGID);
         for each(effectInstance in mimicryItem.possibleEffects)
         {
            if(effectInstance.effectId == ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get displayedLevel() : int
      {
         return this.evolutiveLevel;
      }
      
      public function get possiblePositions() : Vector.<int>
      {
         if(this._possiblePositions == null)
         {
            this.initPossiblePositions();
         }
         return this._possiblePositions;
      }
      
      private function initPossiblePositions() : void
      {
         var cat:int = 0;
         var itemType:ItemType = type as ItemType;
         if(!itemType)
         {
            return;
         }
         if(this.isLivingObject || this.isWrapperObject)
         {
            cat = 0;
            if(this.isLivingObject)
            {
               cat = this.livingObjectCategory;
            }
            else
            {
               cat = this.wrapperObjectCategory;
            }
            itemType = ItemType.getItemTypeById(cat);
         }
         this._possiblePositions = itemType.possiblePositions;
         if(this._possiblePositions == null || this._possiblePositions.length == 0)
         {
            this._possiblePositions = itemType.superType.possiblePositions;
         }
      }
      
      public function update(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>) : void
      {
         if(this.objectGID != objectGID || this.effectsList != newEffects)
         {
            this._uri = this._uriPngMode = null;
         }
         this.position = position;
         this.objectGID = objectGID;
         this.quantity = quantity;
         this.effectsList = newEffects;
         this.effects = new Vector.<EffectInstance>();
         this.livingObjectCategory = 0;
         this.wrapperObjectCategory = 0;
         this.livingObjectId = 0;
         var refItem:Item = Item.getItemById(objectGID);
         refItem.copy(refItem,this);
         this.updateEffects(newEffects);
         ++this._setCount;
      }
      
      public function getIconUri(pngMode:Boolean = true) : Uri
      {
         var iconId:String = null;
         var skinItem:Item = null;
         var skinItemm:Item = null;
         var modster:Modster = null;
         var isKroma:* = false;
         var compId:int = 0;
         var ei:EffectInstance = null;
         var companion:Companion = null;
         if(pngMode && this._uriPngMode)
         {
            return this._uriPngMode;
         }
         if(!pngMode && this._uri)
         {
            return this._uri;
         }
         var item:Item = Item.getItemById(this.objectGID);
         if(this.presetIcon != -1)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path").concat("presets/icons.swf|icon_").concat(this.presetIcon));
            if(!_uriLoaderContext)
            {
               _uriLoaderContext = new LoaderContext();
               AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
            }
            this._uri.loaderContext = _uriLoaderContext;
            return this._uri;
         }
         if(this.isLivingObject)
         {
            iconId = LivingObjectSkinJntMood.getLivingObjectSkin(!!this.livingObjectId ? int(this.livingObjectId) : int(this.objectGID),this.livingObjectMood,this.livingObjectSkin).toString();
         }
         else if(this.isObjectWrapped)
         {
            skinItem = Item.getItemById(this._wrapperItemSkinGID);
            iconId = !!skinItem ? skinItem.iconId.toString() : "error_on_item_" + this.objectGID + ".png";
         }
         else if(this.isMimicryObject)
         {
            skinItemm = Item.getItemById(this._mimicryItemSkinGID);
            iconId = !!skinItemm ? skinItemm.iconId.toString() : "error_on_item_" + this.objectGID + ".png";
         }
         else
         {
            if(item.typeId == DataEnum.ITEM_TYPE_MODSTER)
            {
               modster = Modster.getModsterByScrollId(item.id);
               if(modster)
               {
                  isKroma = modster.itemIdKroma == item.id;
                  this._uriPngMode = this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "modsters/" + modster.modsterId + ".swf|" + (!!isKroma ? "Chroma" : "Normal"));
               }
               return this._uri;
            }
            if(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && this.isCompanion && pngMode)
            {
               for each(ei in item.possibleEffects)
               {
                  if(ei.effectId == ActionIds.ACTION_SET_COMPANION)
                  {
                     compId = int(ei.parameter2);
                     companion = Companion.getCompanionById(compId);
                     this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "companions/square_" + companion.assetId + ".png");
                     return this._uriPngMode;
                  }
               }
            }
            else
            {
               iconId = !!item ? item.iconId.toString() : "error_on_item_" + this.objectGID + ".png";
            }
         }
         if(pngMode)
         {
            this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.bitmap").concat(iconId).concat(".png"));
            return this._uriPngMode;
         }
         this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.item.vector").concat(iconId).concat(".swf"));
         if(!_uriLoaderContext)
         {
            _uriLoaderContext = new LoaderContext();
            AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
         }
         this._uri.loaderContext = _uriLoaderContext;
         return this._uri;
      }
      
      public function clone(baseClass:Class = null) : ItemWrapper
      {
         if(baseClass == null)
         {
            baseClass = ItemWrapper;
         }
         var item:ItemWrapper = new baseClass() as ItemWrapper;
         MEMORY_LOG[item] = 1;
         item.copy(this,item);
         item.objectUID = this.objectUID;
         item.position = this.position;
         item.objectGID = this.objectGID;
         item.quantity = this.quantity;
         item.effects = this.effects;
         item.effectsList = this.effectsList;
         item.wrapperObjectCategory = this.wrapperObjectCategory;
         item.livingObjectCategory = this.livingObjectCategory;
         item.livingObjectFoodDate = this.livingObjectFoodDate;
         item.livingObjectId = this.livingObjectId;
         item.livingObjectLevel = this.livingObjectLevel;
         item.livingObjectMood = this.livingObjectMood;
         item.livingObjectSkin = this.livingObjectSkin;
         item.livingObjectXp = this.livingObjectXp;
         item.livingObjectMaxXp = this.livingObjectMaxXp;
         item.exchangeAllowed = this.exchangeAllowed;
         item.isOkForMultiUse = this.isOkForMultiUse;
         item.sortOrder = this.sortOrder;
         item.givenExperienceAsSuperFood = this.givenExperienceAsSuperFood;
         item.experiencePoints = this.experiencePoints;
         item.evolutiveLevel = this.evolutiveLevel;
         item.customTextureUri = this.customTextureUri;
         item.initPossiblePositions();
         return item;
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      private function updateLivingObjects(effect:EffectInstance) : void
      {
         switch(effect.effectId)
         {
            case ActionIds.ACTION_PETS_LAST_MEAL:
               this.livingObjectFoodDate = effect.description;
               return;
            case ActionIds.ACTION_ITEM_LIVING_ID:
               this.livingObjectId = EffectInstanceInteger(effect).value;
               break;
            case ActionIds.ACTION_ITEM_LIVING_MOOD:
               this.livingObjectMood = EffectInstanceInteger(effect).value;
               break;
            case ActionIds.ACTION_ITEM_LIVING_SKIN:
               this.livingObjectSkin = EffectInstanceInteger(effect).value;
               break;
            case ActionIds.ACTION_ITEM_LIVING_CATEGORY:
               this.livingObjectCategory = EffectInstanceInteger(effect).value;
               break;
            case ActionIds.ACTION_ITEM_LIVING_LEVEL:
               this.livingObjectLevel = this.getLivingObjectLevel(EffectInstanceInteger(effect).value);
               this.livingObjectXp = EffectInstanceInteger(effect).value - LEVEL_STEP[this.livingObjectLevel - 1];
               this.livingObjectMaxXp = LEVEL_STEP[this.livingObjectLevel] - LEVEL_STEP[this.livingObjectLevel - 1];
         }
      }
      
      private function updatePresets(effect:EffectInstance) : void
      {
         switch(effect.effectId)
         {
            case ActionIds.ACTION_ITEM_EQUIP_PRESET:
               this.presetIcon = int(effect.parameter0);
               return;
            default:
               return;
         }
      }
      
      private function getLivingObjectLevel(xp:int) : uint
      {
         for(var i:int = 0; i < LEVEL_STEP.length; i++)
         {
            if(LEVEL_STEP[i] > xp)
            {
               return i;
            }
         }
         return LEVEL_STEP.length;
      }
      
      public function updateEffects(updateEffects:Vector.<ObjectEffect>) : void
      {
         var effect:ObjectEffect = null;
         var itemType:ItemType = null;
         var effectInstance:EffectInstance = null;
         var itbt:Item = Item.getItemById(this.objectGID);
         var shape:uint = 0;
         var zoneSize:uint = 0;
         var zoneMinSize:uint = 0;
         if(itbt && itbt.isWeapon)
         {
            itemType = ItemType.getItemTypeById(itbt.typeId);
            if(itemType !== null)
            {
               shape = itemType.zoneShape;
               zoneSize = itemType.zoneSize;
               zoneMinSize = itemType.zoneMinSize;
            }
         }
         this.exchangeAllowed = true;
         var multiUseCheck:int = 0;
         for each(effect in updateEffects)
         {
            effectInstance = ObjectEffectAdapter.fromNetwork(effect);
            if(shape && effectInstance.category == DataEnum.ACTION_TYPE_DAMAGES)
            {
               effectInstance.zoneShape = shape;
               effectInstance.zoneSize = zoneSize;
               effectInstance.zoneMinSize = zoneMinSize;
            }
            this.effects.push(effectInstance);
            this.updateLivingObjects(effectInstance);
            this.updatePresets(effectInstance);
            if(multiUseCheck != -1 && (effectInstance.effectId == ActionIds.ACTION_CHARACTER_ENERGY_POINTS_WIN || effectInstance.effectId == ActionIds.ACTION_CHARACTER_BOOST_LIFE_POINTS || effectInstance.effectId == ActionIds.ACTION_CHARACTER_GAIN_XP || effectInstance.effectId == ActionIds.ACTION_CHARACTER_INVENTORY_GAIN_KAMAS || effectInstance.effectId == ActionIdProtocol.ACTION_CHARACTER_INVENTORY_ADD_ITEM_NOCHECK))
            {
               multiUseCheck = 1;
            }
            if(multiUseCheck != -1 && effectInstance.effectId != ActionIds.ACTION_CHARACTER_ENERGY_POINTS_WIN && effectInstance.effectId != ActionIds.ACTION_CHARACTER_BOOST_LIFE_POINTS && effectInstance.effectId != ActionIds.ACTION_CHARACTER_GAIN_XP && effectInstance.effectId != ActionIds.ACTION_CHARACTER_INVENTORY_GAIN_KAMAS && effectInstance.effectId != ActionIdProtocol.ACTION_CHARACTER_INVENTORY_ADD_ITEM_NOCHECK && effectInstance.effectId != ActionIds.ACTION_MARK_NEVER_TRADABLE_STRONG && effectInstance.effectId != ActionIds.ACTION_MARK_NEVER_TRADABLE && effectInstance.effectId != ActionIds.ACTION_MARK_NOT_TRADABLE)
            {
               multiUseCheck = -1;
            }
            if(effectInstance.effectId == ActionIds.ACTION_MARK_NOT_TRADABLE)
            {
               this.exchangeAllowed = false;
            }
            if(effectInstance.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE_STRONG || effectInstance.effectId == ActionIds.ACTION_MARK_NEVER_TRADABLE)
            {
               exchangeable = false;
            }
            if(effectInstance.effectId == ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE)
            {
               this.wrapperObjectCategory = EffectInstanceInteger(effectInstance).value;
            }
            if(effectInstance.effectId == ActionIds.ACTION_EVOLUTIVE_OBJECT_EXPERIENCE)
            {
               this.experiencePoints = EffectInstanceDice(effectInstance).value;
            }
            if(effectInstance.effectId == ActionIds.ACTION_EVOLUTIVE_PET_LEVEL)
            {
               this.evolutiveLevel = EffectInstanceDice(effectInstance).value;
            }
         }
         this.isOkForMultiUse = multiUseCheck == 1;
      }
      
      public function get itemHoldsLegendaryPower() : Boolean
      {
         var effect:EffectInstance = null;
         for each(effect in this.effects)
         {
            if(effect.effectId == ActionIds.ACTION_LEGENDARY_POWER_SPELL)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get itemHoldsLegendaryStatus() : Boolean
      {
         var effect:EffectInstance = null;
         for each(effect in this.effects)
         {
            if(effect.effectId == ActionIds.ACTION_LEGENDARY_STATUS)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get itemHasLegendaryEffect() : Boolean
      {
         return this.itemHoldsLegendaryPower || this.itemHoldsLegendaryStatus;
      }
      
      public function get itemHasLockedLegendarySpell() : Boolean
      {
         var effect:EffectInstance = null;
         var categories:Array = null;
         var cat:LegendaryPowerCategory = null;
         for each(effect in this.effects)
         {
            if(effect.effectId == ActionIds.ACTION_CAST_STARTING_SPELL)
            {
               categories = LegendaryPowerCategory.getLegendaryPowersCategories();
               for each(cat in categories)
               {
                  if(cat.categorySpells.indexOf((effect as EffectInstanceDice).diceNum) != -1)
                  {
                     return !cat.categoryOverridable;
                  }
               }
            }
         }
         return false;
      }
      
      public function canBeUsedForAutoPiloting(other:ItemWrapper) : Boolean
      {
         var effect:EffectInstance = null;
         if(!this.itemHasAutoPilotingEffect || other === null)
         {
            return false;
         }
         if(other.typeId === DataEnum.ITEM_TYPE_PETSMOUNT)
         {
            for each(effect in other.effects)
            {
               if(effect.effectId == ActionIds.ACTION_SELF_PILOTING)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public function get itemHasAutoPilotingEffect() : Boolean
      {
         var effect:EffectInstance = null;
         for each(effect in this.effects)
         {
            if(effect.effectId == ActionIds.ACTION_SELF_PILOTING)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get isEquippable() : Boolean
      {
         return this.possiblePositions != null && this.possiblePositions.length > 0;
      }
   }
}

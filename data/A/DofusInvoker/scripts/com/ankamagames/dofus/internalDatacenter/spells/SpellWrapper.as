package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.interfaces.IClonable;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.SlotDataHolderManager;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.spells.EffectZone;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.network.enums.SpellModifierActionTypeEnum;
   import com.ankamagames.dofus.network.enums.SpellModifierTypeEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import damageCalculation.tools.StatIds;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   import tools.ActionIdHelper;
   
   public dynamic class SpellWrapper extends Proxy implements ISlotData, IClonable, ICellZoneProvider, IDataCenter
   {
      
      private static var _cache:Array = [];
      
      private static var _playersCache:Dictionary = new Dictionary();
      
      private static var _cac:SpellWrapper;
      
      private static var _errorIconUri:Uri;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellWrapper));
      
      public static const INFINITE_VALUE:uint = 63;
      
      public static const BASE_DAMAGE_EFFECT_IDS:Array = [ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_MOVEMENT_POINTS_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_MOVEMENT_POINTS_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_MOVEMENT_POINTS_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_BASED_ON_MOVEMENT_POINTS_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_BEST_ELEMENT,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_FROM_WORST_ELEMENT,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_NO_BOOST,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_NO_BOOST_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_NO_BOOST_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_NO_BOOST_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_LOST_NO_BOOST_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_AIR,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_BEST_ELEMENT,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_EARTH,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_FIRE,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_WATER,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_FROM_WORST_ELEMENT,ActionIds.ACTION_CHARACTER_LIFE_POINTS_STEAL_WITHOUT_BOOST,ActionIds.ACTION_CHARACTER_MANA_USE_KILL_LIFE_AIR,ActionIds.ACTION_CHARACTER_MANA_USE_KILL_LIFE_FIRE,ActionIds.ACTION_CHARACTER_MANA_USE_KILL_LIFE_WATER,ActionIds.ACTION_CHARACTER_MOVEMENT_USE_KILL_LIFE_AIR,ActionIds.ACTION_CHARACTER_MOVEMENT_USE_KILL_LIFE_EARTH,ActionIds.ACTION_CHARACTER_MOVEMENT_USE_KILL_LIFE_FIRE,ActionIds.ACTION_CHARACTER_MOVEMENT_USE_KILL_LIFE_NEUTRAL,ActionIds.ACTION_CHARACTER_MOVEMENT_USE_KILL_LIFE_WATER];
       
      
      private var _uri:Uri;
      
      private var _slotDataHolderManager:SlotDataHolderManager;
      
      private var _canTargetCasterOutOfZone:Object;
      
      private var _variantActivated:Boolean;
      
      private var _spellLevel:SpellLevel;
      
      private var _spell:Spell;
      
      private var _isActiveOutsideTurn:Boolean = false;
      
      public var id:uint = 0;
      
      public var spellLevel:int = 1;
      
      public var effects:Vector.<EffectInstance>;
      
      public var criticalEffect:Vector.<EffectInstance>;
      
      public var gfxId:int;
      
      public var playerId:Number;
      
      public var versionNum:int;
      
      private var _actualCooldown:uint = 0;
      
      public function SpellWrapper()
      {
         super();
      }
      
      public static function create(spellID:uint, spellLevel:int = 0, useCache:Boolean = true, playerId:Number = 0, variantActivated:Boolean = false, areModifiers:Boolean = true, isActiveOutsideTurn:Boolean = false) : SpellWrapper
      {
         var spell:SpellWrapper = null;
         if(spellID == 0)
         {
            useCache = false;
         }
         if(useCache)
         {
            if(_cache[spellID] && !playerId)
            {
               spell = _cache[spellID];
            }
            else if(_playersCache[playerId] && _playersCache[playerId][spellID])
            {
               spell = _playersCache[playerId][spellID];
            }
         }
         if(spellID == 0 && _cac != null)
         {
            spell = _cac;
         }
         if(!spell)
         {
            spell = new SpellWrapper();
            spell.id = spellID;
            if(useCache)
            {
               if(playerId)
               {
                  if(!_playersCache[playerId])
                  {
                     _playersCache[playerId] = [];
                  }
                  if(!_playersCache[playerId][spellID])
                  {
                     _playersCache[playerId][spellID] = spell;
                  }
               }
               else
               {
                  _cache[spellID] = spell;
               }
            }
            spell._slotDataHolderManager = new SlotDataHolderManager(spell);
         }
         if(spellID != 0 || !_cac)
         {
            if(spellID == 0)
            {
               _cac = spell;
            }
            spell.id = spellID;
            spell.gfxId = spellID;
            spell.variantActivated = variantActivated;
         }
         spell.playerId = playerId;
         var spellData:Spell = Spell.getSpellById(spellID);
         if(!spellData)
         {
            return null;
         }
         if(spellLevel == 0)
         {
            spell.updateSpellLevelAccordingToPlayerLevel();
         }
         else
         {
            spell.spellLevel = spellLevel;
            spell._spellLevel = spellData.getSpellLevel(spell.spellLevel);
         }
         spell.setSpellEffects(areModifiers);
         spell._isActiveOutsideTurn = isActiveOutsideTurn;
         return spell;
      }
      
      public static function getSpellWrapperById(spellId:uint, playerID:Number, forceCreate:Boolean = false) : SpellWrapper
      {
         if(forceCreate)
         {
            return create(spellId);
         }
         if(playerID != 0)
         {
            if(!_playersCache[playerID])
            {
               return null;
            }
            if(!_playersCache[playerID][spellId] && _cache[spellId])
            {
               _playersCache[playerID][spellId] = _cache[spellId].clone();
            }
            if(spellId == 0)
            {
               return _cac;
            }
            if(_playersCache[playerID][spellId])
            {
               return _playersCache[playerID][spellId];
            }
            return null;
         }
         return _cache[spellId];
      }
      
      public static function refreshAllPlayerSpellHolder(playerId:Number) : void
      {
         EnterFrameDispatcher.worker.addUniqueSingleTreatment(SpellWrapper,refreshSpellHolders,[playerId]);
      }
      
      private static function refreshSpellHolders(playerID:Number) : void
      {
         var wrapper:SpellWrapper = null;
         for each(wrapper in _playersCache[playerID])
         {
            if(wrapper)
            {
               wrapper._slotDataHolderManager.refreshAll();
            }
         }
         if(_cac)
         {
            _cac._slotDataHolderManager.refreshAll();
         }
      }
      
      public static function resetAllCoolDown(playerId:Number, accessKey:Object) : void
      {
         var wrapper:SpellWrapper = null;
         SecureCenter.checkAccessKey(accessKey);
         for each(wrapper in _playersCache[playerId])
         {
            wrapper.actualCooldown = 0;
         }
      }
      
      public static function removeAllSpellWrapperBut(playerId:Number, accessKey:Object) : void
      {
         var id:* = null;
         var num:int = 0;
         var i:int = 0;
         SecureCenter.checkAccessKey(accessKey);
         var temp:Array = [];
         for(id in _playersCache)
         {
            if(Number(id) != playerId)
            {
               temp.push(id);
            }
         }
         num = temp.length;
         i = -1;
         while(++i < num)
         {
            delete _playersCache[temp[i]];
         }
      }
      
      public static function removeAllSpellWrapper() : void
      {
         _playersCache = new Dictionary();
         _cache = [];
      }
      
      public function get previewZones() : Vector.<EffectZone>
      {
         if(this._spellLevel === null)
         {
            return null;
         }
         return this._spellLevel.previewZones;
      }
      
      public function set actualCooldown(u:uint) : void
      {
         this._actualCooldown = u;
         this._slotDataHolderManager.refreshAll();
      }
      
      public function get actualCooldown() : uint
      {
         return !!PlayedCharacterManager.getInstance().isFighting ? uint(this._actualCooldown) : uint(0);
      }
      
      public function get spellLevelInfos() : SpellLevel
      {
         return this._spellLevel;
      }
      
      public function updateSpellLevelAndEffectsAccordingToPlayerLevel() : void
      {
         this.updateSpellLevelAccordingToPlayerLevel();
         this.setSpellEffects();
      }
      
      public function get variantActivated() : Boolean
      {
         return this._variantActivated;
      }
      
      public function set variantActivated(value:Boolean) : void
      {
         this._variantActivated = value;
      }
      
      public function get needFreeCellWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.FREE_CELL,this.spellLevelInfos["needFreeCell"]);
      }
      
      public function get needTakenCellWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.OCCUPIED_CELL,this.spellLevelInfos["needTakenCell"]);
      }
      
      public function get needVisibleEntityWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.VISIBLE_TARGET,this.spellLevelInfos["needVisibleEntity"]);
      }
      
      public function get needCellWithoutPortalWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.PORTAL_FREE_CELL,this.spellLevelInfos["needCellWithoutPortal"]);
      }
      
      public function get portalProjectionForbiddenWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.PORTAL_PROJECTION,this.spellLevelInfos["portalProjectionForbidden"]);
      }
      
      public function get minimalRange() : uint
      {
         return this["minRange"];
      }
      
      public function get maximalRange() : uint
      {
         return this.spellLevelInfos.range;
      }
      
      public function get castZoneInLine() : Boolean
      {
         return this["castInLine"];
      }
      
      public function get castZoneInDiagonal() : Boolean
      {
         return this["castInDiagonal"];
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape>
      {
         var build:BuildWrapper = null;
         var iw:ItemWrapper = null;
         if(InventoryManager.getInstance().currentBuildId != -1)
         {
            for each(build in InventoryManager.getInstance().builds)
            {
               if(build.id == InventoryManager.getInstance().currentBuildId)
               {
                  break;
               }
            }
            if(this.id == 0)
            {
               for each(iw in build.equipment)
               {
                  if(iw is WeaponWrapper)
                  {
                     break;
                  }
               }
               if(!(iw is WeaponWrapper) && this.spellLevelInfos)
               {
                  return this.spellLevelInfos.spellZoneEffects;
               }
            }
         }
         if(this.id != 0 || !PlayedCharacterManager.getInstance().currentWeapon)
         {
            if(this.spellLevelInfos)
            {
               return this.spellLevelInfos.spellZoneEffects;
            }
         }
         return null;
      }
      
      public function get hideEffects() : Boolean
      {
         if(this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
         {
            return (PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper).hideEffects;
         }
         if(this.spellLevelInfos)
         {
            return this.spellLevelInfos.hideEffects;
         }
         return false;
      }
      
      public function get backGroundIconUri() : Uri
      {
         if(this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
         {
            return new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/spells/all.swf|noIcon"));
         }
         return null;
      }
      
      public function get iconUri() : Uri
      {
         return this.fullSizeIconUri;
      }
      
      public function get fullSizeIconUri() : Uri
      {
         var build:BuildWrapper = null;
         var iw:ItemWrapper = null;
         if(!this._uri || this.id == 0)
         {
            if(InventoryManager.getInstance().currentBuildId != -1)
            {
               for each(build in InventoryManager.getInstance().builds)
               {
                  if(build.id == InventoryManager.getInstance().currentBuildId)
                  {
                     break;
                  }
               }
               if(this.id == 0)
               {
                  for each(iw in build.equipment)
                  {
                     if(iw is WeaponWrapper)
                     {
                        break;
                     }
                  }
                  if(iw is WeaponWrapper)
                  {
                     this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(iw.typeId));
                  }
                  else
                  {
                     this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_0"));
                  }
               }
               else
               {
                  this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(!!this.spell ? this.spell.iconId : 0));
               }
            }
            else if(this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
            {
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|weapon_").concat(PlayedCharacterManager.getInstance().currentWeapon.typeId));
            }
            else
            {
               this._uri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|sort_").concat(!!this.spell ? this.spell.iconId : 0));
            }
            this._uri.tag = Slot.NEED_CACHE_AS_BITMAP;
         }
         return this._uri;
      }
      
      public function get errorIconUri() : Uri
      {
         if(!_errorIconUri)
         {
            _errorIconUri = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.spells").concat("all.swf|noIcon"));
         }
         return _errorIconUri;
      }
      
      public function get info1() : String
      {
         if(this.actualCooldown == 0 || !PlayedCharacterManager.getInstance().isFighting)
         {
            return null;
         }
         if(this.actualCooldown == 63)
         {
            return "-";
         }
         return this.actualCooldown.toString();
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
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            return true;
         }
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var isForceActive:Boolean = this._isActiveOutsideTurn && fightContextFrame !== null && fightContextFrame.battleFrame.currentPlayerId !== this.playerId;
         if(isForceActive)
         {
            return true;
         }
         return Boolean(CurrentPlayedFighterManager.getInstance().canCastThisSpell(this.spellId,this.spellLevel));
      }
      
      public function get spell() : Spell
      {
         if(!this._spell)
         {
            this._spell = Spell.getSpellById(this.id);
         }
         return this._spell;
      }
      
      public function get spellId() : uint
      {
         if(this.spell)
         {
            return this.spell.id;
         }
         return 0;
      }
      
      public function get criticalHitProbability() : int
      {
         var entityId:Number = this.getEntityId();
         var criticalHitProbability:int = this.baseCriticalHitProbability;
         var stats:EntityStats = null;
         if(!isNaN(entityId))
         {
            criticalHitProbability = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.CRITICAL_HIT_BONUS,criticalHitProbability);
            if(criticalHitProbability > 0)
            {
               stats = StatsManager.getInstance().getStats(entityId);
            }
         }
         if(stats !== null)
         {
            criticalHitProbability += stats.getStatTotalValue(StatIds.CRITICAL_HIT);
         }
         criticalHitProbability = Math.max(0,criticalHitProbability);
         return int(Math.min(criticalHitProbability,100));
      }
      
      public function get isMaxRangeModifiableWithStats() : Boolean
      {
         return this.spellLevelInfos.rangeCanBeBoosted;
      }
      
      public function get isMaxRangeModifiableWithStatsWithModifiers() : Boolean
      {
         return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.RANGEABLE,this.isMaxRangeModifiableWithStats);
      }
      
      public function get maxRange() : int
      {
         var rangeBonus:Number = NaN;
         var entityId:Number = this.getEntityId();
         var stats:EntityStats = StatsManager.getInstance().getStats(entityId);
         var spellModifiers:SpellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(entityId,this.id);
         var finalRange:Number = this.maximalRange;
         if(spellModifiers != null)
         {
            if(spellModifiers.hasAction(SpellModifierTypeEnum.RANGE_MAX,SpellModifierActionTypeEnum.ACTION_SET))
            {
               return spellModifiers.getModifiedInt(SpellModifierTypeEnum.RANGE_MAX);
            }
            finalRange = spellModifiers.getModifiedInt(SpellModifierTypeEnum.RANGE_MAX,finalRange);
         }
         if(this.isMaxRangeModifiableWithStatsWithModifiers && stats !== null)
         {
            rangeBonus = stats.getStatTotalValue(StatIds.RANGE) - stats.getStatAdditionalValue(StatIds.RANGE);
            finalRange += rangeBonus;
         }
         if(finalRange < this.minimalRange)
         {
            finalRange = this.minimalRange;
         }
         return finalRange;
      }
      
      public function get canTargetCasterOutOfZone() : Boolean
      {
         var effect:EffectInstance = null;
         if(this._canTargetCasterOutOfZone == null)
         {
            for each(effect in this.effects)
            {
               if(effect.targetMask.indexOf("C") != -1 && effect.triggers == "I")
               {
                  this._canTargetCasterOutOfZone = true;
                  break;
               }
            }
            if(!this._canTargetCasterOutOfZone)
            {
               for each(effect in this.criticalEffect)
               {
                  if(effect.targetMask.indexOf("C") != -1 && effect.triggers == "I")
                  {
                     this._canTargetCasterOutOfZone = true;
                     break;
                  }
               }
            }
            if(!this._canTargetCasterOutOfZone)
            {
               this._canTargetCasterOutOfZone = false;
            }
         }
         return this._canTargetCasterOutOfZone;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var build:BuildWrapper = null;
         var iw:ItemWrapper = null;
         if(isAttribute(name))
         {
            return this[name];
         }
         if(InventoryManager.getInstance().currentBuildId != -1)
         {
            for each(build in InventoryManager.getInstance().builds)
            {
               if(build.id == InventoryManager.getInstance().currentBuildId)
               {
                  break;
               }
            }
            if(this.id == 0)
            {
               for each(iw in build.equipment)
               {
                  if(iw is WeaponWrapper)
                  {
                     break;
                  }
               }
               if(iw is WeaponWrapper)
               {
                  return this.getWeaponProperty(name,iw);
               }
            }
         }
         else if(this.id == 0 && PlayedCharacterManager.getInstance().currentWeapon != null)
         {
            return this.getWeaponProperty(name);
         }
         switch(name.toString())
         {
            case "id":
            case "nameId":
            case "descriptionId":
            case "typeId":
            case "scriptParams":
            case "scriptParamsCritical":
            case "scriptId":
            case "scriptIdCritical":
            case "iconId":
            case "spellLevels":
            case "useParamCache":
            case "name":
            case "description":
            case "variants":
            case "defaultPreviewZone":
            case "effectZone":
               return this.spell[name];
            case "spellBreed":
            case "needFreeCell":
            case "needTakenCell":
            case "minPlayerLevel":
            case "maxStack":
            case "globalCooldown":
               return this.spellLevelInfos[name.toString()];
            case "maxCastPerTurn":
               return SpellModifiersManager.getInstance().getModifiedInt(this.getEntityId(),this.id,SpellModifierTypeEnum.MAX_CAST_PER_TURN,this.spellLevelInfos["maxCastPerTurn"]);
            case "range":
            case "maxRange":
               return this.maxRange;
            case "minRange":
               return SpellModifiersManager.getInstance().getModifiedInt(this.getEntityId(),this.id,SpellModifierTypeEnum.RANGE_MIN,this.spellLevelInfos["minRange"]);
            case "maxCastPerTarget":
               return SpellModifiersManager.getInstance().getModifiedInt(this.getEntityId(),this.id,SpellModifierTypeEnum.MAX_CAST_PER_TARGET,this.spellLevelInfos["maxCastPerTarget"]);
            case "castInLine":
               return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.CAST_LINE,this.spellLevelInfos["castInLine"]);
            case "castInDiagonal":
               return this.spellLevelInfos["castInDiagonal"];
            case "castTestLos":
               return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.LOS,this.spellLevelInfos["castTestLos"]);
            case "rangeCanBeBoosted":
               return SpellModifiersManager.getInstance().getModifiedBool(this.getEntityId(),this.id,SpellModifierTypeEnum.RANGEABLE,this.spellLevelInfos["rangeCanBeBoosted"]);
            case "apCost":
               return SpellModifiersManager.getInstance().getModifiedInt(this.getEntityId(),this.id,SpellModifierTypeEnum.AP_COST,this.spellLevelInfos["apCost"]);
            case "minCastInterval":
               return SpellModifiersManager.getInstance().getModifiedInt(this.getEntityId(),this.id,SpellModifierTypeEnum.CAST_INTERVAL,this.spellLevelInfos["minCastInterval"]);
            case "isSpellWeapon":
               return this.id == 0;
            case "isDefaultSpellWeapon":
               return this.id == 0 && !PlayedCharacterManager.getInstance().currentWeapon;
            case "statesCriterion":
               return this.spellLevelInfos.statesCriterion;
            default:
               return;
         }
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : *
      {
         return null;
      }
      
      public function getEntityId() : Number
      {
         if(!isNaN(this.playerId) && this.playerId !== 0)
         {
            return this.playerId;
         }
         if(PlayedCharacterApi.getInstance().isInFight())
         {
            return CurrentPlayedFighterManager.getInstance().currentFighterId;
         }
         return PlayedCharacterManager.getInstance().id;
      }
      
      private function getWeaponProperty(name:*, item:ItemWrapper = null) : *
      {
         var modificator:int = 0;
         var weapon:ItemWrapper = !!item ? item : PlayedCharacterManager.getInstance().currentWeapon as ItemWrapper;
         if(!weapon)
         {
            return null;
         }
         switch(name.toString())
         {
            case "id":
               return 0;
            case "nameId":
            case "descriptionId":
            case "iconId":
            case "name":
            case "description":
            case "baseCriticalHitProbability":
            case "criticalHitProbability":
            case "castInLine":
            case "castInDiagonal":
            case "castTestLos":
            case "apCost":
            case "minRange":
            case "range":
               return weapon[name];
            case "isDefaultSpellWeapon":
            case "useParamCache":
            case "needTakenCell":
            case "needTakenCellWithModifiers":
            case "needVisibleEntity":
            case "needVisibleEntityWithModifiers":
            case "needCellWithoutPortal":
            case "needCellWithoutPortalWithModifiers":
            case "portalProjectionForbidden":
            case "portalProjectionForbiddenWithModifiers":
            case "rangeCanBeBoosted":
               return false;
            case "isSpellWeapon":
            case "needFreeCell":
            case "needFreeCellWithModifiers":
               return true;
            case "minCastInterval":
            case "minPlayerLevel":
            case "maxStack":
            case "maxCastPerTurn":
            case "maxCastPerTarget":
               return 0;
            case "typeId":
               return DataEnum.SPELL_TYPE_SPECIALS;
            case "scriptParams":
            case "scriptParamsCritical":
            case "spellLevels":
               return null;
            case "scriptId":
            case "scriptIdCritical":
            case "spellBreed":
               return 0;
            case "variants":
               return [];
            default:
               return;
         }
      }
      
      public function get baseCriticalHitProbability() : Number
      {
         var toReturn:* = undefined;
         if(this["isSpellWeapon"] && !this["isDefaultSpellWeapon"])
         {
            toReturn = this.getWeaponProperty("criticalHitProbability");
            if(toReturn === null)
            {
               return 0;
            }
            return toReturn;
         }
         return this.spellLevelInfos["criticalHitProbability"];
      }
      
      public function clone() : *
      {
         var returnSpellWrapper:SpellWrapper = null;
         var useCache:Boolean = false;
         return SpellWrapper.create(this.id,this.spellLevel,useCache,this.playerId,this.variantActivated);
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
         this._slotDataHolderManager.addHolder(h);
      }
      
      public function setLinkedSlotData(slotData:ISlotData) : void
      {
         this._slotDataHolderManager.setLinkedSlotData(slotData);
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
         this._slotDataHolderManager.removeHolder(h);
      }
      
      public function toString() : String
      {
         return "[SpellWrapper #" + this.id + "]";
      }
      
      private function updateSpellLevelAccordingToPlayerLevel() : void
      {
         var i:int = 0;
         var currentCharacterLevel:int = PlayedCharacterManager.getInstance().limitedLevel;
         if(!this.spell)
         {
            return;
         }
         var spellLevels:Array = this._spell.spellLevelsInfo;
         var spellLevelsCount:int = spellLevels.length;
         var index:int = 0;
         for(i = spellLevelsCount - 1; i >= 0; i--)
         {
            if(currentCharacterLevel >= spellLevels[i].minPlayerLevel)
            {
               index = i;
               break;
            }
         }
         this._spellLevel = spellLevels[index];
         this.spellLevel = index + 1;
      }
      
      public function setSpellEffects(areModifiers:Boolean = true) : void
      {
         var effectInstance:EffectInstance = null;
         var entityId:Number = NaN;
         var regularBaseDamageMod:int = 0;
         var criticalBaseDamageMod:int = 0;
         this.effects = new Vector.<EffectInstance>();
         this.criticalEffect = new Vector.<EffectInstance>();
         for each(effectInstance in this._spellLevel.effects)
         {
            effectInstance = effectInstance.clone();
            entityId = this.getEntityId();
            if(areModifiers && (effectInstance.category == DataEnum.ACTION_TYPE_DAMAGES && (BASE_DAMAGE_EFFECT_IDS.indexOf(effectInstance.effectId) != -1 || ActionIdHelper.isHeal(effectInstance.effectId))))
            {
               if(effectInstance is EffectInstanceDice)
               {
                  regularBaseDamageMod = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.BASE_DAMAGE);
                  (effectInstance as EffectInstanceDice).diceNum += regularBaseDamageMod;
                  if((effectInstance as EffectInstanceDice).diceSide > 0)
                  {
                     (effectInstance as EffectInstanceDice).diceSide += regularBaseDamageMod;
                  }
               }
               if(ActionIdHelper.isHeal(effectInstance.effectId))
               {
                  effectInstance.modificator = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.HEAL_BONUS,effectInstance.modificator);
               }
               else
               {
                  effectInstance.modificator = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.DAMAGE);
               }
            }
            this.effects.push(effectInstance);
         }
         for each(effectInstance in this._spellLevel.criticalEffect)
         {
            effectInstance = effectInstance.clone();
            if(areModifiers && (effectInstance.category == DataEnum.ACTION_TYPE_DAMAGES && (BASE_DAMAGE_EFFECT_IDS.indexOf(effectInstance.effectId) != -1 || ActionIdHelper.isHeal(effectInstance.effectId))))
            {
               if(effectInstance is EffectInstanceDice)
               {
                  criticalBaseDamageMod = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.BASE_DAMAGE);
                  (effectInstance as EffectInstanceDice).diceNum += criticalBaseDamageMod;
                  if((effectInstance as EffectInstanceDice).diceSide > 0)
                  {
                     (effectInstance as EffectInstanceDice).diceSide += criticalBaseDamageMod;
                  }
               }
               if(ActionIdHelper.isHeal(effectInstance.effectId))
               {
                  effectInstance.modificator = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.HEAL_BONUS,effectInstance.modificator);
               }
               else
               {
                  effectInstance.modificator = SpellModifiersManager.getInstance().getModifiedInt(entityId,this.id,SpellModifierTypeEnum.DAMAGE);
               }
            }
            this.criticalEffect.push(effectInstance);
         }
      }
   }
}

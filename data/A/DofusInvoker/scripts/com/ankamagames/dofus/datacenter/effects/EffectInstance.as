package com.ankamagames.dofus.datacenter.effects
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.items.LegendaryPowerCategory;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.misc.CharacterXPMapping;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.mounts.MountFamily;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
   import com.ankamagames.dofus.types.enums.LanguageEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.utils.getQualifiedClassName;
   import mapTools.SpellZone;
   
   public class EffectInstance implements IDataCenter
   {
      
      private static const UNKNOWN_NAME:String = "???";
      
      public static const IS_DISPELLABLE:int = 1;
      
      public static const IS_DISPELLABLE_ONLY_BY_DEATH:int = 2;
      
      public static const IS_NOT_DISPELLABLE:int = 3;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EffectInstance));
      
      private static const UNDEFINED_CATEGORY:int = -2;
      
      private static const UNDEFINED_SHOW:int = -1;
      
      private static const UNDEFINED_DESCRIPTION:String = "undefined";
       
      
      public var effectUid:uint;
      
      public var baseEffectId:uint;
      
      public var effectId:uint;
      
      public var order:int;
      
      public var targetId:int;
      
      public var targetMask:String;
      
      public var duration:int;
      
      public var delay:int;
      
      public var random:Number;
      
      public var group:int;
      
      public var modificator:int;
      
      public var trigger:Boolean;
      
      public var triggers:String;
      
      public var visibleInTooltip:Boolean = true;
      
      public var visibleInBuffUi:Boolean = true;
      
      public var visibleInFightLog:Boolean = true;
      
      public var visibleOnTerrain:Boolean = true;
      
      public var forClientOnly:Boolean = false;
      
      public var dispellable:int = 1;
      
      public var zoneSize:Object;
      
      public var zoneShape:uint;
      
      public var zoneMinSize:Object;
      
      public var zoneEfficiencyPercent:Object;
      
      public var zoneMaxEfficiency:Object;
      
      public var zoneStopAtTarget:Object;
      
      public var effectElement:int;
      
      public var spellId:int;
      
      private var _effectData:Effect;
      
      private var _durationStringValue:int;
      
      private var _delayStringValue:int;
      
      private var _durationString:String;
      
      private var _bonusType:int = -2;
      
      private var _oppositeId:int = -1;
      
      private var _category:int = -2;
      
      private var _description:String = "undefined";
      
      private var _theoricDescription:String = "undefined";
      
      private var _descriptionForTooltip:String = "undefined";
      
      private var _theoricDescriptionForTooltip:String = "undefined";
      
      private var _showSet:int = -1;
      
      private var _priority:uint = 0;
      
      private var _rawZone:String;
      
      private var _theoricShortDescriptionForTooltip:String = "undefined";
      
      public function EffectInstance()
      {
         super();
      }
      
      public function set rawZone(data:String) : void
      {
         this._rawZone = data;
         this.parseZone();
      }
      
      public function get rawZone() : String
      {
         return this._rawZone;
      }
      
      public function get durationString() : String
      {
         if(!this._durationString || this._durationStringValue != this.duration || this._delayStringValue != this.delay)
         {
            this._durationStringValue = this.duration;
            this._delayStringValue = this.delay;
            this._durationString = this.getTurnCountStr(false);
         }
         return this._durationString;
      }
      
      public function get category() : int
      {
         if(this._category == UNDEFINED_CATEGORY)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            this._category = !!this._effectData ? int(this._effectData.category) : -1;
         }
         return this._category;
      }
      
      public function get bonusType() : int
      {
         if(this._bonusType == -2)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            this._bonusType = !!this._effectData ? int(this._effectData.bonusType) : -2;
         }
         return this._bonusType;
      }
      
      public function get useInFight() : Boolean
      {
         if(!this._effectData)
         {
            this._effectData = Effect.getEffectById(this.effectId);
         }
         return this._effectData && this._effectData.useInFight;
      }
      
      public function get oppositeId() : int
      {
         if(this._oppositeId == -1)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            this._oppositeId = !!this._effectData ? int(this._effectData.oppositeId) : -1;
         }
         return this._oppositeId;
      }
      
      public function get showInSet() : int
      {
         if(this._showSet == UNDEFINED_SHOW)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            this._showSet = !!this._effectData ? (!!this._effectData.showInSet ? 1 : 0) : 0;
         }
         return this._showSet;
      }
      
      public function get priority() : uint
      {
         if(this._priority == 0)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            this._priority = !!this._effectData ? uint(this._effectData.effectPriority) : uint(0);
         }
         return this._priority;
      }
      
      public function get parameter0() : Object
      {
         return null;
      }
      
      public function get parameter1() : Object
      {
         return null;
      }
      
      public function get parameter2() : Object
      {
         return null;
      }
      
      public function get parameter3() : Object
      {
         return null;
      }
      
      public function get parameter4() : Object
      {
         return null;
      }
      
      public function get description() : String
      {
         if(this._description == UNDEFINED_DESCRIPTION)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            if(!this._effectData)
            {
               this._description = null;
               return null;
            }
            this._description = this.prepareDescription(this._effectData.description,this.effectId);
         }
         return this._description;
      }
      
      public function get theoreticalDescription() : String
      {
         var sSourceDesc:String = null;
         if(this._theoricDescription == UNDEFINED_DESCRIPTION)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            if(!this._effectData)
            {
               this._theoricDescription = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 0)
            {
               this._theoricDescription = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 1)
            {
               sSourceDesc = this._effectData.description;
            }
            else
            {
               sSourceDesc = this._effectData.theoreticalDescription;
            }
            this._theoricDescription = this.prepareDescription(sSourceDesc,this.effectId);
         }
         return this._theoricDescription;
      }
      
      public function get descriptionForTooltip() : String
      {
         if(this._descriptionForTooltip == UNDEFINED_DESCRIPTION)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            if(!this._effectData)
            {
               this._descriptionForTooltip = null;
               return null;
            }
            this._descriptionForTooltip = this.prepareDescription(this._effectData.description,this.effectId,true);
         }
         return this._descriptionForTooltip;
      }
      
      public function get theoreticalDescriptionForTooltip() : String
      {
         var sSourceDesc:String = null;
         if(this._theoricDescriptionForTooltip == UNDEFINED_DESCRIPTION)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            if(!this._effectData)
            {
               this._theoricDescriptionForTooltip = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 0)
            {
               this._theoricDescriptionForTooltip = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 1)
            {
               sSourceDesc = this._effectData.description;
            }
            else
            {
               sSourceDesc = this._effectData.theoreticalDescription;
            }
            this._theoricDescriptionForTooltip = this.prepareDescription(sSourceDesc,this.effectId,true);
         }
         return this._theoricDescriptionForTooltip;
      }
      
      public function get theoreticalShortDescriptionForTooltip() : String
      {
         var sSourceDesc:String = null;
         if(this._theoricShortDescriptionForTooltip == UNDEFINED_DESCRIPTION)
         {
            if(!this._effectData)
            {
               this._effectData = Effect.getEffectById(this.effectId);
            }
            if(!this._effectData)
            {
               this._theoricShortDescriptionForTooltip = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 0)
            {
               this._theoricShortDescriptionForTooltip = null;
               return null;
            }
            if(this._effectData.theoreticalPattern == 1)
            {
               sSourceDesc = this._effectData.description;
            }
            else
            {
               sSourceDesc = this._effectData.theoreticalDescription;
            }
            this._theoricShortDescriptionForTooltip = this.prepareDescription(sSourceDesc,this.effectId,true,true);
         }
         return this._theoricShortDescriptionForTooltip;
      }
      
      public function clone() : EffectInstance
      {
         var o:EffectInstance = new EffectInstance();
         o.zoneShape = this.zoneShape;
         o.zoneSize = this.zoneSize;
         o.zoneMinSize = this.zoneMinSize;
         o.zoneEfficiencyPercent = this.zoneEfficiencyPercent;
         o.zoneMaxEfficiency = this.zoneMaxEfficiency;
         o.effectUid = this.effectUid;
         o.effectId = this.effectId;
         o.order = this.order;
         o.duration = this.duration;
         o.random = this.random;
         o.group = this.group;
         o.targetId = this.targetId;
         o.targetMask = this.targetMask;
         o.delay = this.delay;
         o.triggers = this.triggers;
         o.visibleInTooltip = this.visibleInTooltip;
         o.visibleInBuffUi = this.visibleInBuffUi;
         o.visibleInFightLog = this.visibleInFightLog;
         o.visibleOnTerrain = this.visibleOnTerrain;
         o.forClientOnly = this.forClientOnly;
         o.dispellable = this.dispellable;
         return o;
      }
      
      public function add(effect:*) : EffectInstance
      {
         return new EffectInstance();
      }
      
      public function setParameter(paramIndex:uint, value:*) : void
      {
      }
      
      public function forceDescriptionRefresh() : void
      {
         this._description = UNDEFINED_DESCRIPTION;
         this._theoricDescription = UNDEFINED_DESCRIPTION;
      }
      
      private function getTurnCountStr(bShowLast:Boolean) : String
      {
         var sTmp:String = new String();
         if(this.delay > 0)
         {
            return PatternDecoder.combine(I18n.getUiText("ui.common.delayTurn",[this.delay]),"n",this.delay <= 1,this.delay == 0);
         }
         var d:int = this.duration;
         if(isNaN(d))
         {
            return "";
         }
         if(d > -1)
         {
            if(d > 1)
            {
               return PatternDecoder.combine(I18n.getUiText("ui.common.turn",[d]),"n",false);
            }
            if(d == 0)
            {
               return "";
            }
            if(bShowLast)
            {
               return I18n.getUiText("ui.common.lastTurn");
            }
            return PatternDecoder.combine(I18n.getUiText("ui.common.turn",[d]),"n",true);
         }
         return I18n.getUiText("ui.common.infinit");
      }
      
      private function getEmoticonName(id:int) : String
      {
         var o:Emoticon = Emoticon.getEmoticonById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getItemTypeName(id:int) : String
      {
         var o:ItemType = ItemType.getItemTypeById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getMonsterName(id:int) : String
      {
         var o:Monster = Monster.getMonsterById(id);
         return !!o ? o.name : I18n.getUiText("ui.effect.unknownMonster");
      }
      
      private function getCompanionName(id:int) : String
      {
         var o:Companion = Companion.getCompanionById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getMonsterGrade(pId:int, pGrade:int) : String
      {
         var m:Monster = Monster.getMonsterById(pId);
         return !!m ? m.getMonsterGrade(pGrade).level.toString() : UNKNOWN_NAME;
      }
      
      private function getSpellName(id:int) : String
      {
         var o:Spell = Spell.getSpellById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getSpellLevelName(id:int) : String
      {
         var o:SpellLevel = SpellLevel.getLevelById(id);
         var name:String = !!o ? this.getSpellName(o.spellId) : UNKNOWN_NAME;
         return !!o ? this.getSpellName(o.spellId) : UNKNOWN_NAME;
      }
      
      private function getLegendaryPowerCategoryName(id:int) : String
      {
         var powerCategory:LegendaryPowerCategory = LegendaryPowerCategory.getLegendaryPowerCategoryById(id);
         return !!powerCategory ? powerCategory.categoryName : UNKNOWN_NAME;
      }
      
      private function getJobName(id:int) : String
      {
         var o:Job = Job.getJobById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getDocumentTitle(id:int) : String
      {
         var o:Document = Document.getDocumentById(id);
         return !!o ? o.title : UNKNOWN_NAME;
      }
      
      private function getAlignmentSideName(id:int) : String
      {
         var o:AlignmentSide = AlignmentSide.getAlignmentSideById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getItemName(id:int) : String
      {
         var o:Item = Item.getItemById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getMonsterSuperRaceName(id:int) : String
      {
         var o:MonsterSuperRace = MonsterSuperRace.getMonsterSuperRaceById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getMonsterRaceName(id:int) : String
      {
         var o:MonsterRace = MonsterRace.getMonsterRaceById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getTitleName(id:int) : String
      {
         var o:Title = Title.getTitleById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getMountFamilyName(id:int) : String
      {
         var o:MountFamily = MountFamily.getMountFamilyById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function getStatName(id:int) : String
      {
         var o:Characteristic = Characteristic.getCharacteristicById(id);
         return !!o ? o.name : UNKNOWN_NAME;
      }
      
      private function parseZone() : void
      {
         var params:Array = null;
         if(this.rawZone && this.rawZone.length)
         {
            this.zoneShape = this.rawZone.charCodeAt(0);
            params = this.rawZone.substr(1).split(",");
            switch(this.zoneShape)
            {
               case SpellShapeEnum.l:
                  this.zoneMinSize = parseInt(params[0]);
                  this.zoneSize = parseInt(params[1]);
                  if(params.length > 2)
                  {
                     this.zoneEfficiencyPercent = parseInt(params[2]);
                     this.zoneMaxEfficiency = parseInt(params[3]);
                  }
                  if(params.length == 5)
                  {
                     this.zoneStopAtTarget = parseInt(params[4]);
                  }
                  return;
               default:
                  if(params.length > 0)
                  {
                     if(params[0] == "")
                     {
                        this.zoneSize = 1;
                     }
                     else
                     {
                        this.zoneSize = parseInt(params[0]);
                     }
                  }
                  switch(params.length)
                  {
                     case 2:
                        if(SpellZone.hasMinSize(this.rawZone.substr(0,1)))
                        {
                           this.zoneMinSize = parseInt(params[1]);
                        }
                        else
                        {
                           this.zoneEfficiencyPercent = parseInt(params[1]);
                        }
                        break;
                     case 3:
                        if(SpellZone.hasMinSize(this.rawZone.substr(0,1)))
                        {
                           this.zoneMinSize = parseInt(params[1]);
                           this.zoneEfficiencyPercent = parseInt(params[2]);
                        }
                        else
                        {
                           this.zoneEfficiencyPercent = parseInt(params[1]);
                           this.zoneMaxEfficiency = parseInt(params[2]);
                        }
                        break;
                     case 4:
                        this.zoneMinSize = parseInt(params[1]);
                        this.zoneEfficiencyPercent = parseInt(params[2]);
                        this.zoneMaxEfficiency = parseInt(params[3]);
                        break;
                     default:
                        this.zoneMinSize = 0;
                        this.zoneEfficiencyPercent = null;
                        this.zoneMaxEfficiency = null;
                  }
            }
         }
         else
         {
            _log.error("Zone incorrect (" + this.rawZone + ")");
         }
      }
      
      private function prepareDescription(desc:String, effectId:uint, forTooltip:Boolean = false, short:Boolean = false) : String
      {
         var aTmp:Array = null;
         var spellState:SpellState = null;
         var nYear:String = null;
         var nMonth:String = null;
         var nDay:String = null;
         var nHours:String = null;
         var nMinutes:String = null;
         var lang:String = null;
         var level:uint = 0;
         var remainingXpPercentage:uint = 0;
         var currentMapping:CharacterXPMapping = null;
         var nextMapping:CharacterXPMapping = null;
         var text:String = null;
         var statName:String = null;
         var currentLevelXP:Number = NaN;
         var nextLevelXP:Number = NaN;
         var i:uint = 0;
         var firstValue:int = 0;
         var lastValue:int = 0;
         if(desc == null)
         {
            return "";
         }
         var sEffect:String = "";
         var hasAddedSpanTag:Boolean = false;
         var spellModif:Boolean = false;
         if(desc.indexOf("#") != -1)
         {
            aTmp = [this.parameter0,this.parameter1,this.parameter2,this.parameter3,this.parameter4];
            if(this.parameter0 > 0 && this.parameter1 > 0 && this.bonusType == -1)
            {
               aTmp = [this.parameter1,this.parameter0,this.parameter2,this.parameter3,this.parameter4];
            }
            switch(effectId)
            {
               case ActionIds.ACTION_CHARACTER_DISPELL_SPELL:
                  aTmp[1] = this.getSpellName(!!aTmp[0] ? int(aTmp[0]) : (!!aTmp[1] ? int(aTmp[1]) : int(aTmp[2])));
                  break;
               case ActionIds.ACTION_CHARACTER_LEARN_EMOTICON:
                  aTmp[2] = this.getEmoticonName(aTmp[0]);
                  break;
               case ActionIds.ACTION_CHARACTER_BOOST_ONE_WEAPON_DAMAGE_PERCENT:
               case ActionIds.ACTION_ITEM_GIFT_CONTENT:
                  aTmp[0] = this.getItemTypeName(aTmp[0]);
                  break;
               case ActionIds.ACTION_ITEM_WRAPPER_COMPATIBLE_OBJ_TYPE:
                  aTmp[0] = this.getItemTypeName(!!aTmp[0] ? int(aTmp[0]) : int(aTmp[2]));
                  break;
               case ActionIds.ACTION_CHARACTER_TRANSFORM:
               case ActionIds.ACTION_SUMMON_CREATURE:
               case ActionIds.ACTION_FIGHT_KILL_AND_SUMMON:
               case ActionIds.ACTION_FIGHT_KILL_AND_SUMMON_SLAVE:
               case ActionIds.ACTION_LADDER_ID:
               case ActionIds.ACTION_SUMMON_BOMB:
               case ActionIds.ACTION_SUMMON_SLAVE:
                  aTmp[0] = this.getMonsterName(aTmp[0]);
                  break;
               case ActionIds.ACTION_CHARACTER_REFLECTOR_UNBOOSTED:
                  if(!aTmp[0] && !aTmp[1] && aTmp[2])
                  {
                     aTmp[0] = aTmp[2];
                  }
                  aTmp[5] = "m";
                  aTmp[6] = aTmp[1] != null ? false : Math.abs(aTmp[0]) == 1;
                  aTmp[7] = aTmp[1] != null ? false : aTmp[0] == 0;
                  break;
               case ActionIds.ACTION_ITEM_CHANGE_DURABILITY:
                  if(aTmp[2] && aTmp[1] == null)
                  {
                     aTmp[1] = 0;
                  }
               case ActionIds.ACTION_BOOST_SPELL_RANGE_MAX:
               case ActionIds.ACTION_BOOST_SPELL_RANGE_MIN:
               case ActionIds.ACTION_BOOST_SPELL_RANGEABLE:
               case ActionIds.ACTION_BOOST_SPELL_DMG:
               case ActionIds.ACTION_BOOST_SPELL_HEAL:
               case ActionIds.ACTION_BOOST_SPELL_AP_COST:
               case ActionIds.ACTION_DEBOOST_SPELL_AP_COST:
               case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL:
               case ActionIds.ACTION_BOOST_SPELL_CC:
               case ActionIds.ACTION_BOOST_SPELL_CASTOUTLINE:
               case ActionIds.ACTION_BOOST_SPELL_NOLINEOFSIGHT:
               case ActionIds.ACTION_BOOST_SPELL_MAXPERTURN:
               case ActionIds.ACTION_BOOST_SPELL_MAXPERTARGET:
               case ActionIds.ACTION_BOOST_SPELL_CAST_INTVL_SET:
               case ActionIds.ACTION_BOOST_SPELL_BASE_DMG:
               case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MAX:
               case ActionIds.ACTION_DEBOOST_SPELL_RANGE_MIN:
               case ActionIds.ACTION_CASTER_EXECUTE_SPELL:
               case ActionIds.ACTION_SET_SPELL_RANGE_MAX:
               case ActionIds.ACTION_SET_SPELL_RANGE_MIN:
                  aTmp[0] = this.getSpellName(aTmp[0]);
                  spellModif = true;
                  break;
               case ActionIds.ACTION_CAST_STARTING_SPELL:
                  aTmp[0] = "{spellNoLvl," + aTmp[0] + "," + aTmp[1] + "}";
                  break;
               case ActionIds.ACTION_CHARACTER_LEARN_SPELL:
                  if(aTmp[2] == null)
                  {
                     aTmp[2] = aTmp[0];
                  }
                  aTmp[2] = this.getSpellLevelName(aTmp[2]);
                  break;
               case ActionIds.ACTION_LEGENDARY_POWER_SPELL:
                  aTmp[2] = I18n.getUiText("ui.itemtooltip.giveSpellCategory",[this.getLegendaryPowerCategoryName(aTmp[0])]);
                  break;
               case ActionIds.ACTION_CHARACTER_GAIN_JOB_XP:
                  aTmp[0] = aTmp[2];
                  aTmp[1] = this.getJobName(aTmp[1]);
                  break;
               case ActionIds.ACTION_CHARACTER_LEARN_SPELL_FORGETTABLE:
                  aTmp[2] = this.getSpellName(aTmp[!!aTmp[2] ? 2 : 0]);
                  break;
               case ActionIds.ACTION_CHARACTER_UNLEARN_GUILDSPELL:
                  aTmp[2] = this.getSpellName(aTmp[0]);
                  break;
               case ActionIds.ACTION_CHARACTER_READ_BOOK:
                  aTmp[2] = this.getDocumentTitle(aTmp[0]);
                  break;
               case ActionIds.ACTION_CHARACTER_SUMMON_MONSTER:
                  aTmp[2] = this.getMonsterName(aTmp[1]);
                  break;
               case ActionIds.ACTION_CHARACTER_SUMMON_MONSTER_GROUP:
               case ActionIds.ACTION_CHARACTER_SUMMON_MONSTER_GROUP_DYNAMIC:
                  aTmp[1] = this.getMonsterGrade(aTmp[2],aTmp[0]);
                  aTmp[2] = this.getMonsterName(aTmp[2]);
                  break;
               case ActionIds.ACTION_FAKE_ALIGNMENT:
               case ActionIdProtocol.ACTION_SHOW_ALIGNMENT:
                  aTmp[2] = this.getAlignmentSideName(aTmp[0]);
                  break;
               case ActionIds.ACTION_CHARACTER_REFERENCEMENT:
                  aTmp[0] = this.getJobName(aTmp[0]);
                  break;
               case ActionIds.ACTION_LADDER_SUPERRACE:
                  aTmp[0] = this.getMonsterSuperRaceName(aTmp[0]);
                  break;
               case ActionIds.ACTION_LADDER_RACE:
                  aTmp[0] = this.getMonsterRaceName(aTmp[0]);
                  break;
               case ActionIds.ACTION_GAIN_TITLE:
                  aTmp[2] = this.getTitleName(aTmp[0]);
                  break;
               case ActionIds.ACTION_TARGET_EXECUTE_SPELL:
               case ActionIds.ACTION_TARGET_EXECUTE_SPELL_WITH_ANIMATION:
               case ActionIds.ACTION_TARGET_EXECUTE_SPELL_ON_SOURCE:
               case ActionIds.ACTION_SOURCE_EXECUTE_SPELL_ON_TARGET:
               case ActionIds.ACTION_SOURCE_EXECUTE_SPELL_ON_SOURCE:
               case ActionIds.ACTION_CHARACTER_ADD_SPELL_COOLDOWN:
               case ActionIds.ACTION_CHARACTER_REMOVE_SPELL_COOLDOWN:
               case ActionIds.ACTION_CHARACTER_PROTECTION_FROM_SPELL:
               case ActionIds.ACTION_CHARACTER_SET_SPELL_COOLDOWN:
               case ActionIds.ACTION_TARGET_EXECUTE_SPELL_ON_CELL:
               case ActionIds.ACTION_DECORS_PLAY_ANIMATION_D2:
                  aTmp[0] = this.getSpellName(aTmp[0]);
                  break;
               case ActionIdProtocol.ACTION_SHOW_GRADE:
               case ActionIdProtocol.ACTION_SHOW_LEVEL:
               case ActionIds.ACTION_ITEM_SUMMON_MONSTER_GROUP_MAX_LOOT_SHARES:
                  aTmp[2] = aTmp[0];
                  break;
               case ActionIds.ACTION_ITEM_SUMMON_MONSTER_REWARD_RATE:
                  if(aTmp[0] == 0)
                  {
                     aTmp[0] = "-";
                  }
                  else
                  {
                     aTmp[0] = "+";
                  }
                  aTmp[0] += aTmp[1];
                  break;
               case ActionIds.ACTION_ITEM_PETS_SHAPE:
                  if(aTmp[1] > 6)
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.fat",[aTmp[1]]);
                  }
                  else if(aTmp[2] > 6)
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.lean",[aTmp[2]]);
                  }
                  else if(this is EffectInstanceInteger && aTmp[0] > 6)
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.lean",[aTmp[0]]);
                  }
                  else
                  {
                     aTmp[0] = I18n.getUiText("ui.petWeight.nominal");
                  }
                  break;
               case ActionIds.ACTION_ITEM_PETS_EAT:
                  if(aTmp[0])
                  {
                     aTmp[0] = this.getItemName(aTmp[0]);
                  }
                  else
                  {
                     aTmp[0] = I18n.getUiText("ui.common.none");
                  }
                  break;
               case ActionIds.ACTION_ITEM_DUNGEON_KEY_DATE:
               case ActionIds.ACTION_ITEM_MIMICRY_OBJ_GID:
               case ActionIds.ACTION_ITEM_WRAPPER_LOOK_OBJ_GID:
               case ActionIds.ACTION_RIDE_HARNESS_GID:
                  aTmp[0] = this.getItemName(aTmp[0]);
                  break;
               case ActionIds.ACTION_RIDE_GAIN_CAPACITY:
                  aTmp[0] = this.getMountFamilyName(aTmp[0]);
                  break;
               case ActionIds.ACTION_FIGHT_CHALLENGE_AGAINST_MONSTER:
                  aTmp[1] = this.getMonsterName(aTmp[1]);
                  break;
               case ActionIds.ACTION_PET_SET_POWER_BOOST:
               case ActionIds.ACTION_PET_POWER_BOOST:
                  aTmp[2] = this.getItemName(aTmp[0]);
                  break;
               case ActionIds.ACTION_FIGHT_SET_STATE:
               case ActionIds.ACTION_FIGHT_UNSET_STATE:
               case ActionIds.ACTION_FIGHT_DISABLE_STATE:
                  spellState = aTmp[2] != null ? SpellState.getSpellStateById(aTmp[2]) : SpellState.getSpellStateById(aTmp[0]);
                  if(spellState)
                  {
                     if(spellState.isSilent)
                     {
                        return "";
                     }
                     aTmp[2] = spellState.name;
                  }
                  else
                  {
                     aTmp[2] = UNKNOWN_NAME;
                  }
                  break;
               case ActionIds.ACTION_SET_CRAFTERMAGE:
               case ActionIds.ACTION_SET_OWNER:
               case ActionIds.ACTION_SET_CRAFTER:
                  aTmp[3] = "{player," + aTmp[3] + "}";
                  break;
               case ActionIds.ACTION_SET_COMPANION:
                  aTmp[0] = this.getCompanionName(aTmp[0]);
                  break;
               case ActionIds.ACTION_EVOLUTIVE_OBJECT_EXPERIENCE:
                  if(!aTmp[2])
                  {
                     aTmp[2] = 0;
                  }
                  if(!aTmp[1])
                  {
                     aTmp[1] = 0;
                  }
                  if(aTmp[1] == 0)
                  {
                     aTmp[2] = I18n.getUiText("ui.common.maximum");
                  }
                  else
                  {
                     aTmp[2] = I18n.getUiText("ui.tooltip.monsterXpAlone",[aTmp[2] + " / " + aTmp[1]]);
                  }
                  break;
               case ActionIds.ACTION_EVOLUTIVE_PET_LEVEL:
                  aTmp[0] = this.getItemTypeName(aTmp[0]);
                  aTmp[2] = aTmp[2] - 1;
                  break;
               case ActionIds.ACTION_SUPERFOOD_EXPERIENCE:
                  aTmp[2] = aTmp[0];
                  break;
               case ActionIds.ACTION_ITEM_CHANGE_DURATION:
               case ActionIds.ACTION_PETS_LAST_MEAL:
               case ActionIds.ACTION_MARK_NOT_TRADABLE:
               case ActionIdProtocol.ACTION_ITEM_EXPIRATION:
                  if(aTmp[0] == undefined && aTmp[1] == undefined && aTmp[2] > 0)
                  {
                     aTmp[0] = aTmp[2];
                     break;
                  }
                  if(aTmp[0] == null && aTmp[1] == null && aTmp[2] == null)
                  {
                     break;
                  }
                  aTmp[2] = aTmp[2] == undefined ? 0 : aTmp[2];
                  nYear = aTmp[0];
                  nMonth = aTmp[1].substr(0,2);
                  nDay = aTmp[1].substr(2,2);
                  nHours = aTmp[2].substr(0,2);
                  nMinutes = aTmp[2].substr(2,2);
                  lang = XmlConfig.getInstance().getEntry("config.lang.current");
                  switch(lang)
                  {
                     case LanguageEnum.LANG_FR:
                        aTmp[0] = nDay + "/" + nMonth + "/" + nYear + " " + nHours + ":" + nMinutes;
                        break;
                     case LanguageEnum.LANG_EN:
                        aTmp[0] = nMonth + "/" + nDay + "/" + nYear + " " + nHours + ":" + nMinutes;
                        break;
                     default:
                        aTmp[0] = nMonth + "/" + nDay + "/" + nYear + " " + nHours + ":" + nMinutes;
                  }
                  break;
               case ActionIds.SMITHMAGIC_FORCE_PROBABILITY:
                  if(aTmp[0] == undefined && aTmp[1] == undefined && aTmp[2] > 0)
                  {
                     aTmp[0] = aTmp[2];
                     aTmp[2] = 0;
                  }
                  break;
               case ActionIds.ACTION_CHARACTER_GAIN_XP_WO_BOOST:
                  level = aTmp[1];
                  remainingXpPercentage = aTmp[2];
                  currentMapping = CharacterXPMapping.getCharacterXPMappingById(level);
                  nextMapping = CharacterXPMapping.getCharacterXPMappingById(level + 1);
                  if(currentMapping == null)
                  {
                     _log.log(LogLevel.WARN,"Xp Mapping is null for Level " + level);
                  }
                  else
                  {
                     currentLevelXP = currentMapping.experiencePoints;
                     nextLevelXP = 0;
                     if(nextMapping != null)
                     {
                        nextLevelXP = (nextMapping.experiencePoints - currentMapping.experiencePoints) * remainingXpPercentage / 100;
                     }
                     aTmp[0] = StringUtils.formateIntToString(currentLevelXP + nextLevelXP);
                  }
                  break;
               case ActionIds.ACTION_ITEM_CUSTOM_EFFECT:
                  for(i = 0; i < aTmp.length; i++)
                  {
                     aTmp[i] = aTmp[i] == null ? 0 : aTmp[i];
                  }
                  aTmp[0] = I18n.getUiText("ui.customEffect." + aTmp[2]);
                  aTmp[2] = null;
                  text = "";
                  switch(aTmp[1])
                  {
                     case 0:
                        text = aTmp[0].replace(aTmp[0],"<span class=\'bonus\'>" + aTmp[0]);
                        break;
                     case 1:
                        text = aTmp[0].replace(aTmp[0],"<span class=\'malus\'>" + aTmp[0]);
                        break;
                     case 2:
                        text = aTmp[0].replace(aTmp[0],"<span class=\'neutral\'>" + aTmp[0]);
                        break;
                     case 3:
                        text = aTmp[0].replace(aTmp[0],"<span class=\'exotic\'>" + aTmp[0]);
                  }
                  aTmp[1] = null;
                  aTmp[0] = text + "</span>";
                  break;
               case ActionIds.ACTION_FIGHT_ADD_PORTAL:
                  if(aTmp[2] == null)
                  {
                     aTmp[2] = 0;
                  }
                  break;
               case ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_SUMMONED_CREATURES:
               case ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT:
               case ActionIds.ACTION_CHARACTER_DEBOOST_MAXIMUM_WEIGHT:
               case ActionIds.ACTION_CHARACTER_BOOST_HEAL_BONUS:
               case ActionIds.ACTION_CHARACTER_DEBOOST_HEAL_BONUS:
               case ActionIds.ACTION_CHARACTER_BOOST_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_EARTH_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_EARTH_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_FIRE_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_FIRE_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_WATER_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_WATER_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_AIR_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_AIR_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_NEUTRAL_DAMAGES:
               case ActionIds.ACTION_CHARACTER_DEBOOST_NEUTRAL_DAMAGES:
               case ActionIds.ACTION_CHARACTER_BOOST_TRAP:
               case ActionIds.ACTION_CHARACTER_BOOST_CRITICAL_DAMAGES_BONUS:
               case ActionIds.ACTION_CHARACTER_DEBOOST_CRITICAL_DAMAGES_BONUS:
               case ActionIds.ACTION_CHARACTER_BOOST_PUSH_DAMAGE:
               case ActionIds.ACTION_CHARACTER_DEBOOST_PUSH_DAMAGE:
               case ActionIds.ACTION_CHARACTER_BOOST_EARTH_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_DEBOOST_EARTH_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_BOOST_FIRE_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_DEBOOST_FIRE_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_BOOST_AIR_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_DEBOOST_AIR_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_BOOST_WATER_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_DEBOOST_WATER_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_BOOST_NEUTRAL_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_DEBOOST_NEUTRAL_ELEMENT_RESIST:
               case ActionIds.ACTION_CHARACTER_BOOST_CRITICAL_DAMAGES_REDUCTION:
               case ActionIds.ACTION_CHARACTER_DEBOOST_CRITICAL_DAMAGES_REDUCTION:
               case ActionIds.ACTION_CHARACTER_BOOST_PUSH_DAMAGE_REDUCTION:
               case ActionIds.ACTION_CHARACTER_DEBOOST_PUSH_DAMAGE_REDUCTION:
                  aTmp[5] = "m";
                  aTmp[6] = aTmp[1] != null ? false : Math.abs(aTmp[0]) == 1;
                  aTmp[7] = aTmp[1] != null ? false : aTmp[0] == 0;
                  break;
               case ActionIds.ACTION_CHARACTER_LIMIT_STATS:
                  statName = this.getStatName(aTmp[1] as int);
                  aTmp[1] = aTmp[0];
                  aTmp[0] = statName;
            }
            if(forTooltip && aTmp)
            {
               if(spellModif && aTmp[2] != null)
               {
                  hasAddedSpanTag = true;
                  aTmp[2] += "</span>";
               }
               else if(aTmp[1] != null)
               {
                  hasAddedSpanTag = true;
                  aTmp[1] += "</span>";
               }
               else if(aTmp[0] != null)
               {
                  hasAddedSpanTag = true;
                  aTmp[0] += "</span>";
               }
            }
            sEffect = PatternDecoder.getDescription(desc,aTmp);
            if(sEffect == null || sEffect == "")
            {
               return "";
            }
         }
         else
         {
            if(short)
            {
               return "";
            }
            sEffect = desc;
         }
         if(forTooltip)
         {
            if(hasAddedSpanTag && sEffect.indexOf("</span>") != -1)
            {
               if(short)
               {
                  firstValue = desc.indexOf("#");
                  lastValue = desc.lastIndexOf("#");
                  if(firstValue != lastValue && firstValue >= 0 && lastValue >= 0)
                  {
                     sEffect = sEffect.substring(0,sEffect.indexOf("</span>"));
                  }
               }
               else if(spellModif)
               {
                  sEffect = sEffect.replace(aTmp[2],"<span class=\'#valueCssClass\'>" + aTmp[2]);
               }
               else
               {
                  sEffect = "<span class=\'#valueCssClass\'>" + sEffect;
               }
            }
            if(hasAddedSpanTag && sEffect.indexOf("%") != -1)
            {
               sEffect = sEffect.replace("%","<span class=\'#valueCssClass\'>%</span>");
            }
         }
         if(this.modificator != 0)
         {
            sEffect += " " + I18n.getUiText("ui.effect.boosted.spell.complement",[this.modificator],"%");
         }
         if(this.random > 0)
         {
            if(this.group > 0)
            {
               sEffect += " (" + I18n.getUiText("ui.common.random") + ")";
            }
            else
            {
               sEffect += " " + I18n.getUiText("ui.effect.randomProbability",[this.random],"%");
            }
         }
         return sEffect;
      }
   }
}

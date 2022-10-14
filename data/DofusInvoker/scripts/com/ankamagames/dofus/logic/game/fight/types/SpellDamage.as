package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import damageCalculation.damageManagement.DamageRange;
   import flash.utils.getQualifiedClassName;
   import tools.enumeration.ElementEnum;
   
   public class SpellDamage
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellDamage));
      
      public static const DAMAGE_TYPE_COUNT:int = 4;
      
      public static const LIFE_DAMAGES:int = 0;
      
      public static const SHIELD_DAMAGES:int = 1;
      
      public static const SHIELD_ADDED:int = 2;
      
      public static const LIFE_ADDED:int = 3;
      
      public static const CRITICAL_COUNT:int = 2;
      
      public static const NORMAL:int = 0;
      
      public static const CRITICAL:int = 1;
      
      public static const MIN_MAX_COUNT:int = 3;
      
      public static const MIN:int = 0;
      
      public static const MAX:int = 1;
      
      public static const HAS_ZERO:int = 2;
       
      
      private var _damageRanges:Vector.<DamageRange>;
      
      private var _randomGroupDamages:Vector.<SpellDamage>;
      
      private var group:int = 0;
      
      private var _damages:Array;
      
      private var _element:Array;
      
      public var invulnerableState:Boolean;
      
      public var unhealableState:Boolean;
      
      public var telefrag:Boolean = false;
      
      public var unknownDamage:Boolean = false;
      
      public var effectIcons:Array;
      
      public function SpellDamage()
      {
         this.effectIcons = [];
         super();
         this._damageRanges = new Vector.<DamageRange>();
         this._randomGroupDamages = new Vector.<SpellDamage>();
         this._damages = [[[0,0,0],[0,0,0]],[[0,0,0],[0,0,0]],[[0,0,0],[0,0,0]],[[0,0,0],[0,0,0]]];
         this._element = [0,0];
      }
      
      private static function getElementTextColor(pElementId:int) : String
      {
         var color:String = null;
         switch(pElementId)
         {
            case ElementEnum.ELEMENT_NEUTRAL:
               color = "fight.text.neutral";
               break;
            case ElementEnum.ELEMENT_EARTH:
               color = "fight.text.earth";
               break;
            case ElementEnum.ELEMENT_FIRE:
               color = "fight.text.fire";
               break;
            case ElementEnum.ELEMENT_WATER:
               color = "fight.text.water";
               break;
            case ElementEnum.ELEMENT_AIR:
               color = "fight.text.air";
               break;
            default:
               color = "fight.text.multi";
         }
         return XmlConfig.getInstance().getEntry("colors." + color);
      }
      
      private static function getRangeString(min:int, max:int, forceTrace:Boolean) : String
      {
         var range:String = "";
         if(forceTrace || min != 0 || max != 0)
         {
            if(min == max || max == 0)
            {
               range = String(min);
            }
            else
            {
               range = min + " - " + max;
            }
         }
         return range;
      }
      
      public function hasDamageType(damageType:int, critical:int) : Boolean
      {
         return this._damages[damageType][critical][MIN] != 0 || this._damages[damageType][critical][MAX] != 0;
      }
      
      public function hasDamage() : Boolean
      {
         return this._damageRanges.length > 0 || this._randomGroupDamages.length > 0;
      }
      
      public function reset() : void
      {
         var j:int = 0;
         var k:int = 0;
         for(var i:int = 0; i < DAMAGE_TYPE_COUNT; i++)
         {
            for(j = 0; j < CRITICAL_COUNT; j++)
            {
               for(k = 0; k < MIN_MAX_COUNT; k++)
               {
                  this._damages[i][j][k] = 0;
               }
               this._element[j] = ElementEnum.ELEMENT_NONE;
            }
         }
         this.invulnerableState = true;
         this.unhealableState = true;
      }
      
      public function updateDamageLine(damage:DamageRange, damageType:int, critical:int) : void
      {
         if(damage.isHeal)
         {
            this.unhealableState = false;
         }
         else
         {
            this.invulnerableState = false;
            if((this.hasDamageType(LIFE_DAMAGES,critical) || this.hasDamageType(SHIELD_DAMAGES,critical)) != damage.isZero())
            {
               if(this._element[critical] != ElementEnum.ELEMENT_UNDEFINED)
               {
                  if(this._element[critical] != ElementEnum.ELEMENT_NONE && damage.elemId != this._element[critical])
                  {
                     this._element[critical] = ElementEnum.ELEMENT_UNDEFINED;
                  }
                  else
                  {
                     this._element[critical] = damage.elemId;
                  }
               }
            }
            else if(!damage.isZero())
            {
               this._element[critical] = damage.elemId;
            }
         }
         if(damage.isZero())
         {
            ++this._damages[damageType][critical][HAS_ZERO];
         }
         else
         {
            this._damages[damageType][critical][MIN] += damage.min;
            this._damages[damageType][critical][MAX] += damage.max;
         }
      }
      
      public function updateDamage() : void
      {
         var damage:DamageRange = null;
         var randomGroup:SpellDamage = null;
         var damageType:int = 0;
         var critical:int = 0;
         this.reset();
         var hasInvulnerability:Boolean = false;
         var hasUnhealable:Boolean = false;
         for each(damage in this._damageRanges)
         {
            if(damage.isInvulnerable)
            {
               if(damage.isHeal)
               {
                  hasUnhealable = true;
               }
               else
               {
                  hasInvulnerability = true;
               }
            }
            else
            {
               if(damage.isCollision)
               {
                  damage.elemId = ElementEnum.ELEMENT_NEUTRAL;
               }
               damageType = !!damage.isHeal ? (!!damage.isShieldDamage ? int(SHIELD_ADDED) : int(LIFE_ADDED)) : (!!damage.isShieldDamage ? int(SHIELD_DAMAGES) : int(LIFE_DAMAGES));
               critical = !!damage.isCritical ? int(CRITICAL) : int(NORMAL);
               this.updateDamageLine(damage,damageType,critical);
            }
         }
         this.invulnerableState = this.invulnerableState && hasInvulnerability;
         this.unhealableState = this.unhealableState && hasUnhealable;
         for each(randomGroup in this._randomGroupDamages)
         {
            randomGroup.updateDamage();
            this.invulnerableState = this.invulnerableState && randomGroup.invulnerableState;
            this.unhealableState = this.unhealableState && randomGroup.unhealableState;
         }
      }
      
      public function addDamageRange(damageRange:DamageRange, pIndex:int = 2147483647) : void
      {
         var randomGroup:SpellDamage = null;
         var groupDamages:SpellDamage = null;
         if(damageRange.group != 0)
         {
            randomGroup = null;
            for each(groupDamages in this._randomGroupDamages)
            {
               if(groupDamages.group == damageRange.group)
               {
                  randomGroup = groupDamages;
                  break;
               }
            }
            if(randomGroup == null)
            {
               randomGroup = new SpellDamage();
               randomGroup.group = damageRange.group;
               randomGroup.effectIcons = this.effectIcons;
               this._randomGroupDamages.push(randomGroup);
            }
            randomGroup._damageRanges.splice(pIndex,0,damageRange);
         }
         else
         {
            this._damageRanges.splice(pIndex,0,damageRange);
         }
      }
      
      public function hasRandomEffects() : Boolean
      {
         return this._randomGroupDamages.length > 0;
      }
      
      public function get random() : int
      {
         if(this._damageRanges && this._damageRanges.length > 0)
         {
            return this._damageRanges[0].probability;
         }
         return -1;
      }
      
      public function printZero(forDamage:Boolean) : Boolean
      {
         var damageType:int = !!forDamage ? int(LIFE_DAMAGES) : int(LIFE_ADDED);
         var hasEffect:* = this._damages[damageType][NORMAL][HAS_ZERO] > 0;
         return Boolean(hasEffect || this._damages[damageType][CRITICAL][HAS_ZERO] > 0);
      }
      
      public function isZeroOnly(damageType:int, critical:int) : Boolean
      {
         return this._damages[damageType][critical][HAS_ZERO] > 0;
      }
      
      private function getEffectString(damageType:int, colorString:Boolean) : String
      {
         var effectStr:String = "";
         var normal:String = getRangeString(this._damages[damageType][NORMAL][MIN],this._damages[damageType][NORMAL][MAX],this.isZeroOnly(damageType,NORMAL));
         if(colorString)
         {
            effectStr = HtmlManager.addTag(normal,HtmlManager.SPAN,{"color":getElementTextColor(this._element[NORMAL])});
         }
         else
         {
            effectStr = normal;
         }
         var critical:String = getRangeString(this._damages[damageType][CRITICAL][MIN],this._damages[damageType][CRITICAL][MAX],this.isZeroOnly(damageType,CRITICAL));
         if(critical != "")
         {
            if(colorString)
            {
               effectStr += " (" + HtmlManager.addTag(critical,HtmlManager.SPAN,{"color":getElementTextColor(this._element[CRITICAL])}) + ")";
            }
            else
            {
               effectStr += " (" + critical + ")";
            }
         }
         return effectStr;
      }
      
      public function writeLineString(damageType:int, icon:String, colorString:Boolean) : String
      {
         var shieldAddedStr:* = null;
         if(this.hasDamageType(damageType,NORMAL) || this.hasDamageType(damageType,CRITICAL))
         {
            shieldAddedStr = this.getEffectString(damageType,colorString);
            if(this.unknownDamage)
            {
               shieldAddedStr += HtmlManager.addTag(" (+ ?)",HtmlManager.SPAN,{"color":getElementTextColor(ElementEnum.ELEMENT_MULTI)});
            }
            if(shieldAddedStr != "")
            {
               this.effectIcons.push(icon);
               shieldAddedStr += "\n";
            }
            return shieldAddedStr;
         }
         return "";
      }
      
      public function toString() : String
      {
         var invulnerableStateData:SpellState = null;
         var invulnerableStr:String = null;
         var i:int = 0;
         var randomGroup:SpellDamage = null;
         var finalStr:* = this.random > 0 ? this.random + "% " : "";
         if(this.invulnerableState)
         {
            this.effectIcons.push(null);
            invulnerableStateData = SpellState.getSpellStateById(DataEnum.SPELL_STATE_INVULNERABLE);
            invulnerableStr = !!invulnerableStateData ? invulnerableStateData.name : I18n.getUiText("ui.prism.state0");
            finalStr += invulnerableStr + "\n";
         }
         else
         {
            finalStr += this.writeLineString(SHIELD_DAMAGES,"broken_armor",true);
            finalStr += this.writeLineString(LIFE_DAMAGES,null,true);
            if(!this.hasDamageType(LIFE_DAMAGES,NORMAL) && !this.hasDamageType(LIFE_DAMAGES,CRITICAL) && this.printZero(true))
            {
               this.effectIcons.push(null);
               finalStr += HtmlManager.addTag("0",HtmlManager.SPAN,{"color":getElementTextColor(this._element[NORMAL])}) + "\n";
            }
         }
         finalStr += this.writeLineString(SHIELD_ADDED,"armor",false);
         if(this.unhealableState)
         {
            this.effectIcons.push(null);
            finalStr += SpellState.getSpellStateById(DataEnum.SPELL_STATE_UNHEALABLE).name;
         }
         else
         {
            finalStr += this.writeLineString(LIFE_ADDED,"pv",false);
            if(!this.hasDamageType(LIFE_ADDED,NORMAL) && !this.hasDamageType(LIFE_ADDED,CRITICAL) && this.printZero(false))
            {
               this.effectIcons.push("pv");
               finalStr += "0\n";
            }
         }
         if(this.hasRandomEffects())
         {
            for(i = 0; i < this._randomGroupDamages.length; i++)
            {
               randomGroup = this._randomGroupDamages[i];
               if(i > 0 || finalStr != "")
               {
                  this.effectIcons.push("common/window_separator_grey_horizontal");
                  finalStr += "\n";
               }
               finalStr += randomGroup.toString() + "\n";
            }
         }
         if(this.telefrag)
         {
            finalStr += SpellState.getSpellStateById(DataEnum.SPELL_STATE_TELEFRAG_ALLY).name;
         }
         else if(finalStr.charAt(finalStr.length - 1) == "\n")
         {
            finalStr = finalStr.substring(0,finalStr.length - 1);
         }
         return finalStr;
      }
   }
}

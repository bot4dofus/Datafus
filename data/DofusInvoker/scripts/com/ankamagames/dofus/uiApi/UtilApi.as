package com.ankamagames.dofus.uiApi
{
   import by.blooddy.crypto.serialization.JSON;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.EntitiesLooksManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.network.enums.BoostableCharacteristicEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.globalization.Collator;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLNode;
   import tools.ActionIdHelper;
   import tools.enumeration.ElementEnum;
   
   [InstanciedApi]
   public class UtilApi implements IApi
   {
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      private var _stringSorter:Collator;
      
      private var _triggeredSpells:Dictionary;
      
      public function UtilApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(UtilApi));
         this._triggeredSpells = new Dictionary(true);
         super();
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function callWithParameters(method:Function, parameters:Array) : void
      {
         CallWithParameters.call(method,parameters);
      }
      
      public function callConstructorWithParameters(callClass:Class, parameters:Array) : *
      {
         return CallWithParameters.callConstructor(callClass,parameters);
      }
      
      public function callRWithParameters(method:Function, parameters:Array) : *
      {
         return CallWithParameters.callR(method,parameters);
      }
      
      public function kamasToString(kamas:Number, unit:String = "-") : String
      {
         return StringUtils.kamasToString(kamas,unit);
      }
      
      public function formateIntToString(val:Number, precision:int = 2) : String
      {
         return StringUtils.formateIntToString(val,precision);
      }
      
      public function stringToKamas(string:String, unit:String = "-") : Number
      {
         return StringUtils.stringToKamas(string,unit);
      }
      
      public function getTextWithParams(textId:int, params:Array, replace:String = "%") : String
      {
         var msgContent:String = I18n.getText(textId);
         if(msgContent)
         {
            return ParamsDecoder.applyParams(msgContent,params,replace);
         }
         return "";
      }
      
      public function applyTextParams(pText:String, pParams:Array, pReplace:String = "%") : String
      {
         return ParamsDecoder.applyParams(pText,pParams,pReplace);
      }
      
      public function noAccent(str:String) : String
      {
         return StringUtils.noAccent(str);
      }
      
      public function getAllIndexOf(pStringLookFor:String, pWholeString:String) : Array
      {
         return StringUtils.getAllIndexOf(pStringLookFor,pWholeString);
      }
      
      public function changeColor(obj:Object, color:Number, depth:int, unColor:Boolean = false) : void
      {
         var t0:ColorTransform = null;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         var t:ColorTransform = null;
         if(obj != null)
         {
            if(unColor)
            {
               t0 = new ColorTransform(1,1,1,1,0,0,0);
               if(obj is Texture)
               {
                  Texture(obj).colorTransform = t0;
               }
               else if(obj is DisplayObject)
               {
                  DisplayObject(obj).transform.colorTransform = t0;
               }
            }
            else
            {
               R = color >> 16 & 255;
               V = color >> 8 & 255;
               B = color >> 0 & 255;
               t = new ColorTransform(0,0,0,1,R,V,B);
               if(obj is Texture)
               {
                  Texture(obj).colorTransform = t;
               }
               else if(obj is DisplayObject)
               {
                  DisplayObject(obj).transform.colorTransform = t;
               }
            }
         }
      }
      
      public function sortOnString(list:*, field:String = "", ascending:Boolean = true) : void
      {
         if(!(list is Array) && !(list is Vector.<*>))
         {
            this._log.error("Tried to sort something different than an Array or a Vector!");
            return;
         }
         if(!this._stringSorter)
         {
            this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
         }
         if(field)
         {
            list.sort(function(a:*, b:*):int
            {
               var result:int = _stringSorter.compare(a[field],b[field]);
               return !!ascending ? int(result) : int(result * -1);
            });
         }
         else
         {
            list.sort(this._stringSorter.compare);
         }
      }
      
      public function sort(target:*, field:String, ascendand:Boolean = true, isNumeric:Boolean = false) : *
      {
         var result:* = undefined;
         var sup:int = 0;
         var inf:int = 0;
         if(target is Array)
         {
            result = (target as Array).concat();
            result.sortOn(field,(!!ascendand ? 0 : Array.DESCENDING) | (!!isNumeric ? Array.NUMERIC : Array.CASEINSENSITIVE));
            return result;
         }
         if(target is Vector.<*>)
         {
            result = target.concat();
            sup = !!ascendand ? 1 : -1;
            inf = !!ascendand ? -1 : 1;
            if(isNumeric)
            {
               result.sort(function(a:*, b:*):int
               {
                  if(a[field] > b[field])
                  {
                     return sup;
                  }
                  if(a[field] < b[field])
                  {
                     return inf;
                  }
                  return 0;
               });
            }
            else
            {
               result.sort(function(a:*, b:*):int
               {
                  var astr:String = a[field].toLocaleLowerCase();
                  var bstr:String = b[field].toLocaleLowerCase();
                  if(astr > bstr)
                  {
                     return sup;
                  }
                  if(astr < bstr)
                  {
                     return inf;
                  }
                  return 0;
               });
            }
            return result;
         }
         return null;
      }
      
      public function filter(target:*, pattern:*, field:String) : *
      {
         var searchFor:String = null;
         var targetField:String = null;
         if(!target)
         {
            return null;
         }
         var result:* = new (target.constructor as Class)();
         var len:uint = target.length;
         var i:uint = 0;
         if(pattern is String)
         {
            searchFor = String(pattern).toLowerCase();
            for(searchFor = StringUtils.noAccent(searchFor); i < len; )
            {
               targetField = String(target[i][field]).toLowerCase();
               targetField = StringUtils.noAccent(targetField);
               if(targetField.indexOf(searchFor) != -1)
               {
                  result.push(target[i]);
               }
               i++;
            }
         }
         else
         {
            while(i < len)
            {
               if(target[i][field] == pattern)
               {
                  result.push(target[i]);
               }
               i++;
            }
         }
         return result;
      }
      
      public function getTiphonEntityLook(pEntityId:Number) : TiphonEntityLook
      {
         return EntitiesLooksManager.getInstance().getTiphonEntityLook(pEntityId);
      }
      
      public function getRealTiphonEntityLook(pEntityId:Number, pWithoutMount:Boolean = false) : TiphonEntityLook
      {
         return EntitiesLooksManager.getInstance().getRealTiphonEntityLook(pEntityId,pWithoutMount);
      }
      
      public function getLookFromContext(pEntityId:Number, pForceCreature:Boolean = false) : TiphonEntityLook
      {
         return EntitiesLooksManager.getInstance().getLookFromContext(pEntityId,pForceCreature);
      }
      
      public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean = false) : TiphonEntityLook
      {
         return EntitiesLooksManager.getInstance().getLookFromContextInfos(pInfos,pForceCreature);
      }
      
      public function isCreature(pEntityId:Number) : Boolean
      {
         return EntitiesLooksManager.getInstance().isCreature(pEntityId);
      }
      
      public function isCreatureFromLook(pLook:TiphonEntityLook) : Boolean
      {
         return EntitiesLooksManager.getInstance().isCreatureFromLook(pLook);
      }
      
      public function isIncarnation(pEntityId:Number) : Boolean
      {
         return EntitiesLooksManager.getInstance().isIncarnation(pEntityId);
      }
      
      public function isIncarnationFromLook(pLook:TiphonEntityLook) : Boolean
      {
         return EntitiesLooksManager.getInstance().isIncarnationFromLook(pLook);
      }
      
      public function isCreatureMode() : Boolean
      {
         return EntitiesLooksManager.getInstance().isCreatureMode();
      }
      
      public function getCreatureLook(pEntityId:Number) : TiphonEntityLook
      {
         return EntitiesLooksManager.getInstance().getCreatureLook(pEntityId);
      }
      
      public function getGfxUri(pGfxId:int) : String
      {
         return Atouin.getInstance().options.getOption("elementsPath") + "/" + Atouin.getInstance().options.getOption("pngSubPath") + "/" + pGfxId + "." + Atouin.getInstance().options.getOption("mapPictoExtension");
      }
      
      public function encodeToJson(value:*) : String
      {
         return by.blooddy.crypto.serialization.JSON.encode(value);
      }
      
      public function decodeJson(value:String) : *
      {
         return by.blooddy.crypto.serialization.JSON.decode(value);
      }
      
      public function getObjectsUnderPoint() : Array
      {
         return StageShareManager.stage.getObjectsUnderPoint(PoolsManager.getInstance().getPointPool().checkOut()["renew"](StageShareManager.mouseX,StageShareManager.mouseY));
      }
      
      public function isCharacteristicSpell(pSpellWrapper:SpellWrapper, pCharacteristicId:int, pRecursive:Boolean = false) : Boolean
      {
         var effect:EffectInstance = null;
         var triggeredSpell:SpellWrapper = null;
         var spellId:* = undefined;
         var characteristicTriggeredSpell:Boolean = false;
         var result:* = false;
         if(!pRecursive)
         {
            for(spellId in this._triggeredSpells)
            {
               delete this._triggeredSpells[spellId];
            }
         }
         for each(effect in pSpellWrapper.effects)
         {
            if(effect != null)
            {
               if(pSpellWrapper.typeId != DataEnum.SPELL_TYPE_TEST && pSpellWrapper.id != DataEnum.SPELL_SRAM_TRAPS && (effect.effectId != ActionIds.ACTION_FIGHT_LIFE_POINTS_WIN_PERCENT && (ActionIdHelper.isBasedOnTargetLife(effect.effectId) || effect.effectId == ActionIds.ACTION_CHARACTER_LIFE_POINTS_MALUS_PERCENT)))
               {
                  if(effect.effectId == ActionIds.ACTION_CASTER_EXECUTE_SPELL || effect.effectId == ActionIds.ACTION_TARGET_EXECUTE_SPELL && effect.targetMask && effect.targetMask.indexOf("C") != -1 || effect.effectId == ActionIds.ACTION_TARGET_EXECUTE_SPELL_WITH_ANIMATION || effect.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL)
                  {
                     triggeredSpell = SpellWrapper.create(effect.parameter0 as uint,effect.parameter1 as int);
                     if(triggeredSpell != null)
                     {
                        if(!this._triggeredSpells[triggeredSpell.spellId] && triggeredSpell.spellId != pSpellWrapper.spellId)
                        {
                           this._triggeredSpells[triggeredSpell.spellId] = true;
                           characteristicTriggeredSpell = this.isCharacteristicSpell(triggeredSpell,pCharacteristicId,true);
                           if(characteristicTriggeredSpell)
                           {
                              return true;
                           }
                        }
                        else
                        {
                           delete this._triggeredSpells[triggeredSpell.spellId];
                        }
                     }
                  }
                  else
                  {
                     if(pCharacteristicId == BoostableCharacteristicEnum.BOOSTABLE_CHARAC_VITALITY && (effect.effectId == ActionIds.ACTION_CHARACTER_DISPATCH_LIFE_POINTS_PERCENT || DamageUtil.HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(effect.effectId) != -1))
                     {
                        return true;
                     }
                     if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effect.effectId) != -1 && (effect.effectId != ActionIds.ACTION_CHARACTER_DISPATCH_LIFE_POINTS_PERCENT && pCharacteristicId == BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE))
                     {
                        return true;
                     }
                     if(DamageUtil.HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(effect.effectId) == -1 && ActionIdHelper.isBasedOnCasterLifeMissingMaxLife(effect.effectId) && DamageUtil.HEALING_EFFECTS_IDS.indexOf(effect.effectId) == -1 && effect.category == DataEnum.ACTION_TYPE_DAMAGES)
                     {
                        result = false;
                        switch(pCharacteristicId)
                        {
                           case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_STRENGTH:
                              result = Boolean(effect.effectElement == ElementEnum.ELEMENT_NEUTRAL || effect.effectElement == ElementEnum.ELEMENT_EARTH);
                              break;
                           case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_INTELLIGENCE:
                              result = effect.effectElement == ElementEnum.ELEMENT_FIRE;
                              break;
                           case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_CHANCE:
                              result = effect.effectElement == ElementEnum.ELEMENT_WATER;
                              break;
                           case BoostableCharacteristicEnum.BOOSTABLE_CHARAC_AGILITY:
                              result = effect.effectElement == ElementEnum.ELEMENT_AIR;
                        }
                        if(result)
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
      
      public function escapeHTMLDOM(firstNode:XMLNode) : String
      {
         return StringUtils.escapeHTMLDOM(firstNode);
      }
      
      public function sanitizeText(text:String) : String
      {
         return StringUtils.sanitizeText(text);
      }
   }
}

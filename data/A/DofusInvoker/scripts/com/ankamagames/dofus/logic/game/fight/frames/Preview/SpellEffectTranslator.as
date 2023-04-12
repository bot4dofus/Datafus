package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import flash.utils.Dictionary;
   import tools.ActionIdHelper;
   
   public class SpellEffectTranslator extends HaxeSpellEffect
   {
      
      private static var _cache:Dictionary = new Dictionary(true);
       
      
      public function SpellEffectTranslator(id:uint, level:int, order:int, actionId:int, param1:int, param2:int, param3:int, duration:int, isCritical:Boolean, trigger:String, rawZone:String, mask:String, randomWeight:int, randomGroup:int, isDispellable:Boolean, delay:int, category:int)
      {
         super(id,level,order,actionId,param1,param2,param3,duration,isCritical,trigger,rawZone,mask,randomWeight,randomGroup,isDispellable,delay,category);
         if(id != 0)
         {
            _cache[getCacheKey(id,actionId)] = this;
         }
      }
      
      public static function fromSpell(effect:EffectInstance, level:int, isCritical:Boolean) : SpellEffectTranslator
      {
         var cacheKey:String = getCacheKey(effect.effectUid,effect.effectId);
         if(effect.effectUid != 0 && _cache[cacheKey])
         {
            return _cache[cacheKey];
         }
         return new SpellEffectTranslator(effect.effectUid,level,effect.order,effect.effectId,effect.parameter0 as int,effect.parameter1 as int,effect.parameter2 as int,effect.duration,isCritical,effect.triggers || "I",effect.rawZone || "P",effect.targetMask || "A,a",effect.random,effect.group,effect.dispellable == EffectInstance.IS_DISPELLABLE,effect.delay,effect.category);
      }
      
      public static function clearCache() : void
      {
         _cache = new Dictionary(true);
      }
      
      public static function fromBuff(buff:BasicBuff, level:int) : SpellEffectTranslator
      {
         return new SpellEffectTranslator(buff.effect.effectUid,level,buff.effect.order,buff.effect.effectId,buff.param1 as int,buff.param2 as int,buff.param3 as int,buff.effect.duration,false,!!buff.effect.trigger ? buff.effect.triggers : "I",buff.effect.rawZone || "P",buff.effect.targetMask || "A,a",buff.effect.random,buff.effect.group,buff.effect.dispellable == EffectInstance.IS_DISPELLABLE,buff.effect.delay,buff.effect.category);
      }
      
      public static function fromWeapon(effect:EffectInstance, weapon:WeaponWrapper, isCritical:Boolean) : SpellEffectTranslator
      {
         var zone:* = effect.rawZone;
         var mask:String = "A,g";
         var param0:int = effect.parameter0 as int;
         var param1:int = effect.parameter1 as int;
         var param2:int = effect.parameter2 as int;
         if(param0 > 0 && param1 == 0)
         {
            param1 = param0;
         }
         if(effect.zoneShape == 0)
         {
            zone = "P1,";
         }
         else
         {
            zone = String.fromCharCode(effect.zoneShape) + (effect.zoneSize || 1).toString() + ",";
         }
         if(weapon != null)
         {
            if(weapon.type.id == DataEnum.ITEM_TYPE_HAMMER)
            {
               zone += (effect.zoneMinSize || 0).toString() + ",";
            }
            zone += (effect.zoneEfficiencyPercent || 25).toString() + "," + (effect.zoneMaxEfficiency || 1).toString();
            if(isCritical && ActionIdHelper.isDamage(effect.category,effect.effectId))
            {
               param0 += weapon.criticalHitBonus;
               param1 += weapon.criticalHitBonus;
            }
         }
         return new SpellEffectTranslator(DamagePreview.WEAPON_EFFECTS_INDEX++,1,effect.order,effect.effectId,param0,param1,param2,effect.duration,isCritical,effect.triggers || "I",zone,mask,effect.random,effect.group,effect.dispellable == EffectInstance.IS_DISPELLABLE,effect.delay,effect.category);
      }
      
      private static function getCacheKey(id:uint, actionId:int) : String
      {
         return id + "|" + actionId;
      }
      
      override public function getMinRoll() : int
      {
         if(param1 == 0 && param2 == 0)
         {
            return param3;
         }
         return param1;
      }
      
      override public function getMaxRoll() : int
      {
         return param2 != 0 ? int(param2) : int(this.getMinRoll());
      }
   }
}

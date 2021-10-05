package damageCalculation.damageManagement
{
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.tools.Interval;
   import haxe.ds._List.ListNode;
   import tools.ActionIdHelper;
   import tools.enumeration.ElementEnum;
   
   public class DamageSender
   {
      
      public static var MIDLIFE_DAMAGE_PERCENT:Array = _loc1_;
       
      
      public function DamageSender()
      {
      }
      
      public static function getTotalDamage(param1:FightContext, param2:RunningEffect, param3:Boolean = false) : DamageRange
      {
         var _loc7_:int = 0;
         var _loc4_:HaxeFighter = param2.getCaster();
         var _loc5_:HaxeSpellEffect = param2.getSpellEffect();
         var _loc6_:DamageRange = DamageRange.fromSpellEffect(_loc5_,param3);
         if(_loc6_.elemId == 6)
         {
            _loc6_.elemId = int(_loc4_.getBestElement());
         }
         if(param2.getCaster().isUnlucky())
         {
            _loc6_.maximizeBy(_loc6_.min);
         }
         _loc6_.add(int(_loc4_.data.getItemSpellBaseDamageModification(param2.getSpell().id)));
         if(ActionIdHelper.isBasedOnCasterLife(_loc5_.actionId))
         {
            _loc6_ = DamageSender.getDamageBasedOnCasterLife(param2,_loc6_);
         }
         if(ActionIdHelper.isSplash(_loc5_.actionId))
         {
            _loc6_ = DamageSender.getSplashDamage(param2,_loc6_);
         }
         if(ActionIdHelper.isBoostable(_loc5_.actionId))
         {
            _loc6_ = DamageSender.getBoostableDamage(param2,_loc6_);
         }
         if(ActionIdHelper.isBasedOnMovementPoints(_loc5_.actionId))
         {
            if(int(_loc4_.data.getCharacteristicValue(23)) <= 0)
            {
               _loc6_.setToZero();
            }
            else
            {
               _loc7_ = _loc4_.data.getCharacteristicValue(23);
               _loc6_.multiply(_loc7_ / (_loc7_ + int(_loc4_.data.getUsedPM())));
            }
         }
         _loc6_.add(int(_loc4_.data.getItemSpellDamageModification(param2.getSpell().id)));
         _loc6_.isHeal = Boolean(ActionIdHelper.isHeal(_loc5_.actionId));
         return _loc6_;
      }
      
      public static function getTotalShield(param1:RunningEffect, param2:Boolean = false) : DamageRange
      {
         var _loc7_:* = null as Interval;
         var _loc8_:* = null as Interval;
         var _loc3_:HaxeFighter = param1.getCaster();
         var _loc4_:HaxeSpellEffect = param1.getSpellEffect();
         var _loc5_:DamageRange = new DamageRange(0,0);
         _loc5_.isHeal = true;
         _loc5_.isShieldDamage = true;
         _loc5_.isCritical = param1.getSpellEffect().isCritical;
         var _loc6_:int = _loc4_.actionId;
         if(_loc6_ == 1040)
         {
            _loc5_.addInterval(_loc4_.getDamageInterval());
         }
         else if(_loc6_ == 1039)
         {
            _loc7_ = _loc4_.getDamageInterval();
            _loc8_ = new Interval(int(_loc3_.data.getMaxHealthPoints()),int(_loc3_.data.getMaxHealthPoints()));
            _loc5_.addInterval(_loc8_);
            _loc5_.multiplyInterval(_loc7_).multiply(0.01);
         }
         else if(_loc6_ == 1020)
         {
            _loc7_ = _loc4_.getDamageInterval();
            _loc8_ = new Interval(_loc3_.level,_loc3_.level).multiplyInterval(_loc7_);
            _loc8_.min = int(Math.round(_loc8_.min * 0.01));
            _loc8_.max = int(Math.round(_loc8_.max * 0.01));
            _loc5_.addInterval(_loc8_);
         }
         return _loc5_;
      }
      
      public static function getDamageBasedOnCasterLife(param1:RunningEffect, param2:DamageRange) : DamageRange
      {
         var _loc5_:* = null as Interval;
         var _loc6_:int = 0;
         var _loc7_:* = null as Interval;
         var _loc3_:HaxeFighter = param1.getCaster();
         var _loc4_:HaxeSpellEffect = param1.getSpellEffect();
         if(ActionIdHelper.isBasedOnCasterLifePercent(_loc4_.actionId))
         {
            _loc5_ = _loc3_.getPendingLifePoints();
            param2.multiplyInterval(_loc5_);
            param2.multiply(0.01);
         }
         else if(ActionIdHelper.isBasedOnCasterLifeMissing(_loc4_.actionId))
         {
            _loc5_ = _loc3_.getPendingMissingLifePoints();
            param2.multiplyInterval(_loc5_);
            param2.multiply(0.01);
         }
         else if(ActionIdHelper.isBasedOnCasterLifeMissingMaxLife(_loc4_.actionId))
         {
            _loc6_ = _loc3_.data.getCharacteristicValue(102);
            if(_loc6_ >= 0)
            {
               param2.multiply(_loc6_ / 100);
            }
         }
         else if(ActionIdHelper.isBasedOnCasterLifeMidlife(_loc4_.actionId))
         {
            _loc5_ = _loc3_.getPendingLifePoints();
            _loc7_ = new Interval(0,0);
            _loc7_.min = int(100 * _loc5_.min / int(_loc3_.data.getMaxHealthPoints()) - 50);
            _loc7_.max = int(100 * _loc5_.max / int(_loc3_.data.getMaxHealthPoints()) - 50);
            _loc7_.abs().minimizeBy(0).maximizeBy(50);
            param2.min *= int(_loc3_.data.getCharacteristicValue(0)) * DamageSender.MIDLIFE_DAMAGE_PERCENT[_loc7_.min] / 100;
            param2.max *= int(_loc3_.data.getCharacteristicValue(0)) * DamageSender.MIDLIFE_DAMAGE_PERCENT[_loc7_.max] / 100;
         }
         return param2;
      }
      
      public static function getSplashDamage(param1:RunningEffect, param2:DamageRange) : DamageRange
      {
         var _loc4_:* = null as HaxeFighter;
         var _loc5_:* = null as DamageRange;
         var _loc6_:* = null as ListNode;
         var _loc7_:* = null as EffectOutput;
         var _loc8_:* = null as EffectOutput;
         var _loc9_:* = null as DamageRange;
         var _loc3_:HaxeSpellEffect = param1.getSpellEffect();
         if(ActionIdHelper.isSplash(_loc3_.actionId))
         {
            _loc4_ = param1.getCaster();
            _loc5_ = DamageRange.ZERO;
            if(ActionIdHelper.isSplashFinalDamage(_loc3_.actionId) || ActionIdHelper.isSplashHeal(_loc3_.actionId))
            {
               _loc6_ = _loc4_.pendingEffects.h;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.item;
                  _loc6_ = _loc6_.next;
                  _loc8_ = _loc7_;
                  _loc9_ = _loc8_.damageRange;
                  if(_loc9_ != null && !_loc9_.isHeal && !_loc9_.isInvulnerable && !_loc9_.isCollision && !(_loc9_.min == 0 && _loc9_.max == 0))
                  {
                     _loc5_ = _loc9_;
                  }
               }
            }
            else if(!!ActionIdHelper.isSplashRawDamage(_loc3_.actionId) && _loc4_.lastRawDamageTaken != null && _loc4_.lastTheoreticalRawDamageTaken != null)
            {
               if(_loc4_.hasStateEffect(6))
               {
                  _loc5_ = _loc4_.lastRawDamageTaken;
               }
               else
               {
                  _loc5_ = _loc4_.lastTheoreticalRawDamageTaken;
               }
            }
            _loc5_ = _loc5_.copy();
            _loc5_.multiplyInterval(_loc3_.getDamageInterval());
            _loc5_.multiply(0.01);
            param2.min = _loc5_.min;
            param2.max = _loc5_.max;
            param2.elemId = _loc5_.elemId;
            if(_loc3_.actionId == 1223)
            {
               param1.getSpellEffect().actionId = int(ActionIdHelper.getSplashFinalTakenDamageElement(param2.elemId));
            }
            else if(_loc3_.actionId == 1123)
            {
               param1.getSpellEffect().actionId = int(ActionIdHelper.getSplashRawTakenDamageElement(param2.elemId));
            }
         }
         return param2;
      }
      
      public static function getBoostableDamage(param1:RunningEffect, param2:DamageRange) : DamageRange
      {
         param2.add(int(DamageSender.baseDamageBonus(param1)));
         param2.multiply(Number(DamageSender.applyDamageBonus(param1)));
         param2.add(int(DamageSender.flatDamageBonus(param1)));
         if(param1.getSpell().isWeapon)
         {
            param2.multiply((100 + int(param1.getCaster().data.getCharacteristicValue(31))) * 0.01);
         }
         param2.multiply(Number(DamageSender.bombComboBonus(param1)));
         return param2;
      }
      
      public static function flatDamageBonus(param1:RunningEffect) : int
      {
         var _loc2_:HaxeFighter = param1.getCaster();
         var _loc3_:HaxeSpellEffect = param1.getSpellEffect();
         var _loc4_:HaxeSpell = param1.getSpell();
         var _loc5_:* = (!!ActionIdHelper.isHeal(_loc3_.actionId) ? int(_loc2_.data.getCharacteristicValue(49)) : int(_loc2_.data.getCharacteristicValue(16))) + (!!_loc4_.isTrap ? int(_loc2_.data.getCharacteristicValue(70)) : 0);
         if(!ActionIdHelper.isHeal(_loc3_.actionId))
         {
            _loc5_ += int(_loc2_.getElementFlatDamageBonus(int(ElementEnum.getElementFromActionId(_loc3_.actionId)))) + (!!_loc3_.isCritical && int(param1.getSpell().getEffects().indexOf(_loc3_)) == -1 ? int(_loc2_.data.getCharacteristicValue(86)) : 0);
         }
         return _loc5_;
      }
      
      public static function baseDamageBonus(param1:RunningEffect) : int
      {
         return int(param1.getCaster().getSpellBaseDamageModification(param1.getSpell().id));
      }
      
      public static function getDamageBonus(param1:RunningEffect) : Number
      {
         var _loc2_:HaxeFighter = param1.getCaster();
         var _loc3_:HaxeSpellEffect = param1.getSpellEffect();
         var _loc4_:HaxeSpell = param1.getSpell();
         var _loc5_:int = ElementEnum.getElementFromActionId(_loc3_.actionId);
         if(_loc5_ == 6)
         {
            _loc5_ = _loc2_.getBestElement();
         }
         var _loc6_:* = (!!ActionIdHelper.isHeal(_loc3_.actionId) ? 0 : int(_loc2_.data.getCharacteristicValue(25))) + (!!_loc4_.isTrap ? int(_loc2_.data.getCharacteristicValue(69)) : 0) + (!!_loc4_.isGlyph ? int(_loc2_.data.getCharacteristicValue(106)) : 0) + (!!_loc4_.isRune ? int(_loc2_.data.getCharacteristicValue(110)) : 0) + (!!_loc4_.isWeapon ? int(_loc2_.data.getCharacteristicValue(103)) : int(_loc2_.data.getCharacteristicValue(98)) + int(_loc2_.getSpellDamageModification(param1.getSpell().id))) + int(_loc2_.getElementMainStat(_loc5_));
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         return _loc6_;
      }
      
      public static function applyDamageBonus(param1:RunningEffect) : Number
      {
         return (100 + Number(DamageSender.getDamageBonus(param1))) * 0.01;
      }
      
      public static function bombComboBonus(param1:RunningEffect) : Number
      {
         return Number(1 + int(param1.getCaster().data.getCharacteristicValue(94)) / 100);
      }
   }
}

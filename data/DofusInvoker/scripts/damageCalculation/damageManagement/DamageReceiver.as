package damageCalculation.damageManagement
{
   import damageCalculation.FightContext;
   import damageCalculation.fighterManagement.HaxeBuff;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.RunningEffect;
   import damageCalculation.tools.Interval;
   import damageCalculation.tools.LinkedListNode;
   import mapTools.MapTools;
   import tools.ActionIdHelper;
   import tools.FpUtils;
   
   public class DamageReceiver
   {
      
      public static var LIFE_STEAL_MULTIPLICATOR:Number = 0.5;
       
      
      public function DamageReceiver()
      {
      }
      
      public static function receiveDamageOrHeal(param1:FightContext, param2:RunningEffect, param3:DamageRange, param4:HaxeFighter, param5:Boolean = false, param6:Boolean = false) : Array
      {
         var _loc9_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as DamageRange;
         var _loc13_:int = 0;
         var _loc14_:* = null as EffectOutput;
         var _loc15_:* = false;
         var _loc16_:* = null as DamageRange;
         var _loc7_:DamageRange = param3.copy();
         var _loc8_:Array = [];
         if(ActionIdHelper.isFakeDamage(param2.getSpellEffect().actionId))
         {
            _loc8_ = [EffectOutput.fromDamageRange(param4.id,_loc7_)];
         }
         else
         {
            if(param4.underMaximizeRollEffect())
            {
               _loc7_.minimizeBy(_loc7_.max);
            }
            _loc9_ = param4.getHealOnDamageRatio(param2,param5);
            if(_loc9_ > 0 && !_loc7_.isHeal && !param4.isInvulnerableTo(param2,param5,_loc7_.elemId))
            {
               _loc7_.isHeal = true;
               _loc7_.isShieldDamage = false;
               _loc7_.multiply(_loc9_ * 0.01);
            }
            _loc8_ = !!_loc7_.isHeal ? [DamageReceiver.executeLifePointsWin(_loc7_,param4)] : DamageReceiver.receiveDamage(param1,param2,_loc7_,param4,param5,param6);
         }
         var _loc10_:Array = FpUtils.arrayDistinct_damageCalculation_FighterId(FpUtils.arrayMap_damageCalculation_damageManagement_EffectOutput_damageCalculation_FighterId(_loc8_,function(param1:EffectOutput):Number
         {
            return param1.fighterId;
         }));
         _loc9_ = 0;
         while(_loc9_ < int(_loc10_.length))
         {
            _loc11_ = Number(_loc10_[_loc9_]);
            _loc9_++;
            _loc12_ = new DamageRange(0,0);
            _loc13_ = 0;
            while(_loc13_ < int(_loc8_.length))
            {
               _loc14_ = _loc8_[_loc13_];
               _loc13_++;
               if(_loc14_.fighterId == _loc11_ && _loc14_.damageRange != null && !_loc14_.damageRange.isInvulnerable)
               {
                  _loc16_ = _loc14_.damageRange;
                  _loc15_ = !(_loc16_.min == 0 && _loc16_.max == 0);
               }
               else
               {
                  _loc15_ = false;
               }
               if(!!_loc15_ && !_loc14_.damageRange.isShieldDamage)
               {
                  if(_loc14_.damageRange.isHeal)
                  {
                     _loc12_.subInterval(_loc14_.damageRange);
                  }
                  else
                  {
                     _loc12_.addInterval(_loc14_.computeLifeDamage());
                  }
               }
            }
            if(param1.getFighterById(_loc11_).getPendingLifePoints().max - _loc12_.min <= 0)
            {
               _loc8_ = _loc8_.concat([EffectOutput.deathOf(_loc11_)]);
            }
         }
         return _loc8_;
      }
      
      public static function receiveDamage(param1:FightContext, param2:RunningEffect, param3:DamageRange, param4:HaxeFighter, param5:Boolean = false, param6:Boolean = false) : Array
      {
         var _loc9_:* = null as DamageRange;
         var _loc10_:* = null as RunningEffect;
         var _loc11_:* = null as Array;
         var _loc13_:* = null as EffectOutput;
         var _loc7_:Array = [];
         var _loc8_:* = DamageReceiver.executeDodge(param1,param2,param4,param5,param6);
         if(_loc8_.done)
         {
            return _loc8_.damage;
         }
         if(!param3.isCollision)
         {
            param4.lastTheoreticalRawDamageTaken = param3.copy();
            if(!param2.getCaster().hasStateEffect(6))
            {
               param4.lastRawDamageTaken = param4.lastTheoreticalRawDamageTaken;
            }
            else
            {
               param3 = param4.lastRawDamageTaken = DamageRange.ZERO;
            }
            param3.add(-int(DamageReceiver.getFlatResistance(param2,param4,param3.elemId)));
            param3.subInterval(param4.getDamageReductor(param2,param3,param5));
            if(param3.max > 0 && param2.getSpell().canBeReflected && !param2.isReflect && param2.getCaster() != param4)
            {
               _loc9_ = DamageReceiver.reflectDamage(param1,param2,param3,param4);
               if(_loc9_ != null)
               {
                  _loc10_ = param2.copy();
                  _loc10_.isReflect = true;
                  _loc7_ = _loc7_.concat(DamageReceiver.receiveDamageOrHeal(param1,_loc10_,_loc9_,param2.getCaster(),param5));
               }
            }
            param3.multiply(1 - int(param4.getElementMainResist(param3.elemId)) / 100);
            param3.minimizeBy(0);
            _loc11_ = DamageReceiver.getSplitDamage(param1,param2,param3,param4,param6);
            if(_loc11_ != null)
            {
               return _loc7_.concat(_loc11_);
            }
         }
         var _loc12_:EffectOutput = DamageReceiver.applyDamage(param2,param4,param3,param5,param6);
         if(!!ActionIdHelper.isLifeSteal(param2.getSpellEffect().actionId) && param2.getCaster() != param4)
         {
            _loc13_ = DamageReceiver.getLifeStealEffect(_loc12_.computeLifeDamage(),param2.getCaster());
            if(_loc13_ != null)
            {
               _loc7_.push(_loc13_);
            }
         }
         if(!param3.isCollision)
         {
            _loc12_.fighterId = Number(DamageReceiver.changeTargetIfSacrifice(param1,param2,_loc12_,param4,param5));
         }
         _loc7_.push(_loc12_);
         return _loc7_;
      }
      
      public static function getPermanentDamage(param1:DamageRange, param2:HaxeFighter) : DamageRange
      {
         if(param1.isHeal)
         {
            return DamageRange.ZERO;
         }
         var _loc3_:Number = int(Math.floor(Number(Math.max(0,Number(Math.min(int(param2.data.getCharacteristicValue(75)),50)))))) / 100;
         var _loc4_:DamageRange = new DamageRange(int(Math.floor(param1.min * _loc3_)),int(Math.floor(param1.max * _loc3_)));
         var _loc5_:* = int(param2.data.getHealthPoints()) - 1;
         return new DamageRange(int(Math.floor(Number(Math.min(_loc4_.min,_loc5_)))),int(Math.floor(Number(Math.min(_loc4_.max,_loc5_)))));
      }
      
      public static function getDamageBasedOnTargetLife(param1:HaxeSpellEffect, param2:HaxeFighter, param3:DamageRange) : DamageRange
      {
         var _loc4_:* = null as Interval;
         if(ActionIdHelper.isBasedOnTargetMaxLife(param1.actionId))
         {
            param3.multiply(int(param2.data.getMaxHealthPoints()) / 100);
         }
         else if(ActionIdHelper.isBasedOnTargetLifePercent(param1.actionId))
         {
            _loc4_ = param2.getPendingLifePoints();
            param3.multiplyInterval(_loc4_);
            param3.multiply(0.01);
         }
         else if(ActionIdHelper.isBasedOnTargetLifeMissingMaxLife(param1.actionId))
         {
            param3.multiply(int(param2.data.getCharacteristicValue(75)) / 100);
         }
         return param3;
      }
      
      public static function changeTargetIfSacrifice(param1:FightContext, param2:RunningEffect, param3:EffectOutput, param4:HaxeFighter, param5:Boolean) : Number
      {
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as LinkedListNode;
         var _loc10_:* = null as LinkedListNode;
         var _loc11_:* = null as LinkedListNode;
         var _loc12_:* = null as HaxeBuff;
         var _loc13_:* = null as HaxeFighter;
         if(param2.getSpellEffect().actionId != 80 && !param4.isInvulnerableTo(param2,param5,param3.damageRange.elemId))
         {
            _loc6_ = param4.getAllSacrificed();
            _loc7_ = 0;
            while(_loc7_ < int(_loc6_.length))
            {
               _loc8_ = Number(_loc6_[_loc7_]);
               _loc7_++;
               _loc9_ = param4._buffs.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_;
                  _loc9_ = _loc9_.next;
                  _loc11_ = _loc10_;
                  _loc12_ = _loc11_.item;
                  if(_loc12_.effect.actionId == 765 && _loc12_.shouldBeTriggeredOnTarget(param3,param2,param4,param5,param1) && _loc12_.casterId == _loc8_)
                  {
                     _loc13_ = param1.getFighterById(_loc8_);
                     if(_loc13_ != null)
                     {
                        return _loc13_.id;
                     }
                  }
               }
            }
         }
         return param4.id;
      }
      
      public static function applyDamage(param1:RunningEffect, param2:HaxeFighter, param3:DamageRange, param4:Boolean, param5:Boolean) : EffectOutput
      {
         if(param2.isInvulnerableTo(param1,param4,param3.elemId))
         {
            param3.isInvulnerable = true;
         }
         param3.minimizeBy(0);
         param3 = DamageReceiver.applyDealtMultiplier(param1,param3,param2,param4);
         var _loc6_:EffectOutput = EffectOutput.fromDamageRange(param2.id,param3);
         if(!ActionIdHelper.isFakeDamage(param1.getSpellEffect().actionId))
         {
            _loc6_.shield = param2.getPendingShield();
         }
         return _loc6_;
      }
      
      public static function applyDealtMultiplier(param1:RunningEffect, param2:DamageRange, param3:HaxeFighter, param4:Boolean = false) : DamageRange
      {
         var _loc5_:HaxeFighter = param1.getCaster();
         if(ActionIdHelper.isBoostable(param1.getSpellEffect().actionId))
         {
            param2.multiply(int(_loc5_.getCurrentDealtDamageMultiplierCategory(param1.getSpell().isWeapon)) / 100);
            param2.multiply(int(_loc5_.getCurrentDealtDamageMultiplierMelee(param4)) / 100);
            param2.multiply(int(param3.getCurrentReceivedDamageMultiplierCategory(param1.getSpell().isWeapon)) / 100);
            param2.multiply(int(param3.getCurrentReceivedDamageMultiplierMelee(param4)) / 100);
            param2.multiply(int(_loc5_.data.getCharacteristicValue(107)) / 100);
         }
         param2.multiply(int(param3.getDamageMultiplicator(param1,param4,param2.isCollision)) / 100);
         return param2;
      }
      
      public static function reflectDamage(param1:FightContext, param2:RunningEffect, param3:DamageRange, param4:HaxeFighter) : DamageRange
      {
         var _loc9_:* = null as DamageRange;
         var _loc10_:int = 0;
         var _loc5_:HaxeSpellEffect = param2.getSpellEffect();
         var _loc6_:int = param4.data.getCharacteristicValue(50);
         var _loc7_:DamageRange = param4.getDynamicalDamageReflect();
         var _loc8_:DamageRange = new DamageRange(_loc6_,_loc6_);
         _loc8_.addInterval(_loc7_);
         if(!(_loc8_.min == 0 && _loc8_.max == 0))
         {
            _loc9_ = param3.copy();
            if(ActionIdHelper.isBoostable(_loc5_.actionId))
            {
               _loc10_ = param2.getCaster().data.getCharacteristicValue(107);
               _loc9_.multiply(Number(1 + (_loc10_ - 100) / 100));
            }
            _loc9_.maximizeByInterval(_loc8_);
            _loc10_ = param4.getElementMainResist(param3.elemId);
            _loc9_.maximizeByInterval(_loc9_.copy().multiply(1 - _loc10_ / 100));
            return _loc9_;
         }
         return null;
      }
      
      public static function getFlatResistance(param1:RunningEffect, param2:HaxeFighter, param3:int) : int
      {
         var _loc4_:HaxeSpellEffect = param1.getSpellEffect();
         var _loc5_:Boolean = param1.getSpellEffect().isCritical;
         var _loc6_:* = 0;
         if(!!_loc5_ && int(param1.getSpell().getEffects().indexOf(param1.getSpellEffect())) == -1)
         {
            _loc6_ += int(param2.data.getCharacteristicValue(87));
         }
         return _loc6_ + int(param2.getElementMainReduction(param3));
      }
      
      public static function getSplitDamage(param1:FightContext, param2:RunningEffect, param3:DamageRange, param4:HaxeFighter, param5:Boolean = false) : Array
      {
         var _loc10_:* = null as Array;
         var _loc11_:* = null as Function;
         var fightContext:FightContext = param1;
         var runningEffect:RunningEffect = param2;
         var target:HaxeFighter = param4;
         var isPreview:Boolean = param5;
         if(ActionIdHelper.isDrag(runningEffect.getSpellEffect().actionId) || runningEffect.isReflect)
         {
            return null;
         }
         var _loc6_:Function = function(param1:HaxeFighter):Boolean
         {
            return param1 != null;
         };
         var _loc7_:Array = target.getSharingDamageTargets(fightContext);
         if(int(_loc7_.length) == 0)
         {
            return null;
         }
         var _loc8_:Array = [];
         var _loc9_:int = 0;
         while(_loc9_ < int(_loc7_.length))
         {
            _loc10_ = _loc7_[_loc9_];
            _loc9_++;
            FpUtils.arrayFilter_damageCalculation_fighterManagement_HaxeFighter(_loc10_,_loc6_);
            if(int(_loc10_.length) != 0)
            {
               var splitDamage:Array = [param3.copy()];
               splitDamage[0].multiply(1 / (int(_loc10_.length) * int(_loc7_.length)));
               _loc11_ = function(param1:Array):Function
               {
                  var splitDamage1:Array = param1;
                  return function(param1:HaxeFighter):Array
                  {
                     var _loc3_:* = null;
                     var _loc2_:Boolean = MapTools.areCellsAdjacent(int(runningEffect.getCaster().getCurrentPositionCell()),int(param1.getCurrentPositionCell()));
                     if(param1 != target)
                     {
                        _loc3_ = DamageReceiver.executeDodge(fightContext,runningEffect,param1,_loc2_,isPreview);
                        if(_loc3_.done)
                        {
                           return _loc3_.damage;
                        }
                     }
                     var _loc4_:DamageRange = splitDamage1[0].copy();
                     return [DamageReceiver.applyDamage(runningEffect,param1,_loc4_,_loc2_,isPreview)];
                  };
               }(splitDamage);
               _loc8_ = _loc8_.concat(FpUtils.arrayFold_Array_damageCalculation_damageManagement_EffectOutput_Array_damageCalculation_damageManagement_EffectOutput(FpUtils.arrayMap_damageCalculation_fighterManagement_HaxeFighter_Array_damageCalculation_damageManagement_EffectOutput(_loc10_,_loc11_),function():Function
               {
                  return function(param1:Array, param2:Array):Array
                  {
                     return param2.concat(param1);
                  };
               }(),[]));
            }
         }
         return _loc8_;
      }
      
      public static function getLifeStealEffect(param1:DamageRange, param2:HaxeFighter) : EffectOutput
      {
         var _loc4_:* = null as EffectOutput;
         var _loc5_:* = null as DamageRange;
         var _loc3_:EffectOutput = null;
         if(!(param1.min == 0 && param1.max == 0) && !param1.isInvulnerable)
         {
            param1.multiply(0.5);
            _loc4_ = DamageReceiver.executeLifePointsWin(param1,param2);
            _loc5_ = _loc4_.damageRange;
            if(!(_loc5_.min == 0 && _loc5_.max == 0))
            {
               _loc3_ = _loc4_;
            }
         }
         return _loc3_;
      }
      
      public static function executeLifePointsWin(param1:DamageRange, param2:HaxeFighter) : EffectOutput
      {
         var _loc3_:* = null as Interval;
         param1.isHeal = true;
         if(param2.hasStateEffect(5))
         {
            param1.isInvulnerable = true;
         }
         else
         {
            _loc3_ = new Interval(int(param2.data.getMaxHealthPoints()),int(param2.data.getMaxHealthPoints())).subInterval(param2.getPendingLifePoints());
            param1.maximizeByInterval(_loc3_.minimizeBy(0));
            param1.minimizeBy(0);
         }
         return EffectOutput.fromDamageRange(param2.id,param1);
      }
      
      public static function executeDodge(param1:FightContext, param2:RunningEffect, param3:HaxeFighter, param4:Boolean = false, param5:Boolean = false) : Object
      {
         var _loc6_:int = 0;
         if(!param5 && param4 && param2.getCaster() != param3)
         {
            _loc6_ = param3.data.resolveDodge();
            if(_loc6_ != -1)
            {
               return {
                  "done":true,
                  "damage":PushUtils.push(param1,param2,param3,_loc6_,true,true,param5)
               };
            }
         }
         return {
            "done":false,
            "damage":[]
         };
      }
   }
}

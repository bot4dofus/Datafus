package damageCalculation.damageManagement
{
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.tools.Interval;
   
   public class EffectOutput
   {
       
      
      public var unknown:Boolean;
      
      public var throwedBy:Number;
      
      public var throughPortal:Boolean;
      
      public var summon:SummonInfos;
      
      public var shield:Interval;
      
      public var rangeLoss:int;
      
      public var rangeGain:int;
      
      public var newStateId:int;
      
      public var movement:MovementInfos;
      
      public var lostStateId:int;
      
      public var isSummoning:Boolean;
      
      public var isPushed:Boolean;
      
      public var isPulled:Boolean;
      
      public var isLifeAffected:Boolean;
      
      public var fighterId:Number;
      
      public var dispell:Boolean;
      
      public var death:Boolean;
      
      public var damageRange:DamageRange;
      
      public var carriedBy:Number;
      
      public var attemptedApTheft:Boolean;
      
      public var attemptedAmTheft:Boolean;
      
      public var areMaxLifePointsAffected:Boolean;
      
      public var areLifePointsAffected:Boolean;
      
      public var areErodedLifePointsAffected:Boolean;
      
      public var apStolen:int;
      
      public var amStolen:int;
      
      public function EffectOutput(param1:Number)
      {
         isSummoning = false;
         summon = null;
         unknown = false;
         carriedBy = 0;
         throwedBy = 0;
         death = false;
         dispell = false;
         lostStateId = -1;
         newStateId = -1;
         rangeGain = 0;
         rangeLoss = 0;
         amStolen = 0;
         apStolen = 0;
         attemptedAmTheft = false;
         attemptedApTheft = false;
         throughPortal = false;
         isPulled = false;
         isPushed = false;
         movement = null;
         shield = null;
         damageRange = null;
         fighterId = param1;
      }
      
      public static function fromMovement(param1:Number, param2:int, param3:int, param4:HaxeFighter = undefined) : EffectOutput
      {
         var _loc5_:EffectOutput = new EffectOutput(param1);
         _loc5_.movement = new MovementInfos(param2,param3,param4);
         return _loc5_;
      }
      
      public static function fromDamageRange(param1:Number, param2:DamageRange) : EffectOutput
      {
         var _loc3_:EffectOutput = new EffectOutput(param1);
         _loc3_.damageRange = param2;
         return _loc3_;
      }
      
      public static function fromApTheft(param1:Number, param2:int) : EffectOutput
      {
         var _loc3_:EffectOutput = new EffectOutput(param1);
         _loc3_.apStolen = param2;
         _loc3_.attemptedApTheft = true;
         return _loc3_;
      }
      
      public static function fromAmTheft(param1:Number, param2:int) : EffectOutput
      {
         var _loc3_:EffectOutput = new EffectOutput(param1);
         _loc3_.amStolen = param2;
         _loc3_.attemptedAmTheft = true;
         return _loc3_;
      }
      
      public static function fromStateChange(param1:Number, param2:int, param3:Boolean) : EffectOutput
      {
         var _loc4_:EffectOutput = new EffectOutput(param1);
         if(param3)
         {
            _loc4_.newStateId = param2;
         }
         else
         {
            _loc4_.lostStateId = param2;
         }
         return _loc4_;
      }
      
      public static function deathOf(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.death = true;
         return _loc2_;
      }
      
      public static function fromDispell(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.dispell = true;
         return _loc2_;
      }
      
      public static function fromSummon(param1:Number, param2:int, param3:int, param4:Number = 0) : EffectOutput
      {
         var _loc5_:EffectOutput = new EffectOutput(param1);
         _loc5_.summon = new SummonInfos(param2,param3,param4);
         return _loc5_;
      }
      
      public static function fromSummoning(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.isSummoning = true;
         return _loc2_;
      }
      
      public static function fromAffectedLifePoints(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.areLifePointsAffected = true;
         return _loc2_;
      }
      
      public static function fromAffectedMaxLifePoints(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.areMaxLifePointsAffected = true;
         return _loc2_;
      }
      
      public static function fromErodedLifePoints(param1:Number) : EffectOutput
      {
         var _loc2_:EffectOutput = new EffectOutput(param1);
         _loc2_.areErodedLifePointsAffected = true;
         return _loc2_;
      }
      
      public function get_isLifeAffected() : Boolean
      {
         if(!(areLifePointsAffected || areMaxLifePointsAffected))
         {
            return areErodedLifePointsAffected;
         }
         return true;
      }
      
      public function computeShieldDamage() : DamageRange
      {
         if(damageRange == null || shield == null)
         {
            return DamageRange.ZERO;
         }
         var _loc1_:DamageRange = damageRange.copy();
         _loc1_.maximizeByInterval(shield);
         _loc1_.isShieldDamage = true;
         return _loc1_;
      }
      
      public function computeLifeDamage() : DamageRange
      {
         if(damageRange == null)
         {
            return DamageRange.ZERO;
         }
         var _loc1_:DamageRange = damageRange.copy();
         if(shield != null)
         {
            _loc1_.subInterval(shield);
            _loc1_.minimizeBy(0);
         }
         return _loc1_;
      }
   }
}

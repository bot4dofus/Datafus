package damageCalculation.damageManagement
{
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.tools.Interval;
   import tools.enumeration.ElementEnum;
   
   public class DamageRange extends Interval
   {
      
      public static var ZERO:DamageRange = new DamageRange(0,0);
       
      
      public var probability:Number;
      
      public var isShieldDamage:Boolean;
      
      public var isInvulnerable:Boolean;
      
      public var isHeal:Boolean;
      
      public var isCritical:Boolean;
      
      public var isCollision:Boolean;
      
      public var group:int;
      
      public var elemId:int;
      
      public function DamageRange(param1:int = 0, param2:int = 0)
      {
         isInvulnerable = false;
         group = 0;
         probability = 0;
         isCollision = false;
         isCritical = false;
         isHeal = false;
         isShieldDamage = false;
         elemId = -1;
         super(param1,param2);
      }
      
      public static function fromSpellEffect(param1:HaxeSpellEffect, param2:Boolean = false) : DamageRange
      {
         var _loc3_:DamageRange = new DamageRange(!!param2 ? int(param1.getMinRoll()) : int(param1.getRandomRoll()),int(param1.getMaxRoll()));
         _loc3_.isCollision = param1.actionId == 80;
         _loc3_.elemId = int(ElementEnum.getElementFromActionId(param1.actionId));
         _loc3_.isCritical = param1.isCritical;
         _loc3_.probability = param1.randomWeight;
         _loc3_.group = param1.randomGroup;
         return _loc3_;
      }
      
      public static function fromInterval(param1:Interval) : DamageRange
      {
         return new DamageRange(param1.min,param1.max);
      }
      
      override public function copy() : Interval
      {
         var _loc1_:DamageRange = new DamageRange();
         _loc1_.min = min;
         _loc1_.max = max;
         _loc1_.elemId = elemId;
         _loc1_.isShieldDamage = isShieldDamage;
         _loc1_.isHeal = isHeal;
         _loc1_.isCritical = isCritical;
         _loc1_.isCollision = isCollision;
         _loc1_.isInvulnerable = isInvulnerable;
         _loc1_.probability = probability;
         _loc1_.group = group;
         return _loc1_;
      }
   }
}

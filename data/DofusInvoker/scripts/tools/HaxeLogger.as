package tools
{
   import damageCalculation.DamageCalculator;
   import damageCalculation.spellManagement.HaxeSpell;
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import damageCalculation.spellManagement.RunningEffect;
   
   public class HaxeLogger
   {
       
      
      public function HaxeLogger()
      {
      }
      
      public static function logInfiniteLoop(param1:String, param2:RunningEffect) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as HaxeSpellEffect;
         var _loc9_:* = null as HaxeSpell;
         var _loc3_:String = param1;
         var _loc4_:String = "";
         var _loc5_:RunningEffect = param2;
         var _loc6_:int = 0;
         while(_loc6_ < 10)
         {
            _loc7_ = _loc6_++;
            _loc8_ = param2.getSpellEffect();
            _loc9_ = param2.getSpell();
            _loc4_ += "\n   effect " + ("" + _loc8_.id) + " with actionId " + _loc8_.actionId + " in spell " + _loc9_.id;
            param2 = param2.getParentEffect();
            if(param2 == null)
            {
               break;
            }
            _loc5_ = param2;
         }
         while(_loc5_.getParentEffect() != null)
         {
            _loc5_ = _loc5_.getParentEffect();
         }
         _loc3_ += "\nCasting spell : " + _loc5_.getSpell().id;
         _loc3_ += "\nLast effects : " + _loc4_;
         DamageCalculator.logger.logError(_loc3_);
      }
   }
}

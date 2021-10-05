package damageCalculation.spellManagement
{
   public class HaxeSpellState
   {
       
      
      public var id:uint;
      
      public var _stateEffects:Array;
      
      public function HaxeSpellState(param1:uint, param2:Array)
      {
         id = param1;
         _stateEffects = param2;
      }
      
      public function hasEffect(param1:int) : Boolean
      {
         return int(_stateEffects.indexOf(param1)) != -1;
      }
   }
}

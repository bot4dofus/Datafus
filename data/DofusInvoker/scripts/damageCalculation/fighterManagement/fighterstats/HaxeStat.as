package damageCalculation.fighterManagement.fighterstats
{
   import damageCalculation.spellManagement.HaxeSpellEffect;
   import tools.ActionIdHelper;
   
   public class HaxeStat
   {
       
      
      public var total:int;
      
      public var id:int;
      
      public function HaxeStat(param1:int)
      {
         total = 0;
         id = -1;
         id = param1;
      }
      
      public function updateStatWithValue(param1:int, param2:Boolean) : void
      {
      }
      
      public function updateStatFromEffect(param1:HaxeSpellEffect, param2:Boolean) : void
      {
         if(ActionIdHelper.isFlatStatBoostActionId(param1.actionId) || ActionIdHelper.isPercentStatBoostActionId(param1.actionId))
         {
            updateStatWithValue(int(param1.getMinRoll()),param2);
         }
      }
      
      public function get_total() : int
      {
         return total;
      }
      
      public function get_id() : int
      {
         return id;
      }
   }
}

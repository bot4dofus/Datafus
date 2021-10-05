package damageCalculation.fighterManagement.fighterstats
{
   public class HaxeSimpleStat extends HaxeStat
   {
       
      
      public function HaxeSimpleStat(param1:int, param2:int)
      {
         super(param1);
         total = param2;
      }
      
      override public function updateStatWithValue(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = !!param2 ? 1 : -1;
         var _loc4_:int = Math.floor(_loc3_ * param1);
         total += _loc4_;
      }
   }
}

package damageCalculation.fighterManagement.fighterstats
{
   public class HaxeUsableStat extends HaxeDetailedStat
   {
       
      
      public var used:int;
      
      public function HaxeUsableStat(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int)
      {
         used = 0;
         super(param1,param2,param3,param4,param5,param6);
         used = param7;
      }
   }
}

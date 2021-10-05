package damageCalculation.damageManagement
{
   import damageCalculation.fighterManagement.HaxeFighter;
   
   public class MovementInfos
   {
       
      
      public var swappedWith:HaxeFighter;
      
      public var newPosition:int;
      
      public var direction:int;
      
      public function MovementInfos(param1:int, param2:int, param3:HaxeFighter = undefined)
      {
         newPosition = param1;
         swappedWith = param3;
         direction = param2;
      }
   }
}

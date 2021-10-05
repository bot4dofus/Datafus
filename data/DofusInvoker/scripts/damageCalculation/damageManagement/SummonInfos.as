package damageCalculation.damageManagement
{
   public class SummonInfos
   {
       
      
      public var position:int;
      
      public var lookId:Number;
      
      public var direction:int;
      
      public function SummonInfos(param1:int, param2:int, param3:Number = 0)
      {
         position = param1;
         lookId = param3;
         direction = param2;
      }
   }
}

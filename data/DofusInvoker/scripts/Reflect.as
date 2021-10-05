package
{
   public class Reflect
   {
       
      
      public function Reflect()
      {
      }
      
      public static function field(param1:*, param2:String) : *
      {
         if(param1 != null && param2 in param1)
         {
            return param1[param2];
         }
         return null;
      }
   }
}

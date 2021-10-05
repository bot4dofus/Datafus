package
{
   import flash.Boot;
   
   public class Std
   {
       
      
      public function Std()
      {
      }
      
      public static function §is§(param1:*, param2:*) : Boolean
      {
         return Boolean(Boot.__instanceof(param1,param2));
      }
      
      public static function string(param1:*) : String
      {
         return Boot.__string_rec(param1,"");
      }
      
      public static function parseInt(param1:String) : Object
      {
         var _loc2_:Object = parseInt(param1);
         if(isNaN(_loc2_))
         {
            return null;
         }
         return _loc2_;
      }
   }
}

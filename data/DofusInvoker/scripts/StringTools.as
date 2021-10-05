package
{
   public class StringTools
   {
       
      
      public function StringTools()
      {
      }
      
      public static function startsWith(param1:String, param2:String) : Boolean
      {
         if(param1.length >= param2.length)
         {
            return param1.substr(0,param2.length) == param2;
         }
         return false;
      }
      
      public static function isSpace(param1:String, param2:int) : Boolean
      {
         var _loc3_:Object = param1.charCodeAt(param2);
         if(!(_loc3_ > 8 && _loc3_ < 14))
         {
            return _loc3_ == 32;
         }
         return true;
      }
      
      public static function ltrim(param1:String) : String
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_ && StringTools.isSpace(param1,_loc3_))
         {
            _loc3_++;
         }
         if(_loc3_ > 0)
         {
            return param1.substr(_loc3_,_loc2_ - _loc3_);
         }
         return param1;
      }
      
      public static function rtrim(param1:String) : String
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_ && StringTools.isSpace(param1,_loc2_ - _loc3_ - 1))
         {
            _loc3_++;
         }
         if(_loc3_ > 0)
         {
            return param1.substr(0,_loc2_ - _loc3_);
         }
         return param1;
      }
      
      public static function trim(param1:String) : String
      {
         return StringTools.ltrim(StringTools.rtrim(param1));
      }
   }
}

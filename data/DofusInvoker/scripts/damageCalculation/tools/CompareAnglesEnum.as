package damageCalculation.tools
{
   import flash.Boot;
   
   public final class CompareAnglesEnum
   {
      
      public static var CLOCKWISE:CompareAnglesEnum = new CompareAnglesEnum("CLOCKWISE",2,null);
      
      public static var COUNTERCLOCKWISE:CompareAnglesEnum = new CompareAnglesEnum("COUNTERCLOCKWISE",3,null);
      
      public static var LIKE:CompareAnglesEnum = new CompareAnglesEnum("LIKE",0,null);
      
      public static var UNLIKE:CompareAnglesEnum = new CompareAnglesEnum("UNLIKE",1,null);
      
      public static var __constructs__:Array = ["LIKE","UNLIKE","CLOCKWISE","COUNTERCLOCKWISE"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function CompareAnglesEnum(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

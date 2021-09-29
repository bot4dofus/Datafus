package
{
   import flash.Boot;
   
   public final class CompressionLevel
   {
      
      public static const __isenum:Boolean = true;
      
      public static var __constructs__ = ["UNCOMPRESSED","FAST","NORMAL","GOOD"];
      
      public static var UNCOMPRESSED:CompressionLevel;
      
      public static var NORMAL:CompressionLevel;
      
      public static var GOOD:CompressionLevel;
      
      public static var FAST:CompressionLevel;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function CompressionLevel(param1:String, param2:int, param3:*)
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

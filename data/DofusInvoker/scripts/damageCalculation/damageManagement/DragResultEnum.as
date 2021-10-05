package damageCalculation.damageManagement
{
   import flash.Boot;
   
   public final class DragResultEnum
   {
      
      public static var ACTIVE_OBJECT:DragResultEnum = new DragResultEnum("ACTIVE_OBJECT",2,null);
      
      public static var COLLISION:DragResultEnum = new DragResultEnum("COLLISION",1,null);
      
      public static var COMPLETE:DragResultEnum = new DragResultEnum("COMPLETE",0,null);
      
      public static var PORTAL:DragResultEnum = new DragResultEnum("PORTAL",3,null);
      
      public static var __constructs__:Array = ["COMPLETE","COLLISION","ACTIVE_OBJECT","PORTAL"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function DragResultEnum(param1:String, param2:int, param3:Array)
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

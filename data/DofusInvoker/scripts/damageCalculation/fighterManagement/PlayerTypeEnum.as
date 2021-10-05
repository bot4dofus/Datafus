package damageCalculation.fighterManagement
{
   import flash.Boot;
   
   public final class PlayerTypeEnum
   {
      
      public static var HUMAN:PlayerTypeEnum = new PlayerTypeEnum("HUMAN",1,null);
      
      public static var MONSTER:PlayerTypeEnum = new PlayerTypeEnum("MONSTER",3,null);
      
      public static var SIDEKICK:PlayerTypeEnum = new PlayerTypeEnum("SIDEKICK",2,null);
      
      public static var UNKNOWN:PlayerTypeEnum = new PlayerTypeEnum("UNKNOWN",0,null);
      
      public static var __constructs__:Array = ["UNKNOWN","HUMAN","SIDEKICK","MONSTER"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function PlayerTypeEnum(param1:String, param2:int, param3:Array)
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

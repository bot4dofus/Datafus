package com.ankamagames.dofus.modules.utils.pathfinding.world
{
   public final class TransitionTypeEnum
   {
      
      public static var UNSPECIFIED:int = 0;
      
      public static var SCROLL:int = 1;
      
      public static var SCROLL_ACTION:int = 2;
      
      public static var MAP_EVENT:int = 4;
      
      public static var MAP_ACTION:int = 8;
      
      public static var MAP_OBSTACLE:int = 16;
      
      public static var INTERACTIVE:int = 32;
      
      public static var NPC_ACTION:int = 64;
       
      
      public function TransitionTypeEnum()
      {
         super();
      }
      
      public static function fromName(name:String) : int
      {
         switch(name)
         {
            case "SCROLL":
               return SCROLL;
            case "SCROLL_ACTION":
               return SCROLL_ACTION;
            case "MAP_EVENT":
               return MAP_EVENT;
            case "MAP_ACTION":
               return MAP_ACTION;
            case "MAP_OBSTACLE":
               return MAP_OBSTACLE;
            case "INTERACTIVE":
               return INTERACTIVE;
            case "NPC_ACTION":
               return NPC_ACTION;
            default:
               return UNSPECIFIED;
         }
      }
   }
}

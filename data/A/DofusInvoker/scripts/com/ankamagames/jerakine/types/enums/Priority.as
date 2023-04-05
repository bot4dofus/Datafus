package com.ankamagames.jerakine.types.enums
{
   public class Priority
   {
      
      public static const LOG:int = 10;
      
      public static const ULTIMATE_HIGHEST_DEPTH_OF_DOOM:int = 3;
      
      public static const HIGHEST:int = 2;
      
      public static const HIGH:int = 1;
      
      public static const NORMAL:int = 0;
      
      public static const LOW:int = -1;
      
      public static const LOWEST:int = -2;
       
      
      public function Priority()
      {
         super();
      }
      
      public static function toString(priority:int) : String
      {
         switch(priority)
         {
            case LOG:
               return "LOG";
            case ULTIMATE_HIGHEST_DEPTH_OF_DOOM:
               return "ULTIMATE_HIGHEST_DEPTH_OF_DOOM";
            case HIGHEST:
               return "HIGHEST";
            case HIGH:
               return "HIGH";
            case NORMAL:
               return "NORMAL";
            case LOW:
               return "LOW";
            case LOWEST:
               return "LOWEST";
            default:
               return "UNKNOW";
         }
      }
      
      public static function fromString(priority:String) : int
      {
         switch(priority)
         {
            case "LOG":
               return LOG;
            case "ULTIMATE_HIGHEST_DEPTH_OF_DOOM":
               return ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
            case "HIGHEST":
               return HIGHEST;
            case "HIGH":
               return HIGH;
            case "NORMAL":
               return NORMAL;
            case "LOW":
               return LOW;
            case "LOWEST":
               return LOWEST;
            default:
               return 666;
         }
      }
   }
}

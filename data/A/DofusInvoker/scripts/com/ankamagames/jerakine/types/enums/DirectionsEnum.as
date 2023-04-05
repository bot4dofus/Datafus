package com.ankamagames.jerakine.types.enums
{
   public class DirectionsEnum
   {
      
      public static const RIGHT:int = 0;
      
      public static const DOWN_RIGHT:int = 1;
      
      public static const DOWN:int = 2;
      
      public static const DOWN_LEFT:int = 3;
      
      public static const LEFT:int = 4;
      
      public static const UP_LEFT:int = 5;
      
      public static const UP:int = 6;
      
      public static const UP_RIGHT:int = 7;
       
      
      public function DirectionsEnum()
      {
         super();
      }
      
      public static function getNameFromDirection(dir:uint) : String
      {
         switch(dir)
         {
            case RIGHT:
               return "RIGHT";
            case DOWN_RIGHT:
               return "DOWN_RIGHT";
            case DOWN:
               return "DOWN";
            case DOWN_LEFT:
               return "DOWN_LEFT";
            case LEFT:
               return "LEFT";
            case UP_LEFT:
               return "UP_LEFT";
            case UP:
               return "UP";
            case UP_RIGHT:
               return "UP_RIGHT";
            default:
               throw new Error("DirectionEnum  : Direction is unknown");
         }
      }
   }
}

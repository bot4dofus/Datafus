package com.ankamagames.dofus.network.enums
{
   public class TreasureHuntRequestEnum
   {
      
      public static const TREASURE_HUNT_ERROR_UNDEFINED:uint = 0;
      
      public static const TREASURE_HUNT_ERROR_NO_QUEST_FOUND:uint = 2;
      
      public static const TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST:uint = 3;
      
      public static const TREASURE_HUNT_ERROR_NOT_AVAILABLE:uint = 4;
      
      public static const TREASURE_HUNT_ERROR_DAILY_LIMIT_EXCEEDED:uint = 5;
      
      public static const TREASURE_HUNT_OK:uint = 1;
       
      
      public function TreasureHuntRequestEnum()
      {
         super();
      }
   }
}

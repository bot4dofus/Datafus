package com.ankamagames.dofus.network.enums
{
   public class PlayerStatusEnum
   {
      
      public static const PLAYER_STATUS_OFFLINE:uint = 0;
      
      public static const PLAYER_STATUS_UNKNOWN:uint = 1;
      
      public static const PLAYER_STATUS_AVAILABLE:uint = 10;
      
      public static const PLAYER_STATUS_IDLE:uint = 20;
      
      public static const PLAYER_STATUS_AFK:uint = 21;
      
      public static const PLAYER_STATUS_PRIVATE:uint = 30;
      
      public static const PLAYER_STATUS_SOLO:uint = 40;
       
      
      public function PlayerStatusEnum()
      {
         super();
      }
   }
}

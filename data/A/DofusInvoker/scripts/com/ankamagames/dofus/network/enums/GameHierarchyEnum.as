package com.ankamagames.dofus.network.enums
{
   public class GameHierarchyEnum
   {
      
      public static const UNAVAILABLE:int = -1;
      
      public static const PLAYER:int = 0;
      
      public static const MODERATOR:int = 10;
      
      public static const GAMEMASTER_PADAWAN:int = 20;
      
      public static const GAMEMASTER:int = 30;
      
      public static const ADMIN:int = 40;
      
      public static const UNKNOWN_SPECIAL_USER:int = 50;
       
      
      public function GameHierarchyEnum()
      {
         super();
      }
   }
}

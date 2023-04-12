package com.ankamagames.dofus.network.enums
{
   public class PartyJoinErrorEnum
   {
      
      public static const PARTY_JOIN_ERROR_UNKNOWN:uint = 0;
      
      public static const PARTY_JOIN_ERROR_PLAYER_NOT_FOUND:uint = 1;
      
      public static const PARTY_JOIN_ERROR_PARTY_NOT_FOUND:uint = 2;
      
      public static const PARTY_JOIN_ERROR_PARTY_FULL:uint = 3;
      
      public static const PARTY_JOIN_ERROR_PLAYER_BUSY:uint = 4;
      
      public static const PARTY_JOIN_ERROR_PLAYER_ALREADY_INVITED:uint = 6;
      
      public static const PARTY_JOIN_ERROR_PLAYER_TOO_SOLLICITED:uint = 7;
      
      public static const PARTY_JOIN_ERROR_PLAYER_LOYAL:uint = 8;
      
      public static const PARTY_JOIN_ERROR_UNMODIFIABLE:uint = 9;
      
      public static const PARTY_JOIN_ERROR_UNMET_CRITERION:uint = 10;
      
      public static const PARTY_JOIN_ERROR_NOT_ENOUGH_ROOM:uint = 11;
      
      public static const PARTY_JOIN_ERROR_COMPOSITION_CHANGED:uint = 12;
      
      public static const PARTY_JOIN_ERROR_PLAYER_IN_TUTORIAL:uint = 13;
       
      
      public function PartyJoinErrorEnum()
      {
         super();
      }
   }
}

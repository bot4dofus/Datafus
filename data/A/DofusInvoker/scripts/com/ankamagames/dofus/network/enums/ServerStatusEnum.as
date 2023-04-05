package com.ankamagames.dofus.network.enums
{
   public class ServerStatusEnum
   {
      
      public static const STATUS_UNKNOWN:uint = 0;
      
      public static const OFFLINE:uint = 1;
      
      public static const STARTING:uint = 2;
      
      public static const ONLINE:uint = 3;
      
      public static const NOJOIN:uint = 4;
      
      public static const SAVING:uint = 5;
      
      public static const STOPING:uint = 6;
      
      public static const FULL:uint = 7;
       
      
      public function ServerStatusEnum()
      {
         super();
      }
   }
}

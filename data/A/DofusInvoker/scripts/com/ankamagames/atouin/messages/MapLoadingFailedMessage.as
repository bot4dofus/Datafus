package com.ankamagames.atouin.messages
{
   public class MapLoadingFailedMessage extends MapMessage
   {
      
      public static const NO_FILE:uint = 0;
      
      public static const CLIENT_SHUTDOWN:uint = 1;
       
      
      public var errorReason:uint;
      
      public function MapLoadingFailedMessage()
      {
         super();
      }
   }
}

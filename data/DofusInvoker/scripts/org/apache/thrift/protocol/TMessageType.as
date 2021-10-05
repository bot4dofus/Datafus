package org.apache.thrift.protocol
{
   public class TMessageType
   {
      
      public static const CALL:int = 1;
      
      public static const REPLY:int = 2;
      
      public static const EXCEPTION:int = 3;
      
      public static const ONEWAY:int = 4;
       
      
      public function TMessageType()
      {
         super();
      }
   }
}

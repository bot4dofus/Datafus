package org.apache.thrift.protocol
{
   import org.apache.thrift.TError;
   
   public class TProtocolError extends TError
   {
      
      public static const UNKNOWN:int = 0;
      
      public static const INVALID_DATA:int = 1;
      
      public static const NEGATIVE_SIZE:int = 2;
      
      public static const SIZE_LIMIT:int = 3;
      
      public static const BAD_VERSION:int = 4;
      
      public static const NOT_IMPLEMENTED:int = 5;
      
      public static const DEPTH_LIMIT:int = 6;
       
      
      public function TProtocolError(param1:int = 0, param2:String = "")
      {
         super(param2,param1);
      }
   }
}

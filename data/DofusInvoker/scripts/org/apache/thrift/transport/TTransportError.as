package org.apache.thrift.transport
{
   import org.apache.thrift.TError;
   
   public class TTransportError extends TError
   {
      
      public static const UNKNOWN:int = 0;
      
      public static const NOT_OPEN:int = 1;
      
      public static const ALREADY_OPEN:int = 2;
      
      public static const TIMED_OUT:int = 3;
      
      public static const END_OF_FILE:int = 4;
       
      
      public function TTransportError(param1:int = 0, param2:String = "")
      {
         super(param2,param1);
      }
   }
}

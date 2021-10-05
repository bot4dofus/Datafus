package org.apache.thrift.protocol
{
   public class TMap
   {
       
      
      public var keyType:int;
      
      public var valueType:int;
      
      public var size:int;
      
      public function TMap(param1:int = 0, param2:int = 0, param3:int = 0)
      {
         super();
         this.keyType = param1;
         this.valueType = param2;
         this.size = param3;
      }
   }
}

package org.apache.thrift
{
   import org.apache.thrift.protocol.TProtocol;
   
   public interface TBase
   {
       
      
      function read(param1:TProtocol) : void;
      
      function write(param1:TProtocol) : void;
      
      function isSet(param1:int) : Boolean;
      
      function getFieldValue(param1:int) : *;
      
      function setFieldValue(param1:int, param2:*) : void;
   }
}

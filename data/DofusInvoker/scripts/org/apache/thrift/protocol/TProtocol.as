package org.apache.thrift.protocol
{
   import flash.utils.ByteArray;
   import org.apache.thrift.transport.TTransport;
   
   public interface TProtocol
   {
       
      
      function getTransport() : TTransport;
      
      function writeMessageBegin(param1:TMessage) : void;
      
      function writeMessageEnd() : void;
      
      function writeStructBegin(param1:TStruct) : void;
      
      function writeStructEnd() : void;
      
      function writeFieldBegin(param1:TField) : void;
      
      function writeFieldEnd() : void;
      
      function writeFieldStop() : void;
      
      function writeMapBegin(param1:TMap) : void;
      
      function writeMapEnd() : void;
      
      function writeListBegin(param1:TList) : void;
      
      function writeListEnd() : void;
      
      function writeSetBegin(param1:TSet) : void;
      
      function writeSetEnd() : void;
      
      function writeBool(param1:Boolean) : void;
      
      function writeByte(param1:int) : void;
      
      function writeI16(param1:int) : void;
      
      function writeI32(param1:int) : void;
      
      function writeDouble(param1:Number) : void;
      
      function writeString(param1:String) : void;
      
      function writeBinary(param1:ByteArray) : void;
      
      function readMessageBegin() : TMessage;
      
      function readMessageEnd() : void;
      
      function readStructBegin() : TStruct;
      
      function readStructEnd() : void;
      
      function readFieldBegin() : TField;
      
      function readFieldEnd() : void;
      
      function readMapBegin() : TMap;
      
      function readMapEnd() : void;
      
      function readListBegin() : TList;
      
      function readListEnd() : void;
      
      function readSetBegin() : TSet;
      
      function readSetEnd() : void;
      
      function readBool() : Boolean;
      
      function readByte() : int;
      
      function readI16() : int;
      
      function readI32() : int;
      
      function readDouble() : Number;
      
      function readString() : String;
      
      function readBinary() : ByteArray;
   }
}

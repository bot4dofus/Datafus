package org.apache.thrift.protocol
{
   import flash.utils.ByteArray;
   import org.apache.thrift.transport.TTransport;
   
   public class TBinaryProtocol implements TProtocol
   {
      
      private static var ANONYMOUS_STRUCT:TStruct = new TStruct();
      
      protected static const VERSION_MASK:int = int(4294901760);
      
      protected static const VERSION_1:int = int(2147549184);
       
      
      protected var strictRead_:Boolean = false;
      
      protected var strictWrite_:Boolean = true;
      
      private var trans_:TTransport;
      
      private var out:ByteArray;
      
      private var stringOut:ByteArray;
      
      private var bytes:ByteArray;
      
      public function TBinaryProtocol(param1:TTransport, param2:Boolean = false, param3:Boolean = true)
      {
         this.out = new ByteArray();
         this.stringOut = new ByteArray();
         this.bytes = new ByteArray();
         super();
         this.trans_ = param1;
         this.strictRead_ = param2;
         this.strictWrite_ = param3;
      }
      
      private static function reset(param1:ByteArray) : void
      {
         param1.length = 0;
         param1.position = 0;
      }
      
      public function getTransport() : TTransport
      {
         return this.trans_;
      }
      
      public function writeMessageBegin(param1:TMessage) : void
      {
         var _loc2_:* = 0;
         if(this.strictWrite_)
         {
            _loc2_ = VERSION_1 | param1.type;
            this.writeI32(_loc2_);
            this.writeString(param1.name);
            this.writeI32(param1.seqid);
         }
         else
         {
            this.writeString(param1.name);
            this.writeByte(param1.type);
            this.writeI32(param1.seqid);
         }
      }
      
      public function writeMessageEnd() : void
      {
      }
      
      public function writeStructBegin(param1:TStruct) : void
      {
      }
      
      public function writeStructEnd() : void
      {
      }
      
      public function writeFieldBegin(param1:TField) : void
      {
         this.writeByte(param1.type);
         this.writeI16(param1.id);
      }
      
      public function writeFieldEnd() : void
      {
      }
      
      public function writeFieldStop() : void
      {
         this.writeByte(TType.STOP);
      }
      
      public function writeMapBegin(param1:TMap) : void
      {
         this.writeByte(param1.keyType);
         this.writeByte(param1.valueType);
         this.writeI32(param1.size);
      }
      
      public function writeMapEnd() : void
      {
      }
      
      public function writeListBegin(param1:TList) : void
      {
         this.writeByte(param1.elemType);
         this.writeI32(param1.size);
      }
      
      public function writeListEnd() : void
      {
      }
      
      public function writeSetBegin(param1:TSet) : void
      {
         this.writeByte(param1.elemType);
         this.writeI32(param1.size);
      }
      
      public function writeSetEnd() : void
      {
      }
      
      public function writeBool(param1:Boolean) : void
      {
         this.writeByte(!!param1 ? 1 : 0);
      }
      
      public function writeByte(param1:int) : void
      {
         reset(this.out);
         this.out.writeByte(param1);
         this.trans_.write(this.out,0,1);
      }
      
      public function writeI16(param1:int) : void
      {
         reset(this.out);
         this.out.writeShort(param1);
         this.trans_.write(this.out,0,2);
      }
      
      public function writeI32(param1:int) : void
      {
         reset(this.out);
         this.out.writeInt(param1);
         this.trans_.write(this.out,0,4);
      }
      
      public function writeDouble(param1:Number) : void
      {
         reset(this.out);
         this.out.writeDouble(param1);
         this.trans_.write(this.out,0,8);
      }
      
      public function writeString(param1:String) : void
      {
         reset(this.stringOut);
         this.stringOut.writeUTFBytes(param1);
         this.writeI32(this.stringOut.length);
         this.trans_.write(this.stringOut,0,this.stringOut.length);
      }
      
      public function writeBinary(param1:ByteArray) : void
      {
         this.writeI32(param1.length);
         this.trans_.write(param1,0,param1.length);
      }
      
      public function readMessageBegin() : TMessage
      {
         var _loc2_:* = 0;
         var _loc1_:int = this.readI32();
         if(_loc1_ < 0)
         {
            _loc2_ = _loc1_ & VERSION_MASK;
            if(_loc2_ != VERSION_1)
            {
               throw new TProtocolError(TProtocolError.BAD_VERSION,"Bad version in readMessageBegin");
            }
            return new TMessage(this.readString(),_loc1_ & 255,this.readI32());
         }
         if(this.strictRead_)
         {
            throw new TProtocolError(TProtocolError.BAD_VERSION,"Missing version in readMessageBegin, old client?");
         }
         return new TMessage(this.readStringBody(_loc1_),this.readByte(),this.readI32());
      }
      
      public function readMessageEnd() : void
      {
      }
      
      public function readStructBegin() : TStruct
      {
         return ANONYMOUS_STRUCT;
      }
      
      public function readStructEnd() : void
      {
      }
      
      public function readFieldBegin() : TField
      {
         var _loc1_:int = this.readByte();
         var _loc2_:int = _loc1_ == TType.STOP ? 0 : int(this.readI16());
         return new TField("",_loc1_,_loc2_);
      }
      
      public function readFieldEnd() : void
      {
      }
      
      public function readMapBegin() : TMap
      {
         return new TMap(this.readByte(),this.readByte(),this.readI32());
      }
      
      public function readMapEnd() : void
      {
      }
      
      public function readListBegin() : TList
      {
         return new TList(this.readByte(),this.readI32());
      }
      
      public function readListEnd() : void
      {
      }
      
      public function readSetBegin() : TSet
      {
         return new TSet(this.readByte(),this.readI32());
      }
      
      public function readSetEnd() : void
      {
      }
      
      public function readBool() : Boolean
      {
         return this.readByte() == 1;
      }
      
      public function readByte() : int
      {
         this.readAll(1);
         return this.bytes.readByte();
      }
      
      public function readI16() : int
      {
         this.readAll(2);
         return this.bytes.readShort();
      }
      
      public function readI32() : int
      {
         this.readAll(4);
         return this.bytes.readInt();
      }
      
      public function readDouble() : Number
      {
         this.readAll(8);
         return this.bytes.readDouble();
      }
      
      public function readString() : String
      {
         var _loc1_:int = this.readI32();
         this.readAll(_loc1_);
         return this.bytes.readUTFBytes(_loc1_);
      }
      
      public function readStringBody(param1:int) : String
      {
         this.readAll(param1);
         return this.bytes.readUTFBytes(param1);
      }
      
      public function readBinary() : ByteArray
      {
         var _loc1_:int = this.readI32();
         var _loc2_:ByteArray = new ByteArray();
         this.trans_.readAll(_loc2_,0,_loc1_);
         return _loc2_;
      }
      
      private function readAll(param1:int) : void
      {
         reset(this.bytes);
         this.trans_.readAll(this.bytes,0,param1);
         this.bytes.position = 0;
      }
   }
}

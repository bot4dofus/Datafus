package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.network.utils.types.Int64;
   import com.ankamagames.jerakine.network.utils.types.UInt64;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class CustomDataWrapper implements ICustomDataInput, ICustomDataOutput
   {
      
      private static const INT_SIZE:int = 32;
      
      private static const SHORT_SIZE:int = 16;
      
      private static const SHORT_MIN_VALUE:int = -32768;
      
      private static const SHORT_MAX_VALUE:int = 32767;
      
      private static const UNSIGNED_SHORT_MAX_VALUE:int = 65536;
      
      private static const CHUNCK_BIT_SIZE:int = 7;
      
      private static const MAX_ENCODING_LENGTH:int = Math.ceil(INT_SIZE / CHUNCK_BIT_SIZE);
      
      private static const MASK_10000000:int = 128;
      
      private static const MASK_01111111:int = 127;
       
      
      private var _data;
      
      public function CustomDataWrapper(data:*)
      {
         super();
         this._data = data;
      }
      
      public function set position(offset:uint) : void
      {
         this._data.position = offset;
      }
      
      public function get position() : uint
      {
         return this._data.position;
      }
      
      public function readVarInt() : int
      {
         var b:int = 0;
         var value:int = 0;
         var offset:int = 0;
         var hasNext:* = false;
         while(offset < INT_SIZE)
         {
            b = this._data.readByte();
            hasNext = (b & MASK_10000000) == MASK_10000000;
            if(offset > 0)
            {
               value += (b & MASK_01111111) << offset;
            }
            else
            {
               value += b & MASK_01111111;
            }
            offset += CHUNCK_BIT_SIZE;
            if(!(hasNext && this._data.bytesAvailable > 0))
            {
               return value;
            }
         }
         throw new Error("Too much data");
      }
      
      public function readVarUhInt() : uint
      {
         return this.readVarInt();
      }
      
      public function readVarShort() : int
      {
         var b:int = 0;
         var value:int = 0;
         var offset:int = 0;
         var hasNext:* = false;
         while(offset < SHORT_SIZE)
         {
            b = this._data.readByte();
            hasNext = (b & MASK_10000000) == MASK_10000000;
            if(offset > 0)
            {
               value += (b & MASK_01111111) << offset;
            }
            else
            {
               value += b & MASK_01111111;
            }
            offset += CHUNCK_BIT_SIZE;
            if(!hasNext)
            {
               if(value > SHORT_MAX_VALUE)
               {
                  value -= UNSIGNED_SHORT_MAX_VALUE;
               }
               return value;
            }
         }
         throw new Error("Too much data");
      }
      
      public function readVarUhShort() : uint
      {
         return this.readVarShort();
      }
      
      public function readVarLong() : Number
      {
         return this.readInt64(this._data).toNumber();
      }
      
      public function readVarUhLong() : Number
      {
         return this.readUInt64(this._data).toNumber();
      }
      
      public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void
      {
         this._data.readBytes(bytes,offset,length);
      }
      
      public function readBoolean() : Boolean
      {
         return this._data.readBoolean();
      }
      
      public function readByte() : int
      {
         return this._data.readByte();
      }
      
      public function readUnsignedByte() : uint
      {
         return this._data.readUnsignedByte();
      }
      
      public function readShort() : int
      {
         return this._data.readShort();
      }
      
      public function readUnsignedShort() : uint
      {
         return this._data.readUnsignedShort();
      }
      
      public function readInt() : int
      {
         return this._data.readInt();
      }
      
      public function readUnsignedInt() : uint
      {
         return this._data.readUnsignedInt();
      }
      
      public function readFloat() : Number
      {
         return this._data.readFloat();
      }
      
      public function readDouble() : Number
      {
         return this._data.readDouble();
      }
      
      public function readMultiByte(length:uint, charSet:String) : String
      {
         return this._data.readMultiByte(length,charSet);
      }
      
      public function readUTF() : String
      {
         return this._data.readUTF();
      }
      
      public function readUTFBytes(length:uint) : String
      {
         return this._data.readUTFBytes(length);
      }
      
      public function get bytesAvailable() : uint
      {
         return this._data.bytesAvailable;
      }
      
      public function readObject() : *
      {
         return this._data.readObject();
      }
      
      public function get objectEncoding() : uint
      {
         return this._data.objectEncoding;
      }
      
      public function set objectEncoding(version:uint) : void
      {
         this._data.objectEncoding = version;
      }
      
      public function get endian() : String
      {
         return this._data.endian;
      }
      
      public function set endian(type:String) : void
      {
         this._data.endian = type;
      }
      
      public function writeVarInt(value:int) : void
      {
         var b:* = 0;
         var ba:ByteArray = new ByteArray();
         if(value >= 0 && value <= MASK_01111111)
         {
            ba.writeByte(value);
            this._data.writeBytes(ba);
            return;
         }
         var c:int = value;
         var buffer:ByteArray = new ByteArray();
         while(c != 0)
         {
            buffer.writeByte(c & MASK_01111111);
            buffer.position = buffer.length - 1;
            b = int(buffer.readByte());
            c >>>= CHUNCK_BIT_SIZE;
            if(c > 0)
            {
               b |= MASK_10000000;
            }
            ba.writeByte(b);
         }
         this._data.writeBytes(ba);
      }
      
      public function writeVarShort(value:int) : void
      {
         var b:* = 0;
         if(value > SHORT_MAX_VALUE || value < SHORT_MIN_VALUE)
         {
            throw new Error("Forbidden value");
         }
         var ba:ByteArray = new ByteArray();
         if(value >= 0 && value <= MASK_01111111)
         {
            ba.writeByte(value);
            this._data.writeBytes(ba);
            return;
         }
         var c:* = value & 65535;
         var buffer:ByteArray = new ByteArray();
         while(c != 0)
         {
            buffer.writeByte(c & MASK_01111111);
            buffer.position = buffer.length - 1;
            b = int(buffer.readByte());
            c >>>= CHUNCK_BIT_SIZE;
            if(c > 0)
            {
               b |= MASK_10000000;
            }
            ba.writeByte(b);
         }
         this._data.writeBytes(ba);
      }
      
      public function writeVarLong(value:Number) : void
      {
         var i:uint = 0;
         var val:Int64 = Int64.fromNumber(value);
         if(val.high == 0)
         {
            this.writeint32(this._data,val.low);
         }
         else
         {
            for(i = 0; i < 4; i++)
            {
               this._data.writeByte(val.low & 127 | 128);
               val.low >>>= 7;
            }
            if((val.high & 268435455 << 3) == 0)
            {
               this._data.writeByte(val.high << 4 | val.low);
            }
            else
            {
               this._data.writeByte((val.high << 4 | val.low) & 127 | 128);
               this.writeint32(this._data,val.high >>> 3);
            }
         }
      }
      
      public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0) : void
      {
         this._data.writeBytes(bytes,offset,length);
      }
      
      public function writeBoolean(value:Boolean) : void
      {
         this._data.writeBoolean(value);
      }
      
      public function writeByte(value:int) : void
      {
         this._data.writeByte(value);
      }
      
      public function writeShort(value:int) : void
      {
         this._data.writeShort(value);
      }
      
      public function writeInt(value:int) : void
      {
         this._data.writeInt(value);
      }
      
      public function writeUnsignedInt(value:uint) : void
      {
         this._data.writeUnsignedInt(value);
      }
      
      public function writeFloat(value:Number) : void
      {
         this._data.writeFloat(value);
      }
      
      public function writeDouble(value:Number) : void
      {
         this._data.writeDouble(value);
      }
      
      public function writeMultiByte(value:String, charSet:String) : void
      {
         this._data.writeMultiByte(value,charSet);
      }
      
      public function writeUTF(value:String) : void
      {
         this._data.writeUTF(value);
      }
      
      public function writeUTFBytes(value:String) : void
      {
         this._data.writeUTFBytes(value);
      }
      
      public function writeObject(object:*) : void
      {
         this._data.writeObject(object);
      }
      
      private function readInt64(input:IDataInput) : Int64
      {
         var b:uint = 0;
         var result:Int64 = new Int64();
         var i:uint = 0;
         while(true)
         {
            b = input.readUnsignedByte();
            if(i == 28)
            {
               break;
            }
            if(b < 128)
            {
               result.low |= b << i;
            }
            continue;
            return result;
         }
         if(b >= 128)
         {
            b &= 127;
            result.low |= b << i;
            result.high = b >>> 4;
            i = 3;
            while(true)
            {
               b = input.readUnsignedByte();
               if(i < 32)
               {
                  if(b < 128)
                  {
                     break;
                  }
                  result.high |= (b & 127) << i;
               }
               i += 7;
            }
            result.high |= b << i;
            return result;
         }
         result.low |= b << i;
         result.high = b >>> 4;
         return result;
      }
      
      private function readUInt64(input:IDataInput) : UInt64
      {
         var b:uint = 0;
         var result:UInt64 = new UInt64();
         var i:uint = 0;
         while(true)
         {
            b = input.readUnsignedByte();
            if(i == 28)
            {
               break;
            }
            if(b < 128)
            {
               result.low |= b << i;
            }
            continue;
            return result;
         }
         if(b >= 128)
         {
            b &= 127;
            result.low |= b << i;
            result.high = b >>> 4;
            i = 3;
            while(true)
            {
               b = input.readUnsignedByte();
               if(i < 32)
               {
                  if(b < 128)
                  {
                     break;
                  }
                  result.high |= (b & 127) << i;
               }
               i += 7;
            }
            result.high |= b << i;
            return result;
         }
         result.low |= b << i;
         result.high = b >>> 4;
         return result;
      }
      
      private function writeint32(output:IDataOutput, value:uint) : void
      {
         while(value >= 128)
         {
            output.writeByte(value & 127 | 128);
            value >>>= 7;
         }
         output.writeByte(value);
      }
   }
}

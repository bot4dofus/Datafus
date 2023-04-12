package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.getQualifiedClassName;
   
   public class NetworkMessage implements INetworkMessage
   {
      
      private static var GLOBAL_INSTANCE_ID:uint = 0;
      
      public static const BIT_RIGHT_SHIFT_LEN_PACKET_ID:uint = 2;
      
      public static const BIT_MASK:uint = 3;
      
      public static var HASH_FUNCTION:Function;
       
      
      private var _instance_id:uint;
      
      public var receptionTime:int;
      
      public var sourceConnection:String;
      
      public var _unpacked:Boolean = false;
      
      public function NetworkMessage()
      {
         this._instance_id = ++GLOBAL_INSTANCE_ID;
         super();
      }
      
      private static function computeTypeLen(len:uint) : uint
      {
         if(len > 65535)
         {
            return 3;
         }
         if(len > 255)
         {
            return 2;
         }
         if(len > 0)
         {
            return 1;
         }
         return 0;
      }
      
      private static function subComputeStaticHeader(msgId:uint, typeLen:uint) : uint
      {
         return msgId << BIT_RIGHT_SHIFT_LEN_PACKET_ID | typeLen;
      }
      
      public function get isInitialized() : Boolean
      {
         throw new AbstractMethodCallError();
      }
      
      public function get unpacked() : Boolean
      {
         return this._unpacked;
      }
      
      public function set unpacked(value:Boolean) : void
      {
         this._unpacked = value;
      }
      
      public function writePacket(output:ICustomDataOutput, id:int, data:ByteArray) : void
      {
         var high:uint = 0;
         var low:uint = 0;
         var typeLen:uint = computeTypeLen(data.length);
         output.writeShort(subComputeStaticHeader(id,typeLen));
         output.writeUnsignedInt(this._instance_id);
         switch(typeLen)
         {
            case 0:
               return;
            case 1:
               output.writeByte(data.length);
               break;
            case 2:
               output.writeShort(data.length);
               break;
            case 3:
               high = data.length >> 16 & 255;
               low = data.length & 65535;
               output.writeByte(high);
               output.writeShort(low);
         }
         output.writeBytes(data,0,data.length);
      }
      
      public function getMessageId() : uint
      {
         throw new AbstractMethodCallError();
      }
      
      public function reset() : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function pack(output:ICustomDataOutput) : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function unpack(input:ICustomDataInput, length:uint) : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         throw new AbstractMethodCallError();
      }
      
      public function readExternal(input:IDataInput) : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function writeExternal(output:IDataOutput) : void
      {
         throw new AbstractMethodCallError();
      }
      
      public function toString() : String
      {
         var className:String = getQualifiedClassName(this);
         return className.substring(className.indexOf("::") + 2) + " @" + this._instance_id;
      }
   }
}

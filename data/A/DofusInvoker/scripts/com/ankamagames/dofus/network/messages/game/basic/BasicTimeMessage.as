package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicTimeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4945;
       
      
      private var _isInitialized:Boolean = false;
      
      public var timestamp:Number = 0;
      
      public var timezoneOffset:int = 0;
      
      public function BasicTimeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4945;
      }
      
      public function initBasicTimeMessage(timestamp:Number = 0, timezoneOffset:int = 0) : BasicTimeMessage
      {
         this.timestamp = timestamp;
         this.timezoneOffset = timezoneOffset;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.timestamp = 0;
         this.timezoneOffset = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BasicTimeMessage(output);
      }
      
      public function serializeAs_BasicTimeMessage(output:ICustomDataOutput) : void
      {
         if(this.timestamp < 0 || this.timestamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         output.writeDouble(this.timestamp);
         output.writeShort(this.timezoneOffset);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicTimeMessage(input);
      }
      
      public function deserializeAs_BasicTimeMessage(input:ICustomDataInput) : void
      {
         this._timestampFunc(input);
         this._timezoneOffsetFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicTimeMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicTimeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._timestampFunc);
         tree.addChild(this._timezoneOffsetFunc);
      }
      
      private function _timestampFunc(input:ICustomDataInput) : void
      {
         this.timestamp = input.readDouble();
         if(this.timestamp < 0 || this.timestamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of BasicTimeMessage.timestamp.");
         }
      }
      
      private function _timezoneOffsetFunc(input:ICustomDataInput) : void
      {
         this.timezoneOffset = input.readShort();
      }
   }
}

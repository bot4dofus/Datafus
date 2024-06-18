package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicAckMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9375;
       
      
      private var _isInitialized:Boolean = false;
      
      public var seq:uint = 0;
      
      public var lastPacketId:uint = 0;
      
      public function BasicAckMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9375;
      }
      
      public function initBasicAckMessage(seq:uint = 0, lastPacketId:uint = 0) : BasicAckMessage
      {
         this.seq = seq;
         this.lastPacketId = lastPacketId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.seq = 0;
         this.lastPacketId = 0;
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
         this.serializeAs_BasicAckMessage(output);
      }
      
      public function serializeAs_BasicAckMessage(output:ICustomDataOutput) : void
      {
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element seq.");
         }
         output.writeVarInt(this.seq);
         if(this.lastPacketId < 0)
         {
            throw new Error("Forbidden value (" + this.lastPacketId + ") on element lastPacketId.");
         }
         output.writeVarShort(this.lastPacketId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicAckMessage(input);
      }
      
      public function deserializeAs_BasicAckMessage(input:ICustomDataInput) : void
      {
         this._seqFunc(input);
         this._lastPacketIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicAckMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicAckMessage(tree:FuncTree) : void
      {
         tree.addChild(this._seqFunc);
         tree.addChild(this._lastPacketIdFunc);
      }
      
      private function _seqFunc(input:ICustomDataInput) : void
      {
         this.seq = input.readVarUhInt();
         if(this.seq < 0)
         {
            throw new Error("Forbidden value (" + this.seq + ") on element of BasicAckMessage.seq.");
         }
      }
      
      private function _lastPacketIdFunc(input:ICustomDataInput) : void
      {
         this.lastPacketId = input.readVarUhShort();
         if(this.lastPacketId < 0)
         {
            throw new Error("Forbidden value (" + this.lastPacketId + ") on element of BasicAckMessage.lastPacketId.");
         }
      }
   }
}

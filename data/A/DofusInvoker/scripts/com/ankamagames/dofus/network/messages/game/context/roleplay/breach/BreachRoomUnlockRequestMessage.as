package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachRoomUnlockRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5483;
       
      
      private var _isInitialized:Boolean = false;
      
      public var roomId:uint = 0;
      
      public function BreachRoomUnlockRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5483;
      }
      
      public function initBreachRoomUnlockRequestMessage(roomId:uint = 0) : BreachRoomUnlockRequestMessage
      {
         this.roomId = roomId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.roomId = 0;
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
         this.serializeAs_BreachRoomUnlockRequestMessage(output);
      }
      
      public function serializeAs_BreachRoomUnlockRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element roomId.");
         }
         output.writeByte(this.roomId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachRoomUnlockRequestMessage(input);
      }
      
      public function deserializeAs_BreachRoomUnlockRequestMessage(input:ICustomDataInput) : void
      {
         this._roomIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachRoomUnlockRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachRoomUnlockRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._roomIdFunc);
      }
      
      private function _roomIdFunc(input:ICustomDataInput) : void
      {
         this.roomId = input.readByte();
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element of BreachRoomUnlockRequestMessage.roomId.");
         }
      }
   }
}

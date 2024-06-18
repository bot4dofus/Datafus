package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachRoomUnlockResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7028;
       
      
      private var _isInitialized:Boolean = false;
      
      public var roomId:uint = 0;
      
      public var result:uint = 0;
      
      public function BreachRoomUnlockResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7028;
      }
      
      public function initBreachRoomUnlockResultMessage(roomId:uint = 0, result:uint = 0) : BreachRoomUnlockResultMessage
      {
         this.roomId = roomId;
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.roomId = 0;
         this.result = 0;
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
         this.serializeAs_BreachRoomUnlockResultMessage(output);
      }
      
      public function serializeAs_BreachRoomUnlockResultMessage(output:ICustomDataOutput) : void
      {
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element roomId.");
         }
         output.writeByte(this.roomId);
         output.writeByte(this.result);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachRoomUnlockResultMessage(input);
      }
      
      public function deserializeAs_BreachRoomUnlockResultMessage(input:ICustomDataInput) : void
      {
         this._roomIdFunc(input);
         this._resultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachRoomUnlockResultMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachRoomUnlockResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._roomIdFunc);
         tree.addChild(this._resultFunc);
      }
      
      private function _roomIdFunc(input:ICustomDataInput) : void
      {
         this.roomId = input.readByte();
         if(this.roomId < 0)
         {
            throw new Error("Forbidden value (" + this.roomId + ") on element of BreachRoomUnlockResultMessage.roomId.");
         }
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of BreachRoomUnlockResultMessage.result.");
         }
      }
   }
}

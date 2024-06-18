package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportToBuddyAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3588;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var buddyId:Number = 0;
      
      public var accept:Boolean = false;
      
      public function TeleportToBuddyAnswerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3588;
      }
      
      public function initTeleportToBuddyAnswerMessage(dungeonId:uint = 0, buddyId:Number = 0, accept:Boolean = false) : TeleportToBuddyAnswerMessage
      {
         this.dungeonId = dungeonId;
         this.buddyId = buddyId;
         this.accept = accept;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.buddyId = 0;
         this.accept = false;
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
         this.serializeAs_TeleportToBuddyAnswerMessage(output);
      }
      
      public function serializeAs_TeleportToBuddyAnswerMessage(output:ICustomDataOutput) : void
      {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
         if(this.buddyId < 0 || this.buddyId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.buddyId + ") on element buddyId.");
         }
         output.writeVarLong(this.buddyId);
         output.writeBoolean(this.accept);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportToBuddyAnswerMessage(input);
      }
      
      public function deserializeAs_TeleportToBuddyAnswerMessage(input:ICustomDataInput) : void
      {
         this._dungeonIdFunc(input);
         this._buddyIdFunc(input);
         this._acceptFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportToBuddyAnswerMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportToBuddyAnswerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         tree.addChild(this._buddyIdFunc);
         tree.addChild(this._acceptFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyAnswerMessage.dungeonId.");
         }
      }
      
      private function _buddyIdFunc(input:ICustomDataInput) : void
      {
         this.buddyId = input.readVarUhLong();
         if(this.buddyId < 0 || this.buddyId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyAnswerMessage.buddyId.");
         }
      }
      
      private function _acceptFunc(input:ICustomDataInput) : void
      {
         this.accept = input.readBoolean();
      }
   }
}

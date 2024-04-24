package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportToBuddyOfferMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1543;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var buddyId:Number = 0;
      
      public var timeLeft:uint = 0;
      
      public function TeleportToBuddyOfferMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1543;
      }
      
      public function initTeleportToBuddyOfferMessage(dungeonId:uint = 0, buddyId:Number = 0, timeLeft:uint = 0) : TeleportToBuddyOfferMessage
      {
         this.dungeonId = dungeonId;
         this.buddyId = buddyId;
         this.timeLeft = timeLeft;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.buddyId = 0;
         this.timeLeft = 0;
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
         this.serializeAs_TeleportToBuddyOfferMessage(output);
      }
      
      public function serializeAs_TeleportToBuddyOfferMessage(output:ICustomDataOutput) : void
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
         if(this.timeLeft < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeft + ") on element timeLeft.");
         }
         output.writeVarInt(this.timeLeft);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportToBuddyOfferMessage(input);
      }
      
      public function deserializeAs_TeleportToBuddyOfferMessage(input:ICustomDataInput) : void
      {
         this._dungeonIdFunc(input);
         this._buddyIdFunc(input);
         this._timeLeftFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportToBuddyOfferMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportToBuddyOfferMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         tree.addChild(this._buddyIdFunc);
         tree.addChild(this._timeLeftFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyOfferMessage.dungeonId.");
         }
      }
      
      private function _buddyIdFunc(input:ICustomDataInput) : void
      {
         this.buddyId = input.readVarUhLong();
         if(this.buddyId < 0 || this.buddyId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyOfferMessage.buddyId.");
         }
      }
      
      private function _timeLeftFunc(input:ICustomDataInput) : void
      {
         this.timeLeft = input.readVarUhInt();
         if(this.timeLeft < 0)
         {
            throw new Error("Forbidden value (" + this.timeLeft + ") on element of TeleportToBuddyOfferMessage.timeLeft.");
         }
      }
   }
}

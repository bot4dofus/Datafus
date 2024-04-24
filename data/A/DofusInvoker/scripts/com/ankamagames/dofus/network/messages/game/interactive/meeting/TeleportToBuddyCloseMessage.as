package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportToBuddyCloseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1575;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public var buddyId:Number = 0;
      
      public function TeleportToBuddyCloseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1575;
      }
      
      public function initTeleportToBuddyCloseMessage(dungeonId:uint = 0, buddyId:Number = 0) : TeleportToBuddyCloseMessage
      {
         this.dungeonId = dungeonId;
         this.buddyId = buddyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dungeonId = 0;
         this.buddyId = 0;
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
         this.serializeAs_TeleportToBuddyCloseMessage(output);
      }
      
      public function serializeAs_TeleportToBuddyCloseMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportToBuddyCloseMessage(input);
      }
      
      public function deserializeAs_TeleportToBuddyCloseMessage(input:ICustomDataInput) : void
      {
         this._dungeonIdFunc(input);
         this._buddyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportToBuddyCloseMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportToBuddyCloseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dungeonIdFunc);
         tree.addChild(this._buddyIdFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportToBuddyCloseMessage.dungeonId.");
         }
      }
      
      private function _buddyIdFunc(input:ICustomDataInput) : void
      {
         this.buddyId = input.readVarUhLong();
         if(this.buddyId < 0 || this.buddyId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.buddyId + ") on element of TeleportToBuddyCloseMessage.buddyId.");
         }
      }
   }
}

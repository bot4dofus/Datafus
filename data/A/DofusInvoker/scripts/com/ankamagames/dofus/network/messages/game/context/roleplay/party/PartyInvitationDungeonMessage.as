package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyInvitationDungeonMessage extends PartyInvitationMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3539;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dungeonId:uint = 0;
      
      public function PartyInvitationDungeonMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3539;
      }
      
      public function initPartyInvitationDungeonMessage(partyId:uint = 0, partyType:uint = 0, partyName:String = "", maxParticipants:uint = 0, fromId:Number = 0, fromName:String = "", toId:Number = 0, dungeonId:uint = 0) : PartyInvitationDungeonMessage
      {
         super.initPartyInvitationMessage(partyId,partyType,partyName,maxParticipants,fromId,fromName,toId);
         this.dungeonId = dungeonId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.dungeonId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyInvitationDungeonMessage(output);
      }
      
      public function serializeAs_PartyInvitationDungeonMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyInvitationMessage(output);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         output.writeVarShort(this.dungeonId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationDungeonMessage(input);
      }
      
      public function deserializeAs_PartyInvitationDungeonMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._dungeonIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationDungeonMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationDungeonMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._dungeonIdFunc);
      }
      
      private function _dungeonIdFunc(input:ICustomDataInput) : void
      {
         this.dungeonId = input.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonMessage.dungeonId.");
         }
      }
   }
}

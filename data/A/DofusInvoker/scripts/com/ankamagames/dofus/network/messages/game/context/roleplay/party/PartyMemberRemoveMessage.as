package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyMemberRemoveMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6273;
       
      
      private var _isInitialized:Boolean = false;
      
      public var leavingPlayerId:Number = 0;
      
      public function PartyMemberRemoveMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6273;
      }
      
      public function initPartyMemberRemoveMessage(partyId:uint = 0, leavingPlayerId:Number = 0) : PartyMemberRemoveMessage
      {
         super.initAbstractPartyEventMessage(partyId);
         this.leavingPlayerId = leavingPlayerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.leavingPlayerId = 0;
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
         this.serializeAs_PartyMemberRemoveMessage(output);
      }
      
      public function serializeAs_PartyMemberRemoveMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.leavingPlayerId < 0 || this.leavingPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element leavingPlayerId.");
         }
         output.writeVarLong(this.leavingPlayerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberRemoveMessage(input);
      }
      
      public function deserializeAs_PartyMemberRemoveMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._leavingPlayerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberRemoveMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._leavingPlayerIdFunc);
      }
      
      private function _leavingPlayerIdFunc(input:ICustomDataInput) : void
      {
         this.leavingPlayerId = input.readVarUhLong();
         if(this.leavingPlayerId < 0 || this.leavingPlayerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element of PartyMemberRemoveMessage.leavingPlayerId.");
         }
      }
   }
}

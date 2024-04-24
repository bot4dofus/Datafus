package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyLeaderUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 893;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyLeaderId:Number = 0;
      
      public function PartyLeaderUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 893;
      }
      
      public function initPartyLeaderUpdateMessage(partyId:uint = 0, partyLeaderId:Number = 0) : PartyLeaderUpdateMessage
      {
         super.initAbstractPartyEventMessage(partyId);
         this.partyLeaderId = partyLeaderId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyLeaderId = 0;
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
         this.serializeAs_PartyLeaderUpdateMessage(output);
      }
      
      public function serializeAs_PartyLeaderUpdateMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.partyLeaderId < 0 || this.partyLeaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
         }
         output.writeVarLong(this.partyLeaderId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyLeaderUpdateMessage(input);
      }
      
      public function deserializeAs_PartyLeaderUpdateMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._partyLeaderIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyLeaderUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyLeaderUpdateMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._partyLeaderIdFunc);
      }
      
      private function _partyLeaderIdFunc(input:ICustomDataInput) : void
      {
         this.partyLeaderId = input.readVarUhLong();
         if(this.partyLeaderId < 0 || this.partyLeaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyLeaderUpdateMessage.partyLeaderId.");
         }
      }
   }
}

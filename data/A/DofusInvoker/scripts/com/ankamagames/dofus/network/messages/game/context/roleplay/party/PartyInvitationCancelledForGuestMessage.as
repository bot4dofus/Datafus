package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyInvitationCancelledForGuestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9178;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cancelerId:Number = 0;
      
      public function PartyInvitationCancelledForGuestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9178;
      }
      
      public function initPartyInvitationCancelledForGuestMessage(partyId:uint = 0, cancelerId:Number = 0) : PartyInvitationCancelledForGuestMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.cancelerId = cancelerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cancelerId = 0;
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
         this.serializeAs_PartyInvitationCancelledForGuestMessage(output);
      }
      
      public function serializeAs_PartyInvitationCancelledForGuestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         if(this.cancelerId < 0 || this.cancelerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
         }
         output.writeVarLong(this.cancelerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationCancelledForGuestMessage(input);
      }
      
      public function deserializeAs_PartyInvitationCancelledForGuestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._cancelerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationCancelledForGuestMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationCancelledForGuestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._cancelerIdFunc);
      }
      
      private function _cancelerIdFunc(input:ICustomDataInput) : void
      {
         this.cancelerId = input.readVarUhLong();
         if(this.cancelerId < 0 || this.cancelerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyInvitationCancelledForGuestMessage.cancelerId.");
         }
      }
   }
}

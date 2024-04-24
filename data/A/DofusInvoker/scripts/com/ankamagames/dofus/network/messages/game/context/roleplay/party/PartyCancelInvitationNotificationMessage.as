package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyCancelInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3506;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cancelerId:Number = 0;
      
      public var guestId:Number = 0;
      
      public function PartyCancelInvitationNotificationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3506;
      }
      
      public function initPartyCancelInvitationNotificationMessage(partyId:uint = 0, cancelerId:Number = 0, guestId:Number = 0) : PartyCancelInvitationNotificationMessage
      {
         super.initAbstractPartyEventMessage(partyId);
         this.cancelerId = cancelerId;
         this.guestId = guestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.cancelerId = 0;
         this.guestId = 0;
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
         this.serializeAs_PartyCancelInvitationNotificationMessage(output);
      }
      
      public function serializeAs_PartyCancelInvitationNotificationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.cancelerId < 0 || this.cancelerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
         }
         output.writeVarLong(this.cancelerId);
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         output.writeVarLong(this.guestId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyCancelInvitationNotificationMessage(input);
      }
      
      public function deserializeAs_PartyCancelInvitationNotificationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._cancelerIdFunc(input);
         this._guestIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyCancelInvitationNotificationMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyCancelInvitationNotificationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._cancelerIdFunc);
         tree.addChild(this._guestIdFunc);
      }
      
      private function _cancelerIdFunc(input:ICustomDataInput) : void
      {
         this.cancelerId = input.readVarUhLong();
         if(this.cancelerId < 0 || this.cancelerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyCancelInvitationNotificationMessage.cancelerId.");
         }
      }
      
      private function _guestIdFunc(input:ICustomDataInput) : void
      {
         this.guestId = input.readVarUhLong();
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationNotificationMessage.guestId.");
         }
      }
   }
}

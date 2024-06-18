package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyCancelInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 425;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guestId:Number = 0;
      
      public function PartyCancelInvitationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 425;
      }
      
      public function initPartyCancelInvitationMessage(partyId:uint = 0, guestId:Number = 0) : PartyCancelInvitationMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.guestId = guestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_PartyCancelInvitationMessage(output);
      }
      
      public function serializeAs_PartyCancelInvitationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         output.writeVarLong(this.guestId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyCancelInvitationMessage(input);
      }
      
      public function deserializeAs_PartyCancelInvitationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._guestIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyCancelInvitationMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyCancelInvitationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._guestIdFunc);
      }
      
      private function _guestIdFunc(input:ICustomDataInput) : void
      {
         this.guestId = input.readVarUhLong();
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyCancelInvitationMessage.guestId.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyAcceptInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4342;
       
      
      private var _isInitialized:Boolean = false;
      
      public function PartyAcceptInvitationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4342;
      }
      
      public function initPartyAcceptInvitationMessage(partyId:uint = 0) : PartyAcceptInvitationMessage
      {
         super.initAbstractPartyMessage(partyId);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_PartyAcceptInvitationMessage(output);
      }
      
      public function serializeAs_PartyAcceptInvitationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyAcceptInvitationMessage(input);
      }
      
      public function deserializeAs_PartyAcceptInvitationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyAcceptInvitationMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyAcceptInvitationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

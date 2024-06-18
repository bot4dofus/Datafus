package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyInvitationArenaRequestMessage extends PartyInvitationRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2774;
       
      
      private var _isInitialized:Boolean = false;
      
      public function PartyInvitationArenaRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2774;
      }
      
      public function initPartyInvitationArenaRequestMessage(target:AbstractPlayerSearchInformation = null) : PartyInvitationArenaRequestMessage
      {
         super.initPartyInvitationRequestMessage(target);
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
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_PartyInvitationArenaRequestMessage(output);
      }
      
      public function serializeAs_PartyInvitationArenaRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyInvitationRequestMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationArenaRequestMessage(input);
      }
      
      public function deserializeAs_PartyInvitationArenaRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationArenaRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationArenaRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

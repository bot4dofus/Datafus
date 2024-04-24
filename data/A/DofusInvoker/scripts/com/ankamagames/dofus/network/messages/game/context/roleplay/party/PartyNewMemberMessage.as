package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyNewMemberMessage extends PartyUpdateMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4803;
       
      
      private var _isInitialized:Boolean = false;
      
      public function PartyNewMemberMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4803;
      }
      
      public function initPartyNewMemberMessage(partyId:uint = 0, memberInformations:PartyMemberInformations = null) : PartyNewMemberMessage
      {
         super.initPartyUpdateMessage(partyId,memberInformations);
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
         this.serializeAs_PartyNewMemberMessage(output);
      }
      
      public function serializeAs_PartyNewMemberMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyUpdateMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyNewMemberMessage(input);
      }
      
      public function deserializeAs_PartyNewMemberMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyNewMemberMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyNewMemberMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

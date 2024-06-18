package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyNewGuestMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7060;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guest:PartyGuestInformations;
      
      private var _guesttree:FuncTree;
      
      public function PartyNewGuestMessage()
      {
         this.guest = new PartyGuestInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7060;
      }
      
      public function initPartyNewGuestMessage(partyId:uint = 0, guest:PartyGuestInformations = null) : PartyNewGuestMessage
      {
         super.initAbstractPartyEventMessage(partyId);
         this.guest = guest;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guest = new PartyGuestInformations();
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
         this.serializeAs_PartyNewGuestMessage(output);
      }
      
      public function serializeAs_PartyNewGuestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyEventMessage(output);
         this.guest.serializeAs_PartyGuestInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyNewGuestMessage(input);
      }
      
      public function deserializeAs_PartyNewGuestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.guest = new PartyGuestInformations();
         this.guest.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyNewGuestMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyNewGuestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._guesttree = tree.addChild(this._guesttreeFunc);
      }
      
      private function _guesttreeFunc(input:ICustomDataInput) : void
      {
         this.guest = new PartyGuestInformations();
         this.guest.deserializeAsync(this._guesttree);
      }
   }
}

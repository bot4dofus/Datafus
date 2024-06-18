package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 729;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyType:uint = 0;
      
      public var partyName:String = "";
      
      public var maxParticipants:uint = 0;
      
      public var fromId:Number = 0;
      
      public var fromName:String = "";
      
      public var toId:Number = 0;
      
      public function PartyInvitationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 729;
      }
      
      public function initPartyInvitationMessage(partyId:uint = 0, partyType:uint = 0, partyName:String = "", maxParticipants:uint = 0, fromId:Number = 0, fromName:String = "", toId:Number = 0) : PartyInvitationMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.partyType = partyType;
         this.partyName = partyName;
         this.maxParticipants = maxParticipants;
         this.fromId = fromId;
         this.fromName = fromName;
         this.toId = toId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyType = 0;
         this.partyName = "";
         this.maxParticipants = 0;
         this.fromId = 0;
         this.fromName = "";
         this.toId = 0;
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
         this.serializeAs_PartyInvitationMessage(output);
      }
      
      public function serializeAs_PartyInvitationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.partyType);
         output.writeUTF(this.partyName);
         if(this.maxParticipants < 0)
         {
            throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
         }
         output.writeByte(this.maxParticipants);
         if(this.fromId < 0 || this.fromId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
         }
         output.writeVarLong(this.fromId);
         output.writeUTF(this.fromName);
         if(this.toId < 0 || this.toId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.toId + ") on element toId.");
         }
         output.writeVarLong(this.toId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationMessage(input);
      }
      
      public function deserializeAs_PartyInvitationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._partyTypeFunc(input);
         this._partyNameFunc(input);
         this._maxParticipantsFunc(input);
         this._fromIdFunc(input);
         this._fromNameFunc(input);
         this._toIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._partyTypeFunc);
         tree.addChild(this._partyNameFunc);
         tree.addChild(this._maxParticipantsFunc);
         tree.addChild(this._fromIdFunc);
         tree.addChild(this._fromNameFunc);
         tree.addChild(this._toIdFunc);
      }
      
      private function _partyTypeFunc(input:ICustomDataInput) : void
      {
         this.partyType = input.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationMessage.partyType.");
         }
      }
      
      private function _partyNameFunc(input:ICustomDataInput) : void
      {
         this.partyName = input.readUTF();
      }
      
      private function _maxParticipantsFunc(input:ICustomDataInput) : void
      {
         this.maxParticipants = input.readByte();
         if(this.maxParticipants < 0)
         {
            throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyInvitationMessage.maxParticipants.");
         }
      }
      
      private function _fromIdFunc(input:ICustomDataInput) : void
      {
         this.fromId = input.readVarUhLong();
         if(this.fromId < 0 || this.fromId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationMessage.fromId.");
         }
      }
      
      private function _fromNameFunc(input:ICustomDataInput) : void
      {
         this.fromName = input.readUTF();
      }
      
      private function _toIdFunc(input:ICustomDataInput) : void
      {
         this.toId = input.readVarUhLong();
         if(this.toId < 0 || this.toId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.toId + ") on element of PartyInvitationMessage.toId.");
         }
      }
   }
}

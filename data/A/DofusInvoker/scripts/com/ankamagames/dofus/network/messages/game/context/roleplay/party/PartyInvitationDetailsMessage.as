package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyInvitationDetailsMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8607;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyType:uint = 0;
      
      public var partyName:String = "";
      
      public var fromId:Number = 0;
      
      public var fromName:String = "";
      
      public var leaderId:Number = 0;
      
      public var members:Vector.<PartyInvitationMemberInformations>;
      
      public var guests:Vector.<PartyGuestInformations>;
      
      private var _memberstree:FuncTree;
      
      private var _gueststree:FuncTree;
      
      public function PartyInvitationDetailsMessage()
      {
         this.members = new Vector.<PartyInvitationMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8607;
      }
      
      public function initPartyInvitationDetailsMessage(partyId:uint = 0, partyType:uint = 0, partyName:String = "", fromId:Number = 0, fromName:String = "", leaderId:Number = 0, members:Vector.<PartyInvitationMemberInformations> = null, guests:Vector.<PartyGuestInformations> = null) : PartyInvitationDetailsMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.partyType = partyType;
         this.partyName = partyName;
         this.fromId = fromId;
         this.fromName = fromName;
         this.leaderId = leaderId;
         this.members = members;
         this.guests = guests;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyType = 0;
         this.partyName = "";
         this.fromId = 0;
         this.fromName = "";
         this.leaderId = 0;
         this.members = new Vector.<PartyInvitationMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
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
         this.serializeAs_PartyInvitationDetailsMessage(output);
      }
      
      public function serializeAs_PartyInvitationDetailsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.partyType);
         output.writeUTF(this.partyName);
         if(this.fromId < 0 || this.fromId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fromId + ") on element fromId.");
         }
         output.writeVarLong(this.fromId);
         output.writeUTF(this.fromName);
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element leaderId.");
         }
         output.writeVarLong(this.leaderId);
         output.writeShort(this.members.length);
         for(var _i6:uint = 0; _i6 < this.members.length; _i6++)
         {
            output.writeShort((this.members[_i6] as PartyInvitationMemberInformations).getTypeId());
            (this.members[_i6] as PartyInvitationMemberInformations).serialize(output);
         }
         output.writeShort(this.guests.length);
         for(var _i7:uint = 0; _i7 < this.guests.length; _i7++)
         {
            (this.guests[_i7] as PartyGuestInformations).serializeAs_PartyGuestInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationDetailsMessage(input);
      }
      
      public function deserializeAs_PartyInvitationDetailsMessage(input:ICustomDataInput) : void
      {
         var _id6:uint = 0;
         var _item6:PartyInvitationMemberInformations = null;
         var _item7:PartyGuestInformations = null;
         super.deserialize(input);
         this._partyTypeFunc(input);
         this._partyNameFunc(input);
         this._fromIdFunc(input);
         this._fromNameFunc(input);
         this._leaderIdFunc(input);
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _membersLen; _i6++)
         {
            _id6 = input.readUnsignedShort();
            _item6 = ProtocolTypeManager.getInstance(PartyInvitationMemberInformations,_id6);
            _item6.deserialize(input);
            this.members.push(_item6);
         }
         var _guestsLen:uint = input.readUnsignedShort();
         for(var _i7:uint = 0; _i7 < _guestsLen; _i7++)
         {
            _item7 = new PartyGuestInformations();
            _item7.deserialize(input);
            this.guests.push(_item7);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationDetailsMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationDetailsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._partyTypeFunc);
         tree.addChild(this._partyNameFunc);
         tree.addChild(this._fromIdFunc);
         tree.addChild(this._fromNameFunc);
         tree.addChild(this._leaderIdFunc);
         this._memberstree = tree.addChild(this._memberstreeFunc);
         this._gueststree = tree.addChild(this._gueststreeFunc);
      }
      
      private function _partyTypeFunc(input:ICustomDataInput) : void
      {
         this.partyType = input.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyInvitationDetailsMessage.partyType.");
         }
      }
      
      private function _partyNameFunc(input:ICustomDataInput) : void
      {
         this.partyName = input.readUTF();
      }
      
      private function _fromIdFunc(input:ICustomDataInput) : void
      {
         this.fromId = input.readVarUhLong();
         if(this.fromId < 0 || this.fromId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.fromId + ") on element of PartyInvitationDetailsMessage.fromId.");
         }
      }
      
      private function _fromNameFunc(input:ICustomDataInput) : void
      {
         this.fromName = input.readUTF();
      }
      
      private function _leaderIdFunc(input:ICustomDataInput) : void
      {
         this.leaderId = input.readVarUhLong();
         if(this.leaderId < 0 || this.leaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.leaderId + ") on element of PartyInvitationDetailsMessage.leaderId.");
         }
      }
      
      private function _memberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._memberstree.addChild(this._membersFunc);
         }
      }
      
      private function _membersFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:PartyInvitationMemberInformations = ProtocolTypeManager.getInstance(PartyInvitationMemberInformations,_id);
         _item.deserialize(input);
         this.members.push(_item);
      }
      
      private function _gueststreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._gueststree.addChild(this._guestsFunc);
         }
      }
      
      private function _guestsFunc(input:ICustomDataInput) : void
      {
         var _item:PartyGuestInformations = new PartyGuestInformations();
         _item.deserialize(input);
         this.guests.push(_item);
      }
   }
}

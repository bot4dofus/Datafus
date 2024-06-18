package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyJoinMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6577;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyType:uint = 0;
      
      public var partyLeaderId:Number = 0;
      
      public var maxParticipants:uint = 0;
      
      public var members:Vector.<PartyMemberInformations>;
      
      public var guests:Vector.<PartyGuestInformations>;
      
      public var restricted:Boolean = false;
      
      public var partyName:String = "";
      
      private var _memberstree:FuncTree;
      
      private var _gueststree:FuncTree;
      
      public function PartyJoinMessage()
      {
         this.members = new Vector.<PartyMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6577;
      }
      
      public function initPartyJoinMessage(partyId:uint = 0, partyType:uint = 0, partyLeaderId:Number = 0, maxParticipants:uint = 0, members:Vector.<PartyMemberInformations> = null, guests:Vector.<PartyGuestInformations> = null, restricted:Boolean = false, partyName:String = "") : PartyJoinMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.partyType = partyType;
         this.partyLeaderId = partyLeaderId;
         this.maxParticipants = maxParticipants;
         this.members = members;
         this.guests = guests;
         this.restricted = restricted;
         this.partyName = partyName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.partyType = 0;
         this.partyLeaderId = 0;
         this.maxParticipants = 0;
         this.members = new Vector.<PartyMemberInformations>();
         this.guests = new Vector.<PartyGuestInformations>();
         this.restricted = false;
         this.partyName = "";
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
         this.serializeAs_PartyJoinMessage(output);
      }
      
      public function serializeAs_PartyJoinMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.partyType);
         if(this.partyLeaderId < 0 || this.partyLeaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
         }
         output.writeVarLong(this.partyLeaderId);
         if(this.maxParticipants < 0)
         {
            throw new Error("Forbidden value (" + this.maxParticipants + ") on element maxParticipants.");
         }
         output.writeByte(this.maxParticipants);
         output.writeShort(this.members.length);
         for(var _i4:uint = 0; _i4 < this.members.length; _i4++)
         {
            output.writeShort((this.members[_i4] as PartyMemberInformations).getTypeId());
            (this.members[_i4] as PartyMemberInformations).serialize(output);
         }
         output.writeShort(this.guests.length);
         for(var _i5:uint = 0; _i5 < this.guests.length; _i5++)
         {
            (this.guests[_i5] as PartyGuestInformations).serializeAs_PartyGuestInformations(output);
         }
         output.writeBoolean(this.restricted);
         output.writeUTF(this.partyName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyJoinMessage(input);
      }
      
      public function deserializeAs_PartyJoinMessage(input:ICustomDataInput) : void
      {
         var _id4:uint = 0;
         var _item4:PartyMemberInformations = null;
         var _item5:PartyGuestInformations = null;
         super.deserialize(input);
         this._partyTypeFunc(input);
         this._partyLeaderIdFunc(input);
         this._maxParticipantsFunc(input);
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i4:uint = 0; _i4 < _membersLen; _i4++)
         {
            _id4 = input.readUnsignedShort();
            _item4 = ProtocolTypeManager.getInstance(PartyMemberInformations,_id4);
            _item4.deserialize(input);
            this.members.push(_item4);
         }
         var _guestsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _guestsLen; _i5++)
         {
            _item5 = new PartyGuestInformations();
            _item5.deserialize(input);
            this.guests.push(_item5);
         }
         this._restrictedFunc(input);
         this._partyNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyJoinMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyJoinMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._partyTypeFunc);
         tree.addChild(this._partyLeaderIdFunc);
         tree.addChild(this._maxParticipantsFunc);
         this._memberstree = tree.addChild(this._memberstreeFunc);
         this._gueststree = tree.addChild(this._gueststreeFunc);
         tree.addChild(this._restrictedFunc);
         tree.addChild(this._partyNameFunc);
      }
      
      private function _partyTypeFunc(input:ICustomDataInput) : void
      {
         this.partyType = input.readByte();
         if(this.partyType < 0)
         {
            throw new Error("Forbidden value (" + this.partyType + ") on element of PartyJoinMessage.partyType.");
         }
      }
      
      private function _partyLeaderIdFunc(input:ICustomDataInput) : void
      {
         this.partyLeaderId = input.readVarUhLong();
         if(this.partyLeaderId < 0 || this.partyLeaderId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyJoinMessage.partyLeaderId.");
         }
      }
      
      private function _maxParticipantsFunc(input:ICustomDataInput) : void
      {
         this.maxParticipants = input.readByte();
         if(this.maxParticipants < 0)
         {
            throw new Error("Forbidden value (" + this.maxParticipants + ") on element of PartyJoinMessage.maxParticipants.");
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
         var _item:PartyMemberInformations = ProtocolTypeManager.getInstance(PartyMemberInformations,_id);
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
      
      private function _restrictedFunc(input:ICustomDataInput) : void
      {
         this.restricted = input.readBoolean();
      }
      
      private function _partyNameFunc(input:ICustomDataInput) : void
      {
         this.partyName = input.readUTF();
      }
   }
}

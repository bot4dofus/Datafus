package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityBaseInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyGuestInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3127;
       
      
      public var guestId:Number = 0;
      
      public var hostId:Number = 0;
      
      public var name:String = "";
      
      public var guestLook:EntityLook;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var status:PlayerStatus;
      
      public var entities:Vector.<PartyEntityBaseInformation>;
      
      private var _guestLooktree:FuncTree;
      
      private var _statustree:FuncTree;
      
      private var _entitiestree:FuncTree;
      
      public function PartyGuestInformations()
      {
         this.guestLook = new EntityLook();
         this.status = new PlayerStatus();
         this.entities = new Vector.<PartyEntityBaseInformation>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3127;
      }
      
      public function initPartyGuestInformations(guestId:Number = 0, hostId:Number = 0, name:String = "", guestLook:EntityLook = null, breed:int = 0, sex:Boolean = false, status:PlayerStatus = null, entities:Vector.<PartyEntityBaseInformation> = null) : PartyGuestInformations
      {
         this.guestId = guestId;
         this.hostId = hostId;
         this.name = name;
         this.guestLook = guestLook;
         this.breed = breed;
         this.sex = sex;
         this.status = status;
         this.entities = entities;
         return this;
      }
      
      public function reset() : void
      {
         this.guestId = 0;
         this.hostId = 0;
         this.name = "";
         this.guestLook = new EntityLook();
         this.sex = false;
         this.status = new PlayerStatus();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyGuestInformations(output);
      }
      
      public function serializeAs_PartyGuestInformations(output:ICustomDataOutput) : void
      {
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         output.writeVarLong(this.guestId);
         if(this.hostId < 0 || this.hostId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.hostId + ") on element hostId.");
         }
         output.writeVarLong(this.hostId);
         output.writeUTF(this.name);
         this.guestLook.serializeAs_EntityLook(output);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
         output.writeShort(this.entities.length);
         for(var _i8:uint = 0; _i8 < this.entities.length; _i8++)
         {
            (this.entities[_i8] as PartyEntityBaseInformation).serializeAs_PartyEntityBaseInformation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyGuestInformations(input);
      }
      
      public function deserializeAs_PartyGuestInformations(input:ICustomDataInput) : void
      {
         var _item8:PartyEntityBaseInformation = null;
         this._guestIdFunc(input);
         this._hostIdFunc(input);
         this._nameFunc(input);
         this.guestLook = new EntityLook();
         this.guestLook.deserialize(input);
         this._breedFunc(input);
         this._sexFunc(input);
         var _id7:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id7);
         this.status.deserialize(input);
         var _entitiesLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _entitiesLen; _i8++)
         {
            _item8 = new PartyEntityBaseInformation();
            _item8.deserialize(input);
            this.entities.push(_item8);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyGuestInformations(tree);
      }
      
      public function deserializeAsyncAs_PartyGuestInformations(tree:FuncTree) : void
      {
         tree.addChild(this._guestIdFunc);
         tree.addChild(this._hostIdFunc);
         tree.addChild(this._nameFunc);
         this._guestLooktree = tree.addChild(this._guestLooktreeFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
         this._entitiestree = tree.addChild(this._entitiestreeFunc);
      }
      
      private function _guestIdFunc(input:ICustomDataInput) : void
      {
         this.guestId = input.readVarUhLong();
         if(this.guestId < 0 || this.guestId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyGuestInformations.guestId.");
         }
      }
      
      private function _hostIdFunc(input:ICustomDataInput) : void
      {
         this.hostId = input.readVarUhLong();
         if(this.hostId < 0 || this.hostId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.hostId + ") on element of PartyGuestInformations.hostId.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _guestLooktreeFunc(input:ICustomDataInput) : void
      {
         this.guestLook = new EntityLook();
         this.guestLook.deserializeAsync(this._guestLooktree);
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
      
      private function _entitiestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._entitiestree.addChild(this._entitiesFunc);
         }
      }
      
      private function _entitiesFunc(input:ICustomDataInput) : void
      {
         var _item:PartyEntityBaseInformation = new PartyEntityBaseInformation();
         _item.deserialize(input);
         this.entities.push(_item);
      }
   }
}

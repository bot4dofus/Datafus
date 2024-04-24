package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityBaseInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyMemberInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7120;
       
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var prospecting:uint = 0;
      
      public var regenRate:uint = 0;
      
      public var initiative:uint = 0;
      
      public var alignmentSide:int = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var status:PlayerStatus;
      
      public var entities:Vector.<PartyEntityBaseInformation>;
      
      private var _statustree:FuncTree;
      
      private var _entitiestree:FuncTree;
      
      public function PartyMemberInformations()
      {
         this.status = new PlayerStatus();
         this.entities = new Vector.<PartyEntityBaseInformation>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7120;
      }
      
      public function initPartyMemberInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false, lifePoints:uint = 0, maxLifePoints:uint = 0, prospecting:uint = 0, regenRate:uint = 0, initiative:uint = 0, alignmentSide:int = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, status:PlayerStatus = null, entities:Vector.<PartyEntityBaseInformation> = null) : PartyMemberInformations
      {
         super.initCharacterBaseInformations(id,name,level,entityLook,breed,sex);
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.prospecting = prospecting;
         this.regenRate = regenRate;
         this.initiative = initiative;
         this.alignmentSide = alignmentSide;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.status = status;
         this.entities = entities;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.lifePoints = 0;
         this.maxLifePoints = 0;
         this.prospecting = 0;
         this.regenRate = 0;
         this.initiative = 0;
         this.alignmentSide = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.status = new PlayerStatus();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyMemberInformations(output);
      }
      
      public function serializeAs_PartyMemberInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterBaseInformations(output);
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         output.writeVarInt(this.lifePoints);
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
         }
         output.writeVarInt(this.maxLifePoints);
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
         }
         output.writeVarInt(this.prospecting);
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
         }
         output.writeByte(this.regenRate);
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
         }
         output.writeVarInt(this.initiative);
         output.writeByte(this.alignmentSide);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
         output.writeShort(this.entities.length);
         for(var _i12:uint = 0; _i12 < this.entities.length; _i12++)
         {
            output.writeShort((this.entities[_i12] as PartyEntityBaseInformation).getTypeId());
            (this.entities[_i12] as PartyEntityBaseInformation).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberInformations(input);
      }
      
      public function deserializeAs_PartyMemberInformations(input:ICustomDataInput) : void
      {
         var _id12:uint = 0;
         var _item12:PartyEntityBaseInformation = null;
         super.deserialize(input);
         this._lifePointsFunc(input);
         this._maxLifePointsFunc(input);
         this._prospectingFunc(input);
         this._regenRateFunc(input);
         this._initiativeFunc(input);
         this._alignmentSideFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         var _id11:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id11);
         this.status.deserialize(input);
         var _entitiesLen:uint = input.readUnsignedShort();
         for(var _i12:uint = 0; _i12 < _entitiesLen; _i12++)
         {
            _id12 = input.readUnsignedShort();
            _item12 = ProtocolTypeManager.getInstance(PartyEntityBaseInformation,_id12);
            _item12.deserialize(input);
            this.entities.push(_item12);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberInformations(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._lifePointsFunc);
         tree.addChild(this._maxLifePointsFunc);
         tree.addChild(this._prospectingFunc);
         tree.addChild(this._regenRateFunc);
         tree.addChild(this._initiativeFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
         this._entitiestree = tree.addChild(this._entitiestreeFunc);
      }
      
      private function _lifePointsFunc(input:ICustomDataInput) : void
      {
         this.lifePoints = input.readVarUhInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyMemberInformations.lifePoints.");
         }
      }
      
      private function _maxLifePointsFunc(input:ICustomDataInput) : void
      {
         this.maxLifePoints = input.readVarUhInt();
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyMemberInformations.maxLifePoints.");
         }
      }
      
      private function _prospectingFunc(input:ICustomDataInput) : void
      {
         this.prospecting = input.readVarUhInt();
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyMemberInformations.prospecting.");
         }
      }
      
      private function _regenRateFunc(input:ICustomDataInput) : void
      {
         this.regenRate = input.readUnsignedByte();
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyMemberInformations.regenRate.");
         }
      }
      
      private function _initiativeFunc(input:ICustomDataInput) : void
      {
         this.initiative = input.readVarUhInt();
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element of PartyMemberInformations.initiative.");
         }
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PartyMemberInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of PartyMemberInformations.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of PartyMemberInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyMemberInformations.subAreaId.");
         }
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
         var _id:uint = input.readUnsignedShort();
         var _item:PartyEntityBaseInformation = ProtocolTypeManager.getInstance(PartyEntityBaseInformation,_id);
         _item.deserialize(input);
         this.entities.push(_item);
      }
   }
}

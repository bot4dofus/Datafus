package com.ankamagames.dofus.network.types.game.context.roleplay.party
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityBaseInformation;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyInvitationMemberInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8078;
       
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var entities:Vector.<PartyEntityBaseInformation>;
      
      private var _entitiestree:FuncTree;
      
      public function PartyInvitationMemberInformations()
      {
         this.entities = new Vector.<PartyEntityBaseInformation>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8078;
      }
      
      public function initPartyInvitationMemberInformations(id:Number = 0, name:String = "", level:uint = 0, entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, entities:Vector.<PartyEntityBaseInformation> = null) : PartyInvitationMemberInformations
      {
         super.initCharacterBaseInformations(id,name,level,entityLook,breed,sex);
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.entities = entities;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.entities = new Vector.<PartyEntityBaseInformation>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyInvitationMemberInformations(output);
      }
      
      public function serializeAs_PartyInvitationMemberInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterBaseInformations(output);
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
         output.writeShort(this.entities.length);
         for(var _i5:uint = 0; _i5 < this.entities.length; _i5++)
         {
            (this.entities[_i5] as PartyEntityBaseInformation).serializeAs_PartyEntityBaseInformation(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationMemberInformations(input);
      }
      
      public function deserializeAs_PartyInvitationMemberInformations(input:ICustomDataInput) : void
      {
         var _item5:PartyEntityBaseInformation = null;
         super.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         var _entitiesLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _entitiesLen; _i5++)
         {
            _item5 = new PartyEntityBaseInformation();
            _item5.deserialize(input);
            this.entities.push(_item5);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyInvitationMemberInformations(tree);
      }
      
      public function deserializeAsyncAs_PartyInvitationMemberInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         this._entitiestree = tree.addChild(this._entitiestreeFunc);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PartyInvitationMemberInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of PartyInvitationMemberInformations.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of PartyInvitationMemberInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PartyInvitationMemberInformations.subAreaId.");
         }
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

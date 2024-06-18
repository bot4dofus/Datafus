package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseInformationsForGuild extends HouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 409;
       
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var ownerTag:AccountTagInformation;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var skillListIds:Vector.<int>;
      
      public var guildshareParams:uint = 0;
      
      private var _ownerTagtree:FuncTree;
      
      private var _skillListIdstree:FuncTree;
      
      public function HouseInformationsForGuild()
      {
         this.ownerTag = new AccountTagInformation();
         this.skillListIds = new Vector.<int>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 409;
      }
      
      public function initHouseInformationsForGuild(houseId:uint = 0, modelId:uint = 0, instanceId:uint = 0, secondHand:Boolean = false, ownerTag:AccountTagInformation = null, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, skillListIds:Vector.<int> = null, guildshareParams:uint = 0) : HouseInformationsForGuild
      {
         super.initHouseInformations(houseId,modelId);
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.ownerTag = ownerTag;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.skillListIds = skillListIds;
         this.guildshareParams = guildshareParams;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.instanceId = 0;
         this.secondHand = false;
         this.ownerTag = new AccountTagInformation();
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.skillListIds = new Vector.<int>();
         this.guildshareParams = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformationsForGuild(output);
      }
      
      public function serializeAs_HouseInformationsForGuild(output:ICustomDataOutput) : void
      {
         super.serializeAs_HouseInformations(output);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.secondHand);
         this.ownerTag.serializeAs_AccountTagInformation(output);
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
         output.writeShort(this.skillListIds.length);
         for(var _i8:uint = 0; _i8 < this.skillListIds.length; _i8++)
         {
            output.writeInt(this.skillListIds[_i8]);
         }
         if(this.guildshareParams < 0)
         {
            throw new Error("Forbidden value (" + this.guildshareParams + ") on element guildshareParams.");
         }
         output.writeVarInt(this.guildshareParams);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformationsForGuild(input);
      }
      
      public function deserializeAs_HouseInformationsForGuild(input:ICustomDataInput) : void
      {
         var _val8:int = 0;
         super.deserialize(input);
         this._instanceIdFunc(input);
         this._secondHandFunc(input);
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         var _skillListIdsLen:uint = input.readUnsignedShort();
         for(var _i8:uint = 0; _i8 < _skillListIdsLen; _i8++)
         {
            _val8 = input.readInt();
            this.skillListIds.push(_val8);
         }
         this._guildshareParamsFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseInformationsForGuild(tree);
      }
      
      public function deserializeAsyncAs_HouseInformationsForGuild(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._secondHandFunc);
         this._ownerTagtree = tree.addChild(this._ownerTagtreeFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         this._skillListIdstree = tree.addChild(this._skillListIdstreeFunc);
         tree.addChild(this._guildshareParamsFunc);
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseInformationsForGuild.instanceId.");
         }
      }
      
      private function _secondHandFunc(input:ICustomDataInput) : void
      {
         this.secondHand = input.readBoolean();
      }
      
      private function _ownerTagtreeFunc(input:ICustomDataInput) : void
      {
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserializeAsync(this._ownerTagtree);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForGuild.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForGuild.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of HouseInformationsForGuild.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForGuild.subAreaId.");
         }
      }
      
      private function _skillListIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._skillListIdstree.addChild(this._skillListIdsFunc);
         }
      }
      
      private function _skillListIdsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readInt();
         this.skillListIds.push(_val);
      }
      
      private function _guildshareParamsFunc(input:ICustomDataInput) : void
      {
         this.guildshareParams = input.readVarUhInt();
         if(this.guildshareParams < 0)
         {
            throw new Error("Forbidden value (" + this.guildshareParams + ") on element of HouseInformationsForGuild.guildshareParams.");
         }
      }
   }
}

package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobCrafterDirectoryEntryPlayerInfo implements INetworkType
   {
      
      public static const protocolId:uint = 8355;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var alignmentSide:int = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var isInWorkshop:Boolean = false;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public var canCraftLegendary:Boolean = false;
      
      public var status:PlayerStatus;
      
      private var _statustree:FuncTree;
      
      public function JobCrafterDirectoryEntryPlayerInfo()
      {
         this.status = new PlayerStatus();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8355;
      }
      
      public function initJobCrafterDirectoryEntryPlayerInfo(playerId:Number = 0, playerName:String = "", alignmentSide:int = 0, breed:int = 0, sex:Boolean = false, isInWorkshop:Boolean = false, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0, canCraftLegendary:Boolean = false, status:PlayerStatus = null) : JobCrafterDirectoryEntryPlayerInfo
      {
         this.playerId = playerId;
         this.playerName = playerName;
         this.alignmentSide = alignmentSide;
         this.breed = breed;
         this.sex = sex;
         this.isInWorkshop = isInWorkshop;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.canCraftLegendary = canCraftLegendary;
         this.status = status;
         return this;
      }
      
      public function reset() : void
      {
         this.playerId = 0;
         this.playerName = "";
         this.alignmentSide = 0;
         this.breed = 0;
         this.sex = false;
         this.isInWorkshop = false;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.canCraftLegendary = false;
         this.status = new PlayerStatus();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryEntryPlayerInfo(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryPlayerInfo(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.alignmentSide);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         output.writeBoolean(this.isInWorkshop);
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
         output.writeBoolean(this.canCraftLegendary);
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryEntryPlayerInfo(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryPlayerInfo(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._alignmentSideFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._isInWorkshopFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
         this._canCraftLegendaryFunc(input);
         var _id12:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id12);
         this.status.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryEntryPlayerInfo(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryEntryPlayerInfo(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._alignmentSideFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._isInWorkshopFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._canCraftLegendaryFunc);
         this._statustree = tree.addChild(this._statustreeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of JobCrafterDirectoryEntryPlayerInfo.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _alignmentSideFunc(input:ICustomDataInput) : void
      {
         this.alignmentSide = input.readByte();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of JobCrafterDirectoryEntryPlayerInfo.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _isInWorkshopFunc(input:ICustomDataInput) : void
      {
         this.isInWorkshop = input.readBoolean();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of JobCrafterDirectoryEntryPlayerInfo.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of JobCrafterDirectoryEntryPlayerInfo.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of JobCrafterDirectoryEntryPlayerInfo.subAreaId.");
         }
      }
      
      private function _canCraftLegendaryFunc(input:ICustomDataInput) : void
      {
         this.canCraftLegendary = input.readBoolean();
      }
      
      private function _statustreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id);
         this.status.deserializeAsync(this._statustree);
      }
   }
}

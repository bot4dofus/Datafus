package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AccountHouseInformations extends HouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8107;
       
      
      public var houseInfos:HouseInstanceInformations;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      private var _houseInfostree:FuncTree;
      
      public function AccountHouseInformations()
      {
         this.houseInfos = new HouseInstanceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8107;
      }
      
      public function initAccountHouseInformations(houseId:uint = 0, modelId:uint = 0, houseInfos:HouseInstanceInformations = null, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0) : AccountHouseInformations
      {
         super.initHouseInformations(houseId,modelId);
         this.houseInfos = houseInfos;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.houseInfos = new HouseInstanceInformations();
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AccountHouseInformations(output);
      }
      
      public function serializeAs_AccountHouseInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_HouseInformations(output);
         output.writeShort(this.houseInfos.getTypeId());
         this.houseInfos.serialize(output);
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
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountHouseInformations(input);
      }
      
      public function deserializeAs_AccountHouseInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.houseInfos = ProtocolTypeManager.getInstance(HouseInstanceInformations,_id1);
         this.houseInfos.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountHouseInformations(tree);
      }
      
      public function deserializeAsyncAs_AccountHouseInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._houseInfostree = tree.addChild(this._houseInfostreeFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
      }
      
      private function _houseInfostreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.houseInfos = ProtocolTypeManager.getInstance(HouseInstanceInformations,_id);
         this.houseInfos.deserializeAsync(this._houseInfostree);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of AccountHouseInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of AccountHouseInformations.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of AccountHouseInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of AccountHouseInformations.subAreaId.");
         }
      }
   }
}

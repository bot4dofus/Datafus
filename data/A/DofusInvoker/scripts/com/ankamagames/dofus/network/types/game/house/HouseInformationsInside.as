package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseInformationsInside extends HouseInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4258;
       
      
      public var houseInfos:HouseInstanceInformations;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      private var _houseInfostree:FuncTree;
      
      public function HouseInformationsInside()
      {
         this.houseInfos = new HouseInstanceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4258;
      }
      
      public function initHouseInformationsInside(houseId:uint = 0, modelId:uint = 0, houseInfos:HouseInstanceInformations = null, worldX:int = 0, worldY:int = 0) : HouseInformationsInside
      {
         super.initHouseInformations(houseId,modelId);
         this.houseInfos = houseInfos;
         this.worldX = worldX;
         this.worldY = worldY;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.houseInfos = new HouseInstanceInformations();
         this.worldY = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformationsInside(output);
      }
      
      public function serializeAs_HouseInformationsInside(output:ICustomDataOutput) : void
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
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformationsInside(input);
      }
      
      public function deserializeAs_HouseInformationsInside(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.houseInfos = ProtocolTypeManager.getInstance(HouseInstanceInformations,_id1);
         this.houseInfos.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseInformationsInside(tree);
      }
      
      public function deserializeAsyncAs_HouseInformationsInside(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._houseInfostree = tree.addChild(this._houseInfostreeFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
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
            throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsInside.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsInside.worldY.");
         }
      }
   }
}

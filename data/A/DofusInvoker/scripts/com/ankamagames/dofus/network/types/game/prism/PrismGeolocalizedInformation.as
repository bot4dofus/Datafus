package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismGeolocalizedInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9281;
       
      
      public var subAreaId:uint = 0;
      
      public var allianceId:uint = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var prism:PrismInformation;
      
      private var _prismtree:FuncTree;
      
      public function PrismGeolocalizedInformation()
      {
         this.prism = new PrismInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9281;
      }
      
      public function initPrismGeolocalizedInformation(subAreaId:uint = 0, allianceId:uint = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, prism:PrismInformation = null) : PrismGeolocalizedInformation
      {
         this.subAreaId = subAreaId;
         this.allianceId = allianceId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.prism = prism;
         return this;
      }
      
      public function reset() : void
      {
         this.subAreaId = 0;
         this.allianceId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.prism = new PrismInformation();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismGeolocalizedInformation(output);
      }
      
      public function serializeAs_PrismGeolocalizedInformation(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         output.writeVarInt(this.allianceId);
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
         output.writeShort(this.prism.getTypeId());
         this.prism.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismGeolocalizedInformation(input);
      }
      
      public function deserializeAs_PrismGeolocalizedInformation(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._allianceIdFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         var _id6:uint = input.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id6);
         this.prism.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismGeolocalizedInformation(tree);
      }
      
      public function deserializeAsyncAs_PrismGeolocalizedInformation(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._allianceIdFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         this._prismtree = tree.addChild(this._prismtreeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismGeolocalizedInformation.subAreaId.");
         }
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of PrismGeolocalizedInformation.allianceId.");
         }
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PrismGeolocalizedInformation.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of PrismGeolocalizedInformation.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of PrismGeolocalizedInformation.mapId.");
         }
      }
      
      private function _prismtreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id);
         this.prism.deserializeAsync(this._prismtree);
      }
   }
}

package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PrismGeolocalizedInformation extends PrismSubareaEmptyInfo implements INetworkType
   {
      
      public static const protocolId:uint = 8423;
       
      
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
      
      override public function getTypeId() : uint
      {
         return 8423;
      }
      
      public function initPrismGeolocalizedInformation(subAreaId:uint = 0, allianceId:uint = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, prism:PrismInformation = null) : PrismGeolocalizedInformation
      {
         super.initPrismSubareaEmptyInfo(subAreaId,allianceId);
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.prism = prism;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.prism = new PrismInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PrismGeolocalizedInformation(output);
      }
      
      public function serializeAs_PrismGeolocalizedInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PrismSubareaEmptyInfo(output);
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
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismGeolocalizedInformation(input);
      }
      
      public function deserializeAs_PrismGeolocalizedInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         var _id4:uint = input.readUnsignedShort();
         this.prism = ProtocolTypeManager.getInstance(PrismInformation,_id4);
         this.prism.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismGeolocalizedInformation(tree);
      }
      
      public function deserializeAsyncAs_PrismGeolocalizedInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         this._prismtree = tree.addChild(this._prismtreeFunc);
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

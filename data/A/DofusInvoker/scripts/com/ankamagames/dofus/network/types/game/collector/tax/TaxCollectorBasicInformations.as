package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorBasicInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4890;
       
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:Number = 0;
      
      public var subAreaId:uint = 0;
      
      public function TaxCollectorBasicInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4890;
      }
      
      public function initTaxCollectorBasicInformations(firstNameId:uint = 0, lastNameId:uint = 0, worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0) : TaxCollectorBasicInformations
      {
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         return this;
      }
      
      public function reset() : void
      {
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorBasicInformations(output);
      }
      
      public function serializeAs_TaxCollectorBasicInformations(output:ICustomDataOutput) : void
      {
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         output.writeVarShort(this.firstNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
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
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorBasicInformations(input);
      }
      
      public function deserializeAs_TaxCollectorBasicInformations(input:ICustomDataInput) : void
      {
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._mapIdFunc(input);
         this._subAreaIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorBasicInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorBasicInformations(tree:FuncTree) : void
      {
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._subAreaIdFunc);
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorBasicInformations.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorBasicInformations.lastNameId.");
         }
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorBasicInformations.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorBasicInformations.worldY.");
         }
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TaxCollectorBasicInformations.mapId.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorBasicInformations.subAreaId.");
         }
      }
   }
}

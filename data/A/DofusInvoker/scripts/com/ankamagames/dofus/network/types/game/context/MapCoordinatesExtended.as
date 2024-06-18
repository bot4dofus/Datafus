package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MapCoordinatesExtended extends MapCoordinatesAndId implements INetworkType
   {
      
      public static const protocolId:uint = 1599;
       
      
      public var subAreaId:uint = 0;
      
      public function MapCoordinatesExtended()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1599;
      }
      
      public function initMapCoordinatesExtended(worldX:int = 0, worldY:int = 0, mapId:Number = 0, subAreaId:uint = 0) : MapCoordinatesExtended
      {
         super.initMapCoordinatesAndId(worldX,worldY,mapId);
         this.subAreaId = subAreaId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.subAreaId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapCoordinatesExtended(output);
      }
      
      public function serializeAs_MapCoordinatesExtended(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapCoordinatesAndId(output);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapCoordinatesExtended(input);
      }
      
      public function deserializeAs_MapCoordinatesExtended(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._subAreaIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapCoordinatesExtended(tree);
      }
      
      public function deserializeAsyncAs_MapCoordinatesExtended(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._subAreaIdFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of MapCoordinatesExtended.subAreaId.");
         }
      }
   }
}

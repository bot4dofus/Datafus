package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MapCoordinatesAndId extends MapCoordinates implements INetworkType
   {
      
      public static const protocolId:uint = 9666;
       
      
      public var mapId:Number = 0;
      
      public function MapCoordinatesAndId()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9666;
      }
      
      public function initMapCoordinatesAndId(worldX:int = 0, worldY:int = 0, mapId:Number = 0) : MapCoordinatesAndId
      {
         super.initMapCoordinates(worldX,worldY);
         this.mapId = mapId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mapId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapCoordinatesAndId(output);
      }
      
      public function serializeAs_MapCoordinatesAndId(output:ICustomDataOutput) : void
      {
         super.serializeAs_MapCoordinates(output);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapCoordinatesAndId(input);
      }
      
      public function deserializeAs_MapCoordinatesAndId(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._mapIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapCoordinatesAndId(tree);
      }
      
      public function deserializeAsyncAs_MapCoordinatesAndId(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._mapIdFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of MapCoordinatesAndId.mapId.");
         }
      }
   }
}

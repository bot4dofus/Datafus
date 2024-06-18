package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class MapCoordinates implements INetworkType
   {
      
      public static const protocolId:uint = 315;
       
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public function MapCoordinates()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 315;
      }
      
      public function initMapCoordinates(worldX:int = 0, worldY:int = 0) : MapCoordinates
      {
         this.worldX = worldX;
         this.worldY = worldY;
         return this;
      }
      
      public function reset() : void
      {
         this.worldX = 0;
         this.worldY = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapCoordinates(output);
      }
      
      public function serializeAs_MapCoordinates(output:ICustomDataOutput) : void
      {
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
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapCoordinates(input);
      }
      
      public function deserializeAs_MapCoordinates(input:ICustomDataInput) : void
      {
         this._worldXFunc(input);
         this._worldYFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapCoordinates(tree);
      }
      
      public function deserializeAsyncAs_MapCoordinates(tree:FuncTree) : void
      {
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of MapCoordinates.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of MapCoordinates.worldY.");
         }
      }
   }
}

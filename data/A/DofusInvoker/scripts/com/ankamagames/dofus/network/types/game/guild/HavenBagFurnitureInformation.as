package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HavenBagFurnitureInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9917;
       
      
      public var cellId:uint = 0;
      
      public var funitureId:int = 0;
      
      public var orientation:uint = 0;
      
      public function HavenBagFurnitureInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9917;
      }
      
      public function initHavenBagFurnitureInformation(cellId:uint = 0, funitureId:int = 0, orientation:uint = 0) : HavenBagFurnitureInformation
      {
         this.cellId = cellId;
         this.funitureId = funitureId;
         this.orientation = orientation;
         return this;
      }
      
      public function reset() : void
      {
         this.cellId = 0;
         this.funitureId = 0;
         this.orientation = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HavenBagFurnitureInformation(output);
      }
      
      public function serializeAs_HavenBagFurnitureInformation(output:ICustomDataOutput) : void
      {
         if(this.cellId < 0)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
         output.writeInt(this.funitureId);
         if(this.orientation < 0)
         {
            throw new Error("Forbidden value (" + this.orientation + ") on element orientation.");
         }
         output.writeByte(this.orientation);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HavenBagFurnitureInformation(input);
      }
      
      public function deserializeAs_HavenBagFurnitureInformation(input:ICustomDataInput) : void
      {
         this._cellIdFunc(input);
         this._funitureIdFunc(input);
         this._orientationFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HavenBagFurnitureInformation(tree);
      }
      
      public function deserializeAsyncAs_HavenBagFurnitureInformation(tree:FuncTree) : void
      {
         tree.addChild(this._cellIdFunc);
         tree.addChild(this._funitureIdFunc);
         tree.addChild(this._orientationFunc);
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of HavenBagFurnitureInformation.cellId.");
         }
      }
      
      private function _funitureIdFunc(input:ICustomDataInput) : void
      {
         this.funitureId = input.readInt();
      }
      
      private function _orientationFunc(input:ICustomDataInput) : void
      {
         this.orientation = input.readByte();
         if(this.orientation < 0)
         {
            throw new Error("Forbidden value (" + this.orientation + ") on element of HavenBagFurnitureInformation.orientation.");
         }
      }
   }
}

package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameActionMarkedCell implements INetworkType
   {
      
      public static const protocolId:uint = 4032;
       
      
      public var cellId:uint = 0;
      
      public var zoneSize:int = 0;
      
      public var cellColor:int = 0;
      
      public var cellsType:int = 0;
      
      public function GameActionMarkedCell()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4032;
      }
      
      public function initGameActionMarkedCell(cellId:uint = 0, zoneSize:int = 0, cellColor:int = 0, cellsType:int = 0) : GameActionMarkedCell
      {
         this.cellId = cellId;
         this.zoneSize = zoneSize;
         this.cellColor = cellColor;
         this.cellsType = cellsType;
         return this;
      }
      
      public function reset() : void
      {
         this.cellId = 0;
         this.zoneSize = 0;
         this.cellColor = 0;
         this.cellsType = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionMarkedCell(output);
      }
      
      public function serializeAs_GameActionMarkedCell(output:ICustomDataOutput) : void
      {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
         output.writeByte(this.zoneSize);
         output.writeInt(this.cellColor);
         output.writeByte(this.cellsType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionMarkedCell(input);
      }
      
      public function deserializeAs_GameActionMarkedCell(input:ICustomDataInput) : void
      {
         this._cellIdFunc(input);
         this._zoneSizeFunc(input);
         this._cellColorFunc(input);
         this._cellsTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameActionMarkedCell(tree);
      }
      
      public function deserializeAsyncAs_GameActionMarkedCell(tree:FuncTree) : void
      {
         tree.addChild(this._cellIdFunc);
         tree.addChild(this._zoneSizeFunc);
         tree.addChild(this._cellColorFunc);
         tree.addChild(this._cellsTypeFunc);
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionMarkedCell.cellId.");
         }
      }
      
      private function _zoneSizeFunc(input:ICustomDataInput) : void
      {
         this.zoneSize = input.readByte();
      }
      
      private function _cellColorFunc(input:ICustomDataInput) : void
      {
         this.cellColor = input.readInt();
      }
      
      private function _cellsTypeFunc(input:ICustomDataInput) : void
      {
         this.cellsType = input.readByte();
      }
   }
}

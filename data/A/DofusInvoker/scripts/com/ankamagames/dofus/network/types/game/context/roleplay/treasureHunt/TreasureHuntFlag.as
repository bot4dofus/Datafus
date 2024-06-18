package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntFlag implements INetworkType
   {
      
      public static const protocolId:uint = 8258;
       
      
      public var mapId:Number = 0;
      
      public var state:uint = 0;
      
      public function TreasureHuntFlag()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8258;
      }
      
      public function initTreasureHuntFlag(mapId:Number = 0, state:uint = 0) : TreasureHuntFlag
      {
         this.mapId = mapId;
         this.state = state;
         return this;
      }
      
      public function reset() : void
      {
         this.mapId = 0;
         this.state = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TreasureHuntFlag(output);
      }
      
      public function serializeAs_TreasureHuntFlag(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeByte(this.state);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntFlag(input);
      }
      
      public function deserializeAs_TreasureHuntFlag(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._stateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntFlag(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntFlag(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._stateFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of TreasureHuntFlag.mapId.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of TreasureHuntFlag.state.");
         }
      }
   }
}

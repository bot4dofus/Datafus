package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntStepFollowDirection extends TreasureHuntStep implements INetworkType
   {
      
      public static const protocolId:uint = 9008;
       
      
      public var direction:uint = 1;
      
      public var mapCount:uint = 0;
      
      public function TreasureHuntStepFollowDirection()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9008;
      }
      
      public function initTreasureHuntStepFollowDirection(direction:uint = 1, mapCount:uint = 0) : TreasureHuntStepFollowDirection
      {
         this.direction = direction;
         this.mapCount = mapCount;
         return this;
      }
      
      override public function reset() : void
      {
         this.direction = 1;
         this.mapCount = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TreasureHuntStepFollowDirection(output);
      }
      
      public function serializeAs_TreasureHuntStepFollowDirection(output:ICustomDataOutput) : void
      {
         super.serializeAs_TreasureHuntStep(output);
         output.writeByte(this.direction);
         if(this.mapCount < 0)
         {
            throw new Error("Forbidden value (" + this.mapCount + ") on element mapCount.");
         }
         output.writeVarShort(this.mapCount);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntStepFollowDirection(input);
      }
      
      public function deserializeAs_TreasureHuntStepFollowDirection(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._directionFunc(input);
         this._mapCountFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntStepFollowDirection(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntStepFollowDirection(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._directionFunc);
         tree.addChild(this._mapCountFunc);
      }
      
      private function _directionFunc(input:ICustomDataInput) : void
      {
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of TreasureHuntStepFollowDirection.direction.");
         }
      }
      
      private function _mapCountFunc(input:ICustomDataInput) : void
      {
         this.mapCount = input.readVarUhShort();
         if(this.mapCount < 0)
         {
            throw new Error("Forbidden value (" + this.mapCount + ") on element of TreasureHuntStepFollowDirection.mapCount.");
         }
      }
   }
}

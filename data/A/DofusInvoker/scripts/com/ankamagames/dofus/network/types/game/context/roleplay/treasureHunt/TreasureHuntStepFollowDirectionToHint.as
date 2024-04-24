package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntStepFollowDirectionToHint extends TreasureHuntStep implements INetworkType
   {
      
      public static const protocolId:uint = 8346;
       
      
      public var direction:uint = 1;
      
      public var npcId:uint = 0;
      
      public function TreasureHuntStepFollowDirectionToHint()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8346;
      }
      
      public function initTreasureHuntStepFollowDirectionToHint(direction:uint = 1, npcId:uint = 0) : TreasureHuntStepFollowDirectionToHint
      {
         this.direction = direction;
         this.npcId = npcId;
         return this;
      }
      
      override public function reset() : void
      {
         this.direction = 1;
         this.npcId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TreasureHuntStepFollowDirectionToHint(output);
      }
      
      public function serializeAs_TreasureHuntStepFollowDirectionToHint(output:ICustomDataOutput) : void
      {
         super.serializeAs_TreasureHuntStep(output);
         output.writeByte(this.direction);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         output.writeVarShort(this.npcId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntStepFollowDirectionToHint(input);
      }
      
      public function deserializeAs_TreasureHuntStepFollowDirectionToHint(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._directionFunc(input);
         this._npcIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TreasureHuntStepFollowDirectionToHint(tree);
      }
      
      public function deserializeAsyncAs_TreasureHuntStepFollowDirectionToHint(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._directionFunc);
         tree.addChild(this._npcIdFunc);
      }
      
      private function _directionFunc(input:ICustomDataInput) : void
      {
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of TreasureHuntStepFollowDirectionToHint.direction.");
         }
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readVarUhShort();
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element of TreasureHuntStepFollowDirectionToHint.npcId.");
         }
      }
   }
}

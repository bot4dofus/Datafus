package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntStepDig extends TreasureHuntStep implements INetworkType
   {
      
      public static const protocolId:uint = 3722;
       
      
      public function TreasureHuntStepDig()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3722;
      }
      
      public function initTreasureHuntStepDig() : TreasureHuntStepDig
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TreasureHuntStepDig(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TreasureHuntStepDig(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_TreasureHuntStepDig(tree:FuncTree) : void
      {
      }
   }
}

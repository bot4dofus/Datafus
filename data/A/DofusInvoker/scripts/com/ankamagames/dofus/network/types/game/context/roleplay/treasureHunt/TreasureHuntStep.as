package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntStep implements INetworkType
   {
      
      public static const protocolId:uint = 8185;
       
      
      public function TreasureHuntStep()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8185;
      }
      
      public function initTreasureHuntStep() : TreasureHuntStep
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TreasureHuntStep(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TreasureHuntStep(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_TreasureHuntStep(tree:FuncTree) : void
      {
      }
   }
}

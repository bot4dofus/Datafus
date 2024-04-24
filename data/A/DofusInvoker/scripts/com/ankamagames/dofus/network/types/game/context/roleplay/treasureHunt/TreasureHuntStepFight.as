package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TreasureHuntStepFight extends TreasureHuntStep implements INetworkType
   {
      
      public static const protocolId:uint = 538;
       
      
      public function TreasureHuntStepFight()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 538;
      }
      
      public function initTreasureHuntStepFight() : TreasureHuntStepFight
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TreasureHuntStepFight(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TreasureHuntStepFight(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_TreasureHuntStepFight(tree:FuncTree) : void
      {
      }
   }
}

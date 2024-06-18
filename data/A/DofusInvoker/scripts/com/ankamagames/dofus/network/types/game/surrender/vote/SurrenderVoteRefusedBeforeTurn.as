package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteRefusedBeforeTurn extends SurrenderVoteRefused implements INetworkType
   {
      
      public static const protocolId:uint = 9709;
       
      
      public var minTurnForSurrenderVote:int = 0;
      
      public function SurrenderVoteRefusedBeforeTurn()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9709;
      }
      
      public function initSurrenderVoteRefusedBeforeTurn(minTurnForSurrenderVote:int = 0) : SurrenderVoteRefusedBeforeTurn
      {
         this.minTurnForSurrenderVote = minTurnForSurrenderVote;
         return this;
      }
      
      override public function reset() : void
      {
         this.minTurnForSurrenderVote = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SurrenderVoteRefusedBeforeTurn(output);
      }
      
      public function serializeAs_SurrenderVoteRefusedBeforeTurn(output:ICustomDataOutput) : void
      {
         super.serializeAs_SurrenderVoteRefused(output);
         output.writeInt(this.minTurnForSurrenderVote);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderVoteRefusedBeforeTurn(input);
      }
      
      public function deserializeAs_SurrenderVoteRefusedBeforeTurn(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._minTurnForSurrenderVoteFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderVoteRefusedBeforeTurn(tree);
      }
      
      public function deserializeAsyncAs_SurrenderVoteRefusedBeforeTurn(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._minTurnForSurrenderVoteFunc);
      }
      
      private function _minTurnForSurrenderVoteFunc(input:ICustomDataInput) : void
      {
         this.minTurnForSurrenderVote = input.readInt();
      }
   }
}

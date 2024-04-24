package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteRefusedWaitBetweenVotes extends SurrenderVoteRefused implements INetworkType
   {
      
      public static const protocolId:uint = 6764;
       
      
      public var nextVoteTimestamp:int = 0;
      
      public function SurrenderVoteRefusedWaitBetweenVotes()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6764;
      }
      
      public function initSurrenderVoteRefusedWaitBetweenVotes(nextVoteTimestamp:int = 0) : SurrenderVoteRefusedWaitBetweenVotes
      {
         this.nextVoteTimestamp = nextVoteTimestamp;
         return this;
      }
      
      override public function reset() : void
      {
         this.nextVoteTimestamp = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SurrenderVoteRefusedWaitBetweenVotes(output);
      }
      
      public function serializeAs_SurrenderVoteRefusedWaitBetweenVotes(output:ICustomDataOutput) : void
      {
         super.serializeAs_SurrenderVoteRefused(output);
         output.writeInt(this.nextVoteTimestamp);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SurrenderVoteRefusedWaitBetweenVotes(input);
      }
      
      public function deserializeAs_SurrenderVoteRefusedWaitBetweenVotes(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._nextVoteTimestampFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SurrenderVoteRefusedWaitBetweenVotes(tree);
      }
      
      public function deserializeAsyncAs_SurrenderVoteRefusedWaitBetweenVotes(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nextVoteTimestampFunc);
      }
      
      private function _nextVoteTimestampFunc(input:ICustomDataInput) : void
      {
         this.nextVoteTimestamp = input.readInt();
      }
   }
}

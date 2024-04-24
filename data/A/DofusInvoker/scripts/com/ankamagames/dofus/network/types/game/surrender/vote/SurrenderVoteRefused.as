package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteRefused extends SurrenderVoteResponse implements INetworkType
   {
      
      public static const protocolId:uint = 2267;
       
      
      public function SurrenderVoteRefused()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2267;
      }
      
      public function initSurrenderVoteRefused() : SurrenderVoteRefused
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderVoteRefused(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderVoteRefused(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderVoteRefused(tree:FuncTree) : void
      {
      }
   }
}

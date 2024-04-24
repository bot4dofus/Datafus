package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteAccepted extends SurrenderVoteResponse implements INetworkType
   {
      
      public static const protocolId:uint = 6159;
       
      
      public function SurrenderVoteAccepted()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6159;
      }
      
      public function initSurrenderVoteAccepted() : SurrenderVoteAccepted
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderVoteAccepted(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderVoteAccepted(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderVoteAccepted(tree:FuncTree) : void
      {
      }
   }
}

package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteResponse implements INetworkType
   {
      
      public static const protocolId:uint = 3674;
       
      
      public function SurrenderVoteResponse()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3674;
      }
      
      public function initSurrenderVoteResponse() : SurrenderVoteResponse
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderVoteResponse(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderVoteResponse(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderVoteResponse(tree:FuncTree) : void
      {
      }
   }
}

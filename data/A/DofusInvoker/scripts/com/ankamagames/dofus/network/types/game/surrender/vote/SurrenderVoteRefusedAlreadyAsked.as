package com.ankamagames.dofus.network.types.game.surrender.vote
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderVoteRefusedAlreadyAsked extends SurrenderVoteRefused implements INetworkType
   {
      
      public static const protocolId:uint = 5204;
       
      
      public function SurrenderVoteRefusedAlreadyAsked()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5204;
      }
      
      public function initSurrenderVoteRefusedAlreadyAsked() : SurrenderVoteRefusedAlreadyAsked
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderVoteRefusedAlreadyAsked(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderVoteRefusedAlreadyAsked(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderVoteRefusedAlreadyAsked(tree:FuncTree) : void
      {
      }
   }
}

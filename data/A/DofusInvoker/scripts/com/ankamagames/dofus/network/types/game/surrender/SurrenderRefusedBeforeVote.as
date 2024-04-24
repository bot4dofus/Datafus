package com.ankamagames.dofus.network.types.game.surrender
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderRefusedBeforeVote extends SurrenderRefused implements INetworkType
   {
      
      public static const protocolId:uint = 1799;
       
      
      public function SurrenderRefusedBeforeVote()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1799;
      }
      
      public function initSurrenderRefusedBeforeVote() : SurrenderRefusedBeforeVote
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderRefusedBeforeVote(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderRefusedBeforeVote(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderRefusedBeforeVote(tree:FuncTree) : void
      {
      }
   }
}

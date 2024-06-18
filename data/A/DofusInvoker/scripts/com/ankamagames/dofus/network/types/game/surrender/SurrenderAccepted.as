package com.ankamagames.dofus.network.types.game.surrender
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderAccepted extends SurrenderResponse implements INetworkType
   {
      
      public static const protocolId:uint = 8859;
       
      
      public function SurrenderAccepted()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8859;
      }
      
      public function initSurrenderAccepted() : SurrenderAccepted
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderAccepted(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderAccepted(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderAccepted(tree:FuncTree) : void
      {
      }
   }
}

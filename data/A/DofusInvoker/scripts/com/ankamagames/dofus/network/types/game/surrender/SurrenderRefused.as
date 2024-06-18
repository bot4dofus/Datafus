package com.ankamagames.dofus.network.types.game.surrender
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderRefused extends SurrenderResponse implements INetworkType
   {
      
      public static const protocolId:uint = 8906;
       
      
      public function SurrenderRefused()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8906;
      }
      
      public function initSurrenderRefused() : SurrenderRefused
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderRefused(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderRefused(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderRefused(tree:FuncTree) : void
      {
      }
   }
}

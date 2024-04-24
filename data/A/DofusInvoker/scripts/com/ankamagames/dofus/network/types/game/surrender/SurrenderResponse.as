package com.ankamagames.dofus.network.types.game.surrender
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SurrenderResponse implements INetworkType
   {
      
      public static const protocolId:uint = 130;
       
      
      public function SurrenderResponse()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 130;
      }
      
      public function initSurrenderResponse() : SurrenderResponse
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SurrenderResponse(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SurrenderResponse(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SurrenderResponse(tree:FuncTree) : void
      {
      }
   }
}

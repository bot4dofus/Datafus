package com.ankamagames.dofus.network.types.game.alliance
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class KothWinner implements INetworkType
   {
      
      public static const protocolId:uint = 5374;
       
      
      public function KothWinner()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5374;
      }
      
      public function initKothWinner() : KothWinner
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_KothWinner(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_KothWinner(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_KothWinner(tree:FuncTree) : void
      {
      }
   }
}

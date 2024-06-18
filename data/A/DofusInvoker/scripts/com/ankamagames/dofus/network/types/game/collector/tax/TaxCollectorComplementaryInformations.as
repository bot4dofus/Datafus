package com.ankamagames.dofus.network.types.game.collector.tax
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorComplementaryInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1982;
       
      
      public function TaxCollectorComplementaryInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1982;
      }
      
      public function initTaxCollectorComplementaryInformations() : TaxCollectorComplementaryInformations
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TaxCollectorComplementaryInformations(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TaxCollectorComplementaryInformations(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_TaxCollectorComplementaryInformations(tree:FuncTree) : void
      {
      }
   }
}

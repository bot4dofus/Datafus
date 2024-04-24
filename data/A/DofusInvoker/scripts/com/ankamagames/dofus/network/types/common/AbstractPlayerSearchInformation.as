package com.ankamagames.dofus.network.types.common
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractPlayerSearchInformation implements INetworkType
   {
      
      public static const protocolId:uint = 7835;
       
      
      public function AbstractPlayerSearchInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7835;
      }
      
      public function initAbstractPlayerSearchInformation() : AbstractPlayerSearchInformation
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_AbstractPlayerSearchInformation(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_AbstractPlayerSearchInformation(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_AbstractPlayerSearchInformation(tree:FuncTree) : void
      {
      }
   }
}

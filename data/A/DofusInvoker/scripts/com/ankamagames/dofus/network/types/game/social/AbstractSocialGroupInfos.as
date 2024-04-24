package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractSocialGroupInfos implements INetworkType
   {
      
      public static const protocolId:uint = 7935;
       
      
      public function AbstractSocialGroupInfos()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7935;
      }
      
      public function initAbstractSocialGroupInfos() : AbstractSocialGroupInfos
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_AbstractSocialGroupInfos(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_AbstractSocialGroupInfos(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_AbstractSocialGroupInfos(tree:FuncTree) : void
      {
      }
   }
}

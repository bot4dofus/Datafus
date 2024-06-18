package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IgnoredInformations extends AbstractContactInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2099;
       
      
      public function IgnoredInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2099;
      }
      
      public function initIgnoredInformations(accountId:uint = 0, accountTag:AccountTagInformation = null) : IgnoredInformations
      {
         super.initAbstractContactInformations(accountId,accountTag);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IgnoredInformations(output);
      }
      
      public function serializeAs_IgnoredInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractContactInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IgnoredInformations(input);
      }
      
      public function deserializeAs_IgnoredInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IgnoredInformations(tree);
      }
      
      public function deserializeAsyncAs_IgnoredInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanOption implements INetworkType
   {
      
      public static const protocolId:uint = 7701;
       
      
      public function HumanOption()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7701;
      }
      
      public function initHumanOption() : HumanOption
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_HumanOption(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_HumanOption(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_HumanOption(tree:FuncTree) : void
      {
      }
   }
}

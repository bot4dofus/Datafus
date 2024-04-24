package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultAdditionalData implements INetworkType
   {
      
      public static const protocolId:uint = 658;
       
      
      public function FightResultAdditionalData()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 658;
      }
      
      public function initFightResultAdditionalData() : FightResultAdditionalData
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_FightResultAdditionalData(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_FightResultAdditionalData(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_FightResultAdditionalData(tree:FuncTree) : void
      {
      }
   }
}

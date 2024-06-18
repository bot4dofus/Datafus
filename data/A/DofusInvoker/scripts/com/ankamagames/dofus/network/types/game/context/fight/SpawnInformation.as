package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpawnInformation implements INetworkType
   {
      
      public static const protocolId:uint = 339;
       
      
      public function SpawnInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 339;
      }
      
      public function initSpawnInformation() : SpawnInformation
      {
         return this;
      }
      
      public function reset() : void
      {
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_SpawnInformation(output:ICustomDataOutput) : void
      {
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_SpawnInformation(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_SpawnInformation(tree:FuncTree) : void
      {
      }
   }
}

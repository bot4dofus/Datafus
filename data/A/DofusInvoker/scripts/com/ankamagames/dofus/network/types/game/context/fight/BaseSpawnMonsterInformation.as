package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BaseSpawnMonsterInformation extends SpawnInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5062;
       
      
      public var creatureGenericId:uint = 0;
      
      public function BaseSpawnMonsterInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5062;
      }
      
      public function initBaseSpawnMonsterInformation(creatureGenericId:uint = 0) : BaseSpawnMonsterInformation
      {
         this.creatureGenericId = creatureGenericId;
         return this;
      }
      
      override public function reset() : void
      {
         this.creatureGenericId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BaseSpawnMonsterInformation(output);
      }
      
      public function serializeAs_BaseSpawnMonsterInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_SpawnInformation(output);
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
         }
         output.writeVarShort(this.creatureGenericId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BaseSpawnMonsterInformation(input);
      }
      
      public function deserializeAs_BaseSpawnMonsterInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creatureGenericIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BaseSpawnMonsterInformation(tree);
      }
      
      public function deserializeAsyncAs_BaseSpawnMonsterInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creatureGenericIdFunc);
      }
      
      private function _creatureGenericIdFunc(input:ICustomDataInput) : void
      {
         this.creatureGenericId = input.readVarUhShort();
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element of BaseSpawnMonsterInformation.creatureGenericId.");
         }
      }
   }
}

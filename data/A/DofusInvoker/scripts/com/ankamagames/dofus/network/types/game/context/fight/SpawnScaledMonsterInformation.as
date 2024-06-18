package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpawnScaledMonsterInformation extends BaseSpawnMonsterInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8568;
       
      
      public var creatureLevel:uint = 0;
      
      public function SpawnScaledMonsterInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8568;
      }
      
      public function initSpawnScaledMonsterInformation(creatureGenericId:uint = 0, creatureLevel:uint = 0) : SpawnScaledMonsterInformation
      {
         super.initBaseSpawnMonsterInformation(creatureGenericId);
         this.creatureLevel = creatureLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creatureLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpawnScaledMonsterInformation(output);
      }
      
      public function serializeAs_SpawnScaledMonsterInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_BaseSpawnMonsterInformation(output);
         if(this.creatureLevel < 0)
         {
            throw new Error("Forbidden value (" + this.creatureLevel + ") on element creatureLevel.");
         }
         output.writeShort(this.creatureLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpawnScaledMonsterInformation(input);
      }
      
      public function deserializeAs_SpawnScaledMonsterInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creatureLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpawnScaledMonsterInformation(tree);
      }
      
      public function deserializeAsyncAs_SpawnScaledMonsterInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creatureLevelFunc);
      }
      
      private function _creatureLevelFunc(input:ICustomDataInput) : void
      {
         this.creatureLevel = input.readShort();
         if(this.creatureLevel < 0)
         {
            throw new Error("Forbidden value (" + this.creatureLevel + ") on element of SpawnScaledMonsterInformation.creatureLevel.");
         }
      }
   }
}

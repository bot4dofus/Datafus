package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpawnMonsterInformation extends BaseSpawnMonsterInformation implements INetworkType
   {
      
      public static const protocolId:uint = 571;
       
      
      public var creatureGrade:uint = 0;
      
      public function SpawnMonsterInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 571;
      }
      
      public function initSpawnMonsterInformation(creatureGenericId:uint = 0, creatureGrade:uint = 0) : SpawnMonsterInformation
      {
         super.initBaseSpawnMonsterInformation(creatureGenericId);
         this.creatureGrade = creatureGrade;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creatureGrade = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpawnMonsterInformation(output);
      }
      
      public function serializeAs_SpawnMonsterInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_BaseSpawnMonsterInformation(output);
         if(this.creatureGrade < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGrade + ") on element creatureGrade.");
         }
         output.writeByte(this.creatureGrade);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpawnMonsterInformation(input);
      }
      
      public function deserializeAs_SpawnMonsterInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creatureGradeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpawnMonsterInformation(tree);
      }
      
      public function deserializeAsyncAs_SpawnMonsterInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creatureGradeFunc);
      }
      
      private function _creatureGradeFunc(input:ICustomDataInput) : void
      {
         this.creatureGrade = input.readByte();
         if(this.creatureGrade < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGrade + ") on element of SpawnMonsterInformation.creatureGrade.");
         }
      }
   }
}

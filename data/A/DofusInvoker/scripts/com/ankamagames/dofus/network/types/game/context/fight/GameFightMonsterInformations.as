package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightMonsterInformations extends GameFightAIInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1792;
       
      
      public var creatureGenericId:uint = 0;
      
      public var creatureGrade:uint = 0;
      
      public var creatureLevel:uint = 0;
      
      public function GameFightMonsterInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1792;
      }
      
      public function initGameFightMonsterInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, creatureGenericId:uint = 0, creatureGrade:uint = 0, creatureLevel:uint = 0) : GameFightMonsterInformations
      {
         super.initGameFightAIInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions);
         this.creatureGenericId = creatureGenericId;
         this.creatureGrade = creatureGrade;
         this.creatureLevel = creatureLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.creatureGenericId = 0;
         this.creatureGrade = 0;
         this.creatureLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMonsterInformations(output);
      }
      
      public function serializeAs_GameFightMonsterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightAIInformations(output);
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element creatureGenericId.");
         }
         output.writeVarShort(this.creatureGenericId);
         if(this.creatureGrade < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGrade + ") on element creatureGrade.");
         }
         output.writeByte(this.creatureGrade);
         if(this.creatureLevel < 0)
         {
            throw new Error("Forbidden value (" + this.creatureLevel + ") on element creatureLevel.");
         }
         output.writeShort(this.creatureLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightMonsterInformations(input);
      }
      
      public function deserializeAs_GameFightMonsterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._creatureGenericIdFunc(input);
         this._creatureGradeFunc(input);
         this._creatureLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightMonsterInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightMonsterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._creatureGenericIdFunc);
         tree.addChild(this._creatureGradeFunc);
         tree.addChild(this._creatureLevelFunc);
      }
      
      private function _creatureGenericIdFunc(input:ICustomDataInput) : void
      {
         this.creatureGenericId = input.readVarUhShort();
         if(this.creatureGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGenericId + ") on element of GameFightMonsterInformations.creatureGenericId.");
         }
      }
      
      private function _creatureGradeFunc(input:ICustomDataInput) : void
      {
         this.creatureGrade = input.readByte();
         if(this.creatureGrade < 0)
         {
            throw new Error("Forbidden value (" + this.creatureGrade + ") on element of GameFightMonsterInformations.creatureGrade.");
         }
      }
      
      private function _creatureLevelFunc(input:ICustomDataInput) : void
      {
         this.creatureLevel = input.readShort();
         if(this.creatureLevel < 0)
         {
            throw new Error("Forbidden value (" + this.creatureLevel + ") on element of GameFightMonsterInformations.creatureLevel.");
         }
      }
   }
}

package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultExperienceData extends FightResultAdditionalData implements INetworkType
   {
      
      public static const protocolId:uint = 9334;
       
      
      public var experience:Number = 0;
      
      public var showExperience:Boolean = false;
      
      public var experienceLevelFloor:Number = 0;
      
      public var showExperienceLevelFloor:Boolean = false;
      
      public var experienceNextLevelFloor:Number = 0;
      
      public var showExperienceNextLevelFloor:Boolean = false;
      
      public var experienceFightDelta:Number = 0;
      
      public var showExperienceFightDelta:Boolean = false;
      
      public var experienceForGuild:Number = 0;
      
      public var showExperienceForGuild:Boolean = false;
      
      public var experienceForMount:Number = 0;
      
      public var showExperienceForMount:Boolean = false;
      
      public var isIncarnationExperience:Boolean = false;
      
      public var rerollExperienceMul:uint = 0;
      
      public function FightResultExperienceData()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 9334;
      }
      
      public function initFightResultExperienceData(experience:Number = 0, showExperience:Boolean = false, experienceLevelFloor:Number = 0, showExperienceLevelFloor:Boolean = false, experienceNextLevelFloor:Number = 0, showExperienceNextLevelFloor:Boolean = false, experienceFightDelta:Number = 0, showExperienceFightDelta:Boolean = false, experienceForGuild:Number = 0, showExperienceForGuild:Boolean = false, experienceForMount:Number = 0, showExperienceForMount:Boolean = false, isIncarnationExperience:Boolean = false, rerollExperienceMul:uint = 0) : FightResultExperienceData
      {
         this.experience = experience;
         this.showExperience = showExperience;
         this.experienceLevelFloor = experienceLevelFloor;
         this.showExperienceLevelFloor = showExperienceLevelFloor;
         this.experienceNextLevelFloor = experienceNextLevelFloor;
         this.showExperienceNextLevelFloor = showExperienceNextLevelFloor;
         this.experienceFightDelta = experienceFightDelta;
         this.showExperienceFightDelta = showExperienceFightDelta;
         this.experienceForGuild = experienceForGuild;
         this.showExperienceForGuild = showExperienceForGuild;
         this.experienceForMount = experienceForMount;
         this.showExperienceForMount = showExperienceForMount;
         this.isIncarnationExperience = isIncarnationExperience;
         this.rerollExperienceMul = rerollExperienceMul;
         return this;
      }
      
      override public function reset() : void
      {
         this.experience = 0;
         this.showExperience = false;
         this.experienceLevelFloor = 0;
         this.showExperienceLevelFloor = false;
         this.experienceNextLevelFloor = 0;
         this.showExperienceNextLevelFloor = false;
         this.experienceFightDelta = 0;
         this.showExperienceFightDelta = false;
         this.experienceForGuild = 0;
         this.showExperienceForGuild = false;
         this.experienceForMount = 0;
         this.showExperienceForMount = false;
         this.isIncarnationExperience = false;
         this.rerollExperienceMul = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultExperienceData(output);
      }
      
      public function serializeAs_FightResultExperienceData(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultAdditionalData(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.showExperience);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.showExperienceLevelFloor);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.showExperienceNextLevelFloor);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.showExperienceFightDelta);
         _box0 = BooleanByteWrapper.setFlag(_box0,4,this.showExperienceForGuild);
         _box0 = BooleanByteWrapper.setFlag(_box0,5,this.showExperienceForMount);
         _box0 = BooleanByteWrapper.setFlag(_box0,6,this.isIncarnationExperience);
         output.writeByte(_box0);
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element experience.");
         }
         output.writeVarLong(this.experience);
         if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element experienceLevelFloor.");
         }
         output.writeVarLong(this.experienceLevelFloor);
         if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element experienceNextLevelFloor.");
         }
         output.writeVarLong(this.experienceNextLevelFloor);
         if(this.experienceFightDelta < 0 || this.experienceFightDelta > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceFightDelta + ") on element experienceFightDelta.");
         }
         output.writeVarLong(this.experienceFightDelta);
         if(this.experienceForGuild < 0 || this.experienceForGuild > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForGuild + ") on element experienceForGuild.");
         }
         output.writeVarLong(this.experienceForGuild);
         if(this.experienceForMount < 0 || this.experienceForMount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForMount + ") on element experienceForMount.");
         }
         output.writeVarLong(this.experienceForMount);
         if(this.rerollExperienceMul < 0)
         {
            throw new Error("Forbidden value (" + this.rerollExperienceMul + ") on element rerollExperienceMul.");
         }
         output.writeByte(this.rerollExperienceMul);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultExperienceData(input);
      }
      
      public function deserializeAs_FightResultExperienceData(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._experienceFunc(input);
         this._experienceLevelFloorFunc(input);
         this._experienceNextLevelFloorFunc(input);
         this._experienceFightDeltaFunc(input);
         this._experienceForGuildFunc(input);
         this._experienceForMountFunc(input);
         this._rerollExperienceMulFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultExperienceData(tree);
      }
      
      public function deserializeAsyncAs_FightResultExperienceData(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._experienceFunc);
         tree.addChild(this._experienceLevelFloorFunc);
         tree.addChild(this._experienceNextLevelFloorFunc);
         tree.addChild(this._experienceFightDeltaFunc);
         tree.addChild(this._experienceForGuildFunc);
         tree.addChild(this._experienceForMountFunc);
         tree.addChild(this._rerollExperienceMulFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.showExperience = BooleanByteWrapper.getFlag(_box0,0);
         this.showExperienceLevelFloor = BooleanByteWrapper.getFlag(_box0,1);
         this.showExperienceNextLevelFloor = BooleanByteWrapper.getFlag(_box0,2);
         this.showExperienceFightDelta = BooleanByteWrapper.getFlag(_box0,3);
         this.showExperienceForGuild = BooleanByteWrapper.getFlag(_box0,4);
         this.showExperienceForMount = BooleanByteWrapper.getFlag(_box0,5);
         this.isIncarnationExperience = BooleanByteWrapper.getFlag(_box0,6);
      }
      
      private function _experienceFunc(input:ICustomDataInput) : void
      {
         this.experience = input.readVarUhLong();
         if(this.experience < 0 || this.experience > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experience + ") on element of FightResultExperienceData.experience.");
         }
      }
      
      private function _experienceLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.experienceLevelFloor = input.readVarUhLong();
         if(this.experienceLevelFloor < 0 || this.experienceLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceLevelFloor + ") on element of FightResultExperienceData.experienceLevelFloor.");
         }
      }
      
      private function _experienceNextLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.experienceNextLevelFloor = input.readVarUhLong();
         if(this.experienceNextLevelFloor < 0 || this.experienceNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceNextLevelFloor + ") on element of FightResultExperienceData.experienceNextLevelFloor.");
         }
      }
      
      private function _experienceFightDeltaFunc(input:ICustomDataInput) : void
      {
         this.experienceFightDelta = input.readVarUhLong();
         if(this.experienceFightDelta < 0 || this.experienceFightDelta > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceFightDelta + ") on element of FightResultExperienceData.experienceFightDelta.");
         }
      }
      
      private function _experienceForGuildFunc(input:ICustomDataInput) : void
      {
         this.experienceForGuild = input.readVarUhLong();
         if(this.experienceForGuild < 0 || this.experienceForGuild > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForGuild + ") on element of FightResultExperienceData.experienceForGuild.");
         }
      }
      
      private function _experienceForMountFunc(input:ICustomDataInput) : void
      {
         this.experienceForMount = input.readVarUhLong();
         if(this.experienceForMount < 0 || this.experienceForMount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.experienceForMount + ") on element of FightResultExperienceData.experienceForMount.");
         }
      }
      
      private function _rerollExperienceMulFunc(input:ICustomDataInput) : void
      {
         this.rerollExperienceMul = input.readByte();
         if(this.rerollExperienceMul < 0)
         {
            throw new Error("Forbidden value (" + this.rerollExperienceMul + ") on element of FightResultExperienceData.rerollExperienceMul.");
         }
      }
   }
}

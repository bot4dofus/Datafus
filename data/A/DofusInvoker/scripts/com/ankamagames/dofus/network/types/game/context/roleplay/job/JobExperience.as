package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobExperience implements INetworkType
   {
      
      public static const protocolId:uint = 3823;
       
      
      public var jobId:uint = 0;
      
      public var jobLevel:uint = 0;
      
      public var jobXP:Number = 0;
      
      public var jobXpLevelFloor:Number = 0;
      
      public var jobXpNextLevelFloor:Number = 0;
      
      public function JobExperience()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3823;
      }
      
      public function initJobExperience(jobId:uint = 0, jobLevel:uint = 0, jobXP:Number = 0, jobXpLevelFloor:Number = 0, jobXpNextLevelFloor:Number = 0) : JobExperience
      {
         this.jobId = jobId;
         this.jobLevel = jobLevel;
         this.jobXP = jobXP;
         this.jobXpLevelFloor = jobXpLevelFloor;
         this.jobXpNextLevelFloor = jobXpNextLevelFloor;
         return this;
      }
      
      public function reset() : void
      {
         this.jobId = 0;
         this.jobLevel = 0;
         this.jobXP = 0;
         this.jobXpLevelFloor = 0;
         this.jobXpNextLevelFloor = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobExperience(output);
      }
      
      public function serializeAs_JobExperience(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         if(this.jobLevel < 0 || this.jobLevel > 255)
         {
            throw new Error("Forbidden value (" + this.jobLevel + ") on element jobLevel.");
         }
         output.writeByte(this.jobLevel);
         if(this.jobXP < 0 || this.jobXP > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXP + ") on element jobXP.");
         }
         output.writeVarLong(this.jobXP);
         if(this.jobXpLevelFloor < 0 || this.jobXpLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXpLevelFloor + ") on element jobXpLevelFloor.");
         }
         output.writeVarLong(this.jobXpLevelFloor);
         if(this.jobXpNextLevelFloor < 0 || this.jobXpNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXpNextLevelFloor + ") on element jobXpNextLevelFloor.");
         }
         output.writeVarLong(this.jobXpNextLevelFloor);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobExperience(input);
      }
      
      public function deserializeAs_JobExperience(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
         this._jobLevelFunc(input);
         this._jobXPFunc(input);
         this._jobXpLevelFloorFunc(input);
         this._jobXpNextLevelFloorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobExperience(tree);
      }
      
      public function deserializeAsyncAs_JobExperience(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         tree.addChild(this._jobLevelFunc);
         tree.addChild(this._jobXPFunc);
         tree.addChild(this._jobXpLevelFloorFunc);
         tree.addChild(this._jobXpNextLevelFloorFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobExperience.jobId.");
         }
      }
      
      private function _jobLevelFunc(input:ICustomDataInput) : void
      {
         this.jobLevel = input.readUnsignedByte();
         if(this.jobLevel < 0 || this.jobLevel > 255)
         {
            throw new Error("Forbidden value (" + this.jobLevel + ") on element of JobExperience.jobLevel.");
         }
      }
      
      private function _jobXPFunc(input:ICustomDataInput) : void
      {
         this.jobXP = input.readVarUhLong();
         if(this.jobXP < 0 || this.jobXP > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXP + ") on element of JobExperience.jobXP.");
         }
      }
      
      private function _jobXpLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.jobXpLevelFloor = input.readVarUhLong();
         if(this.jobXpLevelFloor < 0 || this.jobXpLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXpLevelFloor + ") on element of JobExperience.jobXpLevelFloor.");
         }
      }
      
      private function _jobXpNextLevelFloorFunc(input:ICustomDataInput) : void
      {
         this.jobXpNextLevelFloor = input.readVarUhLong();
         if(this.jobXpNextLevelFloor < 0 || this.jobXpNextLevelFloor > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.jobXpNextLevelFloor + ") on element of JobExperience.jobXpNextLevelFloor.");
         }
      }
   }
}

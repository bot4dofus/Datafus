package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobCrafterDirectoryEntryJobInfo implements INetworkType
   {
      
      public static const protocolId:uint = 5157;
       
      
      public var jobId:uint = 0;
      
      public var jobLevel:uint = 0;
      
      public var free:Boolean = false;
      
      public var minLevel:uint = 0;
      
      public function JobCrafterDirectoryEntryJobInfo()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5157;
      }
      
      public function initJobCrafterDirectoryEntryJobInfo(jobId:uint = 0, jobLevel:uint = 0, free:Boolean = false, minLevel:uint = 0) : JobCrafterDirectoryEntryJobInfo
      {
         this.jobId = jobId;
         this.jobLevel = jobLevel;
         this.free = free;
         this.minLevel = minLevel;
         return this;
      }
      
      public function reset() : void
      {
         this.jobId = 0;
         this.jobLevel = 0;
         this.free = false;
         this.minLevel = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryEntryJobInfo(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryJobInfo(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         if(this.jobLevel < 1 || this.jobLevel > 200)
         {
            throw new Error("Forbidden value (" + this.jobLevel + ") on element jobLevel.");
         }
         output.writeByte(this.jobLevel);
         output.writeBoolean(this.free);
         if(this.minLevel < 0 || this.minLevel > 255)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element minLevel.");
         }
         output.writeByte(this.minLevel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryEntryJobInfo(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryJobInfo(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
         this._jobLevelFunc(input);
         this._freeFunc(input);
         this._minLevelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryEntryJobInfo(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryEntryJobInfo(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         tree.addChild(this._jobLevelFunc);
         tree.addChild(this._freeFunc);
         tree.addChild(this._minLevelFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectoryEntryJobInfo.jobId.");
         }
      }
      
      private function _jobLevelFunc(input:ICustomDataInput) : void
      {
         this.jobLevel = input.readUnsignedByte();
         if(this.jobLevel < 1 || this.jobLevel > 200)
         {
            throw new Error("Forbidden value (" + this.jobLevel + ") on element of JobCrafterDirectoryEntryJobInfo.jobLevel.");
         }
      }
      
      private function _freeFunc(input:ICustomDataInput) : void
      {
         this.free = input.readBoolean();
      }
      
      private function _minLevelFunc(input:ICustomDataInput) : void
      {
         this.minLevel = input.readUnsignedByte();
         if(this.minLevel < 0 || this.minLevel > 255)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element of JobCrafterDirectoryEntryJobInfo.minLevel.");
         }
      }
   }
}

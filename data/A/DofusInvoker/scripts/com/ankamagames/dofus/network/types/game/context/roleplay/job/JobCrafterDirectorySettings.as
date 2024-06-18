package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobCrafterDirectorySettings implements INetworkType
   {
      
      public static const protocolId:uint = 7939;
       
      
      public var jobId:uint = 0;
      
      public var minLevel:uint = 0;
      
      public var free:Boolean = false;
      
      public function JobCrafterDirectorySettings()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7939;
      }
      
      public function initJobCrafterDirectorySettings(jobId:uint = 0, minLevel:uint = 0, free:Boolean = false) : JobCrafterDirectorySettings
      {
         this.jobId = jobId;
         this.minLevel = minLevel;
         this.free = free;
         return this;
      }
      
      public function reset() : void
      {
         this.jobId = 0;
         this.minLevel = 0;
         this.free = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectorySettings(output);
      }
      
      public function serializeAs_JobCrafterDirectorySettings(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
         if(this.minLevel < 0 || this.minLevel > 255)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element minLevel.");
         }
         output.writeByte(this.minLevel);
         output.writeBoolean(this.free);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectorySettings(input);
      }
      
      public function deserializeAs_JobCrafterDirectorySettings(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
         this._minLevelFunc(input);
         this._freeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectorySettings(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectorySettings(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
         tree.addChild(this._minLevelFunc);
         tree.addChild(this._freeFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of JobCrafterDirectorySettings.jobId.");
         }
      }
      
      private function _minLevelFunc(input:ICustomDataInput) : void
      {
         this.minLevel = input.readUnsignedByte();
         if(this.minLevel < 0 || this.minLevel > 255)
         {
            throw new Error("Forbidden value (" + this.minLevel + ") on element of JobCrafterDirectorySettings.minLevel.");
         }
      }
      
      private function _freeFunc(input:ICustomDataInput) : void
      {
         this.free = input.readBoolean();
      }
   }
}

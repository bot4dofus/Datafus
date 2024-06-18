package com.ankamagames.dofus.network.types.game.context.roleplay.job
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class JobCrafterDirectoryListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 7693;
       
      
      public var playerInfo:JobCrafterDirectoryEntryPlayerInfo;
      
      public var jobInfo:JobCrafterDirectoryEntryJobInfo;
      
      private var _playerInfotree:FuncTree;
      
      private var _jobInfotree:FuncTree;
      
      public function JobCrafterDirectoryListEntry()
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.jobInfo = new JobCrafterDirectoryEntryJobInfo();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7693;
      }
      
      public function initJobCrafterDirectoryListEntry(playerInfo:JobCrafterDirectoryEntryPlayerInfo = null, jobInfo:JobCrafterDirectoryEntryJobInfo = null) : JobCrafterDirectoryListEntry
      {
         this.playerInfo = playerInfo;
         this.jobInfo = jobInfo;
         return this;
      }
      
      public function reset() : void
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryListEntry(output);
      }
      
      public function serializeAs_JobCrafterDirectoryListEntry(output:ICustomDataOutput) : void
      {
         this.playerInfo.serializeAs_JobCrafterDirectoryEntryPlayerInfo(output);
         this.jobInfo.serializeAs_JobCrafterDirectoryEntryJobInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryListEntry(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryListEntry(input:ICustomDataInput) : void
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserialize(input);
         this.jobInfo = new JobCrafterDirectoryEntryJobInfo();
         this.jobInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryListEntry(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryListEntry(tree:FuncTree) : void
      {
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
         this._jobInfotree = tree.addChild(this._jobInfotreeFunc);
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserializeAsync(this._playerInfotree);
      }
      
      private function _jobInfotreeFunc(input:ICustomDataInput) : void
      {
         this.jobInfo = new JobCrafterDirectoryEntryJobInfo();
         this.jobInfo.deserializeAsync(this._jobInfotree);
      }
   }
}

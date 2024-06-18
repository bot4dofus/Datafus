package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryEntryJobInfo;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryEntryPlayerInfo;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobCrafterDirectoryEntryMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2116;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerInfo:JobCrafterDirectoryEntryPlayerInfo;
      
      public var jobInfoList:Vector.<JobCrafterDirectoryEntryJobInfo>;
      
      public var playerLook:EntityLook;
      
      private var _playerInfotree:FuncTree;
      
      private var _jobInfoListtree:FuncTree;
      
      private var _playerLooktree:FuncTree;
      
      public function JobCrafterDirectoryEntryMessage()
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.jobInfoList = new Vector.<JobCrafterDirectoryEntryJobInfo>();
         this.playerLook = new EntityLook();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2116;
      }
      
      public function initJobCrafterDirectoryEntryMessage(playerInfo:JobCrafterDirectoryEntryPlayerInfo = null, jobInfoList:Vector.<JobCrafterDirectoryEntryJobInfo> = null, playerLook:EntityLook = null) : JobCrafterDirectoryEntryMessage
      {
         this.playerInfo = playerInfo;
         this.jobInfoList = jobInfoList;
         this.playerLook = playerLook;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerLook = new EntityLook();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_JobCrafterDirectoryEntryMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryEntryMessage(output:ICustomDataOutput) : void
      {
         this.playerInfo.serializeAs_JobCrafterDirectoryEntryPlayerInfo(output);
         output.writeShort(this.jobInfoList.length);
         for(var _i2:uint = 0; _i2 < this.jobInfoList.length; _i2++)
         {
            (this.jobInfoList[_i2] as JobCrafterDirectoryEntryJobInfo).serializeAs_JobCrafterDirectoryEntryJobInfo(output);
         }
         this.playerLook.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryEntryMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryEntryMessage(input:ICustomDataInput) : void
      {
         var _item2:JobCrafterDirectoryEntryJobInfo = null;
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserialize(input);
         var _jobInfoListLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _jobInfoListLen; _i2++)
         {
            _item2 = new JobCrafterDirectoryEntryJobInfo();
            _item2.deserialize(input);
            this.jobInfoList.push(_item2);
         }
         this.playerLook = new EntityLook();
         this.playerLook.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryEntryMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryEntryMessage(tree:FuncTree) : void
      {
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
         this._jobInfoListtree = tree.addChild(this._jobInfoListtreeFunc);
         this._playerLooktree = tree.addChild(this._playerLooktreeFunc);
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         this.playerInfo = new JobCrafterDirectoryEntryPlayerInfo();
         this.playerInfo.deserializeAsync(this._playerInfotree);
      }
      
      private function _jobInfoListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._jobInfoListtree.addChild(this._jobInfoListFunc);
         }
      }
      
      private function _jobInfoListFunc(input:ICustomDataInput) : void
      {
         var _item:JobCrafterDirectoryEntryJobInfo = new JobCrafterDirectoryEntryJobInfo();
         _item.deserialize(input);
         this.jobInfoList.push(_item);
      }
      
      private function _playerLooktreeFunc(input:ICustomDataInput) : void
      {
         this.playerLook = new EntityLook();
         this.playerLook.deserializeAsync(this._playerLooktree);
      }
   }
}

package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobCrafterDirectoryAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9328;
       
      
      private var _isInitialized:Boolean = false;
      
      public var listEntry:JobCrafterDirectoryListEntry;
      
      private var _listEntrytree:FuncTree;
      
      public function JobCrafterDirectoryAddMessage()
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9328;
      }
      
      public function initJobCrafterDirectoryAddMessage(listEntry:JobCrafterDirectoryListEntry = null) : JobCrafterDirectoryAddMessage
      {
         this.listEntry = listEntry;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
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
         this.serializeAs_JobCrafterDirectoryAddMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryAddMessage(output:ICustomDataOutput) : void
      {
         this.listEntry.serializeAs_JobCrafterDirectoryListEntry(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryAddMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryAddMessage(input:ICustomDataInput) : void
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         this.listEntry.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryAddMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryAddMessage(tree:FuncTree) : void
      {
         this._listEntrytree = tree.addChild(this._listEntrytreeFunc);
      }
      
      private function _listEntrytreeFunc(input:ICustomDataInput) : void
      {
         this.listEntry = new JobCrafterDirectoryListEntry();
         this.listEntry.deserializeAsync(this._listEntrytree);
      }
   }
}

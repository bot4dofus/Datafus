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
   
   public class JobCrafterDirectoryListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7103;
       
      
      private var _isInitialized:Boolean = false;
      
      public var listEntries:Vector.<JobCrafterDirectoryListEntry>;
      
      private var _listEntriestree:FuncTree;
      
      public function JobCrafterDirectoryListMessage()
      {
         this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7103;
      }
      
      public function initJobCrafterDirectoryListMessage(listEntries:Vector.<JobCrafterDirectoryListEntry> = null) : JobCrafterDirectoryListMessage
      {
         this.listEntries = listEntries;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
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
         this.serializeAs_JobCrafterDirectoryListMessage(output);
      }
      
      public function serializeAs_JobCrafterDirectoryListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.listEntries.length);
         for(var _i1:uint = 0; _i1 < this.listEntries.length; _i1++)
         {
            (this.listEntries[_i1] as JobCrafterDirectoryListEntry).serializeAs_JobCrafterDirectoryListEntry(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobCrafterDirectoryListMessage(input);
      }
      
      public function deserializeAs_JobCrafterDirectoryListMessage(input:ICustomDataInput) : void
      {
         var _item1:JobCrafterDirectoryListEntry = null;
         var _listEntriesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _listEntriesLen; _i1++)
         {
            _item1 = new JobCrafterDirectoryListEntry();
            _item1.deserialize(input);
            this.listEntries.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobCrafterDirectoryListMessage(tree);
      }
      
      public function deserializeAsyncAs_JobCrafterDirectoryListMessage(tree:FuncTree) : void
      {
         this._listEntriestree = tree.addChild(this._listEntriestreeFunc);
      }
      
      private function _listEntriestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._listEntriestree.addChild(this._listEntriesFunc);
         }
      }
      
      private function _listEntriesFunc(input:ICustomDataInput) : void
      {
         var _item:JobCrafterDirectoryListEntry = new JobCrafterDirectoryListEntry();
         _item.deserialize(input);
         this.listEntries.push(_item);
      }
   }
}

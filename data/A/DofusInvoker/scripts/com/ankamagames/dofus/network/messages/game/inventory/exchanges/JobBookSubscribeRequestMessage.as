package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class JobBookSubscribeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7221;
       
      
      private var _isInitialized:Boolean = false;
      
      public var jobIds:Vector.<uint>;
      
      private var _jobIdstree:FuncTree;
      
      public function JobBookSubscribeRequestMessage()
      {
         this.jobIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7221;
      }
      
      public function initJobBookSubscribeRequestMessage(jobIds:Vector.<uint> = null) : JobBookSubscribeRequestMessage
      {
         this.jobIds = jobIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.jobIds = new Vector.<uint>();
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
         this.serializeAs_JobBookSubscribeRequestMessage(output);
      }
      
      public function serializeAs_JobBookSubscribeRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.jobIds.length);
         for(var _i1:uint = 0; _i1 < this.jobIds.length; _i1++)
         {
            if(this.jobIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.jobIds[_i1] + ") on element 1 (starting at 1) of jobIds.");
            }
            output.writeByte(this.jobIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_JobBookSubscribeRequestMessage(input);
      }
      
      public function deserializeAs_JobBookSubscribeRequestMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _jobIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _jobIdsLen; _i1++)
         {
            _val1 = input.readByte();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of jobIds.");
            }
            this.jobIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_JobBookSubscribeRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_JobBookSubscribeRequestMessage(tree:FuncTree) : void
      {
         this._jobIdstree = tree.addChild(this._jobIdstreeFunc);
      }
      
      private function _jobIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._jobIdstree.addChild(this._jobIdsFunc);
         }
      }
      
      private function _jobIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of jobIds.");
         }
         this.jobIds.push(_val);
      }
   }
}

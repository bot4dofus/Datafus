package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkJobIndexMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1248;
       
      
      private var _isInitialized:Boolean = false;
      
      public var jobs:Vector.<uint>;
      
      private var _jobstree:FuncTree;
      
      public function ExchangeStartOkJobIndexMessage()
      {
         this.jobs = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1248;
      }
      
      public function initExchangeStartOkJobIndexMessage(jobs:Vector.<uint> = null) : ExchangeStartOkJobIndexMessage
      {
         this.jobs = jobs;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.jobs = new Vector.<uint>();
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
         this.serializeAs_ExchangeStartOkJobIndexMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkJobIndexMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.jobs.length);
         for(var _i1:uint = 0; _i1 < this.jobs.length; _i1++)
         {
            if(this.jobs[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.jobs[_i1] + ") on element 1 (starting at 1) of jobs.");
            }
            output.writeVarInt(this.jobs[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkJobIndexMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkJobIndexMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _jobsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _jobsLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of jobs.");
            }
            this.jobs.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkJobIndexMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkJobIndexMessage(tree:FuncTree) : void
      {
         this._jobstree = tree.addChild(this._jobstreeFunc);
      }
      
      private function _jobstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._jobstree.addChild(this._jobsFunc);
         }
      }
      
      private function _jobsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of jobs.");
         }
         this.jobs.push(_val);
      }
   }
}

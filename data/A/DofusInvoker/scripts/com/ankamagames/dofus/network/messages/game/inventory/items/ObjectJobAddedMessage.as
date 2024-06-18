package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectJobAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5441;
       
      
      private var _isInitialized:Boolean = false;
      
      public var jobId:uint = 0;
      
      public function ObjectJobAddedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5441;
      }
      
      public function initObjectJobAddedMessage(jobId:uint = 0) : ObjectJobAddedMessage
      {
         this.jobId = jobId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.jobId = 0;
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
         this.serializeAs_ObjectJobAddedMessage(output);
      }
      
      public function serializeAs_ObjectJobAddedMessage(output:ICustomDataOutput) : void
      {
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element jobId.");
         }
         output.writeByte(this.jobId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectJobAddedMessage(input);
      }
      
      public function deserializeAs_ObjectJobAddedMessage(input:ICustomDataInput) : void
      {
         this._jobIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectJobAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectJobAddedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._jobIdFunc);
      }
      
      private function _jobIdFunc(input:ICustomDataInput) : void
      {
         this.jobId = input.readByte();
         if(this.jobId < 0)
         {
            throw new Error("Forbidden value (" + this.jobId + ") on element of ObjectJobAddedMessage.jobId.");
         }
      }
   }
}

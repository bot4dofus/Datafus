package com.ankamagames.dofus.network.messages.queues
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LoginQueueStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3098;
       
      
      private var _isInitialized:Boolean = false;
      
      public var position:uint = 0;
      
      public var total:uint = 0;
      
      public function LoginQueueStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3098;
      }
      
      public function initLoginQueueStatusMessage(position:uint = 0, total:uint = 0) : LoginQueueStatusMessage
      {
         this.position = position;
         this.total = total;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.position = 0;
         this.total = 0;
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
         this.serializeAs_LoginQueueStatusMessage(output);
      }
      
      public function serializeAs_LoginQueueStatusMessage(output:ICustomDataOutput) : void
      {
         if(this.position < 0 || this.position > 65535)
         {
            throw new Error("Forbidden value (" + this.position + ") on element position.");
         }
         output.writeShort(this.position);
         if(this.total < 0 || this.total > 65535)
         {
            throw new Error("Forbidden value (" + this.total + ") on element total.");
         }
         output.writeShort(this.total);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LoginQueueStatusMessage(input);
      }
      
      public function deserializeAs_LoginQueueStatusMessage(input:ICustomDataInput) : void
      {
         this._positionFunc(input);
         this._totalFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LoginQueueStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_LoginQueueStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._positionFunc);
         tree.addChild(this._totalFunc);
      }
      
      private function _positionFunc(input:ICustomDataInput) : void
      {
         this.position = input.readUnsignedShort();
         if(this.position < 0 || this.position > 65535)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of LoginQueueStatusMessage.position.");
         }
      }
      
      private function _totalFunc(input:ICustomDataInput) : void
      {
         this.total = input.readUnsignedShort();
         if(this.total < 0 || this.total > 65535)
         {
            throw new Error("Forbidden value (" + this.total + ") on element of LoginQueueStatusMessage.total.");
         }
      }
   }
}

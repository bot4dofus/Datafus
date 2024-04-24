package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiValidationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9709;
       
      
      private var _isInitialized:Boolean = false;
      
      public var transaction:String = "";
      
      public function HaapiValidationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9709;
      }
      
      public function initHaapiValidationRequestMessage(transaction:String = "") : HaapiValidationRequestMessage
      {
         this.transaction = transaction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.transaction = "";
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
         this.serializeAs_HaapiValidationRequestMessage(output);
      }
      
      public function serializeAs_HaapiValidationRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.transaction);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiValidationRequestMessage(input);
      }
      
      public function deserializeAs_HaapiValidationRequestMessage(input:ICustomDataInput) : void
      {
         this._transactionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiValidationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiValidationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._transactionFunc);
      }
      
      private function _transactionFunc(input:ICustomDataInput) : void
      {
         this.transaction = input.readUTF();
      }
   }
}

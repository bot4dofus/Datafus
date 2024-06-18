package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9232;
       
      
      private var _isInitialized:Boolean = false;
      
      public var errorType:int = 0;
      
      public function ExchangeErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9232;
      }
      
      public function initExchangeErrorMessage(errorType:int = 0) : ExchangeErrorMessage
      {
         this.errorType = errorType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.errorType = 0;
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
         this.serializeAs_ExchangeErrorMessage(output);
      }
      
      public function serializeAs_ExchangeErrorMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.errorType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeErrorMessage(input);
      }
      
      public function deserializeAs_ExchangeErrorMessage(input:ICustomDataInput) : void
      {
         this._errorTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._errorTypeFunc);
      }
      
      private function _errorTypeFunc(input:ICustomDataInput) : void
      {
         this.errorType = input.readByte();
      }
   }
}

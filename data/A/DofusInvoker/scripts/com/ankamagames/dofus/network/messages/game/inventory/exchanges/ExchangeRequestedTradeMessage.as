package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeRequestedTradeMessage extends ExchangeRequestedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9062;
       
      
      private var _isInitialized:Boolean = false;
      
      public var source:Number = 0;
      
      public var target:Number = 0;
      
      public function ExchangeRequestedTradeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9062;
      }
      
      public function initExchangeRequestedTradeMessage(exchangeType:int = 0, source:Number = 0, target:Number = 0) : ExchangeRequestedTradeMessage
      {
         super.initExchangeRequestedMessage(exchangeType);
         this.source = source;
         this.target = target;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.source = 0;
         this.target = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeRequestedTradeMessage(output);
      }
      
      public function serializeAs_ExchangeRequestedTradeMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeRequestedMessage(output);
         if(this.source < 0 || this.source > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.source + ") on element source.");
         }
         output.writeVarLong(this.source);
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element target.");
         }
         output.writeVarLong(this.target);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeRequestedTradeMessage(input);
      }
      
      public function deserializeAs_ExchangeRequestedTradeMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._sourceFunc(input);
         this._targetFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeRequestedTradeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeRequestedTradeMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._sourceFunc);
         tree.addChild(this._targetFunc);
      }
      
      private function _sourceFunc(input:ICustomDataInput) : void
      {
         this.source = input.readVarUhLong();
         if(this.source < 0 || this.source > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.source + ") on element of ExchangeRequestedTradeMessage.source.");
         }
      }
      
      private function _targetFunc(input:ICustomDataInput) : void
      {
         this.target = input.readVarUhLong();
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element of ExchangeRequestedTradeMessage.target.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkRecycleTradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6135;
       
      
      private var _isInitialized:Boolean = false;
      
      public var percentToPrism:uint = 0;
      
      public var percentToPlayer:uint = 0;
      
      public function ExchangeStartOkRecycleTradeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6135;
      }
      
      public function initExchangeStartOkRecycleTradeMessage(percentToPrism:uint = 0, percentToPlayer:uint = 0) : ExchangeStartOkRecycleTradeMessage
      {
         this.percentToPrism = percentToPrism;
         this.percentToPlayer = percentToPlayer;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.percentToPrism = 0;
         this.percentToPlayer = 0;
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
         this.serializeAs_ExchangeStartOkRecycleTradeMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkRecycleTradeMessage(output:ICustomDataOutput) : void
      {
         if(this.percentToPrism < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPrism + ") on element percentToPrism.");
         }
         output.writeShort(this.percentToPrism);
         if(this.percentToPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPlayer + ") on element percentToPlayer.");
         }
         output.writeShort(this.percentToPlayer);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkRecycleTradeMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkRecycleTradeMessage(input:ICustomDataInput) : void
      {
         this._percentToPrismFunc(input);
         this._percentToPlayerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkRecycleTradeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkRecycleTradeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._percentToPrismFunc);
         tree.addChild(this._percentToPlayerFunc);
      }
      
      private function _percentToPrismFunc(input:ICustomDataInput) : void
      {
         this.percentToPrism = input.readShort();
         if(this.percentToPrism < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPrism + ") on element of ExchangeStartOkRecycleTradeMessage.percentToPrism.");
         }
      }
      
      private function _percentToPlayerFunc(input:ICustomDataInput) : void
      {
         this.percentToPlayer = input.readShort();
         if(this.percentToPlayer < 0)
         {
            throw new Error("Forbidden value (" + this.percentToPlayer + ") on element of ExchangeStartOkRecycleTradeMessage.percentToPlayer.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftPaymentModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2319;
       
      
      private var _isInitialized:Boolean = false;
      
      public var goldSum:Number = 0;
      
      public function ExchangeCraftPaymentModifiedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2319;
      }
      
      public function initExchangeCraftPaymentModifiedMessage(goldSum:Number = 0) : ExchangeCraftPaymentModifiedMessage
      {
         this.goldSum = goldSum;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.goldSum = 0;
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
         this.serializeAs_ExchangeCraftPaymentModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeCraftPaymentModifiedMessage(output:ICustomDataOutput) : void
      {
         if(this.goldSum < 0 || this.goldSum > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.goldSum + ") on element goldSum.");
         }
         output.writeVarLong(this.goldSum);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftPaymentModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftPaymentModifiedMessage(input:ICustomDataInput) : void
      {
         this._goldSumFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftPaymentModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftPaymentModifiedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._goldSumFunc);
      }
      
      private function _goldSumFunc(input:ICustomDataInput) : void
      {
         this.goldSum = input.readVarUhLong();
         if(this.goldSum < 0 || this.goldSum > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.goldSum + ") on element of ExchangeCraftPaymentModifiedMessage.goldSum.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectModifyPricedMessage extends ExchangeObjectMovePricedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1058;
       
      
      private var _isInitialized:Boolean = false;
      
      public function ExchangeObjectModifyPricedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1058;
      }
      
      public function initExchangeObjectModifyPricedMessage(objectUID:uint = 0, quantity:int = 0, price:Number = 0) : ExchangeObjectModifyPricedMessage
      {
         super.initExchangeObjectMovePricedMessage(objectUID,quantity,price);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ExchangeObjectModifyPricedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectModifyPricedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMovePricedMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectModifyPricedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectModifyPricedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectModifyPricedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectModifyPricedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeKamaModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4910;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quantity:Number = 0;
      
      public function ExchangeKamaModifiedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4910;
      }
      
      public function initExchangeKamaModifiedMessage(remote:Boolean = false, quantity:Number = 0) : ExchangeKamaModifiedMessage
      {
         super.initExchangeObjectMessage(remote);
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.quantity = 0;
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
         this.serializeAs_ExchangeKamaModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeKamaModifiedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(output);
         if(this.quantity < 0 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarLong(this.quantity);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeKamaModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeKamaModifiedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._quantityFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeKamaModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeKamaModifiedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhLong();
         if(this.quantity < 0 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeKamaModifiedMessage.quantity.");
         }
      }
   }
}

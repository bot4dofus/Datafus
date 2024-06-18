package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftPaymentModificationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2392;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quantity:Number = 0;
      
      public function ExchangeCraftPaymentModificationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2392;
      }
      
      public function initExchangeCraftPaymentModificationRequestMessage(quantity:Number = 0) : ExchangeCraftPaymentModificationRequestMessage
      {
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeCraftPaymentModificationRequestMessage(output);
      }
      
      public function serializeAs_ExchangeCraftPaymentModificationRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.quantity < 0 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarLong(this.quantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftPaymentModificationRequestMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftPaymentModificationRequestMessage(input:ICustomDataInput) : void
      {
         this._quantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftPaymentModificationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftPaymentModificationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhLong();
         if(this.quantity < 0 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeCraftPaymentModificationRequestMessage.quantity.");
         }
      }
   }
}

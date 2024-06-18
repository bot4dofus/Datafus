package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectMoveKamaMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7773;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quantity:Number = 0;
      
      public function ExchangeObjectMoveKamaMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7773;
      }
      
      public function initExchangeObjectMoveKamaMessage(quantity:Number = 0) : ExchangeObjectMoveKamaMessage
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
         this.serializeAs_ExchangeObjectMoveKamaMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMoveKamaMessage(output:ICustomDataOutput) : void
      {
         if(this.quantity < -9007199254740992 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarLong(this.quantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectMoveKamaMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMoveKamaMessage(input:ICustomDataInput) : void
      {
         this._quantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectMoveKamaMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectMoveKamaMessage(tree:FuncTree) : void
      {
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarLong();
         if(this.quantity < -9007199254740992 || this.quantity > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeObjectMoveKamaMessage.quantity.");
         }
      }
   }
}

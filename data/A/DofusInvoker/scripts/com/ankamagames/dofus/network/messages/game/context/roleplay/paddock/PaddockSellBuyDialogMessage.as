package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockSellBuyDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4196;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bsell:Boolean = false;
      
      public var ownerId:uint = 0;
      
      public var price:Number = 0;
      
      public function PaddockSellBuyDialogMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4196;
      }
      
      public function initPaddockSellBuyDialogMessage(bsell:Boolean = false, ownerId:uint = 0, price:Number = 0) : PaddockSellBuyDialogMessage
      {
         this.bsell = bsell;
         this.ownerId = ownerId;
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.bsell = false;
         this.ownerId = 0;
         this.price = 0;
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
         this.serializeAs_PaddockSellBuyDialogMessage(output);
      }
      
      public function serializeAs_PaddockSellBuyDialogMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.bsell);
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
         }
         output.writeVarInt(this.ownerId);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockSellBuyDialogMessage(input);
      }
      
      public function deserializeAs_PaddockSellBuyDialogMessage(input:ICustomDataInput) : void
      {
         this._bsellFunc(input);
         this._ownerIdFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockSellBuyDialogMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockSellBuyDialogMessage(tree:FuncTree) : void
      {
         tree.addChild(this._bsellFunc);
         tree.addChild(this._ownerIdFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function _bsellFunc(input:ICustomDataInput) : void
      {
         this.bsell = input.readBoolean();
      }
      
      private function _ownerIdFunc(input:ICustomDataInput) : void
      {
         this.ownerId = input.readVarUhInt();
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element of PaddockSellBuyDialogMessage.ownerId.");
         }
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellBuyDialogMessage.price.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PurchasableDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9556;
       
      
      private var _isInitialized:Boolean = false;
      
      public var buyOrSell:Boolean = false;
      
      public var purchasableId:Number = 0;
      
      public var purchasableInstanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var price:Number = 0;
      
      public function PurchasableDialogMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9556;
      }
      
      public function initPurchasableDialogMessage(buyOrSell:Boolean = false, purchasableId:Number = 0, purchasableInstanceId:uint = 0, secondHand:Boolean = false, price:Number = 0) : PurchasableDialogMessage
      {
         this.buyOrSell = buyOrSell;
         this.purchasableId = purchasableId;
         this.purchasableInstanceId = purchasableInstanceId;
         this.secondHand = secondHand;
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.buyOrSell = false;
         this.purchasableId = 0;
         this.purchasableInstanceId = 0;
         this.secondHand = false;
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
         this.serializeAs_PurchasableDialogMessage(output);
      }
      
      public function serializeAs_PurchasableDialogMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.buyOrSell);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.secondHand);
         output.writeByte(_box0);
         if(this.purchasableId < 0 || this.purchasableId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.purchasableId + ") on element purchasableId.");
         }
         output.writeDouble(this.purchasableId);
         if(this.purchasableInstanceId < 0)
         {
            throw new Error("Forbidden value (" + this.purchasableInstanceId + ") on element purchasableInstanceId.");
         }
         output.writeInt(this.purchasableInstanceId);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PurchasableDialogMessage(input);
      }
      
      public function deserializeAs_PurchasableDialogMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._purchasableIdFunc(input);
         this._purchasableInstanceIdFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PurchasableDialogMessage(tree);
      }
      
      public function deserializeAsyncAs_PurchasableDialogMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._purchasableIdFunc);
         tree.addChild(this._purchasableInstanceIdFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.buyOrSell = BooleanByteWrapper.getFlag(_box0,0);
         this.secondHand = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _purchasableIdFunc(input:ICustomDataInput) : void
      {
         this.purchasableId = input.readDouble();
         if(this.purchasableId < 0 || this.purchasableId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.purchasableId + ") on element of PurchasableDialogMessage.purchasableId.");
         }
      }
      
      private function _purchasableInstanceIdFunc(input:ICustomDataInput) : void
      {
         this.purchasableInstanceId = input.readInt();
         if(this.purchasableInstanceId < 0)
         {
            throw new Error("Forbidden value (" + this.purchasableInstanceId + ") on element of PurchasableDialogMessage.purchasableInstanceId.");
         }
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PurchasableDialogMessage.price.");
         }
      }
   }
}

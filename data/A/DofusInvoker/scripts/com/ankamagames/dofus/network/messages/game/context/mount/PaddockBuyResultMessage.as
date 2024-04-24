package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockBuyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 335;
       
      
      private var _isInitialized:Boolean = false;
      
      public var paddockId:Number = 0;
      
      public var bought:Boolean = false;
      
      public var realPrice:Number = 0;
      
      public function PaddockBuyResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 335;
      }
      
      public function initPaddockBuyResultMessage(paddockId:Number = 0, bought:Boolean = false, realPrice:Number = 0) : PaddockBuyResultMessage
      {
         this.paddockId = paddockId;
         this.bought = bought;
         this.realPrice = realPrice;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paddockId = 0;
         this.bought = false;
         this.realPrice = 0;
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
         this.serializeAs_PaddockBuyResultMessage(output);
      }
      
      public function serializeAs_PaddockBuyResultMessage(output:ICustomDataOutput) : void
      {
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element paddockId.");
         }
         output.writeDouble(this.paddockId);
         output.writeBoolean(this.bought);
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element realPrice.");
         }
         output.writeVarLong(this.realPrice);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockBuyResultMessage(input);
      }
      
      public function deserializeAs_PaddockBuyResultMessage(input:ICustomDataInput) : void
      {
         this._paddockIdFunc(input);
         this._boughtFunc(input);
         this._realPriceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockBuyResultMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockBuyResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._paddockIdFunc);
         tree.addChild(this._boughtFunc);
         tree.addChild(this._realPriceFunc);
      }
      
      private function _paddockIdFunc(input:ICustomDataInput) : void
      {
         this.paddockId = input.readDouble();
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element of PaddockBuyResultMessage.paddockId.");
         }
      }
      
      private function _boughtFunc(input:ICustomDataInput) : void
      {
         this.bought = input.readBoolean();
      }
      
      private function _realPriceFunc(input:ICustomDataInput) : void
      {
         this.realPrice = input.readVarUhLong();
         if(this.realPrice < 0 || this.realPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.realPrice + ") on element of PaddockBuyResultMessage.realPrice.");
         }
      }
   }
}

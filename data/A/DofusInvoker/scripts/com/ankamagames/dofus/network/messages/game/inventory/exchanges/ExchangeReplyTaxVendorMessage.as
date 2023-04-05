package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeReplyTaxVendorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1144;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectValue:Number = 0;
      
      public var totalTaxValue:Number = 0;
      
      public function ExchangeReplyTaxVendorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1144;
      }
      
      public function initExchangeReplyTaxVendorMessage(objectValue:Number = 0, totalTaxValue:Number = 0) : ExchangeReplyTaxVendorMessage
      {
         this.objectValue = objectValue;
         this.totalTaxValue = totalTaxValue;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectValue = 0;
         this.totalTaxValue = 0;
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
         this.serializeAs_ExchangeReplyTaxVendorMessage(output);
      }
      
      public function serializeAs_ExchangeReplyTaxVendorMessage(output:ICustomDataOutput) : void
      {
         if(this.objectValue < 0 || this.objectValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element objectValue.");
         }
         output.writeVarLong(this.objectValue);
         if(this.totalTaxValue < 0 || this.totalTaxValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.totalTaxValue + ") on element totalTaxValue.");
         }
         output.writeVarLong(this.totalTaxValue);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeReplyTaxVendorMessage(input);
      }
      
      public function deserializeAs_ExchangeReplyTaxVendorMessage(input:ICustomDataInput) : void
      {
         this._objectValueFunc(input);
         this._totalTaxValueFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeReplyTaxVendorMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeReplyTaxVendorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectValueFunc);
         tree.addChild(this._totalTaxValueFunc);
      }
      
      private function _objectValueFunc(input:ICustomDataInput) : void
      {
         this.objectValue = input.readVarUhLong();
         if(this.objectValue < 0 || this.objectValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectValue + ") on element of ExchangeReplyTaxVendorMessage.objectValue.");
         }
      }
      
      private function _totalTaxValueFunc(input:ICustomDataInput) : void
      {
         this.totalTaxValue = input.readVarUhLong();
         if(this.totalTaxValue < 0 || this.totalTaxValue > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.totalTaxValue + ") on element of ExchangeReplyTaxVendorMessage.totalTaxValue.");
         }
      }
   }
}

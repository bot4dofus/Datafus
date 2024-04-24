package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiConfirmationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1131;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kamas:Number = 0;
      
      public var amount:Number = 0;
      
      public var rate:uint = 0;
      
      public var action:uint = 0;
      
      public var transaction:String = "";
      
      public function HaapiConfirmationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1131;
      }
      
      public function initHaapiConfirmationMessage(kamas:Number = 0, amount:Number = 0, rate:uint = 0, action:uint = 0, transaction:String = "") : HaapiConfirmationMessage
      {
         this.kamas = kamas;
         this.amount = amount;
         this.rate = rate;
         this.action = action;
         this.transaction = transaction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kamas = 0;
         this.amount = 0;
         this.rate = 0;
         this.action = 0;
         this.transaction = "";
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
         this.serializeAs_HaapiConfirmationMessage(output);
      }
      
      public function serializeAs_HaapiConfirmationMessage(output:ICustomDataOutput) : void
      {
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarLong(this.amount);
         if(this.rate < 0)
         {
            throw new Error("Forbidden value (" + this.rate + ") on element rate.");
         }
         output.writeVarShort(this.rate);
         output.writeByte(this.action);
         output.writeUTF(this.transaction);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiConfirmationMessage(input);
      }
      
      public function deserializeAs_HaapiConfirmationMessage(input:ICustomDataInput) : void
      {
         this._kamasFunc(input);
         this._amountFunc(input);
         this._rateFunc(input);
         this._actionFunc(input);
         this._transactionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiConfirmationMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiConfirmationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kamasFunc);
         tree.addChild(this._amountFunc);
         tree.addChild(this._rateFunc);
         tree.addChild(this._actionFunc);
         tree.addChild(this._transactionFunc);
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of HaapiConfirmationMessage.kamas.");
         }
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhLong();
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of HaapiConfirmationMessage.amount.");
         }
      }
      
      private function _rateFunc(input:ICustomDataInput) : void
      {
         this.rate = input.readVarUhShort();
         if(this.rate < 0)
         {
            throw new Error("Forbidden value (" + this.rate + ") on element of HaapiConfirmationMessage.rate.");
         }
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of HaapiConfirmationMessage.action.");
         }
      }
      
      private function _transactionFunc(input:ICustomDataInput) : void
      {
         this.transaction = input.readUTF();
      }
   }
}

package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiBuyValidationMessage extends HaapiValidationMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1448;
       
      
      private var _isInitialized:Boolean = false;
      
      public var amount:Number = 0;
      
      public var email:String = "";
      
      public function HaapiBuyValidationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1448;
      }
      
      public function initHaapiBuyValidationMessage(action:uint = 0, code:uint = 0, amount:Number = 0, email:String = "") : HaapiBuyValidationMessage
      {
         super.initHaapiValidationMessage(action,code);
         this.amount = amount;
         this.email = email;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.amount = 0;
         this.email = "";
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
         this.serializeAs_HaapiBuyValidationMessage(output);
      }
      
      public function serializeAs_HaapiBuyValidationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_HaapiValidationMessage(output);
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarLong(this.amount);
         output.writeUTF(this.email);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiBuyValidationMessage(input);
      }
      
      public function deserializeAs_HaapiBuyValidationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._amountFunc(input);
         this._emailFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiBuyValidationMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiBuyValidationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._amountFunc);
         tree.addChild(this._emailFunc);
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhLong();
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of HaapiBuyValidationMessage.amount.");
         }
      }
      
      private function _emailFunc(input:ICustomDataInput) : void
      {
         this.email = input.readUTF();
      }
   }
}

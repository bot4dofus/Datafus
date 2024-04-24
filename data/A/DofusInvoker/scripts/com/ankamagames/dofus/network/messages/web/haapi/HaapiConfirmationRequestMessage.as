package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiConfirmationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4700;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kamas:Number = 0;
      
      public var ogrines:Number = 0;
      
      public var rate:uint = 0;
      
      public var action:uint = 0;
      
      public function HaapiConfirmationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4700;
      }
      
      public function initHaapiConfirmationRequestMessage(kamas:Number = 0, ogrines:Number = 0, rate:uint = 0, action:uint = 0) : HaapiConfirmationRequestMessage
      {
         this.kamas = kamas;
         this.ogrines = ogrines;
         this.rate = rate;
         this.action = action;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.kamas = 0;
         this.ogrines = 0;
         this.rate = 0;
         this.action = 0;
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
         this.serializeAs_HaapiConfirmationRequestMessage(output);
      }
      
      public function serializeAs_HaapiConfirmationRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
         if(this.ogrines < 0 || this.ogrines > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.ogrines + ") on element ogrines.");
         }
         output.writeVarLong(this.ogrines);
         if(this.rate < 0)
         {
            throw new Error("Forbidden value (" + this.rate + ") on element rate.");
         }
         output.writeVarShort(this.rate);
         output.writeByte(this.action);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiConfirmationRequestMessage(input);
      }
      
      public function deserializeAs_HaapiConfirmationRequestMessage(input:ICustomDataInput) : void
      {
         this._kamasFunc(input);
         this._ogrinesFunc(input);
         this._rateFunc(input);
         this._actionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiConfirmationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiConfirmationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._kamasFunc);
         tree.addChild(this._ogrinesFunc);
         tree.addChild(this._rateFunc);
         tree.addChild(this._actionFunc);
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of HaapiConfirmationRequestMessage.kamas.");
         }
      }
      
      private function _ogrinesFunc(input:ICustomDataInput) : void
      {
         this.ogrines = input.readVarUhLong();
         if(this.ogrines < 0 || this.ogrines > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.ogrines + ") on element of HaapiConfirmationRequestMessage.ogrines.");
         }
      }
      
      private function _rateFunc(input:ICustomDataInput) : void
      {
         this.rate = input.readVarUhShort();
         if(this.rate < 0)
         {
            throw new Error("Forbidden value (" + this.rate + ") on element of HaapiConfirmationRequestMessage.rate.");
         }
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of HaapiConfirmationRequestMessage.action.");
         }
      }
   }
}

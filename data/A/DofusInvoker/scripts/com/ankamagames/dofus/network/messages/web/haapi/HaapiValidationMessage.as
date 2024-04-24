package com.ankamagames.dofus.network.messages.web.haapi
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HaapiValidationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1774;
       
      
      private var _isInitialized:Boolean = false;
      
      public var action:uint = 0;
      
      public var code:uint = 0;
      
      public function HaapiValidationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1774;
      }
      
      public function initHaapiValidationMessage(action:uint = 0, code:uint = 0) : HaapiValidationMessage
      {
         this.action = action;
         this.code = code;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.action = 0;
         this.code = 0;
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
         this.serializeAs_HaapiValidationMessage(output);
      }
      
      public function serializeAs_HaapiValidationMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.action);
         output.writeByte(this.code);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HaapiValidationMessage(input);
      }
      
      public function deserializeAs_HaapiValidationMessage(input:ICustomDataInput) : void
      {
         this._actionFunc(input);
         this._codeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HaapiValidationMessage(tree);
      }
      
      public function deserializeAsyncAs_HaapiValidationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._actionFunc);
         tree.addChild(this._codeFunc);
      }
      
      private function _actionFunc(input:ICustomDataInput) : void
      {
         this.action = input.readByte();
         if(this.action < 0)
         {
            throw new Error("Forbidden value (" + this.action + ") on element of HaapiValidationMessage.action.");
         }
      }
      
      private function _codeFunc(input:ICustomDataInput) : void
      {
         this.code = input.readByte();
         if(this.code < 0)
         {
            throw new Error("Forbidden value (" + this.code + ") on element of HaapiValidationMessage.code.");
         }
      }
   }
}

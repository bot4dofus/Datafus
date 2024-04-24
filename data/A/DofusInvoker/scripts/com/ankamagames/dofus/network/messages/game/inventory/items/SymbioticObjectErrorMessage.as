package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SymbioticObjectErrorMessage extends ObjectErrorMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7448;
       
      
      private var _isInitialized:Boolean = false;
      
      public var errorCode:int = 0;
      
      public function SymbioticObjectErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7448;
      }
      
      public function initSymbioticObjectErrorMessage(reason:int = 0, errorCode:int = 0) : SymbioticObjectErrorMessage
      {
         super.initObjectErrorMessage(reason);
         this.errorCode = errorCode;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.errorCode = 0;
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
         this.serializeAs_SymbioticObjectErrorMessage(output);
      }
      
      public function serializeAs_SymbioticObjectErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectErrorMessage(output);
         output.writeByte(this.errorCode);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SymbioticObjectErrorMessage(input);
      }
      
      public function deserializeAs_SymbioticObjectErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._errorCodeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SymbioticObjectErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_SymbioticObjectErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._errorCodeFunc);
      }
      
      private function _errorCodeFunc(input:ICustomDataInput) : void
      {
         this.errorCode = input.readByte();
      }
   }
}

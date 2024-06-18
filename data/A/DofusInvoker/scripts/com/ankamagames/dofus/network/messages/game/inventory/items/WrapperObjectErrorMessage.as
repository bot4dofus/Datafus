package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WrapperObjectErrorMessage extends SymbioticObjectErrorMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5215;
       
      
      private var _isInitialized:Boolean = false;
      
      public function WrapperObjectErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5215;
      }
      
      public function initWrapperObjectErrorMessage(reason:int = 0, errorCode:int = 0) : WrapperObjectErrorMessage
      {
         super.initSymbioticObjectErrorMessage(reason,errorCode);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_WrapperObjectErrorMessage(output);
      }
      
      public function serializeAs_WrapperObjectErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SymbioticObjectErrorMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WrapperObjectErrorMessage(input);
      }
      
      public function deserializeAs_WrapperObjectErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WrapperObjectErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_WrapperObjectErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

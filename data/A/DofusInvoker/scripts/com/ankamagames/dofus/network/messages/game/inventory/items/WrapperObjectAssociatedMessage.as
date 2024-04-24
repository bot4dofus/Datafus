package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class WrapperObjectAssociatedMessage extends SymbioticObjectAssociatedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2853;
       
      
      private var _isInitialized:Boolean = false;
      
      public function WrapperObjectAssociatedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2853;
      }
      
      public function initWrapperObjectAssociatedMessage(hostUID:uint = 0) : WrapperObjectAssociatedMessage
      {
         super.initSymbioticObjectAssociatedMessage(hostUID);
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
         this.serializeAs_WrapperObjectAssociatedMessage(output);
      }
      
      public function serializeAs_WrapperObjectAssociatedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SymbioticObjectAssociatedMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_WrapperObjectAssociatedMessage(input);
      }
      
      public function deserializeAs_WrapperObjectAssociatedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_WrapperObjectAssociatedMessage(tree);
      }
      
      public function deserializeAsyncAs_WrapperObjectAssociatedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

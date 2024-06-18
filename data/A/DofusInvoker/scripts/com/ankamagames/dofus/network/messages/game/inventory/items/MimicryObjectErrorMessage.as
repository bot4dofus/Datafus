package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MimicryObjectErrorMessage extends SymbioticObjectErrorMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3920;
       
      
      private var _isInitialized:Boolean = false;
      
      public var preview:Boolean = false;
      
      public function MimicryObjectErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3920;
      }
      
      public function initMimicryObjectErrorMessage(reason:int = 0, errorCode:int = 0, preview:Boolean = false) : MimicryObjectErrorMessage
      {
         super.initSymbioticObjectErrorMessage(reason,errorCode);
         this.preview = preview;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.preview = false;
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
         this.serializeAs_MimicryObjectErrorMessage(output);
      }
      
      public function serializeAs_MimicryObjectErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SymbioticObjectErrorMessage(output);
         output.writeBoolean(this.preview);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MimicryObjectErrorMessage(input);
      }
      
      public function deserializeAs_MimicryObjectErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._previewFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MimicryObjectErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_MimicryObjectErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._previewFunc);
      }
      
      private function _previewFunc(input:ICustomDataInput) : void
      {
         this.preview = input.readBoolean();
      }
   }
}

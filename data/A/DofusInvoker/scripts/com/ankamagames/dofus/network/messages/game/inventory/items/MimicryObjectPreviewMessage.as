package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MimicryObjectPreviewMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2196;
       
      
      private var _isInitialized:Boolean = false;
      
      public var result:ObjectItem;
      
      private var _resulttree:FuncTree;
      
      public function MimicryObjectPreviewMessage()
      {
         this.result = new ObjectItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2196;
      }
      
      public function initMimicryObjectPreviewMessage(result:ObjectItem = null) : MimicryObjectPreviewMessage
      {
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = new ObjectItem();
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
         this.serializeAs_MimicryObjectPreviewMessage(output);
      }
      
      public function serializeAs_MimicryObjectPreviewMessage(output:ICustomDataOutput) : void
      {
         this.result.serializeAs_ObjectItem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MimicryObjectPreviewMessage(input);
      }
      
      public function deserializeAs_MimicryObjectPreviewMessage(input:ICustomDataInput) : void
      {
         this.result = new ObjectItem();
         this.result.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MimicryObjectPreviewMessage(tree);
      }
      
      public function deserializeAsyncAs_MimicryObjectPreviewMessage(tree:FuncTree) : void
      {
         this._resulttree = tree.addChild(this._resulttreeFunc);
      }
      
      private function _resulttreeFunc(input:ICustomDataInput) : void
      {
         this.result = new ObjectItem();
         this.result.deserializeAsync(this._resulttree);
      }
   }
}

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
   
   public class ObjectModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 334;
       
      
      private var _isInitialized:Boolean = false;
      
      public var object:ObjectItem;
      
      private var _objecttree:FuncTree;
      
      public function ObjectModifiedMessage()
      {
         this.object = new ObjectItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 334;
      }
      
      public function initObjectModifiedMessage(object:ObjectItem = null) : ObjectModifiedMessage
      {
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.object = new ObjectItem();
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
         this.serializeAs_ObjectModifiedMessage(output);
      }
      
      public function serializeAs_ObjectModifiedMessage(output:ICustomDataOutput) : void
      {
         this.object.serializeAs_ObjectItem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectModifiedMessage(input);
      }
      
      public function deserializeAs_ObjectModifiedMessage(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectModifiedMessage(tree:FuncTree) : void
      {
         this._objecttree = tree.addChild(this._objecttreeFunc);
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserializeAsync(this._objecttree);
      }
   }
}

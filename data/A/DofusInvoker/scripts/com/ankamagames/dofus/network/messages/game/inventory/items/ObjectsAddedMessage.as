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
   
   public class ObjectsAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1527;
       
      
      private var _isInitialized:Boolean = false;
      
      public var object:Vector.<ObjectItem>;
      
      private var _objecttree:FuncTree;
      
      public function ObjectsAddedMessage()
      {
         this.object = new Vector.<ObjectItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1527;
      }
      
      public function initObjectsAddedMessage(object:Vector.<ObjectItem> = null) : ObjectsAddedMessage
      {
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.object = new Vector.<ObjectItem>();
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
         this.serializeAs_ObjectsAddedMessage(output);
      }
      
      public function serializeAs_ObjectsAddedMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.object.length);
         for(var _i1:uint = 0; _i1 < this.object.length; _i1++)
         {
            (this.object[_i1] as ObjectItem).serializeAs_ObjectItem(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectsAddedMessage(input);
      }
      
      public function deserializeAs_ObjectsAddedMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItem = null;
         var _objectLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectLen; _i1++)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.object.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectsAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectsAddedMessage(tree:FuncTree) : void
      {
         this._objecttree = tree.addChild(this._objecttreeFunc);
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objecttree.addChild(this._objectFunc);
         }
      }
      
      private function _objectFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.object.push(_item);
      }
   }
}

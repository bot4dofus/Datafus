package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectsQuantityMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3309;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectsUIDAndQty:Vector.<ObjectItemQuantity>;
      
      private var _objectsUIDAndQtytree:FuncTree;
      
      public function ObjectsQuantityMessage()
      {
         this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3309;
      }
      
      public function initObjectsQuantityMessage(objectsUIDAndQty:Vector.<ObjectItemQuantity> = null) : ObjectsQuantityMessage
      {
         this.objectsUIDAndQty = objectsUIDAndQty;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectsUIDAndQty = new Vector.<ObjectItemQuantity>();
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
         this.serializeAs_ObjectsQuantityMessage(output);
      }
      
      public function serializeAs_ObjectsQuantityMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectsUIDAndQty.length);
         for(var _i1:uint = 0; _i1 < this.objectsUIDAndQty.length; _i1++)
         {
            (this.objectsUIDAndQty[_i1] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectsQuantityMessage(input);
      }
      
      public function deserializeAs_ObjectsQuantityMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItemQuantity = null;
         var _objectsUIDAndQtyLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsUIDAndQtyLen; _i1++)
         {
            _item1 = new ObjectItemQuantity();
            _item1.deserialize(input);
            this.objectsUIDAndQty.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectsQuantityMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectsQuantityMessage(tree:FuncTree) : void
      {
         this._objectsUIDAndQtytree = tree.addChild(this._objectsUIDAndQtytreeFunc);
      }
      
      private function _objectsUIDAndQtytreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectsUIDAndQtytree.addChild(this._objectsUIDAndQtyFunc);
         }
      }
      
      private function _objectsUIDAndQtyFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemQuantity = new ObjectItemQuantity();
         _item.deserialize(input);
         this.objectsUIDAndQty.push(_item);
      }
   }
}

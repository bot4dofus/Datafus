package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StorageObjectsUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6093;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectList:Vector.<ObjectItem>;
      
      private var _objectListtree:FuncTree;
      
      public function StorageObjectsUpdateMessage()
      {
         this.objectList = new Vector.<ObjectItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6093;
      }
      
      public function initStorageObjectsUpdateMessage(objectList:Vector.<ObjectItem> = null) : StorageObjectsUpdateMessage
      {
         this.objectList = objectList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectList = new Vector.<ObjectItem>();
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
         this.serializeAs_StorageObjectsUpdateMessage(output);
      }
      
      public function serializeAs_StorageObjectsUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectList.length);
         for(var _i1:uint = 0; _i1 < this.objectList.length; _i1++)
         {
            (this.objectList[_i1] as ObjectItem).serializeAs_ObjectItem(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StorageObjectsUpdateMessage(input);
      }
      
      public function deserializeAs_StorageObjectsUpdateMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItem = null;
         var _objectListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectListLen; _i1++)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.objectList.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StorageObjectsUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_StorageObjectsUpdateMessage(tree:FuncTree) : void
      {
         this._objectListtree = tree.addChild(this._objectListtreeFunc);
      }
      
      private function _objectListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectListtree.addChild(this._objectListFunc);
         }
      }
      
      private function _objectListFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.objectList.push(_item);
      }
   }
}

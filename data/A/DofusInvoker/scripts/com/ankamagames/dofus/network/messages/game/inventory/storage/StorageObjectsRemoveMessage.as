package com.ankamagames.dofus.network.messages.game.inventory.storage
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StorageObjectsRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1673;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUIDList:Vector.<uint>;
      
      private var _objectUIDListtree:FuncTree;
      
      public function StorageObjectsRemoveMessage()
      {
         this.objectUIDList = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1673;
      }
      
      public function initStorageObjectsRemoveMessage(objectUIDList:Vector.<uint> = null) : StorageObjectsRemoveMessage
      {
         this.objectUIDList = objectUIDList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUIDList = new Vector.<uint>();
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
         this.serializeAs_StorageObjectsRemoveMessage(output);
      }
      
      public function serializeAs_StorageObjectsRemoveMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objectUIDList.length);
         for(var _i1:uint = 0; _i1 < this.objectUIDList.length; _i1++)
         {
            if(this.objectUIDList[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.objectUIDList[_i1] + ") on element 1 (starting at 1) of objectUIDList.");
            }
            output.writeVarInt(this.objectUIDList[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StorageObjectsRemoveMessage(input);
      }
      
      public function deserializeAs_StorageObjectsRemoveMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _objectUIDListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectUIDListLen; _i1++)
         {
            _val1 = input.readVarUhInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of objectUIDList.");
            }
            this.objectUIDList.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StorageObjectsRemoveMessage(tree);
      }
      
      public function deserializeAsyncAs_StorageObjectsRemoveMessage(tree:FuncTree) : void
      {
         this._objectUIDListtree = tree.addChild(this._objectUIDListtreeFunc);
      }
      
      private function _objectUIDListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectUIDListtree.addChild(this._objectUIDListFunc);
         }
      }
      
      private function _objectUIDListFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of objectUIDList.");
         }
         this.objectUIDList.push(_val);
      }
   }
}

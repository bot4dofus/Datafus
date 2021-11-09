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
   
   public class InventoryContentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5506;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objects:Vector.<ObjectItem>;
      
      public var kamas:Number = 0;
      
      private var _objectstree:FuncTree;
      
      public function InventoryContentMessage()
      {
         this.objects = new Vector.<ObjectItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5506;
      }
      
      public function initInventoryContentMessage(objects:Vector.<ObjectItem> = null, kamas:Number = 0) : InventoryContentMessage
      {
         this.objects = objects;
         this.kamas = kamas;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objects = new Vector.<ObjectItem>();
         this.kamas = 0;
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
         this.serializeAs_InventoryContentMessage(output);
      }
      
      public function serializeAs_InventoryContentMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.objects.length);
         for(var _i1:uint = 0; _i1 < this.objects.length; _i1++)
         {
            (this.objects[_i1] as ObjectItem).serializeAs_ObjectItem(output);
         }
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InventoryContentMessage(input);
      }
      
      public function deserializeAs_InventoryContentMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItem = null;
         var _objectsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectsLen; _i1++)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.objects.push(_item1);
         }
         this._kamasFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InventoryContentMessage(tree);
      }
      
      public function deserializeAsyncAs_InventoryContentMessage(tree:FuncTree) : void
      {
         this._objectstree = tree.addChild(this._objectstreeFunc);
         tree.addChild(this._kamasFunc);
      }
      
      private function _objectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._objectstree.addChild(this._objectsFunc);
         }
      }
      
      private function _objectsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItem = new ObjectItem();
         _item.deserialize(input);
         this.objects.push(_item);
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of InventoryContentMessage.kamas.");
         }
      }
   }
}

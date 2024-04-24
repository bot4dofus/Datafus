package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectsAddedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2916;
       
      
      private var _isInitialized:Boolean = false;
      
      public var object:Vector.<ObjectItem>;
      
      private var _objecttree:FuncTree;
      
      public function ExchangeObjectsAddedMessage()
      {
         this.object = new Vector.<ObjectItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2916;
      }
      
      public function initExchangeObjectsAddedMessage(remote:Boolean = false, object:Vector.<ObjectItem> = null) : ExchangeObjectsAddedMessage
      {
         super.initExchangeObjectMessage(remote);
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeObjectsAddedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectsAddedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(output);
         output.writeShort(this.object.length);
         for(var _i1:uint = 0; _i1 < this.object.length; _i1++)
         {
            (this.object[_i1] as ObjectItem).serializeAs_ObjectItem(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectsAddedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectsAddedMessage(input:ICustomDataInput) : void
      {
         var _item1:ObjectItem = null;
         super.deserialize(input);
         var _objectLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _objectLen; _i1++)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.object.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectsAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectsAddedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
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

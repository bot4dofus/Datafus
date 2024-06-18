package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.inventory.exchanges.RecycledItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EvolutiveObjectRecycleResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5637;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recycledItems:Vector.<RecycledItem>;
      
      private var _recycledItemstree:FuncTree;
      
      public function EvolutiveObjectRecycleResultMessage()
      {
         this.recycledItems = new Vector.<RecycledItem>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5637;
      }
      
      public function initEvolutiveObjectRecycleResultMessage(recycledItems:Vector.<RecycledItem> = null) : EvolutiveObjectRecycleResultMessage
      {
         this.recycledItems = recycledItems;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recycledItems = new Vector.<RecycledItem>();
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
         this.serializeAs_EvolutiveObjectRecycleResultMessage(output);
      }
      
      public function serializeAs_EvolutiveObjectRecycleResultMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.recycledItems.length);
         for(var _i1:uint = 0; _i1 < this.recycledItems.length; _i1++)
         {
            (this.recycledItems[_i1] as RecycledItem).serializeAs_RecycledItem(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EvolutiveObjectRecycleResultMessage(input);
      }
      
      public function deserializeAs_EvolutiveObjectRecycleResultMessage(input:ICustomDataInput) : void
      {
         var _item1:RecycledItem = null;
         var _recycledItemsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _recycledItemsLen; _i1++)
         {
            _item1 = new RecycledItem();
            _item1.deserialize(input);
            this.recycledItems.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EvolutiveObjectRecycleResultMessage(tree);
      }
      
      public function deserializeAsyncAs_EvolutiveObjectRecycleResultMessage(tree:FuncTree) : void
      {
         this._recycledItemstree = tree.addChild(this._recycledItemstreeFunc);
      }
      
      private function _recycledItemstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._recycledItemstree.addChild(this._recycledItemsFunc);
         }
      }
      
      private function _recycledItemsFunc(input:ICustomDataInput) : void
      {
         var _item:RecycledItem = new RecycledItem();
         _item.deserialize(input);
         this.recycledItems.push(_item);
      }
   }
}

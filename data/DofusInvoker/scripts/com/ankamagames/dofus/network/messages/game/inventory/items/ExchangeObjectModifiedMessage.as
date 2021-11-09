package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6336;
       
      
      private var _isInitialized:Boolean = false;
      
      public var object:ObjectItem;
      
      private var _objecttree:FuncTree;
      
      public function ExchangeObjectModifiedMessage()
      {
         this.object = new ObjectItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6336;
      }
      
      public function initExchangeObjectModifiedMessage(remote:Boolean = false, object:ObjectItem = null) : ExchangeObjectModifiedMessage
      {
         super.initExchangeObjectMessage(remote);
         this.object = object;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeObjectModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeObjectModifiedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(output);
         this.object.serializeAs_ObjectItem(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectModifiedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.object = new ObjectItem();
         this.object.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectModifiedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._objecttree = tree.addChild(this._objecttreeFunc);
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserializeAsync(this._objecttree);
      }
   }
}

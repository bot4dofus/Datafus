package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftResultWithObjectDescMessage extends ExchangeCraftResultMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4819;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectInfo:ObjectItemNotInContainer;
      
      private var _objectInfotree:FuncTree;
      
      public function ExchangeCraftResultWithObjectDescMessage()
      {
         this.objectInfo = new ObjectItemNotInContainer();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4819;
      }
      
      public function initExchangeCraftResultWithObjectDescMessage(craftResult:uint = 0, objectInfo:ObjectItemNotInContainer = null) : ExchangeCraftResultWithObjectDescMessage
      {
         super.initExchangeCraftResultMessage(craftResult);
         this.objectInfo = objectInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.objectInfo = new ObjectItemNotInContainer();
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
         this.serializeAs_ExchangeCraftResultWithObjectDescMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultWithObjectDescMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeCraftResultMessage(output);
         this.objectInfo.serializeAs_ObjectItemNotInContainer(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftResultWithObjectDescMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultWithObjectDescMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.objectInfo = new ObjectItemNotInContainer();
         this.objectInfo.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftResultWithObjectDescMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftResultWithObjectDescMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._objectInfotree = tree.addChild(this._objectInfotreeFunc);
      }
      
      private function _objectInfotreeFunc(input:ICustomDataInput) : void
      {
         this.objectInfo = new ObjectItemNotInContainer();
         this.objectInfo.deserializeAsync(this._objectInfotree);
      }
   }
}

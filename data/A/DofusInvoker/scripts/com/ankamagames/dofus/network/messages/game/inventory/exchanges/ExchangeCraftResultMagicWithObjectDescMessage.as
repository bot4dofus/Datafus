package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftResultMagicWithObjectDescMessage extends ExchangeCraftResultWithObjectDescMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 95;
       
      
      private var _isInitialized:Boolean = false;
      
      public var magicPoolStatus:int = 0;
      
      public function ExchangeCraftResultMagicWithObjectDescMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 95;
      }
      
      public function initExchangeCraftResultMagicWithObjectDescMessage(craftResult:uint = 0, objectInfo:ObjectItemNotInContainer = null, magicPoolStatus:int = 0) : ExchangeCraftResultMagicWithObjectDescMessage
      {
         super.initExchangeCraftResultWithObjectDescMessage(craftResult,objectInfo);
         this.magicPoolStatus = magicPoolStatus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.magicPoolStatus = 0;
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
         this.serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(output);
      }
      
      public function serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeCraftResultWithObjectDescMessage(output);
         output.writeByte(this.magicPoolStatus);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._magicPoolStatusFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftResultMagicWithObjectDescMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftResultMagicWithObjectDescMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._magicPoolStatusFunc);
      }
      
      private function _magicPoolStatusFunc(input:ICustomDataInput) : void
      {
         this.magicPoolStatus = input.readByte();
      }
   }
}

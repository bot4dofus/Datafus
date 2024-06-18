package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeCraftCountModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7440;
       
      
      private var _isInitialized:Boolean = false;
      
      public var count:int = 0;
      
      public function ExchangeCraftCountModifiedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7440;
      }
      
      public function initExchangeCraftCountModifiedMessage(count:int = 0) : ExchangeCraftCountModifiedMessage
      {
         this.count = count;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.count = 0;
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
         this.serializeAs_ExchangeCraftCountModifiedMessage(output);
      }
      
      public function serializeAs_ExchangeCraftCountModifiedMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.count);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeCraftCountModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangeCraftCountModifiedMessage(input:ICustomDataInput) : void
      {
         this._countFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeCraftCountModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeCraftCountModifiedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._countFunc);
      }
      
      private function _countFunc(input:ICustomDataInput) : void
      {
         this.count = input.readVarInt();
      }
   }
}

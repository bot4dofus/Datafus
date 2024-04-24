package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeItemAutoCraftStopedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6145;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:int = 0;
      
      public function ExchangeItemAutoCraftStopedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6145;
      }
      
      public function initExchangeItemAutoCraftStopedMessage(reason:int = 0) : ExchangeItemAutoCraftStopedMessage
      {
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.reason = 0;
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
         this.serializeAs_ExchangeItemAutoCraftStopedMessage(output);
      }
      
      public function serializeAs_ExchangeItemAutoCraftStopedMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.reason);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeItemAutoCraftStopedMessage(input);
      }
      
      public function deserializeAs_ExchangeItemAutoCraftStopedMessage(input:ICustomDataInput) : void
      {
         this._reasonFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeItemAutoCraftStopedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeItemAutoCraftStopedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._reasonFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
      }
   }
}

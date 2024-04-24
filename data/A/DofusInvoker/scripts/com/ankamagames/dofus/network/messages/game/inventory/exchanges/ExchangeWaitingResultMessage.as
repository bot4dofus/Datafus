package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeWaitingResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6531;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bwait:Boolean = false;
      
      public function ExchangeWaitingResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6531;
      }
      
      public function initExchangeWaitingResultMessage(bwait:Boolean = false) : ExchangeWaitingResultMessage
      {
         this.bwait = bwait;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.bwait = false;
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
         this.serializeAs_ExchangeWaitingResultMessage(output);
      }
      
      public function serializeAs_ExchangeWaitingResultMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.bwait);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeWaitingResultMessage(input);
      }
      
      public function deserializeAs_ExchangeWaitingResultMessage(input:ICustomDataInput) : void
      {
         this._bwaitFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeWaitingResultMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeWaitingResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._bwaitFunc);
      }
      
      private function _bwaitFunc(input:ICustomDataInput) : void
      {
         this.bwait = input.readBoolean();
      }
   }
}

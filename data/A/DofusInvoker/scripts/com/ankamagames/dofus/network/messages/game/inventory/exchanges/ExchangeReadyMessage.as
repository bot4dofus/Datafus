package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2256;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ready:Boolean = false;
      
      public var step:uint = 0;
      
      public function ExchangeReadyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2256;
      }
      
      public function initExchangeReadyMessage(ready:Boolean = false, step:uint = 0) : ExchangeReadyMessage
      {
         this.ready = ready;
         this.step = step;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ready = false;
         this.step = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_ExchangeReadyMessage(output);
      }
      
      public function serializeAs_ExchangeReadyMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.ready);
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element step.");
         }
         output.writeVarShort(this.step);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeReadyMessage(input);
      }
      
      public function deserializeAs_ExchangeReadyMessage(input:ICustomDataInput) : void
      {
         this._readyFunc(input);
         this._stepFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeReadyMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeReadyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._readyFunc);
         tree.addChild(this._stepFunc);
      }
      
      private function _readyFunc(input:ICustomDataInput) : void
      {
         this.ready = input.readBoolean();
      }
      
      private function _stepFunc(input:ICustomDataInput) : void
      {
         this.step = input.readVarUhShort();
         if(this.step < 0)
         {
            throw new Error("Forbidden value (" + this.step + ") on element of ExchangeReadyMessage.step.");
         }
      }
   }
}

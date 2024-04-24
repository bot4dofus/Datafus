package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangePodsModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8862;
       
      
      private var _isInitialized:Boolean = false;
      
      public var currentWeight:uint = 0;
      
      public var maxWeight:uint = 0;
      
      public function ExchangePodsModifiedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8862;
      }
      
      public function initExchangePodsModifiedMessage(remote:Boolean = false, currentWeight:uint = 0, maxWeight:uint = 0) : ExchangePodsModifiedMessage
      {
         super.initExchangeObjectMessage(remote);
         this.currentWeight = currentWeight;
         this.maxWeight = maxWeight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.currentWeight = 0;
         this.maxWeight = 0;
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
         this.serializeAs_ExchangePodsModifiedMessage(output);
      }
      
      public function serializeAs_ExchangePodsModifiedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeObjectMessage(output);
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element currentWeight.");
         }
         output.writeVarInt(this.currentWeight);
         if(this.maxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.maxWeight + ") on element maxWeight.");
         }
         output.writeVarInt(this.maxWeight);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangePodsModifiedMessage(input);
      }
      
      public function deserializeAs_ExchangePodsModifiedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._currentWeightFunc(input);
         this._maxWeightFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangePodsModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangePodsModifiedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._currentWeightFunc);
         tree.addChild(this._maxWeightFunc);
      }
      
      private function _currentWeightFunc(input:ICustomDataInput) : void
      {
         this.currentWeight = input.readVarUhInt();
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element of ExchangePodsModifiedMessage.currentWeight.");
         }
      }
      
      private function _maxWeightFunc(input:ICustomDataInput) : void
      {
         this.maxWeight = input.readVarUhInt();
         if(this.maxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.maxWeight + ") on element of ExchangePodsModifiedMessage.maxWeight.");
         }
      }
   }
}

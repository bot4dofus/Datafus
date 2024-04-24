package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1988;
       
      
      private var _isInitialized:Boolean = false;
      
      public var currentWeight:uint = 0;
      
      public var maxWeight:uint = 0;
      
      public function ExchangeWeightMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1988;
      }
      
      public function initExchangeWeightMessage(currentWeight:uint = 0, maxWeight:uint = 0) : ExchangeWeightMessage
      {
         this.currentWeight = currentWeight;
         this.maxWeight = maxWeight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeWeightMessage(output);
      }
      
      public function serializeAs_ExchangeWeightMessage(output:ICustomDataOutput) : void
      {
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
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeWeightMessage(input);
      }
      
      public function deserializeAs_ExchangeWeightMessage(input:ICustomDataInput) : void
      {
         this._currentWeightFunc(input);
         this._maxWeightFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeWeightMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeWeightMessage(tree:FuncTree) : void
      {
         tree.addChild(this._currentWeightFunc);
         tree.addChild(this._maxWeightFunc);
      }
      
      private function _currentWeightFunc(input:ICustomDataInput) : void
      {
         this.currentWeight = input.readVarUhInt();
         if(this.currentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.currentWeight + ") on element of ExchangeWeightMessage.currentWeight.");
         }
      }
      
      private function _maxWeightFunc(input:ICustomDataInput) : void
      {
         this.maxWeight = input.readVarUhInt();
         if(this.maxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.maxWeight + ") on element of ExchangeWeightMessage.maxWeight.");
         }
      }
   }
}

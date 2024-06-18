package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartedWithPodsMessage extends ExchangeStartedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5028;
       
      
      private var _isInitialized:Boolean = false;
      
      public var firstCharacterId:Number = 0;
      
      public var firstCharacterCurrentWeight:uint = 0;
      
      public var firstCharacterMaxWeight:uint = 0;
      
      public var secondCharacterId:Number = 0;
      
      public var secondCharacterCurrentWeight:uint = 0;
      
      public var secondCharacterMaxWeight:uint = 0;
      
      public function ExchangeStartedWithPodsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5028;
      }
      
      public function initExchangeStartedWithPodsMessage(exchangeType:int = 0, firstCharacterId:Number = 0, firstCharacterCurrentWeight:uint = 0, firstCharacterMaxWeight:uint = 0, secondCharacterId:Number = 0, secondCharacterCurrentWeight:uint = 0, secondCharacterMaxWeight:uint = 0) : ExchangeStartedWithPodsMessage
      {
         super.initExchangeStartedMessage(exchangeType);
         this.firstCharacterId = firstCharacterId;
         this.firstCharacterCurrentWeight = firstCharacterCurrentWeight;
         this.firstCharacterMaxWeight = firstCharacterMaxWeight;
         this.secondCharacterId = secondCharacterId;
         this.secondCharacterCurrentWeight = secondCharacterCurrentWeight;
         this.secondCharacterMaxWeight = secondCharacterMaxWeight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.firstCharacterId = 0;
         this.firstCharacterCurrentWeight = 0;
         this.firstCharacterMaxWeight = 0;
         this.secondCharacterId = 0;
         this.secondCharacterCurrentWeight = 0;
         this.secondCharacterMaxWeight = 0;
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
         this.serializeAs_ExchangeStartedWithPodsMessage(output);
      }
      
      public function serializeAs_ExchangeStartedWithPodsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeStartedMessage(output);
         if(this.firstCharacterId < -9007199254740992 || this.firstCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.firstCharacterId + ") on element firstCharacterId.");
         }
         output.writeDouble(this.firstCharacterId);
         if(this.firstCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element firstCharacterCurrentWeight.");
         }
         output.writeVarInt(this.firstCharacterCurrentWeight);
         if(this.firstCharacterMaxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element firstCharacterMaxWeight.");
         }
         output.writeVarInt(this.firstCharacterMaxWeight);
         if(this.secondCharacterId < -9007199254740992 || this.secondCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.secondCharacterId + ") on element secondCharacterId.");
         }
         output.writeDouble(this.secondCharacterId);
         if(this.secondCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element secondCharacterCurrentWeight.");
         }
         output.writeVarInt(this.secondCharacterCurrentWeight);
         if(this.secondCharacterMaxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element secondCharacterMaxWeight.");
         }
         output.writeVarInt(this.secondCharacterMaxWeight);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartedWithPodsMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedWithPodsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._firstCharacterIdFunc(input);
         this._firstCharacterCurrentWeightFunc(input);
         this._firstCharacterMaxWeightFunc(input);
         this._secondCharacterIdFunc(input);
         this._secondCharacterCurrentWeightFunc(input);
         this._secondCharacterMaxWeightFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartedWithPodsMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartedWithPodsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._firstCharacterIdFunc);
         tree.addChild(this._firstCharacterCurrentWeightFunc);
         tree.addChild(this._firstCharacterMaxWeightFunc);
         tree.addChild(this._secondCharacterIdFunc);
         tree.addChild(this._secondCharacterCurrentWeightFunc);
         tree.addChild(this._secondCharacterMaxWeightFunc);
      }
      
      private function _firstCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.firstCharacterId = input.readDouble();
         if(this.firstCharacterId < -9007199254740992 || this.firstCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.firstCharacterId + ") on element of ExchangeStartedWithPodsMessage.firstCharacterId.");
         }
      }
      
      private function _firstCharacterCurrentWeightFunc(input:ICustomDataInput) : void
      {
         this.firstCharacterCurrentWeight = input.readVarUhInt();
         if(this.firstCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterCurrentWeight.");
         }
      }
      
      private function _firstCharacterMaxWeightFunc(input:ICustomDataInput) : void
      {
         this.firstCharacterMaxWeight = input.readVarUhInt();
         if(this.firstCharacterMaxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterMaxWeight.");
         }
      }
      
      private function _secondCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.secondCharacterId = input.readDouble();
         if(this.secondCharacterId < -9007199254740992 || this.secondCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.secondCharacterId + ") on element of ExchangeStartedWithPodsMessage.secondCharacterId.");
         }
      }
      
      private function _secondCharacterCurrentWeightFunc(input:ICustomDataInput) : void
      {
         this.secondCharacterCurrentWeight = input.readVarUhInt();
         if(this.secondCharacterCurrentWeight < 0)
         {
            throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterCurrentWeight.");
         }
      }
      
      private function _secondCharacterMaxWeightFunc(input:ICustomDataInput) : void
      {
         this.secondCharacterMaxWeight = input.readVarUhInt();
         if(this.secondCharacterMaxWeight < 0)
         {
            throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterMaxWeight.");
         }
      }
   }
}

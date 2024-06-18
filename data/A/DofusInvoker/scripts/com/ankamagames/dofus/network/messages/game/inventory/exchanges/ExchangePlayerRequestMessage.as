package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangePlayerRequestMessage extends ExchangeRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9371;
       
      
      private var _isInitialized:Boolean = false;
      
      public var target:Number = 0;
      
      public function ExchangePlayerRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9371;
      }
      
      public function initExchangePlayerRequestMessage(exchangeType:int = 0, target:Number = 0) : ExchangePlayerRequestMessage
      {
         super.initExchangeRequestMessage(exchangeType);
         this.target = target;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.target = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangePlayerRequestMessage(output);
      }
      
      public function serializeAs_ExchangePlayerRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeRequestMessage(output);
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element target.");
         }
         output.writeVarLong(this.target);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangePlayerRequestMessage(input);
      }
      
      public function deserializeAs_ExchangePlayerRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._targetFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangePlayerRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangePlayerRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._targetFunc);
      }
      
      private function _targetFunc(input:ICustomDataInput) : void
      {
         this.target = input.readVarUhLong();
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element of ExchangePlayerRequestMessage.target.");
         }
      }
   }
}

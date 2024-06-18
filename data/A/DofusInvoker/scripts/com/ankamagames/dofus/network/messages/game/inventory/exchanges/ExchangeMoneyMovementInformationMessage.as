package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeMoneyMovementInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6145;
       
      
      private var _isInitialized:Boolean = false;
      
      public var limit:Number = 0;
      
      public function ExchangeMoneyMovementInformationMessage()
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
      
      public function initExchangeMoneyMovementInformationMessage(limit:Number = 0) : ExchangeMoneyMovementInformationMessage
      {
         this.limit = limit;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.limit = 0;
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
         this.serializeAs_ExchangeMoneyMovementInformationMessage(output);
      }
      
      public function serializeAs_ExchangeMoneyMovementInformationMessage(output:ICustomDataOutput) : void
      {
         if(this.limit < 0 || this.limit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.limit + ") on element limit.");
         }
         output.writeVarLong(this.limit);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeMoneyMovementInformationMessage(input);
      }
      
      public function deserializeAs_ExchangeMoneyMovementInformationMessage(input:ICustomDataInput) : void
      {
         this._limitFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeMoneyMovementInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeMoneyMovementInformationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._limitFunc);
      }
      
      private function _limitFunc(input:ICustomDataInput) : void
      {
         this.limit = input.readVarUhLong();
         if(this.limit < 0 || this.limit > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.limit + ") on element of ExchangeMoneyMovementInformationMessage.limit.");
         }
      }
   }
}

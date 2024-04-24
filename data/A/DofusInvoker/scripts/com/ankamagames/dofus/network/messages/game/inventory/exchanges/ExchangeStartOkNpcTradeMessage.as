package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartOkNpcTradeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7225;
       
      
      private var _isInitialized:Boolean = false;
      
      public var npcId:Number = 0;
      
      public function ExchangeStartOkNpcTradeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7225;
      }
      
      public function initExchangeStartOkNpcTradeMessage(npcId:Number = 0) : ExchangeStartOkNpcTradeMessage
      {
         this.npcId = npcId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.npcId = 0;
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
         this.serializeAs_ExchangeStartOkNpcTradeMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkNpcTradeMessage(output:ICustomDataOutput) : void
      {
         if(this.npcId < -9007199254740992 || this.npcId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         output.writeDouble(this.npcId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkNpcTradeMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkNpcTradeMessage(input:ICustomDataInput) : void
      {
         this._npcIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartOkNpcTradeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartOkNpcTradeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._npcIdFunc);
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readDouble();
         if(this.npcId < -9007199254740992 || this.npcId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element of ExchangeStartOkNpcTradeMessage.npcId.");
         }
      }
   }
}

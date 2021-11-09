package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStoppedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1093;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public function ExchangeStoppedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1093;
      }
      
      public function initExchangeStoppedMessage(id:Number = 0) : ExchangeStoppedMessage
      {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
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
         this.serializeAs_ExchangeStoppedMessage(output);
      }
      
      public function serializeAs_ExchangeStoppedMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStoppedMessage(input);
      }
      
      public function deserializeAs_ExchangeStoppedMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStoppedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStoppedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeStoppedMessage.id.");
         }
      }
   }
}

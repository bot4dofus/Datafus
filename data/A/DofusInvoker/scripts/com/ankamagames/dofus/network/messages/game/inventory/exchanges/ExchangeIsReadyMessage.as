package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeIsReadyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9119;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public var ready:Boolean = false;
      
      public function ExchangeIsReadyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9119;
      }
      
      public function initExchangeIsReadyMessage(id:Number = 0, ready:Boolean = false) : ExchangeIsReadyMessage
      {
         this.id = id;
         this.ready = ready;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.ready = false;
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
         this.serializeAs_ExchangeIsReadyMessage(output);
      }
      
      public function serializeAs_ExchangeIsReadyMessage(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         output.writeBoolean(this.ready);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeIsReadyMessage(input);
      }
      
      public function deserializeAs_ExchangeIsReadyMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._readyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeIsReadyMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeIsReadyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._readyFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeIsReadyMessage.id.");
         }
      }
      
      private function _readyFunc(input:ICustomDataInput) : void
      {
         this.ready = input.readBoolean();
      }
   }
}

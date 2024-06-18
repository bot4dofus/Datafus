package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3411;
       
      
      private var _isInitialized:Boolean = false;
      
      public var remote:Boolean = false;
      
      public function ExchangeObjectMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3411;
      }
      
      public function initExchangeObjectMessage(remote:Boolean = false) : ExchangeObjectMessage
      {
         this.remote = remote;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.remote = false;
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
         this.serializeAs_ExchangeObjectMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.remote);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMessage(input:ICustomDataInput) : void
      {
         this._remoteFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectMessage(tree:FuncTree) : void
      {
         tree.addChild(this._remoteFunc);
      }
      
      private function _remoteFunc(input:ICustomDataInput) : void
      {
         this.remote = input.readBoolean();
      }
   }
}

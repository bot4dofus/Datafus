package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1767;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:uint = 0;
      
      public var follow:Boolean = false;
      
      public function ExchangeBidHouseListMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1767;
      }
      
      public function initExchangeBidHouseListMessage(id:uint = 0, follow:Boolean = false) : ExchangeBidHouseListMessage
      {
         this.id = id;
         this.follow = follow;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.follow = false;
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
         this.serializeAs_ExchangeBidHouseListMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseListMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         output.writeBoolean(this.follow);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseListMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseListMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._followFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseListMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseListMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._followFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeBidHouseListMessage.id.");
         }
      }
      
      private function _followFunc(input:ICustomDataInput) : void
      {
         this.follow = input.readBoolean();
      }
   }
}

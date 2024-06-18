package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseTypeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8802;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public var follow:Boolean = false;
      
      public function ExchangeBidHouseTypeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8802;
      }
      
      public function initExchangeBidHouseTypeMessage(type:uint = 0, follow:Boolean = false) : ExchangeBidHouseTypeMessage
      {
         this.type = type;
         this.follow = follow;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.type = 0;
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
         this.serializeAs_ExchangeBidHouseTypeMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseTypeMessage(output:ICustomDataOutput) : void
      {
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element type.");
         }
         output.writeVarInt(this.type);
         output.writeBoolean(this.follow);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseTypeMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseTypeMessage(input:ICustomDataInput) : void
      {
         this._typeFunc(input);
         this._followFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseTypeMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseTypeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._typeFunc);
         tree.addChild(this._followFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readVarUhInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseTypeMessage.type.");
         }
      }
      
      private function _followFunc(input:ICustomDataInput) : void
      {
         this.follow = input.readBoolean();
      }
   }
}

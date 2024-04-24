package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseSearchMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8231;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectGID:uint = 0;
      
      public var follow:Boolean = false;
      
      public function ExchangeBidHouseSearchMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8231;
      }
      
      public function initExchangeBidHouseSearchMessage(objectGID:uint = 0, follow:Boolean = false) : ExchangeBidHouseSearchMessage
      {
         this.objectGID = objectGID;
         this.follow = follow;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
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
         this.serializeAs_ExchangeBidHouseSearchMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseSearchMessage(output:ICustomDataOutput) : void
      {
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
         output.writeBoolean(this.follow);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseSearchMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseSearchMessage(input:ICustomDataInput) : void
      {
         this._objectGIDFunc(input);
         this._followFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseSearchMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseSearchMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectGIDFunc);
         tree.addChild(this._followFunc);
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ExchangeBidHouseSearchMessage.objectGID.");
         }
      }
      
      private function _followFunc(input:ICustomDataInput) : void
      {
         this.follow = input.readBoolean();
      }
   }
}

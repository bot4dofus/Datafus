package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseInListRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4180;
       
      
      private var _isInitialized:Boolean = false;
      
      public var itemUID:int = 0;
      
      public var objectGID:uint = 0;
      
      public var objectType:uint = 0;
      
      public function ExchangeBidHouseInListRemovedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4180;
      }
      
      public function initExchangeBidHouseInListRemovedMessage(itemUID:int = 0, objectGID:uint = 0, objectType:uint = 0) : ExchangeBidHouseInListRemovedMessage
      {
         this.itemUID = itemUID;
         this.objectGID = objectGID;
         this.objectType = objectType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.itemUID = 0;
         this.objectGID = 0;
         this.objectType = 0;
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
         this.serializeAs_ExchangeBidHouseInListRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseInListRemovedMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.itemUID);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
         if(this.objectType < 0)
         {
            throw new Error("Forbidden value (" + this.objectType + ") on element objectType.");
         }
         output.writeInt(this.objectType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseInListRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseInListRemovedMessage(input:ICustomDataInput) : void
      {
         this._itemUIDFunc(input);
         this._objectGIDFunc(input);
         this._objectTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseInListRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseInListRemovedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._itemUIDFunc);
         tree.addChild(this._objectGIDFunc);
         tree.addChild(this._objectTypeFunc);
      }
      
      private function _itemUIDFunc(input:ICustomDataInput) : void
      {
         this.itemUID = input.readInt();
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ExchangeBidHouseInListRemovedMessage.objectGID.");
         }
      }
      
      private function _objectTypeFunc(input:ICustomDataInput) : void
      {
         this.objectType = input.readInt();
         if(this.objectType < 0)
         {
            throw new Error("Forbidden value (" + this.objectType + ") on element of ExchangeBidHouseInListRemovedMessage.objectType.");
         }
      }
   }
}

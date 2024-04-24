package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeObjectMoveToTabMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3518;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objectUID:uint = 0;
      
      public var quantity:int = 0;
      
      public var tabNumber:uint = 0;
      
      public function ExchangeObjectMoveToTabMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3518;
      }
      
      public function initExchangeObjectMoveToTabMessage(objectUID:uint = 0, quantity:int = 0, tabNumber:uint = 0) : ExchangeObjectMoveToTabMessage
      {
         this.objectUID = objectUID;
         this.quantity = quantity;
         this.tabNumber = tabNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.quantity = 0;
         this.tabNumber = 0;
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
         this.serializeAs_ExchangeObjectMoveToTabMessage(output);
      }
      
      public function serializeAs_ExchangeObjectMoveToTabMessage(output:ICustomDataOutput) : void
      {
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
         output.writeVarInt(this.quantity);
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element tabNumber.");
         }
         output.writeVarInt(this.tabNumber);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeObjectMoveToTabMessage(input);
      }
      
      public function deserializeAs_ExchangeObjectMoveToTabMessage(input:ICustomDataInput) : void
      {
         this._objectUIDFunc(input);
         this._quantityFunc(input);
         this._tabNumberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeObjectMoveToTabMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeObjectMoveToTabMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._quantityFunc);
         tree.addChild(this._tabNumberFunc);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeObjectMoveToTabMessage.objectUID.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarInt();
      }
      
      private function _tabNumberFunc(input:ICustomDataInput) : void
      {
         this.tabNumber = input.readVarUhInt();
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of ExchangeObjectMoveToTabMessage.tabNumber.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseGenericItemRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3347;
       
      
      private var _isInitialized:Boolean = false;
      
      public var objGenericId:uint = 0;
      
      public function ExchangeBidHouseGenericItemRemovedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3347;
      }
      
      public function initExchangeBidHouseGenericItemRemovedMessage(objGenericId:uint = 0) : ExchangeBidHouseGenericItemRemovedMessage
      {
         this.objGenericId = objGenericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.objGenericId = 0;
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
         this.serializeAs_ExchangeBidHouseGenericItemRemovedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseGenericItemRemovedMessage(output:ICustomDataOutput) : void
      {
         if(this.objGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objGenericId + ") on element objGenericId.");
         }
         output.writeVarInt(this.objGenericId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseGenericItemRemovedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseGenericItemRemovedMessage(input:ICustomDataInput) : void
      {
         this._objGenericIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseGenericItemRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseGenericItemRemovedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._objGenericIdFunc);
      }
      
      private function _objGenericIdFunc(input:ICustomDataInput) : void
      {
         this.objGenericId = input.readVarUhInt();
         if(this.objGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.objGenericId + ") on element of ExchangeBidHouseGenericItemRemovedMessage.objGenericId.");
         }
      }
   }
}

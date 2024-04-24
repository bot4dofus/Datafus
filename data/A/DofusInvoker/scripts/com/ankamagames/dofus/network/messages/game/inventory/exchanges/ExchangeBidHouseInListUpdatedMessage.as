package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeBidHouseInListUpdatedMessage extends ExchangeBidHouseInListAddedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4284;
       
      
      private var _isInitialized:Boolean = false;
      
      public function ExchangeBidHouseInListUpdatedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4284;
      }
      
      public function initExchangeBidHouseInListUpdatedMessage(itemUID:int = 0, objectGID:uint = 0, objectType:uint = 0, effects:Vector.<ObjectEffect> = null, prices:Vector.<Number> = null) : ExchangeBidHouseInListUpdatedMessage
      {
         super.initExchangeBidHouseInListAddedMessage(itemUID,objectGID,objectType,effects,prices);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeBidHouseInListUpdatedMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseInListUpdatedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExchangeBidHouseInListAddedMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeBidHouseInListUpdatedMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseInListUpdatedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeBidHouseInListUpdatedMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeBidHouseInListUpdatedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

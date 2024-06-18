package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseSellRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1606;
       
      
      private var _isInitialized:Boolean = false;
      
      public var instanceId:uint = 0;
      
      public var amount:Number = 0;
      
      public var forSale:Boolean = false;
      
      public function HouseSellRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1606;
      }
      
      public function initHouseSellRequestMessage(instanceId:uint = 0, amount:Number = 0, forSale:Boolean = false) : HouseSellRequestMessage
      {
         this.instanceId = instanceId;
         this.amount = amount;
         this.forSale = forSale;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.instanceId = 0;
         this.amount = 0;
         this.forSale = false;
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
         this.serializeAs_HouseSellRequestMessage(output);
      }
      
      public function serializeAs_HouseSellRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarLong(this.amount);
         output.writeBoolean(this.forSale);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseSellRequestMessage(input);
      }
      
      public function deserializeAs_HouseSellRequestMessage(input:ICustomDataInput) : void
      {
         this._instanceIdFunc(input);
         this._amountFunc(input);
         this._forSaleFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseSellRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseSellRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._amountFunc);
         tree.addChild(this._forSaleFunc);
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseSellRequestMessage.instanceId.");
         }
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhLong();
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of HouseSellRequestMessage.amount.");
         }
      }
      
      private function _forSaleFunc(input:ICustomDataInput) : void
      {
         this.forSale = input.readBoolean();
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeOkMultiCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4122;
       
      
      private var _isInitialized:Boolean = false;
      
      public var initiatorId:Number = 0;
      
      public var otherId:Number = 0;
      
      public var role:int = 0;
      
      public function ExchangeOkMultiCraftMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4122;
      }
      
      public function initExchangeOkMultiCraftMessage(initiatorId:Number = 0, otherId:Number = 0, role:int = 0) : ExchangeOkMultiCraftMessage
      {
         this.initiatorId = initiatorId;
         this.otherId = otherId;
         this.role = role;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.initiatorId = 0;
         this.otherId = 0;
         this.role = 0;
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
         this.serializeAs_ExchangeOkMultiCraftMessage(output);
      }
      
      public function serializeAs_ExchangeOkMultiCraftMessage(output:ICustomDataOutput) : void
      {
         if(this.initiatorId < 0 || this.initiatorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element initiatorId.");
         }
         output.writeVarLong(this.initiatorId);
         if(this.otherId < 0 || this.otherId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.otherId + ") on element otherId.");
         }
         output.writeVarLong(this.otherId);
         output.writeByte(this.role);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeOkMultiCraftMessage(input);
      }
      
      public function deserializeAs_ExchangeOkMultiCraftMessage(input:ICustomDataInput) : void
      {
         this._initiatorIdFunc(input);
         this._otherIdFunc(input);
         this._roleFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeOkMultiCraftMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeOkMultiCraftMessage(tree:FuncTree) : void
      {
         tree.addChild(this._initiatorIdFunc);
         tree.addChild(this._otherIdFunc);
         tree.addChild(this._roleFunc);
      }
      
      private function _initiatorIdFunc(input:ICustomDataInput) : void
      {
         this.initiatorId = input.readVarUhLong();
         if(this.initiatorId < 0 || this.initiatorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element of ExchangeOkMultiCraftMessage.initiatorId.");
         }
      }
      
      private function _otherIdFunc(input:ICustomDataInput) : void
      {
         this.otherId = input.readVarUhLong();
         if(this.otherId < 0 || this.otherId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.otherId + ") on element of ExchangeOkMultiCraftMessage.otherId.");
         }
      }
      
      private function _roleFunc(input:ICustomDataInput) : void
      {
         this.role = input.readByte();
      }
   }
}

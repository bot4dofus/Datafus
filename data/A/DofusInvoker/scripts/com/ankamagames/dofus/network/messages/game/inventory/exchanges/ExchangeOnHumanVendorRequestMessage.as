package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeOnHumanVendorRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5497;
       
      
      private var _isInitialized:Boolean = false;
      
      public var humanVendorId:Number = 0;
      
      public var humanVendorCell:uint = 0;
      
      public function ExchangeOnHumanVendorRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5497;
      }
      
      public function initExchangeOnHumanVendorRequestMessage(humanVendorId:Number = 0, humanVendorCell:uint = 0) : ExchangeOnHumanVendorRequestMessage
      {
         this.humanVendorId = humanVendorId;
         this.humanVendorCell = humanVendorCell;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.humanVendorId = 0;
         this.humanVendorCell = 0;
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
         this.serializeAs_ExchangeOnHumanVendorRequestMessage(output);
      }
      
      public function serializeAs_ExchangeOnHumanVendorRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.humanVendorId < 0 || this.humanVendorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.humanVendorId + ") on element humanVendorId.");
         }
         output.writeVarLong(this.humanVendorId);
         if(this.humanVendorCell < 0 || this.humanVendorCell > 559)
         {
            throw new Error("Forbidden value (" + this.humanVendorCell + ") on element humanVendorCell.");
         }
         output.writeVarShort(this.humanVendorCell);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeOnHumanVendorRequestMessage(input);
      }
      
      public function deserializeAs_ExchangeOnHumanVendorRequestMessage(input:ICustomDataInput) : void
      {
         this._humanVendorIdFunc(input);
         this._humanVendorCellFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeOnHumanVendorRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeOnHumanVendorRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._humanVendorIdFunc);
         tree.addChild(this._humanVendorCellFunc);
      }
      
      private function _humanVendorIdFunc(input:ICustomDataInput) : void
      {
         this.humanVendorId = input.readVarUhLong();
         if(this.humanVendorId < 0 || this.humanVendorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.humanVendorId + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorId.");
         }
      }
      
      private function _humanVendorCellFunc(input:ICustomDataInput) : void
      {
         this.humanVendorCell = input.readVarUhShort();
         if(this.humanVendorCell < 0 || this.humanVendorCell > 559)
         {
            throw new Error("Forbidden value (" + this.humanVendorCell + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorCell.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ExchangeStartedTaxCollectorEquipmentMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9029;
       
      
      private var _isInitialized:Boolean = false;
      
      public var information:TaxCollectorInformations;
      
      private var _informationtree:FuncTree;
      
      public function ExchangeStartedTaxCollectorEquipmentMessage()
      {
         this.information = new TaxCollectorInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9029;
      }
      
      public function initExchangeStartedTaxCollectorEquipmentMessage(information:TaxCollectorInformations = null) : ExchangeStartedTaxCollectorEquipmentMessage
      {
         this.information = information;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.information = new TaxCollectorInformations();
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
         this.serializeAs_ExchangeStartedTaxCollectorEquipmentMessage(output);
      }
      
      public function serializeAs_ExchangeStartedTaxCollectorEquipmentMessage(output:ICustomDataOutput) : void
      {
         this.information.serializeAs_TaxCollectorInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartedTaxCollectorEquipmentMessage(input);
      }
      
      public function deserializeAs_ExchangeStartedTaxCollectorEquipmentMessage(input:ICustomDataInput) : void
      {
         this.information = new TaxCollectorInformations();
         this.information.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExchangeStartedTaxCollectorEquipmentMessage(tree);
      }
      
      public function deserializeAsyncAs_ExchangeStartedTaxCollectorEquipmentMessage(tree:FuncTree) : void
      {
         this._informationtree = tree.addChild(this._informationtreeFunc);
      }
      
      private function _informationtreeFunc(input:ICustomDataInput) : void
      {
         this.information = new TaxCollectorInformations();
         this.information.deserializeAsync(this._informationtree);
      }
   }
}

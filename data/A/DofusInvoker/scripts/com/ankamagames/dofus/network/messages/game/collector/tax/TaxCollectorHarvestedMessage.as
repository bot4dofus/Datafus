package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorHarvestedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3704;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public var harvesterId:Number = 0;
      
      public var harvesterName:String = "";
      
      public function TaxCollectorHarvestedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3704;
      }
      
      public function initTaxCollectorHarvestedMessage(taxCollectorId:Number = 0, harvesterId:Number = 0, harvesterName:String = "") : TaxCollectorHarvestedMessage
      {
         this.taxCollectorId = taxCollectorId;
         this.harvesterId = harvesterId;
         this.harvesterName = harvesterName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this.harvesterId = 0;
         this.harvesterName = "";
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
         this.serializeAs_TaxCollectorHarvestedMessage(output);
      }
      
      public function serializeAs_TaxCollectorHarvestedMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
         if(this.harvesterId < 0 || this.harvesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.harvesterId + ") on element harvesterId.");
         }
         output.writeVarLong(this.harvesterId);
         output.writeUTF(this.harvesterName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorHarvestedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorHarvestedMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
         this._harvesterIdFunc(input);
         this._harvesterNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorHarvestedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorHarvestedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
         tree.addChild(this._harvesterIdFunc);
         tree.addChild(this._harvesterNameFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of TaxCollectorHarvestedMessage.taxCollectorId.");
         }
      }
      
      private function _harvesterIdFunc(input:ICustomDataInput) : void
      {
         this.harvesterId = input.readVarUhLong();
         if(this.harvesterId < 0 || this.harvesterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.harvesterId + ") on element of TaxCollectorHarvestedMessage.harvesterId.");
         }
      }
      
      private function _harvesterNameFunc(input:ICustomDataInput) : void
      {
         this.harvesterName = input.readUTF();
      }
   }
}

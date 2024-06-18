package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2310;
       
      
      private var _isInitialized:Boolean = false;
      
      public var collectorId:Number = 0;
      
      public function TaxCollectorRemovedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2310;
      }
      
      public function initTaxCollectorRemovedMessage(collectorId:Number = 0) : TaxCollectorRemovedMessage
      {
         this.collectorId = collectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.collectorId = 0;
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
         this.serializeAs_TaxCollectorRemovedMessage(output);
      }
      
      public function serializeAs_TaxCollectorRemovedMessage(output:ICustomDataOutput) : void
      {
         if(this.collectorId < 0 || this.collectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorId + ") on element collectorId.");
         }
         output.writeDouble(this.collectorId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorRemovedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorRemovedMessage(input:ICustomDataInput) : void
      {
         this._collectorIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorRemovedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._collectorIdFunc);
      }
      
      private function _collectorIdFunc(input:ICustomDataInput) : void
      {
         this.collectorId = input.readDouble();
         if(this.collectorId < 0 || this.collectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.collectorId + ") on element of TaxCollectorRemovedMessage.collectorId.");
         }
      }
   }
}

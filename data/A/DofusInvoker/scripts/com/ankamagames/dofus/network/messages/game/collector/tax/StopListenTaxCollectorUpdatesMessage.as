package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StopListenTaxCollectorUpdatesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4576;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public function StopListenTaxCollectorUpdatesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4576;
      }
      
      public function initStopListenTaxCollectorUpdatesMessage(taxCollectorId:Number = 0) : StopListenTaxCollectorUpdatesMessage
      {
         this.taxCollectorId = taxCollectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
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
         this.serializeAs_StopListenTaxCollectorUpdatesMessage(output);
      }
      
      public function serializeAs_StopListenTaxCollectorUpdatesMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StopListenTaxCollectorUpdatesMessage(input);
      }
      
      public function deserializeAs_StopListenTaxCollectorUpdatesMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StopListenTaxCollectorUpdatesMessage(tree);
      }
      
      public function deserializeAsyncAs_StopListenTaxCollectorUpdatesMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of StopListenTaxCollectorUpdatesMessage.taxCollectorId.");
         }
      }
   }
}

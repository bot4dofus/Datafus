package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5744;
       
      
      private var _isInitialized:Boolean = false;
      
      public var uniqueId:Number = 0;
      
      public var state:uint = 0;
      
      public function TaxCollectorStateUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5744;
      }
      
      public function initTaxCollectorStateUpdateMessage(uniqueId:Number = 0, state:uint = 0) : TaxCollectorStateUpdateMessage
      {
         this.uniqueId = uniqueId;
         this.state = state;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.uniqueId = 0;
         this.state = 0;
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
         this.serializeAs_TaxCollectorStateUpdateMessage(output);
      }
      
      public function serializeAs_TaxCollectorStateUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element uniqueId.");
         }
         output.writeDouble(this.uniqueId);
         output.writeByte(this.state);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorStateUpdateMessage(input);
      }
      
      public function deserializeAs_TaxCollectorStateUpdateMessage(input:ICustomDataInput) : void
      {
         this._uniqueIdFunc(input);
         this._stateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorStateUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorStateUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._uniqueIdFunc);
         tree.addChild(this._stateFunc);
      }
      
      private function _uniqueIdFunc(input:ICustomDataInput) : void
      {
         this.uniqueId = input.readDouble();
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element of TaxCollectorStateUpdateMessage.uniqueId.");
         }
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of TaxCollectorStateUpdateMessage.state.");
         }
      }
   }
}

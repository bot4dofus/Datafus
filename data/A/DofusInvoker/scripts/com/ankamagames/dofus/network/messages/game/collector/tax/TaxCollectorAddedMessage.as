package com.ankamagames.dofus.network.messages.game.collector.tax
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4517;
       
      
      private var _isInitialized:Boolean = false;
      
      public var callerId:Number = 0;
      
      public var description:TaxCollectorInformations;
      
      private var _descriptiontree:FuncTree;
      
      public function TaxCollectorAddedMessage()
      {
         this.description = new TaxCollectorInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4517;
      }
      
      public function initTaxCollectorAddedMessage(callerId:Number = 0, description:TaxCollectorInformations = null) : TaxCollectorAddedMessage
      {
         this.callerId = callerId;
         this.description = description;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.callerId = 0;
         this.description = new TaxCollectorInformations();
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
         this.serializeAs_TaxCollectorAddedMessage(output);
      }
      
      public function serializeAs_TaxCollectorAddedMessage(output:ICustomDataOutput) : void
      {
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element callerId.");
         }
         output.writeVarLong(this.callerId);
         output.writeShort(this.description.getTypeId());
         this.description.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorAddedMessage(input);
      }
      
      public function deserializeAs_TaxCollectorAddedMessage(input:ICustomDataInput) : void
      {
         this._callerIdFunc(input);
         var _id2:uint = input.readUnsignedShort();
         this.description = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id2);
         this.description.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorAddedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._callerIdFunc);
         this._descriptiontree = tree.addChild(this._descriptiontreeFunc);
      }
      
      private function _callerIdFunc(input:ICustomDataInput) : void
      {
         this.callerId = input.readVarUhLong();
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element of TaxCollectorAddedMessage.callerId.");
         }
      }
      
      private function _descriptiontreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.description = ProtocolTypeManager.getInstance(TaxCollectorInformations,_id);
         this.description.deserializeAsync(this._descriptiontree);
      }
   }
}

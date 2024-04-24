package com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AnomalyStateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7435;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var open:Boolean = false;
      
      public var closingTime:Number = 0;
      
      public function AnomalyStateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7435;
      }
      
      public function initAnomalyStateMessage(subAreaId:uint = 0, open:Boolean = false, closingTime:Number = 0) : AnomalyStateMessage
      {
         this.subAreaId = subAreaId;
         this.open = open;
         this.closingTime = closingTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.open = false;
         this.closingTime = 0;
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
         this.serializeAs_AnomalyStateMessage(output);
      }
      
      public function serializeAs_AnomalyStateMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeBoolean(this.open);
         if(this.closingTime < 0 || this.closingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.closingTime + ") on element closingTime.");
         }
         output.writeVarLong(this.closingTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AnomalyStateMessage(input);
      }
      
      public function deserializeAs_AnomalyStateMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._openFunc(input);
         this._closingTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AnomalyStateMessage(tree);
      }
      
      public function deserializeAsyncAs_AnomalyStateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._openFunc);
         tree.addChild(this._closingTimeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of AnomalyStateMessage.subAreaId.");
         }
      }
      
      private function _openFunc(input:ICustomDataInput) : void
      {
         this.open = input.readBoolean();
      }
      
      private function _closingTimeFunc(input:ICustomDataInput) : void
      {
         this.closingTime = input.readVarUhLong();
         if(this.closingTime < 0 || this.closingTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.closingTime + ") on element of AnomalyStateMessage.closingTime.");
         }
      }
   }
}

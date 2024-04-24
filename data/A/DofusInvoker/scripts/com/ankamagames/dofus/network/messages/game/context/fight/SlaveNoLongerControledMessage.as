package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SlaveNoLongerControledMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6754;
       
      
      private var _isInitialized:Boolean = false;
      
      public var masterId:Number = 0;
      
      public var slaveId:Number = 0;
      
      public function SlaveNoLongerControledMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6754;
      }
      
      public function initSlaveNoLongerControledMessage(masterId:Number = 0, slaveId:Number = 0) : SlaveNoLongerControledMessage
      {
         this.masterId = masterId;
         this.slaveId = slaveId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.masterId = 0;
         this.slaveId = 0;
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
         this.serializeAs_SlaveNoLongerControledMessage(output);
      }
      
      public function serializeAs_SlaveNoLongerControledMessage(output:ICustomDataOutput) : void
      {
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element masterId.");
         }
         output.writeDouble(this.masterId);
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element slaveId.");
         }
         output.writeDouble(this.slaveId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SlaveNoLongerControledMessage(input);
      }
      
      public function deserializeAs_SlaveNoLongerControledMessage(input:ICustomDataInput) : void
      {
         this._masterIdFunc(input);
         this._slaveIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SlaveNoLongerControledMessage(tree);
      }
      
      public function deserializeAsyncAs_SlaveNoLongerControledMessage(tree:FuncTree) : void
      {
         tree.addChild(this._masterIdFunc);
         tree.addChild(this._slaveIdFunc);
      }
      
      private function _masterIdFunc(input:ICustomDataInput) : void
      {
         this.masterId = input.readDouble();
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element of SlaveNoLongerControledMessage.masterId.");
         }
      }
      
      private function _slaveIdFunc(input:ICustomDataInput) : void
      {
         this.slaveId = input.readDouble();
         if(this.slaveId < -9007199254740992 || this.slaveId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.slaveId + ") on element of SlaveNoLongerControledMessage.slaveId.");
         }
      }
   }
}

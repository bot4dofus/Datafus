package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LockableStateUpdateHouseDoorMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7692;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public function LockableStateUpdateHouseDoorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7692;
      }
      
      public function initLockableStateUpdateHouseDoorMessage(locked:Boolean = false, houseId:uint = 0, instanceId:uint = 0, secondHand:Boolean = false) : LockableStateUpdateHouseDoorMessage
      {
         super.initLockableStateUpdateAbstractMessage(locked);
         this.houseId = houseId;
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.houseId = 0;
         this.instanceId = 0;
         this.secondHand = false;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_LockableStateUpdateHouseDoorMessage(output);
      }
      
      public function serializeAs_LockableStateUpdateHouseDoorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_LockableStateUpdateAbstractMessage(output);
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.secondHand);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LockableStateUpdateHouseDoorMessage(input);
      }
      
      public function deserializeAs_LockableStateUpdateHouseDoorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._houseIdFunc(input);
         this._instanceIdFunc(input);
         this._secondHandFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LockableStateUpdateHouseDoorMessage(tree);
      }
      
      public function deserializeAsyncAs_LockableStateUpdateHouseDoorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._houseIdFunc);
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._secondHandFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of LockableStateUpdateHouseDoorMessage.houseId.");
         }
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of LockableStateUpdateHouseDoorMessage.instanceId.");
         }
      }
      
      private function _secondHandFunc(input:ICustomDataInput) : void
      {
         this.secondHand = input.readBoolean();
      }
   }
}

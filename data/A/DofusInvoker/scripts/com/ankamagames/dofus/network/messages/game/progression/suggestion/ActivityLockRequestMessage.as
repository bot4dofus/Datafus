package com.ankamagames.dofus.network.messages.game.progression.suggestion
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ActivityLockRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2188;
       
      
      private var _isInitialized:Boolean = false;
      
      public var activityId:uint = 0;
      
      public var lock:Boolean = false;
      
      public function ActivityLockRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2188;
      }
      
      public function initActivityLockRequestMessage(activityId:uint = 0, lock:Boolean = false) : ActivityLockRequestMessage
      {
         this.activityId = activityId;
         this.lock = lock;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.activityId = 0;
         this.lock = false;
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
         this.serializeAs_ActivityLockRequestMessage(output);
      }
      
      public function serializeAs_ActivityLockRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.activityId < 0)
         {
            throw new Error("Forbidden value (" + this.activityId + ") on element activityId.");
         }
         output.writeVarShort(this.activityId);
         output.writeBoolean(this.lock);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ActivityLockRequestMessage(input);
      }
      
      public function deserializeAs_ActivityLockRequestMessage(input:ICustomDataInput) : void
      {
         this._activityIdFunc(input);
         this._lockFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ActivityLockRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ActivityLockRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._activityIdFunc);
         tree.addChild(this._lockFunc);
      }
      
      private function _activityIdFunc(input:ICustomDataInput) : void
      {
         this.activityId = input.readVarUhShort();
         if(this.activityId < 0)
         {
            throw new Error("Forbidden value (" + this.activityId + ") on element of ActivityLockRequestMessage.activityId.");
         }
      }
      
      private function _lockFunc(input:ICustomDataInput) : void
      {
         this.lock = input.readBoolean();
      }
   }
}

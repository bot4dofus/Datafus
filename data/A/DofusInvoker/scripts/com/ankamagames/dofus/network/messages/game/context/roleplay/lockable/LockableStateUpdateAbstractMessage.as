package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LockableStateUpdateAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4059;
       
      
      private var _isInitialized:Boolean = false;
      
      public var locked:Boolean = false;
      
      public function LockableStateUpdateAbstractMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4059;
      }
      
      public function initLockableStateUpdateAbstractMessage(locked:Boolean = false) : LockableStateUpdateAbstractMessage
      {
         this.locked = locked;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.locked = false;
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
         this.serializeAs_LockableStateUpdateAbstractMessage(output);
      }
      
      public function serializeAs_LockableStateUpdateAbstractMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.locked);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LockableStateUpdateAbstractMessage(input);
      }
      
      public function deserializeAs_LockableStateUpdateAbstractMessage(input:ICustomDataInput) : void
      {
         this._lockedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LockableStateUpdateAbstractMessage(tree);
      }
      
      public function deserializeAsyncAs_LockableStateUpdateAbstractMessage(tree:FuncTree) : void
      {
         tree.addChild(this._lockedFunc);
      }
      
      private function _lockedFunc(input:ICustomDataInput) : void
      {
         this.locked = input.readBoolean();
      }
   }
}

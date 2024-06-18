package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class LockableStateUpdateStorageMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 569;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var elementId:uint = 0;
      
      public function LockableStateUpdateStorageMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 569;
      }
      
      public function initLockableStateUpdateStorageMessage(locked:Boolean = false, mapId:Number = 0, elementId:uint = 0) : LockableStateUpdateStorageMessage
      {
         super.initLockableStateUpdateAbstractMessage(locked);
         this.mapId = mapId;
         this.elementId = elementId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mapId = 0;
         this.elementId = 0;
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
         this.serializeAs_LockableStateUpdateStorageMessage(output);
      }
      
      public function serializeAs_LockableStateUpdateStorageMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_LockableStateUpdateAbstractMessage(output);
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
         }
         output.writeVarInt(this.elementId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LockableStateUpdateStorageMessage(input);
      }
      
      public function deserializeAs_LockableStateUpdateStorageMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._mapIdFunc(input);
         this._elementIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LockableStateUpdateStorageMessage(tree);
      }
      
      public function deserializeAsyncAs_LockableStateUpdateStorageMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._elementIdFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of LockableStateUpdateStorageMessage.mapId.");
         }
      }
      
      private function _elementIdFunc(input:ICustomDataInput) : void
      {
         this.elementId = input.readVarUhInt();
         if(this.elementId < 0)
         {
            throw new Error("Forbidden value (" + this.elementId + ") on element of LockableStateUpdateStorageMessage.elementId.");
         }
      }
   }
}

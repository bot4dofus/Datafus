package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InteractiveUsedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3900;
       
      
      private var _isInitialized:Boolean = false;
      
      public var entityId:Number = 0;
      
      public var elemId:uint = 0;
      
      public var skillId:uint = 0;
      
      public var duration:uint = 0;
      
      public var canMove:Boolean = false;
      
      public function InteractiveUsedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3900;
      }
      
      public function initInteractiveUsedMessage(entityId:Number = 0, elemId:uint = 0, skillId:uint = 0, duration:uint = 0, canMove:Boolean = false) : InteractiveUsedMessage
      {
         this.entityId = entityId;
         this.elemId = elemId;
         this.skillId = skillId;
         this.duration = duration;
         this.canMove = canMove;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.entityId = 0;
         this.elemId = 0;
         this.skillId = 0;
         this.duration = 0;
         this.canMove = false;
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
         this.serializeAs_InteractiveUsedMessage(output);
      }
      
      public function serializeAs_InteractiveUsedMessage(output:ICustomDataOutput) : void
      {
         if(this.entityId < 0 || this.entityId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element entityId.");
         }
         output.writeVarLong(this.entityId);
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         output.writeVarInt(this.elemId);
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarShort(this.skillId);
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element duration.");
         }
         output.writeVarShort(this.duration);
         output.writeBoolean(this.canMove);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUsedMessage(input);
      }
      
      public function deserializeAs_InteractiveUsedMessage(input:ICustomDataInput) : void
      {
         this._entityIdFunc(input);
         this._elemIdFunc(input);
         this._skillIdFunc(input);
         this._durationFunc(input);
         this._canMoveFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveUsedMessage(tree);
      }
      
      public function deserializeAsyncAs_InteractiveUsedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._entityIdFunc);
         tree.addChild(this._elemIdFunc);
         tree.addChild(this._skillIdFunc);
         tree.addChild(this._durationFunc);
         tree.addChild(this._canMoveFunc);
      }
      
      private function _entityIdFunc(input:ICustomDataInput) : void
      {
         this.entityId = input.readVarUhLong();
         if(this.entityId < 0 || this.entityId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.entityId + ") on element of InteractiveUsedMessage.entityId.");
         }
      }
      
      private function _elemIdFunc(input:ICustomDataInput) : void
      {
         this.elemId = input.readVarUhInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUsedMessage.elemId.");
         }
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhShort();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUsedMessage.skillId.");
         }
      }
      
      private function _durationFunc(input:ICustomDataInput) : void
      {
         this.duration = input.readVarUhShort();
         if(this.duration < 0)
         {
            throw new Error("Forbidden value (" + this.duration + ") on element of InteractiveUsedMessage.duration.");
         }
      }
      
      private function _canMoveFunc(input:ICustomDataInput) : void
      {
         this.canMove = input.readBoolean();
      }
   }
}

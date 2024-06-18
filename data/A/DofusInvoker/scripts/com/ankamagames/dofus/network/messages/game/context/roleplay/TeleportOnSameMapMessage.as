package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TeleportOnSameMapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6669;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var cellId:uint = 0;
      
      public function TeleportOnSameMapMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6669;
      }
      
      public function initTeleportOnSameMapMessage(targetId:Number = 0, cellId:uint = 0) : TeleportOnSameMapMessage
      {
         this.targetId = targetId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
         this.cellId = 0;
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
         this.serializeAs_TeleportOnSameMapMessage(output);
      }
      
      public function serializeAs_TeleportOnSameMapMessage(output:ICustomDataOutput) : void
      {
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         output.writeVarShort(this.cellId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TeleportOnSameMapMessage(input);
      }
      
      public function deserializeAs_TeleportOnSameMapMessage(input:ICustomDataInput) : void
      {
         this._targetIdFunc(input);
         this._cellIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TeleportOnSameMapMessage(tree);
      }
      
      public function deserializeAsyncAs_TeleportOnSameMapMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._cellIdFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of TeleportOnSameMapMessage.targetId.");
         }
      }
      
      private function _cellIdFunc(input:ICustomDataInput) : void
      {
         this.cellId = input.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of TeleportOnSameMapMessage.cellId.");
         }
      }
   }
}

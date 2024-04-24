package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayPlayerFightRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8488;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var targetCellId:int = 0;
      
      public var friendly:Boolean = false;
      
      public function GameRolePlayPlayerFightRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8488;
      }
      
      public function initGameRolePlayPlayerFightRequestMessage(targetId:Number = 0, targetCellId:int = 0, friendly:Boolean = false) : GameRolePlayPlayerFightRequestMessage
      {
         this.targetId = targetId;
         this.targetCellId = targetCellId;
         this.friendly = friendly;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
         this.targetCellId = 0;
         this.friendly = false;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_GameRolePlayPlayerFightRequestMessage(output);
      }
      
      public function serializeAs_GameRolePlayPlayerFightRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeVarLong(this.targetId);
         if(this.targetCellId < -1 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
         }
         output.writeShort(this.targetCellId);
         output.writeBoolean(this.friendly);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayPlayerFightRequestMessage(input);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightRequestMessage(input:ICustomDataInput) : void
      {
         this._targetIdFunc(input);
         this._targetCellIdFunc(input);
         this._friendlyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayPlayerFightRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayPlayerFightRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
         tree.addChild(this._targetCellIdFunc);
         tree.addChild(this._friendlyFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readVarUhLong();
         if(this.targetId < 0 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightRequestMessage.targetId.");
         }
      }
      
      private function _targetCellIdFunc(input:ICustomDataInput) : void
      {
         this.targetCellId = input.readShort();
         if(this.targetCellId < -1 || this.targetCellId > 559)
         {
            throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameRolePlayPlayerFightRequestMessage.targetCellId.");
         }
      }
      
      private function _friendlyFunc(input:ICustomDataInput) : void
      {
         this.friendly = input.readBoolean();
      }
   }
}

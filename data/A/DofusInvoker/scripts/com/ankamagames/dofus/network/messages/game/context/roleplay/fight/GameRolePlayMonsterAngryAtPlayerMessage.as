package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayMonsterAngryAtPlayerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6385;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public var monsterGroupId:Number = 0;
      
      public var angryStartTime:Number = 0;
      
      public var attackTime:Number = 0;
      
      public function GameRolePlayMonsterAngryAtPlayerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6385;
      }
      
      public function initGameRolePlayMonsterAngryAtPlayerMessage(playerId:Number = 0, monsterGroupId:Number = 0, angryStartTime:Number = 0, attackTime:Number = 0) : GameRolePlayMonsterAngryAtPlayerMessage
      {
         this.playerId = playerId;
         this.monsterGroupId = monsterGroupId;
         this.angryStartTime = angryStartTime;
         this.attackTime = attackTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerId = 0;
         this.monsterGroupId = 0;
         this.angryStartTime = 0;
         this.attackTime = 0;
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
         this.serializeAs_GameRolePlayMonsterAngryAtPlayerMessage(output);
      }
      
      public function serializeAs_GameRolePlayMonsterAngryAtPlayerMessage(output:ICustomDataOutput) : void
      {
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         if(this.monsterGroupId < -9007199254740992 || this.monsterGroupId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.monsterGroupId + ") on element monsterGroupId.");
         }
         output.writeDouble(this.monsterGroupId);
         if(this.angryStartTime < 0 || this.angryStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.angryStartTime + ") on element angryStartTime.");
         }
         output.writeDouble(this.angryStartTime);
         if(this.attackTime < 0 || this.attackTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackTime + ") on element attackTime.");
         }
         output.writeDouble(this.attackTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMonsterAngryAtPlayerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayMonsterAngryAtPlayerMessage(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._monsterGroupIdFunc(input);
         this._angryStartTimeFunc(input);
         this._attackTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayMonsterAngryAtPlayerMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayMonsterAngryAtPlayerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._monsterGroupIdFunc);
         tree.addChild(this._angryStartTimeFunc);
         tree.addChild(this._attackTimeFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GameRolePlayMonsterAngryAtPlayerMessage.playerId.");
         }
      }
      
      private function _monsterGroupIdFunc(input:ICustomDataInput) : void
      {
         this.monsterGroupId = input.readDouble();
         if(this.monsterGroupId < -9007199254740992 || this.monsterGroupId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.monsterGroupId + ") on element of GameRolePlayMonsterAngryAtPlayerMessage.monsterGroupId.");
         }
      }
      
      private function _angryStartTimeFunc(input:ICustomDataInput) : void
      {
         this.angryStartTime = input.readDouble();
         if(this.angryStartTime < 0 || this.angryStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.angryStartTime + ") on element of GameRolePlayMonsterAngryAtPlayerMessage.angryStartTime.");
         }
      }
      
      private function _attackTimeFunc(input:ICustomDataInput) : void
      {
         this.attackTime = input.readDouble();
         if(this.attackTime < 0 || this.attackTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.attackTime + ") on element of GameRolePlayMonsterAngryAtPlayerMessage.attackTime.");
         }
      }
   }
}

package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayMonsterNotAngryAtPlayerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8932;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerId:Number = 0;
      
      public var monsterGroupId:Number = 0;
      
      public function GameRolePlayMonsterNotAngryAtPlayerMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8932;
      }
      
      public function initGameRolePlayMonsterNotAngryAtPlayerMessage(playerId:Number = 0, monsterGroupId:Number = 0) : GameRolePlayMonsterNotAngryAtPlayerMessage
      {
         this.playerId = playerId;
         this.monsterGroupId = monsterGroupId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.playerId = 0;
         this.monsterGroupId = 0;
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
         this.serializeAs_GameRolePlayMonsterNotAngryAtPlayerMessage(output);
      }
      
      public function serializeAs_GameRolePlayMonsterNotAngryAtPlayerMessage(output:ICustomDataOutput) : void
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
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMonsterNotAngryAtPlayerMessage(input);
      }
      
      public function deserializeAs_GameRolePlayMonsterNotAngryAtPlayerMessage(input:ICustomDataInput) : void
      {
         this._playerIdFunc(input);
         this._monsterGroupIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayMonsterNotAngryAtPlayerMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayMonsterNotAngryAtPlayerMessage(tree:FuncTree) : void
      {
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._monsterGroupIdFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of GameRolePlayMonsterNotAngryAtPlayerMessage.playerId.");
         }
      }
      
      private function _monsterGroupIdFunc(input:ICustomDataInput) : void
      {
         this.monsterGroupId = input.readDouble();
         if(this.monsterGroupId < -9007199254740992 || this.monsterGroupId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.monsterGroupId + ") on element of GameRolePlayMonsterNotAngryAtPlayerMessage.monsterGroupId.");
         }
      }
   }
}

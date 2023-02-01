package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage extends GameRolePlayArenaUpdatePlayerInfosMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6951;
       
      
      private var _isInitialized:Boolean = false;
      
      public var team:ArenaRankInfos;
      
      public var duel:ArenaRankInfos;
      
      private var _teamtree:FuncTree;
      
      private var _dueltree:FuncTree;
      
      public function GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage()
      {
         this.team = new ArenaRankInfos();
         this.duel = new ArenaRankInfos();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6951;
      }
      
      public function initGameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(solo:ArenaRankInfos = null, team:ArenaRankInfos = null, duel:ArenaRankInfos = null) : GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage
      {
         super.initGameRolePlayArenaUpdatePlayerInfosMessage(solo);
         this.team = team;
         this.duel = duel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.team = new ArenaRankInfos();
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
         this.serializeAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output);
         this.team.serializeAs_ArenaRankInfos(output);
         this.duel.serializeAs_ArenaRankInfos(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.team = new ArenaRankInfos();
         this.team.deserialize(input);
         this.duel = new ArenaRankInfos();
         this.duel.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosAllQueuesMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._teamtree = tree.addChild(this._teamtreeFunc);
         this._dueltree = tree.addChild(this._dueltreeFunc);
      }
      
      private function _teamtreeFunc(input:ICustomDataInput) : void
      {
         this.team = new ArenaRankInfos();
         this.team.deserializeAsync(this._teamtree);
      }
      
      private function _dueltreeFunc(input:ICustomDataInput) : void
      {
         this.duel = new ArenaRankInfos();
         this.duel.deserializeAsync(this._dueltree);
      }
   }
}

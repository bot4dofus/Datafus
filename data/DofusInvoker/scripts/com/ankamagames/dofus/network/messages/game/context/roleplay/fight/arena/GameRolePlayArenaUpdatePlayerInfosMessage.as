package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaUpdatePlayerInfosMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3184;
       
      
      private var _isInitialized:Boolean = false;
      
      public var solo:ArenaRankInfos;
      
      private var _solotree:FuncTree;
      
      public function GameRolePlayArenaUpdatePlayerInfosMessage()
      {
         this.solo = new ArenaRankInfos();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3184;
      }
      
      public function initGameRolePlayArenaUpdatePlayerInfosMessage(solo:ArenaRankInfos = null) : GameRolePlayArenaUpdatePlayerInfosMessage
      {
         this.solo = solo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.solo = new ArenaRankInfos();
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
         this.serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output:ICustomDataOutput) : void
      {
         this.solo.serializeAs_ArenaRankInfos(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input:ICustomDataInput) : void
      {
         this.solo = new ArenaRankInfos();
         this.solo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaUpdatePlayerInfosMessage(tree:FuncTree) : void
      {
         this._solotree = tree.addChild(this._solotreeFunc);
      }
      
      private function _solotreeFunc(input:ICustomDataInput) : void
      {
         this.solo = new ArenaRankInfos();
         this.solo.deserializeAsync(this._solotree);
      }
   }
}

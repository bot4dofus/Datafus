package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayArenaLeagueRewardsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7599;
       
      
      private var _isInitialized:Boolean = false;
      
      public var seasonId:uint = 0;
      
      public var leagueId:uint = 0;
      
      public var ladderPosition:int = 0;
      
      public var endSeasonReward:Boolean = false;
      
      public function GameRolePlayArenaLeagueRewardsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7599;
      }
      
      public function initGameRolePlayArenaLeagueRewardsMessage(seasonId:uint = 0, leagueId:uint = 0, ladderPosition:int = 0, endSeasonReward:Boolean = false) : GameRolePlayArenaLeagueRewardsMessage
      {
         this.seasonId = seasonId;
         this.leagueId = leagueId;
         this.ladderPosition = ladderPosition;
         this.endSeasonReward = endSeasonReward;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.seasonId = 0;
         this.leagueId = 0;
         this.ladderPosition = 0;
         this.endSeasonReward = false;
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
         this.serializeAs_GameRolePlayArenaLeagueRewardsMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaLeagueRewardsMessage(output:ICustomDataOutput) : void
      {
         if(this.seasonId < 0)
         {
            throw new Error("Forbidden value (" + this.seasonId + ") on element seasonId.");
         }
         output.writeVarShort(this.seasonId);
         if(this.leagueId < 0)
         {
            throw new Error("Forbidden value (" + this.leagueId + ") on element leagueId.");
         }
         output.writeVarShort(this.leagueId);
         output.writeInt(this.ladderPosition);
         output.writeBoolean(this.endSeasonReward);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayArenaLeagueRewardsMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaLeagueRewardsMessage(input:ICustomDataInput) : void
      {
         this._seasonIdFunc(input);
         this._leagueIdFunc(input);
         this._ladderPositionFunc(input);
         this._endSeasonRewardFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayArenaLeagueRewardsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayArenaLeagueRewardsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._seasonIdFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._ladderPositionFunc);
         tree.addChild(this._endSeasonRewardFunc);
      }
      
      private function _seasonIdFunc(input:ICustomDataInput) : void
      {
         this.seasonId = input.readVarUhShort();
         if(this.seasonId < 0)
         {
            throw new Error("Forbidden value (" + this.seasonId + ") on element of GameRolePlayArenaLeagueRewardsMessage.seasonId.");
         }
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarUhShort();
         if(this.leagueId < 0)
         {
            throw new Error("Forbidden value (" + this.leagueId + ") on element of GameRolePlayArenaLeagueRewardsMessage.leagueId.");
         }
      }
      
      private function _ladderPositionFunc(input:ICustomDataInput) : void
      {
         this.ladderPosition = input.readInt();
      }
      
      private function _endSeasonRewardFunc(input:ICustomDataInput) : void
      {
         this.endSeasonReward = input.readBoolean();
      }
   }
}

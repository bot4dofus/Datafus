package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FriendInformations extends AbstractContactInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6157;
       
      
      public var playerState:uint = 99;
      
      public var lastConnection:uint = 0;
      
      public var achievementPoints:int = 0;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public function FriendInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6157;
      }
      
      public function initFriendInformations(accountId:uint = 0, accountTag:AccountTagInformation = null, playerState:uint = 99, lastConnection:uint = 0, achievementPoints:int = 0, leagueId:int = 0, ladderPosition:int = 0) : FriendInformations
      {
         super.initAbstractContactInformations(accountId,accountTag);
         this.playerState = playerState;
         this.lastConnection = lastConnection;
         this.achievementPoints = achievementPoints;
         this.leagueId = leagueId;
         this.ladderPosition = ladderPosition;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerState = 99;
         this.lastConnection = 0;
         this.achievementPoints = 0;
         this.leagueId = 0;
         this.ladderPosition = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FriendInformations(output);
      }
      
      public function serializeAs_FriendInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractContactInformations(output);
         output.writeByte(this.playerState);
         if(this.lastConnection < 0)
         {
            throw new Error("Forbidden value (" + this.lastConnection + ") on element lastConnection.");
         }
         output.writeVarShort(this.lastConnection);
         output.writeInt(this.achievementPoints);
         output.writeVarShort(this.leagueId);
         output.writeInt(this.ladderPosition);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendInformations(input);
      }
      
      public function deserializeAs_FriendInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerStateFunc(input);
         this._lastConnectionFunc(input);
         this._achievementPointsFunc(input);
         this._leagueIdFunc(input);
         this._ladderPositionFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendInformations(tree);
      }
      
      public function deserializeAsyncAs_FriendInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerStateFunc);
         tree.addChild(this._lastConnectionFunc);
         tree.addChild(this._achievementPointsFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._ladderPositionFunc);
      }
      
      private function _playerStateFunc(input:ICustomDataInput) : void
      {
         this.playerState = input.readByte();
         if(this.playerState < 0)
         {
            throw new Error("Forbidden value (" + this.playerState + ") on element of FriendInformations.playerState.");
         }
      }
      
      private function _lastConnectionFunc(input:ICustomDataInput) : void
      {
         this.lastConnection = input.readVarUhShort();
         if(this.lastConnection < 0)
         {
            throw new Error("Forbidden value (" + this.lastConnection + ") on element of FriendInformations.lastConnection.");
         }
      }
      
      private function _achievementPointsFunc(input:ICustomDataInput) : void
      {
         this.achievementPoints = input.readInt();
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarShort();
      }
      
      private function _ladderPositionFunc(input:ICustomDataInput) : void
      {
         this.ladderPosition = input.readInt();
      }
   }
}

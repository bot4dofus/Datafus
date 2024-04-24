package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.game.friend.AbstractContactInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class LeagueFriendInformations extends AbstractContactInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6198;
       
      
      public var playerId:Number = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var level:uint = 0;
      
      public var leagueId:int = 0;
      
      public var totalLeaguePoints:int = 0;
      
      public var ladderPosition:int = 0;
      
      public function LeagueFriendInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6198;
      }
      
      public function initLeagueFriendInformations(accountId:uint = 0, accountTag:AccountTagInformation = null, playerId:Number = 0, playerName:String = "", breed:int = 0, sex:Boolean = false, level:uint = 0, leagueId:int = 0, totalLeaguePoints:int = 0, ladderPosition:int = 0) : LeagueFriendInformations
      {
         super.initAbstractContactInformations(accountId,accountTag);
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         this.level = level;
         this.leagueId = leagueId;
         this.totalLeaguePoints = totalLeaguePoints;
         this.ladderPosition = ladderPosition;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
         this.level = 0;
         this.leagueId = 0;
         this.totalLeaguePoints = 0;
         this.ladderPosition = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_LeagueFriendInformations(output);
      }
      
      public function serializeAs_LeagueFriendInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractContactInformations(output);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
         output.writeUTF(this.playerName);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         output.writeVarShort(this.leagueId);
         output.writeVarShort(this.totalLeaguePoints);
         output.writeInt(this.ladderPosition);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_LeagueFriendInformations(input);
      }
      
      public function deserializeAs_LeagueFriendInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerIdFunc(input);
         this._playerNameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._levelFunc(input);
         this._leagueIdFunc(input);
         this._totalLeaguePointsFunc(input);
         this._ladderPositionFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_LeagueFriendInformations(tree);
      }
      
      public function deserializeAsyncAs_LeagueFriendInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerIdFunc);
         tree.addChild(this._playerNameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._totalLeaguePointsFunc);
         tree.addChild(this._ladderPositionFunc);
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of LeagueFriendInformations.playerId.");
         }
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of LeagueFriendInformations.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of LeagueFriendInformations.level.");
         }
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarShort();
      }
      
      private function _totalLeaguePointsFunc(input:ICustomDataInput) : void
      {
         this.totalLeaguePoints = input.readVarShort();
      }
      
      private function _ladderPositionFunc(input:ICustomDataInput) : void
      {
         this.ladderPosition = input.readInt();
      }
   }
}

package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ArenaRankInfos implements INetworkType
   {
      
      public static const protocolId:uint = 9831;
       
      
      public var arenaType:uint = 3;
      
      public var leagueRanking:ArenaLeagueRanking;
      
      public var bestLeagueId:int = 0;
      
      public var bestRating:int = 0;
      
      public var dailyVictoryCount:uint = 0;
      
      public var seasonVictoryCount:uint = 0;
      
      public var dailyFightcount:uint = 0;
      
      public var seasonFightcount:uint = 0;
      
      public var numFightNeededForLadder:uint = 0;
      
      private var _leagueRankingtree:FuncTree;
      
      public function ArenaRankInfos()
      {
         this.leagueRanking = new ArenaLeagueRanking();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9831;
      }
      
      public function initArenaRankInfos(arenaType:uint = 3, leagueRanking:ArenaLeagueRanking = null, bestLeagueId:int = 0, bestRating:int = 0, dailyVictoryCount:uint = 0, seasonVictoryCount:uint = 0, dailyFightcount:uint = 0, seasonFightcount:uint = 0, numFightNeededForLadder:uint = 0) : ArenaRankInfos
      {
         this.arenaType = arenaType;
         this.leagueRanking = leagueRanking;
         this.bestLeagueId = bestLeagueId;
         this.bestRating = bestRating;
         this.dailyVictoryCount = dailyVictoryCount;
         this.seasonVictoryCount = seasonVictoryCount;
         this.dailyFightcount = dailyFightcount;
         this.seasonFightcount = seasonFightcount;
         this.numFightNeededForLadder = numFightNeededForLadder;
         return this;
      }
      
      public function reset() : void
      {
         this.arenaType = 3;
         this.leagueRanking = new ArenaLeagueRanking();
         this.bestRating = 0;
         this.dailyVictoryCount = 0;
         this.seasonVictoryCount = 0;
         this.dailyFightcount = 0;
         this.seasonFightcount = 0;
         this.numFightNeededForLadder = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ArenaRankInfos(output);
      }
      
      public function serializeAs_ArenaRankInfos(output:ICustomDataOutput) : void
      {
         output.writeInt(this.arenaType);
         if(this.leagueRanking == null)
         {
            output.writeByte(0);
         }
         else
         {
            output.writeByte(1);
            this.leagueRanking.serializeAs_ArenaLeagueRanking(output);
         }
         output.writeVarShort(this.bestLeagueId);
         if(this.bestRating < 0 || this.bestRating > 20000)
         {
            throw new Error("Forbidden value (" + this.bestRating + ") on element bestRating.");
         }
         output.writeInt(this.bestRating);
         if(this.dailyVictoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.dailyVictoryCount + ") on element dailyVictoryCount.");
         }
         output.writeVarShort(this.dailyVictoryCount);
         if(this.seasonVictoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.seasonVictoryCount + ") on element seasonVictoryCount.");
         }
         output.writeVarShort(this.seasonVictoryCount);
         if(this.dailyFightcount < 0)
         {
            throw new Error("Forbidden value (" + this.dailyFightcount + ") on element dailyFightcount.");
         }
         output.writeVarShort(this.dailyFightcount);
         if(this.seasonFightcount < 0)
         {
            throw new Error("Forbidden value (" + this.seasonFightcount + ") on element seasonFightcount.");
         }
         output.writeVarShort(this.seasonFightcount);
         if(this.numFightNeededForLadder < 0)
         {
            throw new Error("Forbidden value (" + this.numFightNeededForLadder + ") on element numFightNeededForLadder.");
         }
         output.writeShort(this.numFightNeededForLadder);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaRankInfos(input);
      }
      
      public function deserializeAs_ArenaRankInfos(input:ICustomDataInput) : void
      {
         this._arenaTypeFunc(input);
         if(input.readByte() == 0)
         {
            this.leagueRanking = null;
         }
         else
         {
            this.leagueRanking = new ArenaLeagueRanking();
            this.leagueRanking.deserialize(input);
         }
         this._bestLeagueIdFunc(input);
         this._bestRatingFunc(input);
         this._dailyVictoryCountFunc(input);
         this._seasonVictoryCountFunc(input);
         this._dailyFightcountFunc(input);
         this._seasonFightcountFunc(input);
         this._numFightNeededForLadderFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaRankInfos(tree);
      }
      
      public function deserializeAsyncAs_ArenaRankInfos(tree:FuncTree) : void
      {
         tree.addChild(this._arenaTypeFunc);
         this._leagueRankingtree = tree.addChild(this._leagueRankingtreeFunc);
         tree.addChild(this._bestLeagueIdFunc);
         tree.addChild(this._bestRatingFunc);
         tree.addChild(this._dailyVictoryCountFunc);
         tree.addChild(this._seasonVictoryCountFunc);
         tree.addChild(this._dailyFightcountFunc);
         tree.addChild(this._seasonFightcountFunc);
         tree.addChild(this._numFightNeededForLadderFunc);
      }
      
      private function _arenaTypeFunc(input:ICustomDataInput) : void
      {
         this.arenaType = input.readInt();
         if(this.arenaType < 0)
         {
            throw new Error("Forbidden value (" + this.arenaType + ") on element of ArenaRankInfos.arenaType.");
         }
      }
      
      private function _leagueRankingtreeFunc(input:ICustomDataInput) : void
      {
         this.leagueRanking = new ArenaLeagueRanking();
         this.leagueRanking.deserializeAsync(this._leagueRankingtree);
      }
      
      private function _bestLeagueIdFunc(input:ICustomDataInput) : void
      {
         this.bestLeagueId = input.readVarShort();
      }
      
      private function _bestRatingFunc(input:ICustomDataInput) : void
      {
         this.bestRating = input.readInt();
         if(this.bestRating < 0 || this.bestRating > 20000)
         {
            throw new Error("Forbidden value (" + this.bestRating + ") on element of ArenaRankInfos.bestRating.");
         }
      }
      
      private function _dailyVictoryCountFunc(input:ICustomDataInput) : void
      {
         this.dailyVictoryCount = input.readVarUhShort();
         if(this.dailyVictoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.dailyVictoryCount + ") on element of ArenaRankInfos.dailyVictoryCount.");
         }
      }
      
      private function _seasonVictoryCountFunc(input:ICustomDataInput) : void
      {
         this.seasonVictoryCount = input.readVarUhShort();
         if(this.seasonVictoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.seasonVictoryCount + ") on element of ArenaRankInfos.seasonVictoryCount.");
         }
      }
      
      private function _dailyFightcountFunc(input:ICustomDataInput) : void
      {
         this.dailyFightcount = input.readVarUhShort();
         if(this.dailyFightcount < 0)
         {
            throw new Error("Forbidden value (" + this.dailyFightcount + ") on element of ArenaRankInfos.dailyFightcount.");
         }
      }
      
      private function _seasonFightcountFunc(input:ICustomDataInput) : void
      {
         this.seasonFightcount = input.readVarUhShort();
         if(this.seasonFightcount < 0)
         {
            throw new Error("Forbidden value (" + this.seasonFightcount + ") on element of ArenaRankInfos.seasonFightcount.");
         }
      }
      
      private function _numFightNeededForLadderFunc(input:ICustomDataInput) : void
      {
         this.numFightNeededForLadder = input.readShort();
         if(this.numFightNeededForLadder < 0)
         {
            throw new Error("Forbidden value (" + this.numFightNeededForLadder + ") on element of ArenaRankInfos.numFightNeededForLadder.");
         }
      }
   }
}

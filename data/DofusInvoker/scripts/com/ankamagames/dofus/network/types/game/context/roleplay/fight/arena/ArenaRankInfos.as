package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ArenaRankInfos implements INetworkType
   {
      
      public static const protocolId:uint = 9362;
       
      
      public var ranking:ArenaRanking;
      
      public var leagueRanking:ArenaLeagueRanking;
      
      public var victoryCount:uint = 0;
      
      public var fightcount:uint = 0;
      
      public var numFightNeededForLadder:uint = 0;
      
      private var _rankingtree:FuncTree;
      
      private var _leagueRankingtree:FuncTree;
      
      public function ArenaRankInfos()
      {
         this.ranking = new ArenaRanking();
         this.leagueRanking = new ArenaLeagueRanking();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9362;
      }
      
      public function initArenaRankInfos(ranking:ArenaRanking = null, leagueRanking:ArenaLeagueRanking = null, victoryCount:uint = 0, fightcount:uint = 0, numFightNeededForLadder:uint = 0) : ArenaRankInfos
      {
         this.ranking = ranking;
         this.leagueRanking = leagueRanking;
         this.victoryCount = victoryCount;
         this.fightcount = fightcount;
         this.numFightNeededForLadder = numFightNeededForLadder;
         return this;
      }
      
      public function reset() : void
      {
         this.ranking = new ArenaRanking();
         this.fightcount = 0;
         this.numFightNeededForLadder = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ArenaRankInfos(output);
      }
      
      public function serializeAs_ArenaRankInfos(output:ICustomDataOutput) : void
      {
         if(this.ranking == null)
         {
            output.writeByte(0);
         }
         else
         {
            output.writeByte(1);
            this.ranking.serializeAs_ArenaRanking(output);
         }
         if(this.leagueRanking == null)
         {
            output.writeByte(0);
         }
         else
         {
            output.writeByte(1);
            this.leagueRanking.serializeAs_ArenaLeagueRanking(output);
         }
         if(this.victoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.victoryCount + ") on element victoryCount.");
         }
         output.writeVarShort(this.victoryCount);
         if(this.fightcount < 0)
         {
            throw new Error("Forbidden value (" + this.fightcount + ") on element fightcount.");
         }
         output.writeVarShort(this.fightcount);
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
         if(input.readByte() == 0)
         {
            this.ranking = null;
         }
         else
         {
            this.ranking = new ArenaRanking();
            this.ranking.deserialize(input);
         }
         if(input.readByte() == 0)
         {
            this.leagueRanking = null;
         }
         else
         {
            this.leagueRanking = new ArenaLeagueRanking();
            this.leagueRanking.deserialize(input);
         }
         this._victoryCountFunc(input);
         this._fightcountFunc(input);
         this._numFightNeededForLadderFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaRankInfos(tree);
      }
      
      public function deserializeAsyncAs_ArenaRankInfos(tree:FuncTree) : void
      {
         this._rankingtree = tree.addChild(this._rankingtreeFunc);
         this._leagueRankingtree = tree.addChild(this._leagueRankingtreeFunc);
         tree.addChild(this._victoryCountFunc);
         tree.addChild(this._fightcountFunc);
         tree.addChild(this._numFightNeededForLadderFunc);
      }
      
      private function _rankingtreeFunc(input:ICustomDataInput) : void
      {
         this.ranking = new ArenaRanking();
         this.ranking.deserializeAsync(this._rankingtree);
      }
      
      private function _leagueRankingtreeFunc(input:ICustomDataInput) : void
      {
         this.leagueRanking = new ArenaLeagueRanking();
         this.leagueRanking.deserializeAsync(this._leagueRankingtree);
      }
      
      private function _victoryCountFunc(input:ICustomDataInput) : void
      {
         this.victoryCount = input.readVarUhShort();
         if(this.victoryCount < 0)
         {
            throw new Error("Forbidden value (" + this.victoryCount + ") on element of ArenaRankInfos.victoryCount.");
         }
      }
      
      private function _fightcountFunc(input:ICustomDataInput) : void
      {
         this.fightcount = input.readVarUhShort();
         if(this.fightcount < 0)
         {
            throw new Error("Forbidden value (" + this.fightcount + ") on element of ArenaRankInfos.fightcount.");
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

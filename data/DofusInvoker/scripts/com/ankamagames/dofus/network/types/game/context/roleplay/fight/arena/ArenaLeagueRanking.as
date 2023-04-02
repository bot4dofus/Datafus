package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ArenaLeagueRanking implements INetworkType
   {
      
      public static const protocolId:uint = 139;
       
      
      public var rank:uint = 0;
      
      public var leagueId:uint = 0;
      
      public var leaguePoints:int = 0;
      
      public var totalLeaguePoints:int = 0;
      
      public var ladderPosition:int = 0;
      
      public function ArenaLeagueRanking()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 139;
      }
      
      public function initArenaLeagueRanking(rank:uint = 0, leagueId:uint = 0, leaguePoints:int = 0, totalLeaguePoints:int = 0, ladderPosition:int = 0) : ArenaLeagueRanking
      {
         this.rank = rank;
         this.leagueId = leagueId;
         this.leaguePoints = leaguePoints;
         this.totalLeaguePoints = totalLeaguePoints;
         this.ladderPosition = ladderPosition;
         return this;
      }
      
      public function reset() : void
      {
         this.rank = 0;
         this.leagueId = 0;
         this.leaguePoints = 0;
         this.totalLeaguePoints = 0;
         this.ladderPosition = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ArenaLeagueRanking(output);
      }
      
      public function serializeAs_ArenaLeagueRanking(output:ICustomDataOutput) : void
      {
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarShort(this.rank);
         if(this.leagueId < 0)
         {
            throw new Error("Forbidden value (" + this.leagueId + ") on element leagueId.");
         }
         output.writeVarShort(this.leagueId);
         output.writeVarShort(this.leaguePoints);
         output.writeVarShort(this.totalLeaguePoints);
         output.writeInt(this.ladderPosition);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaLeagueRanking(input);
      }
      
      public function deserializeAs_ArenaLeagueRanking(input:ICustomDataInput) : void
      {
         this._rankFunc(input);
         this._leagueIdFunc(input);
         this._leaguePointsFunc(input);
         this._totalLeaguePointsFunc(input);
         this._ladderPositionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaLeagueRanking(tree);
      }
      
      public function deserializeAsyncAs_ArenaLeagueRanking(tree:FuncTree) : void
      {
         tree.addChild(this._rankFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._leaguePointsFunc);
         tree.addChild(this._totalLeaguePointsFunc);
         tree.addChild(this._ladderPositionFunc);
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhShort();
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of ArenaLeagueRanking.rank.");
         }
      }
      
      private function _leagueIdFunc(input:ICustomDataInput) : void
      {
         this.leagueId = input.readVarUhShort();
         if(this.leagueId < 0)
         {
            throw new Error("Forbidden value (" + this.leagueId + ") on element of ArenaLeagueRanking.leagueId.");
         }
      }
      
      private function _leaguePointsFunc(input:ICustomDataInput) : void
      {
         this.leaguePoints = input.readVarShort();
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

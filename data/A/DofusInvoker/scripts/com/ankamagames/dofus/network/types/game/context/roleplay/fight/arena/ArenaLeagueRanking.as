package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ArenaLeagueRanking implements INetworkType
   {
      
      public static const protocolId:uint = 3295;
       
      
      public var rating:int = 0;
      
      public var leagueId:int = 0;
      
      public var ladderPosition:int = 0;
      
      public function ArenaLeagueRanking()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3295;
      }
      
      public function initArenaLeagueRanking(rating:int = 0, leagueId:int = 0, ladderPosition:int = 0) : ArenaLeagueRanking
      {
         this.rating = rating;
         this.leagueId = leagueId;
         this.ladderPosition = ladderPosition;
         return this;
      }
      
      public function reset() : void
      {
         this.rating = 0;
         this.leagueId = 0;
         this.ladderPosition = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ArenaLeagueRanking(output);
      }
      
      public function serializeAs_ArenaLeagueRanking(output:ICustomDataOutput) : void
      {
         if(this.rating < 0 || this.rating > 20000)
         {
            throw new Error("Forbidden value (" + this.rating + ") on element rating.");
         }
         output.writeInt(this.rating);
         output.writeVarShort(this.leagueId);
         output.writeInt(this.ladderPosition);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaLeagueRanking(input);
      }
      
      public function deserializeAs_ArenaLeagueRanking(input:ICustomDataInput) : void
      {
         this._ratingFunc(input);
         this._leagueIdFunc(input);
         this._ladderPositionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaLeagueRanking(tree);
      }
      
      public function deserializeAsyncAs_ArenaLeagueRanking(tree:FuncTree) : void
      {
         tree.addChild(this._ratingFunc);
         tree.addChild(this._leagueIdFunc);
         tree.addChild(this._ladderPositionFunc);
      }
      
      private function _ratingFunc(input:ICustomDataInput) : void
      {
         this.rating = input.readInt();
         if(this.rating < 0 || this.rating > 20000)
         {
            throw new Error("Forbidden value (" + this.rating + ") on element of ArenaLeagueRanking.rating.");
         }
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

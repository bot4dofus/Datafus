package com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ArenaRanking implements INetworkType
   {
      
      public static const protocolId:uint = 1089;
       
      
      public var rank:uint = 0;
      
      public var bestRank:uint = 0;
      
      public function ArenaRanking()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1089;
      }
      
      public function initArenaRanking(rank:uint = 0, bestRank:uint = 0) : ArenaRanking
      {
         this.rank = rank;
         this.bestRank = bestRank;
         return this;
      }
      
      public function reset() : void
      {
         this.rank = 0;
         this.bestRank = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ArenaRanking(output);
      }
      
      public function serializeAs_ArenaRanking(output:ICustomDataOutput) : void
      {
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarShort(this.rank);
         if(this.bestRank < 0 || this.bestRank > 20000)
         {
            throw new Error("Forbidden value (" + this.bestRank + ") on element bestRank.");
         }
         output.writeVarShort(this.bestRank);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ArenaRanking(input);
      }
      
      public function deserializeAs_ArenaRanking(input:ICustomDataInput) : void
      {
         this._rankFunc(input);
         this._bestRankFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ArenaRanking(tree);
      }
      
      public function deserializeAsyncAs_ArenaRanking(tree:FuncTree) : void
      {
         tree.addChild(this._rankFunc);
         tree.addChild(this._bestRankFunc);
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhShort();
         if(this.rank < 0 || this.rank > 20000)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of ArenaRanking.rank.");
         }
      }
      
      private function _bestRankFunc(input:ICustomDataInput) : void
      {
         this.bestRank = input.readVarUhShort();
         if(this.bestRank < 0 || this.bestRank > 20000)
         {
            throw new Error("Forbidden value (" + this.bestRank + ") on element of ArenaRanking.bestRank.");
         }
      }
   }
}

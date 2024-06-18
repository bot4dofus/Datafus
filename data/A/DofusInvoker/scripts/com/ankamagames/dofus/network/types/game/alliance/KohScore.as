package com.ankamagames.dofus.network.types.game.alliance
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class KohScore implements INetworkType
   {
      
      public static const protocolId:uint = 5560;
       
      
      public var avaScoreTypeEnum:uint = 1;
      
      public var roundScores:int = 0;
      
      public var cumulScores:int = 0;
      
      public function KohScore()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 5560;
      }
      
      public function initKohScore(avaScoreTypeEnum:uint = 1, roundScores:int = 0, cumulScores:int = 0) : KohScore
      {
         this.avaScoreTypeEnum = avaScoreTypeEnum;
         this.roundScores = roundScores;
         this.cumulScores = cumulScores;
         return this;
      }
      
      public function reset() : void
      {
         this.avaScoreTypeEnum = 1;
         this.roundScores = 0;
         this.cumulScores = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_KohScore(output);
      }
      
      public function serializeAs_KohScore(output:ICustomDataOutput) : void
      {
         output.writeByte(this.avaScoreTypeEnum);
         output.writeInt(this.roundScores);
         output.writeInt(this.cumulScores);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KohScore(input);
      }
      
      public function deserializeAs_KohScore(input:ICustomDataInput) : void
      {
         this._avaScoreTypeEnumFunc(input);
         this._roundScoresFunc(input);
         this._cumulScoresFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KohScore(tree);
      }
      
      public function deserializeAsyncAs_KohScore(tree:FuncTree) : void
      {
         tree.addChild(this._avaScoreTypeEnumFunc);
         tree.addChild(this._roundScoresFunc);
         tree.addChild(this._cumulScoresFunc);
      }
      
      private function _avaScoreTypeEnumFunc(input:ICustomDataInput) : void
      {
         this.avaScoreTypeEnum = input.readByte();
         if(this.avaScoreTypeEnum < 0)
         {
            throw new Error("Forbidden value (" + this.avaScoreTypeEnum + ") on element of KohScore.avaScoreTypeEnum.");
         }
      }
      
      private function _roundScoresFunc(input:ICustomDataInput) : void
      {
         this.roundScores = input.readInt();
      }
      
      private function _cumulScoresFunc(input:ICustomDataInput) : void
      {
         this.cumulScores = input.readInt();
      }
   }
}

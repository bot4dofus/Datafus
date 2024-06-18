package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightMutantInformations extends GameFightFighterNamedInformations implements INetworkType
   {
      
      public static const protocolId:uint = 419;
       
      
      public var powerLevel:uint = 0;
      
      public function GameFightMutantInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 419;
      }
      
      public function initGameFightMutantInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, name:String = "", status:PlayerStatus = null, leagueId:int = 0, ladderPosition:int = 0, hiddenInPrefight:Boolean = false, powerLevel:uint = 0) : GameFightMutantInformations
      {
         super.initGameFightFighterNamedInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions,name,status,leagueId,ladderPosition,hiddenInPrefight);
         this.powerLevel = powerLevel;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.powerLevel = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightMutantInformations(output);
      }
      
      public function serializeAs_GameFightMutantInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterNamedInformations(output);
         if(this.powerLevel < 0)
         {
            throw new Error("Forbidden value (" + this.powerLevel + ") on element powerLevel.");
         }
         output.writeByte(this.powerLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightMutantInformations(input);
      }
      
      public function deserializeAs_GameFightMutantInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._powerLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightMutantInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightMutantInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._powerLevelFunc);
      }
      
      private function _powerLevelFunc(input:ICustomDataInput) : void
      {
         this.powerLevel = input.readByte();
         if(this.powerLevel < 0)
         {
            throw new Error("Forbidden value (" + this.powerLevel + ") on element of GameFightMutantInformations.powerLevel.");
         }
      }
   }
}

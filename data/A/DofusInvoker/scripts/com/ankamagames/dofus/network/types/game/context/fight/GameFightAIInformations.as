package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightAIInformations extends GameFightFighterInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8061;
       
      
      public function GameFightAIInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8061;
      }
      
      public function initGameFightAIInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null) : GameFightAIInformations
      {
         super.initGameFightFighterInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightAIInformations(output);
      }
      
      public function serializeAs_GameFightAIInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightAIInformations(input);
      }
      
      public function deserializeAs_GameFightAIInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightAIInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightAIInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}

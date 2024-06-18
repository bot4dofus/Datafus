package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightTaxCollectorInformations extends GameFightAIInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7175;
       
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public function GameFightTaxCollectorInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7175;
      }
      
      public function initGameFightTaxCollectorInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, firstNameId:uint = 0, lastNameId:uint = 0) : GameFightTaxCollectorInformations
      {
         super.initGameFightAIInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions);
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightTaxCollectorInformations(output);
      }
      
      public function serializeAs_GameFightTaxCollectorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightAIInformations(output);
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         output.writeVarShort(this.firstNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightTaxCollectorInformations(input);
      }
      
      public function deserializeAs_GameFightTaxCollectorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightTaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_GameFightTaxCollectorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of GameFightTaxCollectorInformations.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of GameFightTaxCollectorInformations.lastNameId.");
         }
      }
   }
}

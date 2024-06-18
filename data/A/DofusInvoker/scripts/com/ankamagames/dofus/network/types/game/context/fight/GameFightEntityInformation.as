package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameFightEntityInformation extends GameFightFighterInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4556;
       
      
      public var entityModelId:uint = 0;
      
      public var level:uint = 0;
      
      public var masterId:Number = 0;
      
      public function GameFightEntityInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4556;
      }
      
      public function initGameFightEntityInformation(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, spawnInfo:GameContextBasicSpawnInformation = null, wave:uint = 0, stats:GameFightCharacteristics = null, previousPositions:Vector.<uint> = null, entityModelId:uint = 0, level:uint = 0, masterId:Number = 0) : GameFightEntityInformation
      {
         super.initGameFightFighterInformations(contextualId,disposition,look,spawnInfo,wave,stats,previousPositions);
         this.entityModelId = entityModelId;
         this.level = level;
         this.masterId = masterId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.entityModelId = 0;
         this.level = 0;
         this.masterId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameFightEntityInformation(output);
      }
      
      public function serializeAs_GameFightEntityInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightFighterInformations(output);
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element entityModelId.");
         }
         output.writeByte(this.entityModelId);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element masterId.");
         }
         output.writeDouble(this.masterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightEntityInformation(input);
      }
      
      public function deserializeAs_GameFightEntityInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._entityModelIdFunc(input);
         this._levelFunc(input);
         this._masterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightEntityInformation(tree);
      }
      
      public function deserializeAsyncAs_GameFightEntityInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._entityModelIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._masterIdFunc);
      }
      
      private function _entityModelIdFunc(input:ICustomDataInput) : void
      {
         this.entityModelId = input.readByte();
         if(this.entityModelId < 0)
         {
            throw new Error("Forbidden value (" + this.entityModelId + ") on element of GameFightEntityInformation.entityModelId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameFightEntityInformation.level.");
         }
      }
      
      private function _masterIdFunc(input:ICustomDataInput) : void
      {
         this.masterId = input.readDouble();
         if(this.masterId < -9007199254740992 || this.masterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.masterId + ") on element of GameFightEntityInformation.masterId.");
         }
      }
   }
}

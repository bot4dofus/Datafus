package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SpawnCompanionInformation extends SpawnInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5676;
       
      
      public var modelId:uint = 0;
      
      public var level:uint = 0;
      
      public var summonerId:Number = 0;
      
      public var ownerId:Number = 0;
      
      public function SpawnCompanionInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5676;
      }
      
      public function initSpawnCompanionInformation(modelId:uint = 0, level:uint = 0, summonerId:Number = 0, ownerId:Number = 0) : SpawnCompanionInformation
      {
         this.modelId = modelId;
         this.level = level;
         this.summonerId = summonerId;
         this.ownerId = ownerId;
         return this;
      }
      
      override public function reset() : void
      {
         this.modelId = 0;
         this.level = 0;
         this.summonerId = 0;
         this.ownerId = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SpawnCompanionInformation(output);
      }
      
      public function serializeAs_SpawnCompanionInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_SpawnInformation(output);
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         output.writeByte(this.modelId);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeVarShort(this.level);
         if(this.summonerId < -9007199254740992 || this.summonerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.summonerId + ") on element summonerId.");
         }
         output.writeDouble(this.summonerId);
         if(this.ownerId < -9007199254740992 || this.ownerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
         }
         output.writeDouble(this.ownerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpawnCompanionInformation(input);
      }
      
      public function deserializeAs_SpawnCompanionInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._modelIdFunc(input);
         this._levelFunc(input);
         this._summonerIdFunc(input);
         this._ownerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpawnCompanionInformation(tree);
      }
      
      public function deserializeAsyncAs_SpawnCompanionInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._modelIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._summonerIdFunc);
         tree.addChild(this._ownerIdFunc);
      }
      
      private function _modelIdFunc(input:ICustomDataInput) : void
      {
         this.modelId = input.readByte();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of SpawnCompanionInformation.modelId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readVarUhShort();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of SpawnCompanionInformation.level.");
         }
      }
      
      private function _summonerIdFunc(input:ICustomDataInput) : void
      {
         this.summonerId = input.readDouble();
         if(this.summonerId < -9007199254740992 || this.summonerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.summonerId + ") on element of SpawnCompanionInformation.summonerId.");
         }
      }
      
      private function _ownerIdFunc(input:ICustomDataInput) : void
      {
         this.ownerId = input.readDouble();
         if(this.ownerId < -9007199254740992 || this.ownerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element of SpawnCompanionInformation.ownerId.");
         }
      }
   }
}

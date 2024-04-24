package com.ankamagames.dofus.network.types.game.context.roleplay.party.entity
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PartyEntityMemberInformation extends PartyEntityBaseInformation implements INetworkType
   {
      
      public static const protocolId:uint = 266;
       
      
      public var initiative:uint = 0;
      
      public var lifePoints:uint = 0;
      
      public var maxLifePoints:uint = 0;
      
      public var prospecting:uint = 0;
      
      public var regenRate:uint = 0;
      
      public function PartyEntityMemberInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 266;
      }
      
      public function initPartyEntityMemberInformation(indexId:uint = 0, entityModelId:uint = 0, entityLook:EntityLook = null, initiative:uint = 0, lifePoints:uint = 0, maxLifePoints:uint = 0, prospecting:uint = 0, regenRate:uint = 0) : PartyEntityMemberInformation
      {
         super.initPartyEntityBaseInformation(indexId,entityModelId,entityLook);
         this.initiative = initiative;
         this.lifePoints = lifePoints;
         this.maxLifePoints = maxLifePoints;
         this.prospecting = prospecting;
         this.regenRate = regenRate;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.initiative = 0;
         this.lifePoints = 0;
         this.maxLifePoints = 0;
         this.prospecting = 0;
         this.regenRate = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PartyEntityMemberInformation(output);
      }
      
      public function serializeAs_PartyEntityMemberInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyEntityBaseInformation(output);
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
         }
         output.writeVarInt(this.initiative);
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
         }
         output.writeVarInt(this.lifePoints);
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
         }
         output.writeVarInt(this.maxLifePoints);
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
         }
         output.writeVarInt(this.prospecting);
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
         }
         output.writeByte(this.regenRate);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyEntityMemberInformation(input);
      }
      
      public function deserializeAs_PartyEntityMemberInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._initiativeFunc(input);
         this._lifePointsFunc(input);
         this._maxLifePointsFunc(input);
         this._prospectingFunc(input);
         this._regenRateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyEntityMemberInformation(tree);
      }
      
      public function deserializeAsyncAs_PartyEntityMemberInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._initiativeFunc);
         tree.addChild(this._lifePointsFunc);
         tree.addChild(this._maxLifePointsFunc);
         tree.addChild(this._prospectingFunc);
         tree.addChild(this._regenRateFunc);
      }
      
      private function _initiativeFunc(input:ICustomDataInput) : void
      {
         this.initiative = input.readVarUhInt();
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element of PartyEntityMemberInformation.initiative.");
         }
      }
      
      private function _lifePointsFunc(input:ICustomDataInput) : void
      {
         this.lifePoints = input.readVarUhInt();
         if(this.lifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyEntityMemberInformation.lifePoints.");
         }
      }
      
      private function _maxLifePointsFunc(input:ICustomDataInput) : void
      {
         this.maxLifePoints = input.readVarUhInt();
         if(this.maxLifePoints < 0)
         {
            throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyEntityMemberInformation.maxLifePoints.");
         }
      }
      
      private function _prospectingFunc(input:ICustomDataInput) : void
      {
         this.prospecting = input.readVarUhInt();
         if(this.prospecting < 0)
         {
            throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyEntityMemberInformation.prospecting.");
         }
      }
      
      private function _regenRateFunc(input:ICustomDataInput) : void
      {
         this.regenRate = input.readUnsignedByte();
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyEntityMemberInformation.regenRate.");
         }
      }
   }
}

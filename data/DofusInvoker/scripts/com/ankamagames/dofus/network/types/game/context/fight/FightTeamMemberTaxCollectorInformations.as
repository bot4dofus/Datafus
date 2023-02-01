package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberTaxCollectorInformations extends FightTeamMemberInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8225;
       
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var level:uint = 0;
      
      public var guildId:uint = 0;
      
      public var uid:Number = 0;
      
      public function FightTeamMemberTaxCollectorInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8225;
      }
      
      public function initFightTeamMemberTaxCollectorInformations(id:Number = 0, firstNameId:uint = 0, lastNameId:uint = 0, level:uint = 0, guildId:uint = 0, uid:Number = 0) : FightTeamMemberTaxCollectorInformations
      {
         super.initFightTeamMemberInformations(id);
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.level = level;
         this.guildId = guildId;
         this.uid = uid;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.level = 0;
         this.guildId = 0;
         this.uid = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberTaxCollectorInformations(output);
      }
      
      public function serializeAs_FightTeamMemberTaxCollectorInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberInformations(output);
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
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
         if(this.uid < 0 || this.uid > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeDouble(this.uid);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberTaxCollectorInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberTaxCollectorInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
         this._levelFunc(input);
         this._guildIdFunc(input);
         this._uidFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberTaxCollectorInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberTaxCollectorInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         tree.addChild(this._levelFunc);
         tree.addChild(this._guildIdFunc);
         tree.addChild(this._uidFunc);
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of FightTeamMemberTaxCollectorInformations.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of FightTeamMemberTaxCollectorInformations.lastNameId.");
         }
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readUnsignedByte();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of FightTeamMemberTaxCollectorInformations.level.");
         }
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of FightTeamMemberTaxCollectorInformations.guildId.");
         }
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readDouble();
         if(this.uid < 0 || this.uid > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of FightTeamMemberTaxCollectorInformations.uid.");
         }
      }
   }
}

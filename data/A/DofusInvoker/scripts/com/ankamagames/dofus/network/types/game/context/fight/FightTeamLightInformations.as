package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamLightInformations extends AbstractFightTeamInformations implements INetworkType
   {
      
      public static const protocolId:uint = 6934;
       
      
      public var teamMembersCount:uint = 0;
      
      public var meanLevel:uint = 0;
      
      public var hasFriend:Boolean = false;
      
      public var hasGuildMember:Boolean = false;
      
      public var hasAllianceMember:Boolean = false;
      
      public var hasGroupMember:Boolean = false;
      
      public var hasMyTaxCollector:Boolean = false;
      
      public function FightTeamLightInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6934;
      }
      
      public function initFightTeamLightInformations(teamId:uint = 2, leaderId:Number = 0, teamSide:int = 0, teamTypeId:uint = 0, nbWaves:uint = 0, teamMembersCount:uint = 0, meanLevel:uint = 0, hasFriend:Boolean = false, hasGuildMember:Boolean = false, hasAllianceMember:Boolean = false, hasGroupMember:Boolean = false, hasMyTaxCollector:Boolean = false) : FightTeamLightInformations
      {
         super.initAbstractFightTeamInformations(teamId,leaderId,teamSide,teamTypeId,nbWaves);
         this.teamMembersCount = teamMembersCount;
         this.meanLevel = meanLevel;
         this.hasFriend = hasFriend;
         this.hasGuildMember = hasGuildMember;
         this.hasAllianceMember = hasAllianceMember;
         this.hasGroupMember = hasGroupMember;
         this.hasMyTaxCollector = hasMyTaxCollector;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.teamMembersCount = 0;
         this.meanLevel = 0;
         this.hasFriend = false;
         this.hasGuildMember = false;
         this.hasAllianceMember = false;
         this.hasGroupMember = false;
         this.hasMyTaxCollector = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamLightInformations(output);
      }
      
      public function serializeAs_FightTeamLightInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightTeamInformations(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.hasFriend);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.hasGuildMember);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.hasAllianceMember);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.hasGroupMember);
         _box0 = BooleanByteWrapper.setFlag(_box0,4,this.hasMyTaxCollector);
         output.writeByte(_box0);
         if(this.teamMembersCount < 0)
         {
            throw new Error("Forbidden value (" + this.teamMembersCount + ") on element teamMembersCount.");
         }
         output.writeByte(this.teamMembersCount);
         if(this.meanLevel < 0)
         {
            throw new Error("Forbidden value (" + this.meanLevel + ") on element meanLevel.");
         }
         output.writeVarInt(this.meanLevel);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamLightInformations(input);
      }
      
      public function deserializeAs_FightTeamLightInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._teamMembersCountFunc(input);
         this._meanLevelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamLightInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamLightInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._teamMembersCountFunc);
         tree.addChild(this._meanLevelFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.hasFriend = BooleanByteWrapper.getFlag(_box0,0);
         this.hasGuildMember = BooleanByteWrapper.getFlag(_box0,1);
         this.hasAllianceMember = BooleanByteWrapper.getFlag(_box0,2);
         this.hasGroupMember = BooleanByteWrapper.getFlag(_box0,3);
         this.hasMyTaxCollector = BooleanByteWrapper.getFlag(_box0,4);
      }
      
      private function _teamMembersCountFunc(input:ICustomDataInput) : void
      {
         this.teamMembersCount = input.readByte();
         if(this.teamMembersCount < 0)
         {
            throw new Error("Forbidden value (" + this.teamMembersCount + ") on element of FightTeamLightInformations.teamMembersCount.");
         }
      }
      
      private function _meanLevelFunc(input:ICustomDataInput) : void
      {
         this.meanLevel = input.readVarUhInt();
         if(this.meanLevel < 0)
         {
            throw new Error("Forbidden value (" + this.meanLevel + ") on element of FightTeamLightInformations.meanLevel.");
         }
      }
   }
}

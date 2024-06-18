package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightAllianceTeamInformations extends FightTeamInformations implements INetworkType
   {
      
      public static const protocolId:uint = 8585;
       
      
      public var relation:uint = 0;
      
      public function FightAllianceTeamInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8585;
      }
      
      public function initFightAllianceTeamInformations(teamId:uint = 2, leaderId:Number = 0, teamSide:int = 0, teamTypeId:uint = 0, nbWaves:uint = 0, teamMembers:Vector.<FightTeamMemberInformations> = null, relation:uint = 0) : FightAllianceTeamInformations
      {
         super.initFightTeamInformations(teamId,leaderId,teamSide,teamTypeId,nbWaves,teamMembers);
         this.relation = relation;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.relation = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightAllianceTeamInformations(output);
      }
      
      public function serializeAs_FightAllianceTeamInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamInformations(output);
         output.writeByte(this.relation);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightAllianceTeamInformations(input);
      }
      
      public function deserializeAs_FightAllianceTeamInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._relationFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightAllianceTeamInformations(tree);
      }
      
      public function deserializeAsyncAs_FightAllianceTeamInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._relationFunc);
      }
      
      private function _relationFunc(input:ICustomDataInput) : void
      {
         this.relation = input.readByte();
         if(this.relation < 0)
         {
            throw new Error("Forbidden value (" + this.relation + ") on element of FightAllianceTeamInformations.relation.");
         }
      }
   }
}

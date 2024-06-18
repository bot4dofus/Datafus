package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamInformations extends AbstractFightTeamInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3291;
       
      
      public var teamMembers:Vector.<FightTeamMemberInformations>;
      
      private var _teamMemberstree:FuncTree;
      
      public function FightTeamInformations()
      {
         this.teamMembers = new Vector.<FightTeamMemberInformations>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3291;
      }
      
      public function initFightTeamInformations(teamId:uint = 2, leaderId:Number = 0, teamSide:int = 0, teamTypeId:uint = 0, nbWaves:uint = 0, teamMembers:Vector.<FightTeamMemberInformations> = null) : FightTeamInformations
      {
         super.initAbstractFightTeamInformations(teamId,leaderId,teamSide,teamTypeId,nbWaves);
         this.teamMembers = teamMembers;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.teamMembers = new Vector.<FightTeamMemberInformations>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamInformations(output);
      }
      
      public function serializeAs_FightTeamInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractFightTeamInformations(output);
         output.writeShort(this.teamMembers.length);
         for(var _i1:uint = 0; _i1 < this.teamMembers.length; _i1++)
         {
            output.writeShort((this.teamMembers[_i1] as FightTeamMemberInformations).getTypeId());
            (this.teamMembers[_i1] as FightTeamMemberInformations).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamInformations(input);
      }
      
      public function deserializeAs_FightTeamInformations(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:FightTeamMemberInformations = null;
         super.deserialize(input);
         var _teamMembersLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _teamMembersLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(FightTeamMemberInformations,_id1);
            _item1.deserialize(input);
            this.teamMembers.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._teamMemberstree = tree.addChild(this._teamMemberstreeFunc);
      }
      
      private function _teamMemberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._teamMemberstree.addChild(this._teamMembersFunc);
         }
      }
      
      private function _teamMembersFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:FightTeamMemberInformations = ProtocolTypeManager.getInstance(FightTeamMemberInformations,_id);
         _item.deserialize(input);
         this.teamMembers.push(_item);
      }
   }
}

package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightTeamMemberWithAllianceCharacterInformations extends FightTeamMemberCharacterInformations implements INetworkType
   {
      
      public static const protocolId:uint = 793;
       
      
      public var allianceInfos:BasicAllianceInformations;
      
      private var _allianceInfostree:FuncTree;
      
      public function FightTeamMemberWithAllianceCharacterInformations()
      {
         this.allianceInfos = new BasicAllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 793;
      }
      
      public function initFightTeamMemberWithAllianceCharacterInformations(id:Number = 0, name:String = "", level:uint = 0, allianceInfos:BasicAllianceInformations = null) : FightTeamMemberWithAllianceCharacterInformations
      {
         super.initFightTeamMemberCharacterInformations(id,name,level);
         this.allianceInfos = allianceInfos;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceInfos = new BasicAllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightTeamMemberWithAllianceCharacterInformations(output);
      }
      
      public function serializeAs_FightTeamMemberWithAllianceCharacterInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightTeamMemberCharacterInformations(output);
         this.allianceInfos.serializeAs_BasicAllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightTeamMemberWithAllianceCharacterInformations(input);
      }
      
      public function deserializeAs_FightTeamMemberWithAllianceCharacterInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInfos = new BasicAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightTeamMemberWithAllianceCharacterInformations(tree);
      }
      
      public function deserializeAsyncAs_FightTeamMemberWithAllianceCharacterInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
      }
      
      private function _allianceInfostreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfos = new BasicAllianceInformations();
         this.allianceInfos.deserializeAsync(this._allianceInfostree);
      }
   }
}

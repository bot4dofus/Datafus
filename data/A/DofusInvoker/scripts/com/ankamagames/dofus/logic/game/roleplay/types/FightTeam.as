package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightOptionsInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class FightTeam extends GameContextActorInformations
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTeam));
       
      
      public var fight:Fight;
      
      public var teamType:uint;
      
      public var teamEntity:IEntity;
      
      public var teamInfos:FightTeamInformations;
      
      public var teamOptions:Array;
      
      public function FightTeam(fight:Fight, teamType:uint, teamEntity:IEntity, teamInfos:FightTeamInformations, teamOptions:FightOptionsInformations)
      {
         super();
         this.fight = fight;
         this.teamType = teamType;
         this.teamEntity = teamEntity;
         this.teamInfos = teamInfos;
         this.look = EntityLookAdapter.toNetwork((teamEntity as AnimatedCharacter).look);
         this.teamOptions = new Array();
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP] = teamOptions.isAskingForHelp;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_CLOSED] = teamOptions.isClosed;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_SECRET] = teamOptions.isSecret;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY] = teamOptions.isRestrictedToPartyOnly;
      }
      
      public function hasGroupMember() : Boolean
      {
         var partyMember:PartyMemberWrapper = null;
         var fightTeamMember:FightTeamMemberInformations = null;
         var teamHasGroupMember:Boolean = false;
         var pmf:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         var partyMemberNames:Vector.<String> = new Vector.<String>();
         for each(partyMember in pmf.partyMembers)
         {
            partyMemberNames.push(partyMember.name);
         }
         for each(fightTeamMember in this.teamInfos.teamMembers)
         {
            if(fightTeamMember && fightTeamMember is FightTeamMemberCharacterInformations && partyMemberNames.indexOf(FightTeamMemberCharacterInformations(fightTeamMember).name) != -1)
            {
               teamHasGroupMember = true;
               break;
            }
         }
         return teamHasGroupMember;
      }
      
      public function hasOptions() : Boolean
      {
         var opt:* = undefined;
         var hasOptions:Boolean = false;
         for(opt in this.teamOptions)
         {
            if(this.teamOptions[opt])
            {
               hasOptions = true;
               break;
            }
         }
         return hasOptions;
      }
   }
}

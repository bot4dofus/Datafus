package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.enums.GuildRightsBitEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class GuildRightsItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function GuildRightsItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var hasThisRight:Boolean = false;
         var socialFrame:SocialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
         if(!socialFrame.hasGuild)
         {
            if(_operator.text == ItemCriterionOperator.DIFFERENT)
            {
               return true;
            }
            return false;
         }
         var guild:GuildWrapper = socialFrame.guild;
         switch(criterionValue)
         {
            case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
               hasThisRight = guild.isBoss;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
               hasThisRight = guild.banMembers;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
               hasThisRight = guild.collect;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
               hasThisRight = guild.collectMyTaxCollectors;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
               hasThisRight = guild.prioritizeMeInDefense;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
               hasThisRight = guild.hireTaxCollector;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
               hasThisRight = guild.inviteNewMembers;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
               hasThisRight = guild.manageGuildBoosts;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
               hasThisRight = guild.manageMyXpContribution;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
               hasThisRight = guild.manageRanks;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
               hasThisRight = guild.manageRights;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
               hasThisRight = guild.manageXPContribution;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
               hasThisRight = guild.organizeFarms;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_SET_ALLIANCE_PRISM:
               hasThisRight = guild.setAlliancePrism;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TALK_IN_ALLIANCE_CHAN:
               hasThisRight = guild.talkInAllianceChannel;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
               hasThisRight = guild.takeOthersRidesInFarm;
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
               hasThisRight = guild.useFarms;
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return hasThisRight;
            case ItemCriterionOperator.DIFFERENT:
               return !hasThisRight;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         var readableCriterionValue:String = null;
         switch(criterionValue)
         {
            case GuildRightsBitEnum.GUILD_RIGHT_BOSS:
               readableCriterionValue = I18n.getUiText("ui.guild.right.leader");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_BAN_MEMBERS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsBann");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsCollect");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_COLLECT_MY_TAX_COLLECTOR:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsCollectMy");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_DEFENSE_PRIORITY:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsPrioritizeMe");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_HIRE_TAX_COLLECTOR:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsHiretax");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_INVITE_NEW_MEMBERS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsInvit");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_GUILD_BOOSTS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsBoost");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_MY_XP_CONTRIBUTION:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightManageOwnXP");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RANKS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsRank");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_RIGHTS:
               readableCriterionValue = I18n.getUiText("ui.social.guildManageRights");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_MANAGE_XP_CONTRIBUTION:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsPercentXp");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_ORGANIZE_PADDOCKS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsMountParkArrange");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_SET_ALLIANCE_PRISM:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsSetAlliancePrism");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TALK_IN_ALLIANCE_CHAN:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsTalkInAllianceChannel");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_TAKE_OTHERS_MOUNTS_IN_PADDOCKS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsManageOtherMount");
               break;
            case GuildRightsBitEnum.GUILD_RIGHT_USE_PADDOCKS:
               readableCriterionValue = I18n.getUiText("ui.social.guildRightsMountParkUse");
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.guildRights",[readableCriterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.notGuildRights",[readableCriterionValue]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new GuildRightsItemCriterion(this.basicText);
      }
   }
}

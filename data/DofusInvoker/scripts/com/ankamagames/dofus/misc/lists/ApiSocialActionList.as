package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeGuildRightsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationByNameAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ContactsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.EnemiesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendGuildSetWarnOnAchievementCompleteAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendOrGuildMemberLevelUpWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.MemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.SpouseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StatusShareSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.WarnOnHardcoreDeathAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiSocialActionList
   {
      
      public static const OpenSocial:DofusApiAction = new DofusApiAction("OpenSocialAction",OpenSocialAction);
      
      public static const FriendsListRequest:DofusApiAction = new DofusApiAction("FriendsListRequestAction",FriendsListRequestAction);
      
      public static const ContactsListRequest:DofusApiAction = new DofusApiAction("ContactsListRequestAction",ContactsListRequestAction);
      
      public static const EnemiesListRequest:DofusApiAction = new DofusApiAction("EnemiesListRequestAction",EnemiesListRequestAction);
      
      public static const SpouseRequest:DofusApiAction = new DofusApiAction("SpouseRequestAction",SpouseRequestAction);
      
      public static const AddFriend:DofusApiAction = new DofusApiAction("AddFriendAction",AddFriendAction);
      
      public static const AddEnemy:DofusApiAction = new DofusApiAction("AddEnemyAction",AddEnemyAction);
      
      public static const RemoveFriend:DofusApiAction = new DofusApiAction("RemoveFriendAction",RemoveFriendAction);
      
      public static const RemoveEnemy:DofusApiAction = new DofusApiAction("RemoveEnemyAction",RemoveEnemyAction);
      
      public static const AddIgnored:DofusApiAction = new DofusApiAction("AddIgnoredAction",AddIgnoredAction);
      
      public static const RemoveIgnored:DofusApiAction = new DofusApiAction("RemoveIgnoredAction",RemoveIgnoredAction);
      
      public static const JoinFriend:DofusApiAction = new DofusApiAction("JoinFriendAction",JoinFriendAction);
      
      public static const JoinSpouse:DofusApiAction = new DofusApiAction("JoinSpouseAction",JoinSpouseAction);
      
      public static const FriendSpouseFollow:DofusApiAction = new DofusApiAction("FriendSpouseFollowAction",FriendSpouseFollowAction);
      
      public static const FriendWarningSet:DofusApiAction = new DofusApiAction("FriendWarningSetAction",FriendWarningSetAction);
      
      public static const StatusShareSet:DofusApiAction = new DofusApiAction("StatusShareSetAction",StatusShareSetAction);
      
      public static const MemberWarningSet:DofusApiAction = new DofusApiAction("MemberWarningSetAction",MemberWarningSetAction);
      
      public static const FriendOrGuildMemberLevelUpWarningSet:DofusApiAction = new DofusApiAction("FriendOrGuildMemberLevelUpWarningSetAction",FriendOrGuildMemberLevelUpWarningSetAction);
      
      public static const FriendGuildSetWarnOnAchievementComplete:DofusApiAction = new DofusApiAction("FriendGuildSetWarnOnAchievementCompleteAction",FriendGuildSetWarnOnAchievementCompleteAction);
      
      public static const WarnOnHardcoreDeath:DofusApiAction = new DofusApiAction("WarnOnHardcoreDeathAction",WarnOnHardcoreDeathAction);
      
      public static const GuildGetInformations:DofusApiAction = new DofusApiAction("GuildGetInformationsAction",GuildGetInformationsAction);
      
      public static const GuildCreationValid:DofusApiAction = new DofusApiAction("GuildCreationValidAction",GuildCreationValidAction);
      
      public static const GuildModificationValid:DofusApiAction = new DofusApiAction("GuildModificationValidAction",GuildModificationValidAction);
      
      public static const GuildModificationNameValid:DofusApiAction = new DofusApiAction("GuildModificationNameValidAction",GuildModificationNameValidAction);
      
      public static const GuildModificationEmblemValid:DofusApiAction = new DofusApiAction("GuildModificationEmblemValidAction",GuildModificationEmblemValidAction);
      
      public static const GuildInvitation:DofusApiAction = new DofusApiAction("GuildInvitationAction",GuildInvitationAction);
      
      public static const GuildInvitationByName:DofusApiAction = new DofusApiAction("GuildInvitationByNameAction",GuildInvitationByNameAction);
      
      public static const GuildInvitationAnswer:DofusApiAction = new DofusApiAction("GuildInvitationAnswerAction",GuildInvitationAnswerAction);
      
      public static const GuildKickRequest:DofusApiAction = new DofusApiAction("GuildKickRequestAction",GuildKickRequestAction);
      
      public static const GuildChangeMemberParameters:DofusApiAction = new DofusApiAction("GuildChangeMemberParametersAction",GuildChangeMemberParametersAction);
      
      public static const GuildSpellUpgradeRequest:DofusApiAction = new DofusApiAction("GuildSpellUpgradeRequestAction",GuildSpellUpgradeRequestAction);
      
      public static const GuildCharacsUpgradeRequest:DofusApiAction = new DofusApiAction("GuildCharacsUpgradeRequestAction",GuildCharacsUpgradeRequestAction);
      
      public static const GuildFarmTeleportRequest:DofusApiAction = new DofusApiAction("GuildFarmTeleportRequestAction",GuildFarmTeleportRequestAction);
      
      public static const HouseTeleportRequest:DofusApiAction = new DofusApiAction("HouseTeleportRequestAction",HouseTeleportRequestAction);
      
      public static const GuildMotdSetRequest:DofusApiAction = new DofusApiAction("GuildMotdSetRequestAction",GuildMotdSetRequestAction);
      
      public static const GuildBulletinSetRequest:DofusApiAction = new DofusApiAction("GuildBulletinSetRequestAction",GuildBulletinSetRequestAction);
      
      public static const GuildFightJoinRequest:DofusApiAction = new DofusApiAction("GuildFightJoinRequestAction",GuildFightJoinRequestAction);
      
      public static const GuildFightTakePlaceRequest:DofusApiAction = new DofusApiAction("GuildFightTakePlaceRequestAction",GuildFightTakePlaceRequestAction);
      
      public static const GuildFightLeaveRequest:DofusApiAction = new DofusApiAction("GuildFightLeaveRequestAction",GuildFightLeaveRequestAction);
      
      public static const GameRolePlayTaxCollectorFightRequest:DofusApiAction = new DofusApiAction("GameRolePlayTaxCollectorFightRequestAction",GameRolePlayTaxCollectorFightRequestAction);
      
      public static const GuildFactsRequest:DofusApiAction = new DofusApiAction("GuildFactsRequestAction",GuildFactsRequestAction);
      
      public static const GuildListRequest:DofusApiAction = new DofusApiAction("GuildListRequestAction",GuildListRequestAction);
      
      public static const AllianceCreationValid:DofusApiAction = new DofusApiAction("AllianceCreationValidAction",AllianceCreationValidAction);
      
      public static const AllianceModificationValid:DofusApiAction = new DofusApiAction("AllianceModificationValidAction",AllianceModificationValidAction);
      
      public static const AllianceModificationNameAndTagValid:DofusApiAction = new DofusApiAction("AllianceModificationNameAndTagValidAction",AllianceModificationNameAndTagValidAction);
      
      public static const AllianceModificationEmblemValid:DofusApiAction = new DofusApiAction("AllianceModificationEmblemValidAction",AllianceModificationEmblemValidAction);
      
      public static const AllianceInvitation:DofusApiAction = new DofusApiAction("AllianceInvitationAction",AllianceInvitationAction);
      
      public static const AllianceInvitationAnswer:DofusApiAction = new DofusApiAction("AllianceInvitationAnswerAction",AllianceInvitationAnswerAction);
      
      public static const AllianceKickRequest:DofusApiAction = new DofusApiAction("AllianceKickRequestAction",AllianceKickRequestAction);
      
      public static const AllianceFactsRequest:DofusApiAction = new DofusApiAction("AllianceFactsRequestAction",AllianceFactsRequestAction);
      
      public static const AllianceListRequest:DofusApiAction = new DofusApiAction("AllianceListRequestAction",AllianceListRequestAction);
      
      public static const AllianceInsiderInfoRequest:DofusApiAction = new DofusApiAction("AllianceInsiderInfoRequestAction",AllianceInsiderInfoRequestAction);
      
      public static const AllianceChangeGuildRights:DofusApiAction = new DofusApiAction("AllianceChangeGuildRightsAction",AllianceChangeGuildRightsAction);
      
      public static const AllianceMotdSetRequest:DofusApiAction = new DofusApiAction("AllianceMotdSetRequestAction",AllianceMotdSetRequestAction);
      
      public static const AllianceBulletinSetRequest:DofusApiAction = new DofusApiAction("AllianceBulletinSetRequestAction",AllianceBulletinSetRequestAction);
      
      public static const CharacterReport:DofusApiAction = new DofusApiAction("CharacterReportAction",CharacterReportAction);
      
      public static const ChatReport:DofusApiAction = new DofusApiAction("ChatReportAction",ChatReportAction);
      
      public static const PlayerStatusUpdateRequest:DofusApiAction = new DofusApiAction("PlayerStatusUpdateRequestAction",PlayerStatusUpdateRequestAction);
       
      
      public function ApiSocialActionList()
      {
         super();
      }
   }
}

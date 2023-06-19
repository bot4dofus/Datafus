package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceAllRanksUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceAreThereApplicationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeMemberRankAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceGetRecruitmentInformationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceRankCreateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceRankRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceRankUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceRanksRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceRightsUpdateAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceSetApplicationUpdatesRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceSubmitApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceSummaryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceUpdateApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.NuggetDistributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SendAllianceRecruitmentDataAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StartListenAllianceFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StartListenNuggetsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StopListenAllianceFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.StopListenNuggetsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.CreateGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildAreThereApplicationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildLogbookRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildNoteUpdateAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildRanksRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSetApplicationUpdatesRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSubmitApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSummaryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildUpdateApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.RemoveGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.SendGuildRecruitmentDataAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.UpdateAllGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.UpdateGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.UpdateGuildRightsAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AllianceMemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.CharacterReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ChatReportAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.ContactsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.EnemiesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendGuildSetWarnOnAchievementCompleteAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendOrGuildMemberLevelUpWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendsListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.GuildMemberWarningSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.PlayerStatusUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveIgnoredAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.SpouseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StartListenGuildChestStructureAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StatusShareSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StopListenGuildChestStructureAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.WarnOnHardcoreDeathAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.socialFight.SocialFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.AddTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.AddTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.GameRolePlayTaxCollectorFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.MoveTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.MoveTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.RemoveTaxCollectorOrderedSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.RemoveTaxCollectorPresetSpellAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StartListenTaxCollectorPresetsUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StartListenTaxCollectorUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StopListenTaxCollectorPresetsUpdatesAction;
   import com.ankamagames.dofus.logic.game.common.actions.taxCollector.StopListenTaxCollectorUpdatesAction;
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
      
      public static const GuildMemberWarningSet:DofusApiAction = new DofusApiAction("GuildMemberWarningSetAction",GuildMemberWarningSetAction);
      
      public static const AllianceMemberWarningSet:DofusApiAction = new DofusApiAction("AllianceMemberWarningSetAction",AllianceMemberWarningSetAction);
      
      public static const FriendOrGuildMemberLevelUpWarningSet:DofusApiAction = new DofusApiAction("FriendOrGuildMemberLevelUpWarningSetAction",FriendOrGuildMemberLevelUpWarningSetAction);
      
      public static const FriendGuildSetWarnOnAchievementComplete:DofusApiAction = new DofusApiAction("FriendGuildSetWarnOnAchievementCompleteAction",FriendGuildSetWarnOnAchievementCompleteAction);
      
      public static const WarnOnHardcoreDeath:DofusApiAction = new DofusApiAction("WarnOnHardcoreDeathAction",WarnOnHardcoreDeathAction);
      
      public static const GuildGetInformations:DofusApiAction = new DofusApiAction("GuildGetInformationsAction",GuildGetInformationsAction);
      
      public static const GuildCreationValid:DofusApiAction = new DofusApiAction("GuildCreationValidAction",GuildCreationValidAction);
      
      public static const GuildModificationValid:DofusApiAction = new DofusApiAction("GuildModificationValidAction",GuildModificationValidAction);
      
      public static const GuildModificationNameValid:DofusApiAction = new DofusApiAction("GuildModificationNameValidAction",GuildModificationNameValidAction);
      
      public static const GuildModificationEmblemValid:DofusApiAction = new DofusApiAction("GuildModificationEmblemValidAction",GuildModificationEmblemValidAction);
      
      public static const GuildInvitation:DofusApiAction = new DofusApiAction("GuildInvitationAction",GuildInvitationAction);
      
      public static const GuildDeleteApplicationRequest:DofusApiAction = new DofusApiAction("GuildDeleteApplicationRequestAction",GuildDeleteApplicationRequestAction);
      
      public static const GuildInvitationAnswer:DofusApiAction = new DofusApiAction("GuildInvitationAnswerAction",GuildInvitationAnswerAction);
      
      public static const GuildJoinRequest:DofusApiAction = new DofusApiAction("GuildJoinRequestAction",GuildJoinRequestAction);
      
      public static const GuildSubmitApplication:DofusApiAction = new DofusApiAction("GuildSubmitApplicationAction",GuildSubmitApplicationAction);
      
      public static const GuildUpdateApplication:DofusApiAction = new DofusApiAction("GuildUpdateApplicationAction",GuildUpdateApplicationAction);
      
      public static const GuildKickRequest:DofusApiAction = new DofusApiAction("GuildKickRequestAction",GuildKickRequestAction);
      
      public static const GuildChangeMemberParameters:DofusApiAction = new DofusApiAction("GuildChangeMemberParametersAction",GuildChangeMemberParametersAction);
      
      public static const GuildSpellUpgradeRequest:DofusApiAction = new DofusApiAction("GuildSpellUpgradeRequestAction",GuildSpellUpgradeRequestAction);
      
      public static const GuildCharacsUpgradeRequest:DofusApiAction = new DofusApiAction("GuildCharacsUpgradeRequestAction",GuildCharacsUpgradeRequestAction);
      
      public static const GuildFarmTeleportRequest:DofusApiAction = new DofusApiAction("GuildFarmTeleportRequestAction",GuildFarmTeleportRequestAction);
      
      public static const HouseTeleportRequest:DofusApiAction = new DofusApiAction("HouseTeleportRequestAction",HouseTeleportRequestAction);
      
      public static const GuildMotdSetRequest:DofusApiAction = new DofusApiAction("GuildMotdSetRequestAction",GuildMotdSetRequestAction);
      
      public static const GuildNoteUpdate:DofusApiAction = new DofusApiAction("GuildNoteUpdateAction",GuildNoteUpdateAction);
      
      public static const GuildApplicationReply:DofusApiAction = new DofusApiAction("GuildApplicationReplyAction",GuildApplicationReplyAction);
      
      public static const GuildAreThereApplications:DofusApiAction = new DofusApiAction("GuildAreThereApplicationsAction",GuildAreThereApplicationsAction);
      
      public static const GuildApplicationsRequest:DofusApiAction = new DofusApiAction("GuildApplicationsRequestAction",GuildApplicationsRequestAction);
      
      public static const GuildSetApplicationUpdatesRequest:DofusApiAction = new DofusApiAction("GuildSetApplicationUpdatesRequestAction",GuildSetApplicationUpdatesRequestAction);
      
      public static const GuildSummaryRequest:DofusApiAction = new DofusApiAction("GuildSummaryRequestAction",GuildSummaryRequestAction);
      
      public static const GuildGetPlayerApplicationRequest:DofusApiAction = new DofusApiAction("GuildGetPlayerApplicationAction",GuildGetPlayerApplicationAction);
      
      public static const GuildBulletinSetRequest:DofusApiAction = new DofusApiAction("GuildBulletinSetRequestAction",GuildBulletinSetRequestAction);
      
      public static const SocialFightJoinRequest:DofusApiAction = new DofusApiAction("SocialFightJoinRequestAction",SocialFightJoinRequestAction);
      
      public static const SocialFightLeaveRequest:DofusApiAction = new DofusApiAction("SocialFightLeaveRequestAction",SocialFightLeaveRequestAction);
      
      public static const SocialFightTakePlaceRequest:DofusApiAction = new DofusApiAction("SocialFightTakePlaceRequestAction",SocialFightTakePlaceRequestAction);
      
      public static const GameRolePlayTaxCollectorFightRequest:DofusApiAction = new DofusApiAction("GameRolePlayTaxCollectorFightRequestAction",GameRolePlayTaxCollectorFightRequestAction);
      
      public static const GuildFactsRequest:DofusApiAction = new DofusApiAction("GuildFactsRequestAction",GuildFactsRequestAction);
      
      public static const GuildListRequest:DofusApiAction = new DofusApiAction("GuildListRequestAction",GuildListRequestAction);
      
      public static const AllianceCreationValid:DofusApiAction = new DofusApiAction("AllianceCreationValidAction",AllianceCreationValidAction);
      
      public static const AllianceGetRecruitmentInformation:DofusApiAction = new DofusApiAction("AllianceGetRecruitmentInformationAction",AllianceGetRecruitmentInformationAction);
      
      public static const AllianceModificationValid:DofusApiAction = new DofusApiAction("AllianceModificationValidAction",AllianceModificationValidAction);
      
      public static const AllianceModificationNameAndTagValid:DofusApiAction = new DofusApiAction("AllianceModificationNameAndTagValidAction",AllianceModificationNameAndTagValidAction);
      
      public static const AllianceModificationEmblemValid:DofusApiAction = new DofusApiAction("AllianceModificationEmblemValidAction",AllianceModificationEmblemValidAction);
      
      public static const AllianceDeleteApplicationRequest:DofusApiAction = new DofusApiAction("AllianceDeleteApplicationRequestAction",AllianceDeleteApplicationRequestAction);
      
      public static const AllianceInvitation:DofusApiAction = new DofusApiAction("AllianceInvitationAction",AllianceInvitationAction);
      
      public static const AllianceInvitationAnswer:DofusApiAction = new DofusApiAction("AllianceInvitationAnswerAction",AllianceInvitationAnswerAction);
      
      public static const AllianceJoinRequest:DofusApiAction = new DofusApiAction("AllianceJoinRequestAction",AllianceJoinRequestAction);
      
      public static const AllianceSubmitApplication:DofusApiAction = new DofusApiAction("AllianceSubmitApplicationAction",AllianceSubmitApplicationAction);
      
      public static const AllianceUpdateApplication:DofusApiAction = new DofusApiAction("AllianceUpdateApplicationAction",AllianceUpdateApplicationAction);
      
      public static const AllianceKickRequest:DofusApiAction = new DofusApiAction("AllianceKickRequestAction",AllianceKickRequestAction);
      
      public static const AllianceChangeMemberRank:DofusApiAction = new DofusApiAction("AllianceChangeMemberRankAction",AllianceChangeMemberRankAction);
      
      public static const AllianceFactsRequest:DofusApiAction = new DofusApiAction("AllianceFactsRequestAction",AllianceFactsRequestAction);
      
      public static const AllianceListRequest:DofusApiAction = new DofusApiAction("AllianceListRequestAction",AllianceListRequestAction);
      
      public static const AllianceSummaryRequest:DofusApiAction = new DofusApiAction("AllianceSummaryRequestAction",AllianceSummaryRequestAction);
      
      public static const AllianceGetPlayerApplicationRequest:DofusApiAction = new DofusApiAction("AllianceGetPlayerApplicationAction",AllianceGetPlayerApplicationAction);
      
      public static const AllianceInsiderInfoRequest:DofusApiAction = new DofusApiAction("AllianceInsiderInfoRequestAction",AllianceInsiderInfoRequestAction);
      
      public static const AllianceMotdSetRequest:DofusApiAction = new DofusApiAction("AllianceMotdSetRequestAction",AllianceMotdSetRequestAction);
      
      public static const AllianceBulletinSetRequest:DofusApiAction = new DofusApiAction("AllianceBulletinSetRequestAction",AllianceBulletinSetRequestAction);
      
      public static const AllianceApplicationReply:DofusApiAction = new DofusApiAction("AllianceApplicationReplyAction",AllianceApplicationReplyAction);
      
      public static const AllianceAreThereApplications:DofusApiAction = new DofusApiAction("AllianceAreThereApplicationsAction",AllianceAreThereApplicationsAction);
      
      public static const AllianceApplicationsRequest:DofusApiAction = new DofusApiAction("AllianceApplicationsRequestAction",AllianceApplicationsRequestAction);
      
      public static const AllianceSetApplicationUpdatesRequest:DofusApiAction = new DofusApiAction("AllianceSetApplicationUpdatesRequestAction",AllianceSetApplicationUpdatesRequestAction);
      
      public static const CharacterReport:DofusApiAction = new DofusApiAction("CharacterReportAction",CharacterReportAction);
      
      public static const ChatReport:DofusApiAction = new DofusApiAction("ChatReportAction",ChatReportAction);
      
      public static const PlayerStatusUpdateRequest:DofusApiAction = new DofusApiAction("PlayerStatusUpdateRequestAction",PlayerStatusUpdateRequestAction);
      
      public static const SendGuildRecruitmentData:DofusApiAction = new DofusApiAction("SendGuildRecruitmentDataAction",SendGuildRecruitmentDataAction);
      
      public static const GuildRanksRequest:DofusApiAction = new DofusApiAction("GuildRanksRequestAction",GuildRanksRequestAction);
      
      public static const GuildLogbookRequest:DofusApiAction = new DofusApiAction("GuildLogbookRequestAction",GuildLogbookRequestAction);
      
      public static const CreateGuildRankRequest:DofusApiAction = new DofusApiAction("CreateGuildRankRequestAction",CreateGuildRankRequestAction);
      
      public static const UpdateAllGuildRankRequest:DofusApiAction = new DofusApiAction("UpdateAllGuildRankRequestAction",UpdateAllGuildRankRequestAction);
      
      public static const UpdateGuildRankRequest:DofusApiAction = new DofusApiAction("UpdateGuildRankRequestAction",UpdateGuildRankRequestAction);
      
      public static const RemoveGuildRankRequest:DofusApiAction = new DofusApiAction("RemoveGuildRankRequestAction",RemoveGuildRankRequestAction);
      
      public static const UpdateGuildRights:DofusApiAction = new DofusApiAction("UpdateGuildRightsAction",UpdateGuildRightsAction);
      
      public static const StartListenGuildChestStructure:DofusApiAction = new DofusApiAction("StartListenGuildChestStructureAction",StartListenGuildChestStructureAction);
      
      public static const StopListenGuildChestStructure:DofusApiAction = new DofusApiAction("StopListenGuildChestStructureAction",StopListenGuildChestStructureAction);
      
      public static const SendAllianceRecruitmentData:DofusApiAction = new DofusApiAction("SendAllianceRecruitmentDataAction",SendAllianceRecruitmentDataAction);
      
      public static const AllianceRanksRequest:DofusApiAction = new DofusApiAction("AllianceRanksRequestAction",AllianceRanksRequestAction);
      
      public static const AllianceRankCreateRequest:DofusApiAction = new DofusApiAction("AllianceRankCreateRequestAction",AllianceRankCreateRequestAction);
      
      public static const AllianceAllRanksUpdateRequest:DofusApiAction = new DofusApiAction("AllianceAllRanksUpdateRequestAction",AllianceAllRanksUpdateRequestAction);
      
      public static const AllianceRankUpdateRequest:DofusApiAction = new DofusApiAction("AllianceRankUpdateRequestAction",AllianceRankUpdateRequestAction);
      
      public static const AllianceRankRemoveRequest:DofusApiAction = new DofusApiAction("AllianceRankRemoveRequestAction",AllianceRankRemoveRequestAction);
      
      public static const AllianceRightsUpdate:DofusApiAction = new DofusApiAction("AllianceRightsUpdateAction",AllianceRightsUpdateAction);
      
      public static const StartListenTaxCollectorUpdates:DofusApiAction = new DofusApiAction("StartListenTaxCollectorUpdatesAction",StartListenTaxCollectorUpdatesAction);
      
      public static const StopListenTaxCollectorUpdates:DofusApiAction = new DofusApiAction("StopListenTaxCollectorUpdatesAction",StopListenTaxCollectorUpdatesAction);
      
      public static const StartListenAllianceFight:DofusApiAction = new DofusApiAction("StartListenAllianceFightAction",StartListenAllianceFightAction);
      
      public static const StartListenNuggets:DofusApiAction = new DofusApiAction("StartListenNuggetsAction",StartListenNuggetsAction);
      
      public static const StopListenNuggets:DofusApiAction = new DofusApiAction("StopListenNuggetsAction",StopListenNuggetsAction);
      
      public static const NuggetDistribution:DofusApiAction = new DofusApiAction("NuggetDistributionAction",NuggetDistributionAction);
      
      public static const StopListenAllianceFight:DofusApiAction = new DofusApiAction("StopListenAllianceFightAction",StopListenAllianceFightAction);
      
      public static const AddTaxCollectorOrderedSpell:DofusApiAction = new DofusApiAction("AddTaxCollectorOrderedSpellAction",AddTaxCollectorOrderedSpellAction);
      
      public static const RemoveTaxCollectorOrderedSpell:DofusApiAction = new DofusApiAction("RemoveTaxCollectorOrderedSpellAction",RemoveTaxCollectorOrderedSpellAction);
      
      public static const MoveTaxCollectorOrderedSpell:DofusApiAction = new DofusApiAction("MoveTaxCollectorOrderedSpellAction",MoveTaxCollectorOrderedSpellAction);
      
      public static const AddTaxCollectorPresetSpell:DofusApiAction = new DofusApiAction("AddTaxCollectorPresetSpellAction",AddTaxCollectorPresetSpellAction);
      
      public static const RemoveTaxCollectorPresetSpell:DofusApiAction = new DofusApiAction("RemoveTaxCollectorPresetSpellAction",RemoveTaxCollectorPresetSpellAction);
      
      public static const MoveTaxCollectorPresetSpell:DofusApiAction = new DofusApiAction("MoveTaxCollectorPresetSpellAction",MoveTaxCollectorPresetSpellAction);
      
      public static const StartListenTaxCollectorPresetsUpdates:DofusApiAction = new DofusApiAction("StartListenTaxCollectorPresetsUpdatesAction",StartListenTaxCollectorPresetsUpdatesAction);
      
      public static const StopListenTaxCollectorPresetsUpdates:DofusApiAction = new DofusApiAction("StopListenTaxCollectorPresetsUpdatesAction",StopListenTaxCollectorPresetsUpdatesAction);
       
      
      public function ApiSocialActionList()
      {
         super();
      }
   }
}

package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.alliance.AllianceRank;
   import com.ankamagames.dofus.datacenter.guild.GuildRank;
   import com.ankamagames.dofus.datacenter.seasons.ServerSeason;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.people.ContactWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SocialCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.EmblemWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildHouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.SocialApplicationWrapper;
   import com.ankamagames.dofus.internalDatacenter.social.SocialGroupWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowAllianceManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowGuildManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenAlliancePrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuildPrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceAllRanksUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceAreThereApplicationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceChangeMemberRankAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceGetRecruitmentInformationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInsiderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceKickRequestAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SendAllianceRecruitmentDataAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.CreateGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildAreThereApplicationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildLogbookRequestAction;
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
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.SocialEntitiesManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.ListAddFailureEnum;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupOperationResultEnum;
   import com.ankamagames.dofus.network.enums.SocialNoticeErrorEnum;
   import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildSetWarnOnAchievementCompleteMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildWarnOnAchievementCompleteStateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceAllRanksUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceBulletinSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceChangeMemberRankMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationResultMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInsiderInfoRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecrutedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationStateRecruterMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceJoinAutomaticallyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceJoinedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceKickRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceLeftMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMemberInformationUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMemberLeavingMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMemberOnlineStatusMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMemberStartWarningOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMemberStopWarningOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMembershipMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationResultMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceMotdSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRankCreateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRankRemoveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRankUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRanksMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRanksRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceRightsUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationIsAnsweredMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationListenMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationPresenceMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceApplicationReceivedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceDeleteApplicationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceGetPlayerApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceIsThereAnyApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceListApplicationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceListApplicationModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceListApplicationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AlliancePlayerApplicationInformationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AlliancePlayerNoApplicationInformationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceSubmitApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.application.AllianceUpdateApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.recruitment.AllianceGetRecruitmentInformationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.recruitment.AllianceRecruitmentInformationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.recruitment.AllianceRecruitmentInvalidateMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.recruitment.AllianceUpdateRecruitmentInformationMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.summary.AllianceSummaryMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.summary.AllianceSummaryRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.WarnOnPermaDeathMessage;
   import com.ankamagames.dofus.network.messages.game.friend.AcquaintanceAddedMessage;
   import com.ankamagames.dofus.network.messages.game.friend.AcquaintancesGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.AcquaintancesListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.ContactAddFailureMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendAddFailureMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendAddRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendAddedMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendDeleteRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendDeleteResultMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSetStatusShareMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSetWarnOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSetWarnOnLevelGainMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSpouseFollowWithCompassRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendSpouseJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendStatusShareStateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnConnectionStateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendWarnOnLevelGainStateMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendsGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.FriendsListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddFailureMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddedMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredDeleteRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredDeleteResultMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredGetListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredListMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseGetInformationsMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseInformationsMessage;
   import com.ankamagames.dofus.network.messages.game.friend.SpouseStatusMessage;
   import com.ankamagames.dofus.network.messages.game.friend.WarnOnPermaDeathStateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.CreateGuildRankRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildBulletinMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildBulletinSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildBulletinSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildChangeMemberParametersMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildCharacsUpgradeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildCreationResultMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildCreationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildFactsErrorMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildFactsMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildFactsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildGetInformationsMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildHouseRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildHouseUpdateInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildHousesInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsGeneralMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMemberUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMembersMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsPaddocksMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecrutedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecruterMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildJoinAutomaticallyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildJoinedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildKickRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildLeftMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberLeavingMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberOnlineStatusMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberStartWarnOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberStopWarnOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMembershipMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildModificationResultMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildModificationStartedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMotdMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMotdSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMotdSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockBoughtMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildPaddockTeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildRanksMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildRanksRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSpellUpgradeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSummaryMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSummaryRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.RemoveGuildRankRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.StartListenGuildChestStructureMessage;
   import com.ankamagames.dofus.network.messages.game.guild.StopListenGuildChestStructureMessage;
   import com.ankamagames.dofus.network.messages.game.guild.UpdateAllGuildRankRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.UpdateGuildRankRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.UpdateGuildRightsMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationIsAnsweredMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationListenMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationPresenceMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationReceivedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildDeleteApplicationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildGetPlayerApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildIsThereAnyApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildListApplicationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildListApplicationModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildListApplicationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildPlayerApplicationInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildPlayerNoApplicationInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildSubmitApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildUpdateApplicationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildUpdateNoteMessage;
   import com.ankamagames.dofus.network.messages.game.guild.logbook.GuildLogbookInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.logbook.GuildLogbookInformationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.recruitment.GuildRecruitmentInvalidateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.recruitment.RecruitmentInformationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.recruitment.UpdateRecruitmentInformationMessage;
   import com.ankamagames.dofus.network.messages.game.house.HouseTeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.UpdateSelfAgressableStatusMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookErrorMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchTagInformation;
   import com.ankamagames.dofus.network.types.game.alliance.AllianceMemberInfo;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceInformation;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceOnlineInformation;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildMemberInfo;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.rank.RankInformation;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformation;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.dofus.types.enums.EntityIconEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.filesystem.File;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SocialFrame implements Frame
   {
      
      private static const DATA_WARN_FRIEND_CONNECTION:String = "WarnFriendConnection";
      
      private static const DATA_WARN_FRIEND_LEVELUP:String = "WarnFriendLevelUp";
      
      private static const DATA_WARN_FRIEND_ACHIEVEMENT:String = "WarnFriendAchievement";
      
      private static const DATA_WARN_FRIEND_PERMA_DEATH:String = "WarnFriendPermaDeath";
      
      private static const DATA_FRIEND_SHARE_STATUS:String = "ShareStatusToFriends";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));
      
      private static var _instance:SocialFrame;
       
      
      private const ERROR_CHANNEL:Number = 666;
      
      private var _guildDialogFrame:GuildDialogFrame;
      
      private var _allianceDialogFrame:AllianceDialogFrame;
      
      private var _friendsList:Vector.<SocialCharacterWrapper>;
      
      private var _contactsList:Vector.<SocialCharacterWrapper>;
      
      private var _enemiesList:Vector.<SocialCharacterWrapper>;
      
      private var _ignoredList:Vector.<SocialCharacterWrapper>;
      
      private var _spouse:SpouseWrapper;
      
      private var _hasGuild:Boolean = false;
      
      private var _hasAlliance:Boolean = false;
      
      private var _hasSpouse:Boolean = false;
      
      private var _guild:GuildWrapper;
      
      private var _alliance:AllianceWrapper;
      
      private var _guildMembers:Vector.<GuildMemberInfo>;
      
      private var _allianceMembers:Vector.<AllianceMemberInfo>;
      
      private var _playerGuildRank:RankInformation;
      
      private var _playerAllianceRank:RankInformation;
      
      private var _guildRanks:Dictionary;
      
      private var _guildRanksSorted:Vector.<RankInformation>;
      
      private var _allianceRanks:Dictionary;
      
      private var _allianceRanksSorted:Vector.<RankInformation>;
      
      private var _guildHouses:Vector.<GuildHouseWrapper>;
      
      private var _guildHousesList:Boolean = false;
      
      private var _guildHousesListUpdate:Boolean = false;
      
      private var _guildPaddocks:Vector.<PaddockContentInformations>;
      
      private var _guildPaddocksMax:int = 1;
      
      private var _rankIconIds:Vector.<uint>;
      
      private var _rankIconUri:Dictionary;
      
      private var _shareStatus:Boolean = true;
      
      private var _warnOnFrienConnec:Boolean;
      
      private var _warnOnGuildMemberConnection:Boolean;
      
      private var _warnOnAllianceMemberConnection:Boolean;
      
      private var _warnWhenFriendOrGuildMemberLvlUp:Boolean;
      
      private var _warnWhenFriendOrGuildMemberAchieve:Boolean;
      
      private var _warnOnHardcoreDeath:Boolean;
      
      private var _allGuilds:Dictionary;
      
      private var _allAlliances:Dictionary;
      
      private var _allAlliancesFactSheets:Dictionary;
      
      public function SocialFrame()
      {
         this._guildRanks = new Dictionary(true);
         this._guildRanksSorted = new Vector.<RankInformation>();
         this._allianceRanks = new Dictionary(true);
         this._allianceRanksSorted = new Vector.<RankInformation>();
         this._guildHouses = new Vector.<GuildHouseWrapper>();
         this._guildPaddocks = new Vector.<PaddockContentInformations>();
         this._rankIconIds = new Vector.<uint>();
         this._rankIconUri = new Dictionary();
         this._allGuilds = new Dictionary(true);
         this._allAlliances = new Dictionary(true);
         this._allAlliancesFactSheets = new Dictionary(true);
         super();
      }
      
      public static function getInstance() : SocialFrame
      {
         return _instance;
      }
      
      private static function displayEgoError() : void
      {
         var reason:String = I18n.getUiText("ui.social.friend.addFailureEgocentric");
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         KernelEventsManager.getInstance().processCallback(SocialHookList.FailInvitation,reason);
      }
      
      private static function displayNotFoundError() : void
      {
         var reason:String = I18n.getUiText("ui.social.friend.addFailureNotFound");
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
         KernelEventsManager.getInstance().processCallback(SocialHookList.FailInvitation,reason);
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get friendsList() : Vector.<SocialCharacterWrapper>
      {
         return this._friendsList;
      }
      
      public function get contactsList() : Vector.<SocialCharacterWrapper>
      {
         return this._contactsList;
      }
      
      public function get enemiesList() : Vector.<SocialCharacterWrapper>
      {
         return this._enemiesList;
      }
      
      public function get ignoredList() : Vector.<SocialCharacterWrapper>
      {
         return this._ignoredList;
      }
      
      public function get spouse() : SpouseWrapper
      {
         return this._spouse;
      }
      
      public function get hasGuild() : Boolean
      {
         return this._hasGuild;
      }
      
      public function get hasSpouse() : Boolean
      {
         return this._hasSpouse;
      }
      
      public function get guild() : GuildWrapper
      {
         return this._guild;
      }
      
      public function get guildmembers() : Vector.<GuildMemberInfo>
      {
         return this._guildMembers;
      }
      
      public function get alliancemembers() : Vector.<AllianceMemberInfo>
      {
         return this._allianceMembers;
      }
      
      public function get guildHouses() : Vector.<GuildHouseWrapper>
      {
         return this._guildHouses;
      }
      
      public function get guildPaddocks() : Vector.<PaddockContentInformations>
      {
         return this._guildPaddocks;
      }
      
      public function get maxGuildPaddocks() : int
      {
         return this._guildPaddocksMax;
      }
      
      public function get warnFriendConnec() : Boolean
      {
         return this._warnOnFrienConnec;
      }
      
      public function get shareStatus() : Boolean
      {
         return this._shareStatus;
      }
      
      public function get warnGuildMemberConnection() : Boolean
      {
         return this._warnOnGuildMemberConnection;
      }
      
      public function set warnGuildMemberConnection(value:Boolean) : void
      {
         this._warnOnGuildMemberConnection = value;
      }
      
      public function get warnAllianceMemberConnection() : Boolean
      {
         return this._warnOnAllianceMemberConnection;
      }
      
      public function set warnAllianceMemberConnection(value:Boolean) : void
      {
         this._warnOnAllianceMemberConnection = value;
      }
      
      public function get warnWhenFriendOrGuildMemberLvlUp() : Boolean
      {
         return this._warnWhenFriendOrGuildMemberLvlUp;
      }
      
      public function get warnWhenFriendOrGuildMemberAchieve() : Boolean
      {
         return this._warnWhenFriendOrGuildMemberAchieve;
      }
      
      public function get warnOnHardcoreDeath() : Boolean
      {
         return this._warnOnHardcoreDeath;
      }
      
      public function get guildHousesUpdateNeeded() : Boolean
      {
         return this._guildHousesListUpdate;
      }
      
      public function getGuildRankById(id:uint) : RankInformation
      {
         return this._guildRanks[id];
      }
      
      public function getAllianceRankById(id:uint) : RankInformation
      {
         return this._allianceRanks[id];
      }
      
      public function getGuildRanks() : Vector.<RankInformation>
      {
         return this._guildRanksSorted;
      }
      
      public function getAllianceRanks() : Vector.<RankInformation>
      {
         return this._allianceRanksSorted;
      }
      
      public function getRanksIconIds() : Vector.<uint>
      {
         return this._rankIconIds;
      }
      
      public function get playerGuildRank() : RankInformation
      {
         return this._playerGuildRank;
      }
      
      public function get playerAllianceRank() : RankInformation
      {
         return this._playerAllianceRank;
      }
      
      public function get hasAlliance() : Boolean
      {
         return this._hasAlliance;
      }
      
      public function get alliance() : AllianceWrapper
      {
         return this._alliance;
      }
      
      public function getAllianceById(id:uint) : AllianceWrapper
      {
         var aw:AllianceWrapper = this._allAlliances[id];
         if(!aw)
         {
            aw = AllianceWrapper.getAllianceById(id);
         }
         return aw;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._enemiesList = new Vector.<SocialCharacterWrapper>();
         this._ignoredList = new Vector.<SocialCharacterWrapper>();
         this._guildDialogFrame = new GuildDialogFrame();
         this._allianceDialogFrame = new AllianceDialogFrame();
         ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
         ConnectionsHandler.getConnection().send(new AcquaintancesGetListMessage());
         ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
         ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
         ConnectionsHandler.getConnection().send(new GuildGetInformationsMessage().initGuildGetInformationsMessage(GuildInformationsTypeEnum.INFO_MEMBERS));
         ConnectionsHandler.getConnection().send(new GuildGetPlayerApplicationMessage());
         ConnectionsHandler.getConnection().send(new GuildRanksRequestMessage());
         ConnectionsHandler.getConnection().send(new AllianceGetPlayerApplicationMessage());
         ConnectionsHandler.getConnection().send(new AllianceRanksRequestMessage());
         this.enableAchievementWarn(StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_ACHIEVEMENT,false));
         this.enableFriendConnectionWarn(StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_CONNECTION,false));
         this.enableLevelupWarn(StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_LEVELUP,false));
         this.enablePermaDeathWarn(StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_PERMA_DEATH,false));
         this.enableShareStatusToFriends(StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_FRIEND_SHARE_STATUS,false));
         this.fillRanksIconsList();
         return true;
      }
      
      private function fillRanksIconsList() : void
      {
         var file:File = null;
         var iconId:uint = 0;
         var excludedIcons:Array = [116,117];
         var dir:File = new Uri(XmlConfig.getInstance().getEntry("config.gfx.path") + "guildRanks/").toFile();
         for each(file in dir.getDirectoryListing())
         {
            if(file.nativePath.indexOf(".png") != -1)
            {
               iconId = parseInt(file.name.split(".")[0]);
               if(excludedIcons.indexOf(iconId) == -1)
               {
                  this._rankIconIds.push(iconId);
                  this._rankIconUri[iconId] = new Uri(file.nativePath);
               }
            }
         }
         this._rankIconIds.sort(Array.NUMERIC);
      }
      
      public function getRankIconUriById(id:uint) : Uri
      {
         return this._rankIconUri[id];
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         AllianceWrapper.clearCache();
         GuildWrapper.clearCache();
         SocialEntitiesManager.getInstance().destroy();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var reason:String = null;
         var foi:FriendOnlineInformations = null;
         var aoi:AcquaintanceOnlineInformation = null;
         var notificationId:uint = 0;
         var rank:RankInformation = null;
         var errorMessage:String = null;
         var ds:DataStoreType = null;
         var friendWrapper:FriendWrapper = null;
         var gmmsg:GuildMembershipMessage = null;
         var flmsg:FriendsListMessage = null;
         var almsg:AcquaintancesListMessage = null;
         var sra:SpouseRequestAction = null;
         var simsg:SpouseInformationsMessage = null;
         var ilmsg:IgnoredListMessage = null;
         var osa:OpenSocialAction = null;
         var afa:AddFriendAction = null;
         var famsg:FriendAddedMessage = null;
         var friendToAdd:FriendWrapper = null;
         var isAlreadyMyFriend:Boolean = false;
         var aamsg:AcquaintanceAddedMessage = null;
         var contactToAdd:ContactWrapper = null;
         var aea:AddEnemyAction = null;
         var iamsg:IgnoredAddedMessage = null;
         var rfa:RemoveFriendAction = null;
         var fdrqmsg:FriendDeleteRequestMessage = null;
         var fdrmsg:FriendDeleteResultMessage = null;
         var fumsg:FriendUpdateMessage = null;
         var friendToUpdate:FriendWrapper = null;
         var friendAlreadyInGame:Boolean = false;
         var rea:RemoveEnemyAction = null;
         var idrqmsg:IgnoredDeleteRequestMessage = null;
         var idrmsg:IgnoredDeleteResultMessage = null;
         var aiga:AddIgnoredAction = null;
         var ria:RemoveIgnoredAction = null;
         var idrq2msg:IgnoredDeleteRequestMessage = null;
         var jfa:JoinFriendAction = null;
         var fjrmsg:FriendJoinRequestMessage = null;
         var player_FJRMSG:PlayerSearchCharacterNameInformation = null;
         var fsfa:FriendSpouseFollowAction = null;
         var fsfwcmsg:FriendSpouseFollowWithCompassRequestMessage = null;
         var sssa:StatusShareSetAction = null;
         var fwsa:FriendWarningSetAction = null;
         var gmwsa:GuildMemberWarningSetAction = null;
         var amwsa:AllianceMemberWarningSetAction = null;
         var fogmwsa:FriendOrGuildMemberLevelUpWarningSetAction = null;
         var fgswoaca:FriendGuildSetWarnOnAchievementCompleteAction = null;
         var wohda:WarnOnHardcoreDeathAction = null;
         var ssmsg:SpouseStatusMessage = null;
         var msumsg:MoodSmileyUpdateMessage = null;
         var fsssmsg:FriendStatusShareStateMessage = null;
         var fwocsmsg:FriendWarnOnConnectionStateMessage = null;
         var gmosm:GuildMemberOnlineStatusMessage = null;
         var amosm:AllianceMemberOnlineStatusMessage = null;
         var fwolgsmsg:FriendWarnOnLevelGainStateMessage = null;
         var fgwoacsmsg:FriendGuildWarnOnAchievementCompleteStateMessage = null;
         var wopdsmsg:WarnOnPermaDeathStateMessage = null;
         var gimmsg:GuildInformationsMembersMessage = null;
         var ghimsg:GuildHousesInformationMessage = null;
         var gmsmsg:GuildModificationStartedMessage = null;
         var gcrmsg:GuildCreationResultMessage = null;
         var gmrmsg:GuildModificationResultMessage = null;
         var gimsg:GuildInvitedMessage = null;
         var gisrermsg:GuildInvitationStateRecruterMessage = null;
         var gisredmsg:GuildInvitationStateRecrutedMessage = null;
         var gjmsg:GuildJoinedMessage = null;
         var joinMessage:String = null;
         var seasonId:int = 0;
         var gigmsg:GuildInformationsGeneralMessage = null;
         var gimumsg:GuildInformationsMemberUpdateMessage = null;
         var member:GuildMemberInfo = null;
         var memberRank:RankInformation = null;
         var gmlmsg:GuildMemberLeavingMessage = null;
         var comptgm:uint = 0;
         var gifmsg:GuildInformationsPaddocksMessage = null;
         var gpbmsg:GuildPaddockBoughtMessage = null;
         var gprmsg:GuildPaddockRemovedMessage = null;
         var clmsg:ContactLookMessage = null;
         var ggia:GuildGetInformationsAction = null;
         var askInformation:Boolean = false;
         var gia:GuildInvitationAction = null;
         var ginvitationmsg:GuildInvitationMessage = null;
         var gdarmsg:GuildDeleteApplicationRequestMessage = null;
         var gadm:GuildApplicationDeletedMessage = null;
         var gjra:GuildJoinRequestAction = null;
         var gjarmsg:GuildJoinAutomaticallyRequestMessage = null;
         var gsaa:GuildSubmitApplicationAction = null;
         var gsamsg:GuildSubmitApplicationMessage = null;
         var guaa:GuildUpdateApplicationAction = null;
         var guamsg:GuildUpdateApplicationMessage = null;
         var gaiamsg:GuildApplicationIsAnsweredMessage = null;
         var garmsg:GuildApplicationReceivedMessage = null;
         var gkra:GuildKickRequestAction = null;
         var gkrmsg:GuildKickRequestMessage = null;
         var gcmpa:GuildChangeMemberParametersAction = null;
         var gcmpmsg:GuildChangeMemberParametersMessage = null;
         var gsura:GuildSpellUpgradeRequestAction = null;
         var gsurmsg:GuildSpellUpgradeRequestMessage = null;
         var gcura:GuildCharacsUpgradeRequestAction = null;
         var gcurmsg:GuildCharacsUpgradeRequestMessage = null;
         var gftra:GuildFarmTeleportRequestAction = null;
         var gftrmsg:GuildPaddockTeleportRequestMessage = null;
         var ghtra:HouseTeleportRequestAction = null;
         var ghtrmsg:HouseTeleportRequestMessage = null;
         var galmsg:GuildApplicationListenMessage = null;
         var gitaamsg:GuildIsThereAnyApplicationMessage = null;
         var gataamsg:GuildApplicationPresenceMessage = null;
         var garaction:GuildApplicationsRequestAction = null;
         var glarmsg:GuildListApplicationRequestMessage = null;
         var glaamsg:GuildListApplicationAnswerMessage = null;
         var guildApplicationDescrs:Vector.<SocialApplicationWrapper> = null;
         var guildApplicationReplyAction:GuildApplicationReplyAction = null;
         var guildApplicationAnswerMessage:GuildApplicationAnswerMessage = null;
         var glammsg:GuildListApplicationModifiedMessage = null;
         var gsra:GuildSummaryRequestAction = null;
         var gsrm:GuildSummaryRequestMessage = null;
         var gsm:GuildSummaryMessage = null;
         var guildWrapper:GuildWrapper = null;
         var allGuildsInDirectory:Vector.<SocialGroupWrapper> = null;
         var ggpam:GuildGetPlayerApplicationMessage = null;
         var gpaim:GuildPlayerApplicationInformationMessage = null;
         var gnuaction:GuildNoteUpdateAction = null;
         var gunmsg:GuildUpdateNoteMessage = null;
         var gfra:GuildFactsRequestAction = null;
         var gfrmsg:GuildFactsRequestMessage = null;
         var gfmsg:GuildFactsMessage = null;
         var guildSheet:GuildFactSheetWrapper = null;
         var guildUpEmblem:EmblemWrapper = null;
         var guildBackEmblem:EmblemWrapper = null;
         var gmsra:GuildMotdSetRequestAction = null;
         var gmsrmsg:GuildMotdSetRequestMessage = null;
         var gmomsg:GuildMotdMessage = null;
         var guildMotdContent:String = null;
         var pattern:RegExp = null;
         var motdContent:Array = null;
         var gmosemsg:GuildMotdSetErrorMessage = null;
         var gbsra:GuildBulletinSetRequestAction = null;
         var gbsrmsg:GuildBulletinSetRequestMessage = null;
         var gbomsg:GuildBulletinMessage = null;
         var guildBulletinContent:String = null;
         var bulletinContent:Array = null;
         var gbosemsg:GuildBulletinSetErrorMessage = null;
         var psum:PlayerStatusUpdateMessage = null;
         var message:String = null;
         var psura:PlayerStatusUpdateRequestAction = null;
         var status:PlayerStatus = null;
         var psurmsg:PlayerStatusUpdateRequestMessage = null;
         var clrbia:ContactLookRequestByIdAction = null;
         var recruitmentData:GuildRecruitmentDataWrapper = null;
         var newRecruitmentData:GuildRecruitmentDataWrapper = null;
         var urimsg:UpdateRecruitmentInformationMessage = null;
         var grrm:GuildRanksRequestMessage = null;
         var grm:GuildRanksMessage = null;
         var lastRankCount:uint = 0;
         var cgrra:CreateGuildRankRequestAction = null;
         var cgrrm:CreateGuildRankRequestMessage = null;
         var uagrra:UpdateAllGuildRankRequestAction = null;
         var uagrrm:UpdateAllGuildRankRequestMessage = null;
         var ugrra:UpdateGuildRankRequestAction = null;
         var ugrrm:UpdateGuildRankRequestMessage = null;
         var ugra:UpdateGuildRightsAction = null;
         var ugrm:UpdateGuildRightsMessage = null;
         var rgrra:RemoveGuildRankRequestAction = null;
         var rgrrm:RemoveGuildRankRequestMessage = null;
         var glbrmsg:GuildLogbookInformationRequestMessage = null;
         var glbimsg:GuildLogbookInformationMessage = null;
         var slgcsm:StartListenGuildChestStructureMessage = null;
         var splgcsm:StopListenGuildChestStructureMessage = null;
         var agrimsg:AllianceGetRecruitmentInformationMessage = null;
         var amsmsg:AllianceModificationStartedMessage = null;
         var acrmsg:AllianceCreationResultMessage = null;
         var amrmsg:AllianceModificationResultMessage = null;
         var ammsg:AllianceMembershipMessage = null;
         var agpam:AllianceGetPlayerApplicationMessage = null;
         var apaim:AlliancePlayerApplicationInformationMessage = null;
         var aia:AllianceInvitationAction = null;
         var aimsg:AllianceInvitationMessage = null;
         var adarmsg:AllianceDeleteApplicationRequestMessage = null;
         var aadm:AllianceApplicationDeletedMessage = null;
         var aaiamsg:AllianceApplicationIsAnsweredMessage = null;
         var aarmsg:AllianceApplicationReceivedMessage = null;
         var timeApi:TimeApi = null;
         var ajra:AllianceJoinRequestAction = null;
         var ajarmsg:AllianceJoinAutomaticallyRequestMessage = null;
         var asaa:AllianceSubmitApplicationAction = null;
         var asamsg:AllianceSubmitApplicationMessage = null;
         var auaa:AllianceUpdateApplicationAction = null;
         var auamsg:AllianceUpdateApplicationMessage = null;
         var aidmsg:AllianceInvitedMessage = null;
         var aisrermsg:AllianceInvitationStateRecruterMessage = null;
         var aisredmsg:AllianceInvitationStateRecrutedMessage = null;
         var ajmsg:AllianceJoinedMessage = null;
         var alliancejoinMessage:String = null;
         var akra:AllianceKickRequestAction = null;
         var akrmsg:AllianceKickRequestMessage = null;
         var acmra:AllianceChangeMemberRankAction = null;
         var acmrmsg:AllianceChangeMemberRankMessage = null;
         var amiumsg:AllianceMemberInformationUpdateMessage = null;
         var alliMember:AllianceMemberInfo = null;
         var amlmsg:AllianceMemberLeavingMessage = null;
         var comptam:uint = 0;
         var rpFrame:RoleplayEntitiesFrame = null;
         var afra:AllianceFactsRequestAction = null;
         var afrmsg:AllianceFactsRequestMessage = null;
         var afmsg:AllianceFactsMessage = null;
         var allianceSheet:AllianceFactSheetWrapper = null;
         var allianceUpEmblem:EmblemWrapper = null;
         var allianceBackEmblem:EmblemWrapper = null;
         var aalmsg:AllianceApplicationListenMessage = null;
         var aitaamsg:AllianceIsThereAnyApplicationMessage = null;
         var aataamsg:AllianceApplicationPresenceMessage = null;
         var aaraction:AllianceApplicationsRequestAction = null;
         var alarmsg:AllianceListApplicationRequestMessage = null;
         var alaamsg:AllianceListApplicationAnswerMessage = null;
         var alliApplicationDescrs:Vector.<SocialApplicationWrapper> = null;
         var aara:AllianceApplicationReplyAction = null;
         var aaamsg:AllianceApplicationAnswerMessage = null;
         var alammsg:AllianceListApplicationModifiedMessage = null;
         var asra:AllianceSummaryRequestAction = null;
         var asrmsg:AllianceSummaryRequestMessage = null;
         var asmsg:AllianceSummaryMessage = null;
         var allianceWrapper:AllianceWrapper = null;
         var allAlliancesInDirectory:Vector.<SocialGroupWrapper> = null;
         var aiirmsg:AllianceInsiderInfoRequestMessage = null;
         var aiimsg:AllianceInsiderInfoMessage = null;
         var prismIdsList:Vector.<uint> = null;
         var allianceRecruitmentData:AllianceRecruitmentDataWrapper = null;
         var newAllianceRecruitmentData:AllianceRecruitmentDataWrapper = null;
         var aurimsg:AllianceUpdateRecruitmentInformationMessage = null;
         var arrm:AllianceRanksRequestMessage = null;
         var arm:AllianceRanksMessage = null;
         var lastAllianceRankCount:uint = 0;
         var arcra:AllianceRankCreateRequestAction = null;
         var arcrm:AllianceRankCreateRequestMessage = null;
         var aarura:AllianceAllRanksUpdateRequestAction = null;
         var aarurm:AllianceAllRanksUpdateRequestMessage = null;
         var arura:AllianceRankUpdateRequestAction = null;
         var arurm:AllianceRankUpdateRequestMessage = null;
         var arrra:AllianceRankRemoveRequestAction = null;
         var arrrm:AllianceRankRemoveRequestMessage = null;
         var arua:AllianceRightsUpdateAction = null;
         var arum:AllianceRightsUpdateMessage = null;
         var amsra:AllianceMotdSetRequestAction = null;
         var amsrmsg:AllianceMotdSetRequestMessage = null;
         var amomsg:AllianceMotdMessage = null;
         var allianceMotdContent:String = null;
         var allianceMotdPattern:RegExp = null;
         var allianceMotd:Array = null;
         var amosemsg:AllianceMotdSetErrorMessage = null;
         var motdErrorReason:String = null;
         var absra:AllianceBulletinSetRequestAction = null;
         var absrmsg:AllianceBulletinSetRequestMessage = null;
         var abomsg:AllianceBulletinMessage = null;
         var allianceBulletinContent:String = null;
         var allianceBulletinContents:Array = null;
         var abosemsg:AllianceBulletinSetErrorMessage = null;
         var f:FriendInformations = null;
         var fw:FriendWrapper = null;
         var a:AcquaintanceInformation = null;
         var cw:ContactWrapper = null;
         var i:* = undefined;
         var ew:EnemyWrapper = null;
         var ioi:IgnoredOnlineInformations = null;
         var farmsg:FriendAddRequestMessage = null;
         var friendW:FriendWrapper = null;
         var contactIndex:* = undefined;
         var iarmsg:IgnoredAddRequestMessage = null;
         var enemyToAdd:EnemyWrapper = null;
         var ignored:* = undefined;
         var output:String = null;
         var fd:* = undefined;
         var ct:* = undefined;
         var frd:* = undefined;
         var ed:* = undefined;
         var il:* = undefined;
         var ignoredAdd:* = undefined;
         var iar2msg:IgnoredAddRequestMessage = null;
         var gmswocmsg:GuildMemberStartWarnOnConnectionMessage = null;
         var gmstwocmsg:GuildMemberStopWarnOnConnectionMessage = null;
         var amswocmsg:AllianceMemberStartWarningOnConnectionMessage = null;
         var amstwocmsg:AllianceMemberStopWarningOnConnectionMessage = null;
         var memberInfo:GuildMemberInfo = null;
         var nm:int = 0;
         var imood:int = 0;
         var frdmood:FriendWrapper = null;
         var cttmood:ContactWrapper = null;
         var guildMemberName:String = null;
         var gm:GuildMemberInfo = null;
         var allianceMemberName:String = null;
         var allianceMemberInfo:AllianceMemberInfo = null;
         var mb:GuildMemberInfo = null;
         var houseInformation:HouseInformationsForGuild = null;
         var ghw:GuildHouseWrapper = null;
         var nmu:int = 0;
         var k:int = 0;
         var guildMember:GuildMemberInfo = null;
         var ggimsg:GuildGetInformationsMessage = null;
         var filters:Object = null;
         var guildApplicationInfo:SocialApplicationInformation = null;
         var guildFactInfo:GuildFactSheetInformations = null;
         var ghuimsg:GuildHouseUpdateInformationMessage = null;
         var toUpdate:Boolean = false;
         var house1:GuildHouseWrapper = null;
         var ghw1:GuildHouseWrapper = null;
         var ghrmsg:GuildHouseRemoveMessage = null;
         var iGHR:int = 0;
         var textMotd:String = null;
         var members:GuildMemberInfo = null;
         var snm:int = 0;
         var istatus:int = 0;
         var frdstatus:FriendWrapper = null;
         var ctcStatus:ContactWrapper = null;
         var clrbim:ContactLookRequestByIdMessage = null;
         var guildRankInfo:RankInformation = null;
         var guildRankData:GuildRank = null;
         var nbMembers:int = 0;
         var j:int = 0;
         var allianceMember:AllianceMemberInfo = null;
         var pid:Number = NaN;
         var usasmsg:UpdateSelfAgressableStatusMessage = null;
         var alliApplicationInfo:SocialApplicationInformation = null;
         var alliFactInfo:AllianceFactSheetInformation = null;
         var insPrism:PrismGeolocalizedInformation = null;
         var rankInfo:RankInformation = null;
         var rankData:AllianceRank = null;
         var allianceMotdText:String = null;
         var isAFriend:Boolean = false;
         switch(true)
         {
            case msg is GuildMembershipMessage:
               gmmsg = msg as GuildMembershipMessage;
               rank = this.getGuildRankById(gmmsg.rankId);
               if(this._guild != null)
               {
                  this._guild.update(gmmsg.guildInfo.guildId,gmmsg.guildInfo.guildName,gmmsg.guildInfo.guildEmblem);
               }
               else
               {
                  this._guild = GuildWrapper.create(gmmsg.guildInfo.guildId,gmmsg.guildInfo.guildName,gmmsg.guildInfo.guildEmblem);
               }
               this._hasGuild = true;
               this._playerGuildRank = rank;
               Kernel.getWorker().process(GuildMemberWarningSetAction.create(StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,"warnGuildMemberConnection" + PlayedCharacterManager.getInstance().id)));
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               return true;
            case msg is FriendsListMessage:
               flmsg = msg as FriendsListMessage;
               this._friendsList = new Vector.<SocialCharacterWrapper>();
               for each(f in flmsg.friendsList)
               {
                  if(f is FriendOnlineInformations)
                  {
                     foi = f as FriendOnlineInformations;
                     AccountManager.getInstance().setAccount(foi.playerName,foi.accountId,foi.accountTag.nickname,foi.accountTag.tagNumber);
                     ChatAutocompleteNameManager.getInstance().addEntry(foi.playerName,2);
                  }
                  fw = new FriendWrapper(f);
                  this._friendsList.push(fw);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case msg is AcquaintancesListMessage:
               almsg = msg as AcquaintancesListMessage;
               this._contactsList = new Vector.<SocialCharacterWrapper>();
               for each(a in almsg.acquaintanceList)
               {
                  if(a is AcquaintanceOnlineInformation)
                  {
                     aoi = a as AcquaintanceOnlineInformation;
                     AccountManager.getInstance().setAccount(aoi.playerName,aoi.accountId,aoi.accountTag.nickname,aoi.accountTag.tagNumber);
                     ChatAutocompleteNameManager.getInstance().addEntry(aoi.playerName,2);
                  }
                  cw = new ContactWrapper(a);
                  this._contactsList.push(cw);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
               return true;
            case msg is SpouseRequestAction:
               sra = msg as SpouseRequestAction;
               ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
               return true;
            case msg is SpouseInformationsMessage:
               simsg = msg as SpouseInformationsMessage;
               this._spouse = new SpouseWrapper(simsg.spouse);
               this._hasSpouse = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case msg is IgnoredListMessage:
               this._enemiesList = new Vector.<SocialCharacterWrapper>();
               ilmsg = msg as IgnoredListMessage;
               for each(i in ilmsg.ignoredList)
               {
                  if(i is IgnoredOnlineInformations)
                  {
                     ioi = i as IgnoredOnlineInformations;
                     AccountManager.getInstance().setAccount(ioi.playerName,ioi.accountId,ioi.accountTag.nickname,ioi.accountTag.tagNumber);
                  }
                  ew = new EnemyWrapper(i);
                  this._enemiesList.push(ew);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               return true;
            case msg is OpenSocialAction:
               osa = msg as OpenSocialAction;
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,osa.id);
               return true;
            case msg is OpenGuildPrezAndRecruitAction:
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPrezAndRecruitUiRequested);
               return true;
            case msg is OpenAlliancePrezAndRecruitAction:
               KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePrezAndRecruitUiRequested);
               return true;
            case msg is FriendsListRequestAction:
               ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
               return true;
            case msg is ContactsListRequestAction:
               ConnectionsHandler.getConnection().send(new AcquaintancesGetListMessage());
               return true;
            case msg is EnemiesListRequestAction:
               ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
               return true;
            case msg is AddFriendAction:
               afa = msg as AddFriendAction;
               if(!this.isLenghtCorrect(afa.name,afa.tag))
               {
                  displayNotFoundError();
               }
               else if(this.isMe(afa.name,afa.tag))
               {
                  displayEgoError();
               }
               else
               {
                  farmsg = new FriendAddRequestMessage();
                  farmsg.initFriendAddRequestMessage(this.createAbstractPlayerSearchInformation(afa.name,afa.tag));
                  ConnectionsHandler.getConnection().send(farmsg);
               }
               return true;
            case msg is FriendAddedMessage:
               famsg = msg as FriendAddedMessage;
               if(famsg.friendAdded is FriendOnlineInformations)
               {
                  foi = famsg.friendAdded as FriendOnlineInformations;
                  AccountManager.getInstance().setAccount(foi.playerName,foi.accountId,foi.accountTag.nickname,foi.accountTag.tagNumber);
                  ChatAutocompleteNameManager.getInstance().addEntry(foi.playerName,2);
               }
               friendToAdd = new FriendWrapper(famsg.friendAdded);
               isAlreadyMyFriend = false;
               for each(friendW in this._friendsList)
               {
                  if(friendW.accountId == friendToAdd.accountId)
                  {
                     isAlreadyMyFriend = true;
                     break;
                  }
               }
               for(contactIndex in this._contactsList)
               {
                  if(this._contactsList[contactIndex].name == friendToAdd.name && this._contactsList[contactIndex].tag == friendToAdd.tag)
                  {
                     this._contactsList.splice(contactIndex,1);
                     KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                     break;
                  }
               }
               if(!isAlreadyMyFriend)
               {
                  this._friendsList.push(friendToAdd);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case msg is AcquaintanceAddedMessage:
               aamsg = msg as AcquaintanceAddedMessage;
               if(aamsg.acquaintanceAdded is AcquaintanceOnlineInformation)
               {
                  aoi = aamsg.acquaintanceAdded as AcquaintanceOnlineInformation;
                  AccountManager.getInstance().setAccount(aoi.playerName,aoi.accountId,aoi.accountTag.nickname,aoi.accountTag.tagNumber);
                  ChatAutocompleteNameManager.getInstance().addEntry(aoi.playerName,2);
               }
               contactToAdd = new ContactWrapper(aamsg.acquaintanceAdded);
               this._contactsList.push(contactToAdd);
               KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
               return true;
            case msg is FriendAddFailureMessage:
               this.displayError((msg as FriendAddFailureMessage).reason);
               return true;
            case msg is ContactAddFailureMessage:
               this.displayError((msg as ContactAddFailureMessage).reason);
               return true;
            case msg is IgnoredAddFailureMessage:
               this.displayError((msg as IgnoredAddFailureMessage).reason);
               return true;
            case msg is AddEnemyAction:
               aea = msg as AddEnemyAction;
               if(!this.isLenghtCorrect(aea.name,aea.tag))
               {
                  displayNotFoundError();
               }
               else if(this.isMe(aea.tag,aea.name))
               {
                  displayEgoError();
               }
               else
               {
                  iarmsg = new IgnoredAddRequestMessage();
                  iarmsg.initIgnoredAddRequestMessage(this.createAbstractPlayerSearchInformation(aea.name,aea.tag));
                  ConnectionsHandler.getConnection().send(iarmsg);
               }
               return true;
            case msg is IgnoredAddedMessage:
               iamsg = msg as IgnoredAddedMessage;
               if(iamsg.ignoreAdded is IgnoredOnlineInformations)
               {
                  ioi = iamsg.ignoreAdded as IgnoredOnlineInformations;
                  AccountManager.getInstance().setAccount(ioi.playerName,ioi.accountId,ioi.accountTag.nickname,ioi.accountTag.tagNumber);
               }
               if(!iamsg.session)
               {
                  enemyToAdd = new EnemyWrapper(iamsg.ignoreAdded);
                  this._enemiesList.push(enemyToAdd);
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               }
               else
               {
                  for each(ignored in this._ignoredList)
                  {
                     if(ignored.name == iamsg.ignoreAdded.accountTag.nickname)
                     {
                        return true;
                     }
                  }
                  this._ignoredList.push(new IgnoredWrapper(iamsg.ignoreAdded.accountTag.nickname,iamsg.ignoreAdded.accountTag.tagNumber,iamsg.ignoreAdded.accountId));
                  KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredListUpdated);
               }
               return true;
            case msg is RemoveFriendAction:
               rfa = msg as RemoveFriendAction;
               fdrqmsg = new FriendDeleteRequestMessage();
               fdrqmsg.initFriendDeleteRequestMessage(rfa.accountId);
               ConnectionsHandler.getConnection().send(fdrqmsg);
               return true;
            case msg is FriendDeleteResultMessage:
               fdrmsg = msg as FriendDeleteResultMessage;
               if(fdrmsg.success)
               {
                  output = I18n.getUiText("ui.social.friend.delete",[PlayerManager.getInstance().formatTagName(fdrmsg.tag.nickname,fdrmsg.tag.tagNumber,null,false)]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,output,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
                  for(fd in this._friendsList)
                  {
                     if(this._friendsList[fd].name == fdrmsg.tag.nickname && this._friendsList[fd].tag == fdrmsg.tag.tagNumber)
                     {
                        this._friendsList.splice(fd,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        return true;
                     }
                  }
                  for(ct in this._contactsList)
                  {
                     if(this._contactsList[ct].name == fdrmsg.tag.nickname && this._contactsList[ct].tag == fdrmsg.tag.tagNumber)
                     {
                        this._contactsList.splice(ct,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                        return true;
                     }
                  }
               }
               return true;
            case msg is FriendUpdateMessage:
               fumsg = msg as FriendUpdateMessage;
               friendToUpdate = new FriendWrapper(fumsg.friendUpdated);
               for each(frd in this._friendsList)
               {
                  if(frd.name == friendToUpdate.name)
                  {
                     frd = friendToUpdate;
                     break;
                  }
               }
               friendAlreadyInGame = friendToUpdate.state == PlayerStateEnum.GAME_TYPE_ROLEPLAY || friendToUpdate.state == PlayerStateEnum.GAME_TYPE_FIGHT;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_CONNECTION) && this._warnOnFrienConnec && friendToUpdate.online && !friendAlreadyInGame)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.FRIEND_CONNECTION,[friendToUpdate.name,friendToUpdate.playerName,friendToUpdate.playerId]);
               }
               return true;
            case msg is RemoveEnemyAction:
               rea = msg as RemoveEnemyAction;
               idrqmsg = new IgnoredDeleteRequestMessage();
               idrqmsg.initIgnoredDeleteRequestMessage(rea.accountId);
               ConnectionsHandler.getConnection().send(idrqmsg);
               return true;
            case msg is IgnoredDeleteResultMessage:
               idrmsg = msg as IgnoredDeleteResultMessage;
               if(!idrmsg.session)
               {
                  if(idrmsg.success)
                  {
                     for(ed in this._enemiesList)
                     {
                        if(this._enemiesList[ed].name == idrmsg.tag.nickname && this._enemiesList[ed].tag == idrmsg.tag.tagNumber)
                        {
                           this._enemiesList.splice(ed,1);
                           KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                           return true;
                        }
                     }
                  }
               }
               else if(idrmsg.success)
               {
                  for(il in this._ignoredList)
                  {
                     if(this._ignoredList[il].name == idrmsg.tag.nickname && this._ignoredList[il].tag == idrmsg.tag.tagNumber)
                     {
                        this._ignoredList.splice(il,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredListUpdated);
                        return true;
                     }
                  }
               }
               return true;
            case msg is AddIgnoredAction:
               aiga = msg as AddIgnoredAction;
               if(!this.isLenghtCorrect(aiga.name,aiga.tag))
               {
                  displayNotFoundError();
               }
               else if(this.isMe(aiga.name,aiga.tag))
               {
                  displayEgoError();
               }
               else
               {
                  for each(ignoredAdd in this._ignoredList)
                  {
                     if(ignoredAdd.playerName == aiga.name)
                     {
                        return true;
                     }
                  }
                  iar2msg = new IgnoredAddRequestMessage();
                  iar2msg.initIgnoredAddRequestMessage(this.createAbstractPlayerSearchInformation(aiga.name,aiga.tag),true);
                  ConnectionsHandler.getConnection().send(iar2msg);
               }
               return true;
            case msg is RemoveIgnoredAction:
               ria = msg as RemoveIgnoredAction;
               idrq2msg = new IgnoredDeleteRequestMessage();
               idrq2msg.initIgnoredDeleteRequestMessage(ria.accountId,true);
               ConnectionsHandler.getConnection().send(idrq2msg);
               return true;
            case msg is JoinFriendAction:
               jfa = msg as JoinFriendAction;
               fjrmsg = new FriendJoinRequestMessage();
               player_FJRMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(jfa.name);
               fjrmsg.initFriendJoinRequestMessage(player_FJRMSG);
               ConnectionsHandler.getConnection().send(fjrmsg);
               return true;
            case msg is JoinSpouseAction:
               ConnectionsHandler.getConnection().send(new FriendSpouseJoinRequestMessage());
               return true;
            case msg is FriendSpouseFollowAction:
               fsfa = msg as FriendSpouseFollowAction;
               fsfwcmsg = new FriendSpouseFollowWithCompassRequestMessage();
               fsfwcmsg.initFriendSpouseFollowWithCompassRequestMessage(fsfa.enable);
               ConnectionsHandler.getConnection().send(fsfwcmsg);
               return true;
            case msg is StatusShareSetAction:
               sssa = msg as StatusShareSetAction;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_FRIEND_SHARE_STATUS,sssa.enable);
               this.enableShareStatusToFriends(sssa.enable);
               return true;
            case msg is FriendWarningSetAction:
               fwsa = msg as FriendWarningSetAction;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_CONNECTION,fwsa.enable);
               this.enableFriendConnectionWarn(fwsa.enable);
               return true;
            case msg is GuildMemberWarningSetAction:
               gmwsa = msg as GuildMemberWarningSetAction;
               if(this._warnOnGuildMemberConnection == gmwsa.enable)
               {
                  return true;
               }
               this._warnOnGuildMemberConnection = gmwsa.enable;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,"warnGuildMemberConnection" + PlayedCharacterManager.getInstance().id,this._warnOnGuildMemberConnection);
               if(this._warnOnGuildMemberConnection)
               {
                  gmswocmsg = new GuildMemberStartWarnOnConnectionMessage();
                  gmswocmsg.initGuildMemberStartWarnOnConnectionMessage();
                  ConnectionsHandler.getConnection().send(gmswocmsg);
               }
               else
               {
                  gmstwocmsg = new GuildMemberStopWarnOnConnectionMessage();
                  gmstwocmsg.initGuildMemberStopWarnOnConnectionMessage();
                  ConnectionsHandler.getConnection().send(gmstwocmsg);
               }
               return true;
               break;
            case msg is AllianceMemberWarningSetAction:
               amwsa = msg as AllianceMemberWarningSetAction;
               if(this._warnOnAllianceMemberConnection == amwsa.enable)
               {
                  return true;
               }
               this._warnOnAllianceMemberConnection = amwsa.enable;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,"warnAllianceMemberConnection" + PlayedCharacterManager.getInstance().id,this._warnOnAllianceMemberConnection);
               if(this._warnOnAllianceMemberConnection)
               {
                  amswocmsg = new AllianceMemberStartWarningOnConnectionMessage();
                  amswocmsg.initAllianceMemberStartWarningOnConnectionMessage();
                  ConnectionsHandler.getConnection().send(amswocmsg);
               }
               else
               {
                  amstwocmsg = new AllianceMemberStopWarningOnConnectionMessage();
                  amstwocmsg.initAllianceMemberStopWarningOnConnectionMessage();
                  ConnectionsHandler.getConnection().send(amstwocmsg);
               }
               return true;
               break;
            case msg is FriendOrGuildMemberLevelUpWarningSetAction:
               fogmwsa = msg as FriendOrGuildMemberLevelUpWarningSetAction;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_LEVELUP,fogmwsa.enable);
               this.enableLevelupWarn(fogmwsa.enable);
               return true;
            case msg is FriendGuildSetWarnOnAchievementCompleteAction:
               fgswoaca = msg as FriendGuildSetWarnOnAchievementCompleteAction;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_ACHIEVEMENT,fgswoaca.enable);
               this.enableAchievementWarn(fgswoaca.enable);
               return true;
            case msg is WarnOnHardcoreDeathAction:
               wohda = msg as WarnOnHardcoreDeathAction;
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_OPTIONS,DATA_WARN_FRIEND_PERMA_DEATH,wohda.enable);
               this.enablePermaDeathWarn(wohda.enable);
               return true;
            case msg is SpouseStatusMessage:
               ssmsg = msg as SpouseStatusMessage;
               this._hasSpouse = ssmsg.hasSpouse;
               if(!this._hasSpouse)
               {
                  this._spouse = null;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated,false);
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_SPOUSE,-1);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case msg is MoodSmileyUpdateMessage:
               msumsg = msg as MoodSmileyUpdateMessage;
               if(this._guildMembers != null)
               {
                  nm = this._guildMembers.length;
                  for(imood = 0; imood < nm; imood++)
                  {
                     if(this._guildMembers[imood].id == msumsg.playerId)
                     {
                        this._guildMembers[imood].moodSmileyId = msumsg.smileyId;
                        memberInfo = this._guildMembers[imood];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,memberInfo);
                        break;
                     }
                  }
               }
               if(this._friendsList != null)
               {
                  for each(frdmood in this._friendsList)
                  {
                     if(frdmood.accountId == msumsg.accountId)
                     {
                        frdmood.moodSmileyId = msumsg.smileyId;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        break;
                     }
                  }
               }
               if(this._contactsList != null)
               {
                  for each(cttmood in this._contactsList)
                  {
                     if(cttmood.accountId == msumsg.accountId)
                     {
                        cttmood.moodSmileyId = msumsg.smileyId;
                        KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                        break;
                     }
                  }
               }
               return true;
            case msg is FriendStatusShareStateMessage:
               fsssmsg = msg as FriendStatusShareStateMessage;
               this._shareStatus = fsssmsg.share;
               KernelEventsManager.getInstance().processCallback(SocialHookList.ShareStatusState,fsssmsg.share);
               return true;
            case msg is FriendWarnOnConnectionStateMessage:
               fwocsmsg = msg as FriendWarnOnConnectionStateMessage;
               this._warnOnFrienConnec = fwocsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState,fwocsmsg.enable);
               return true;
            case msg is GuildMemberOnlineStatusMessage:
               if(!this._friendsList)
               {
                  return true;
               }
               gmosm = msg as GuildMemberOnlineStatusMessage;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION) && this._warnOnGuildMemberConnection && gmosm.online)
               {
                  for each(gm in this._guildMembers)
                  {
                     if(gm.id == gmosm.memberId)
                     {
                        guildMemberName = gm.name;
                        break;
                     }
                  }
                  for each(friendWrapper in this._friendsList)
                  {
                     if(friendWrapper.name == guildMemberName)
                     {
                        isAFriend = true;
                        break;
                     }
                  }
                  if(!(isAFriend && !ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.MEMBER_CONNECTION,[guildMemberName,gmosm.memberId]);
                  }
               }
               return true;
               break;
            case msg is AllianceMemberOnlineStatusMessage:
               if(!this._friendsList)
               {
                  return true;
               }
               amosm = msg as AllianceMemberOnlineStatusMessage;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION) && this._warnOnAllianceMemberConnection && amosm.online)
               {
                  for each(allianceMemberInfo in this._guildMembers)
                  {
                     if(allianceMemberInfo.id == amosm.memberId)
                     {
                        allianceMemberName = allianceMemberInfo.name;
                        break;
                     }
                  }
                  for each(friendWrapper in this._friendsList)
                  {
                     if(friendWrapper.name == allianceMemberName)
                     {
                        isAFriend = true;
                        break;
                     }
                  }
                  if(!(isAFriend && !ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.MEMBER_CONNECTION,[allianceMemberName,amosm.memberId]);
                  }
               }
               return true;
               break;
            case msg is FriendWarnOnLevelGainStateMessage:
               fwolgsmsg = msg as FriendWarnOnLevelGainStateMessage;
               this._warnWhenFriendOrGuildMemberLvlUp = fwolgsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState,fwolgsmsg.enable);
               return true;
            case msg is FriendGuildWarnOnAchievementCompleteStateMessage:
               fgwoacsmsg = msg as FriendGuildWarnOnAchievementCompleteStateMessage;
               this._warnWhenFriendOrGuildMemberAchieve = fgwoacsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendGuildWarnOnAchievementCompleteState,fgwoacsmsg.enable);
               return true;
            case msg is WarnOnPermaDeathStateMessage:
               wopdsmsg = msg as WarnOnPermaDeathStateMessage;
               this._warnOnHardcoreDeath = wopdsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.WarnOnHardcoreDeathState,wopdsmsg.enable);
               return true;
            case msg is GuildInformationsMembersMessage:
               gimmsg = msg as GuildInformationsMembersMessage;
               for each(mb in gimmsg.members)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry(mb.name,2);
               }
               this._guildMembers = gimmsg.members;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               return true;
            case msg is GuildHousesInformationMessage:
               ghimsg = msg as GuildHousesInformationMessage;
               this._guildHouses = new Vector.<GuildHouseWrapper>();
               for each(houseInformation in ghimsg.housesInformations)
               {
                  ghw = GuildHouseWrapper.create(houseInformation);
                  this._guildHouses.push(ghw);
               }
               this._guildHousesList = true;
               this._guildHousesListUpdate = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
               return true;
            case msg is GuildCreationStartedMessage:
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,false,false);
               return true;
            case msg is GuildModificationStartedMessage:
               gmsmsg = msg as GuildModificationStartedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,gmsmsg.canChangeName,gmsmsg.canChangeEmblem);
               return true;
            case msg is GuildCreationResultMessage:
               gcrmsg = msg as GuildCreationResultMessage;
               switch(gcrmsg.result)
               {
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_OPERATION_OK:
                     Kernel.getWorker().removeFrame(this._guildDialogFrame);
                     this._hasGuild = true;
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_INVALID:
                     errorMessage = I18n.getUiText("ui.guild.invalidName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_ALREADY_IN_GROUP:
                     errorMessage = I18n.getUiText("ui.guild.alreadyInGuild");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.guild.alreadyUsedName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_LEAVE:
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_CANCEL:
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_REQUIREMENT_UNMET:
                     errorMessage = I18n.getUiText("ui.social.requirementUnmet");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_UNKNOWN:
                     errorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult,gcrmsg.result);
               return true;
            case msg is GuildModificationResultMessage:
               gmrmsg = msg as GuildModificationResultMessage;
               switch(gmrmsg.result)
               {
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_OPERATION_OK:
                     Kernel.getWorker().removeFrame(this._guildDialogFrame);
                     this._hasGuild = true;
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_INVALID:
                     errorMessage = I18n.getUiText("ui.guild.invalidName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.guild.alreadyUsedName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_LEAVE:
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_CANCEL:
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_REQUIREMENT_UNMET:
                     errorMessage = I18n.getUiText("ui.social.requirementUnmet");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_UNKNOWN:
                     errorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildModificationResult,gmrmsg.result);
               return true;
            case msg is GuildInvitedMessage:
               gimsg = msg as GuildInvitedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited,gimsg.guildInfo,gimsg.recruterName);
               return true;
            case msg is GuildInvitationStateRecruterMessage:
               gisrermsg = msg as GuildInvitationStateRecruterMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruter,gisrermsg.invitationState,gisrermsg.recrutedName);
               if(gisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || gisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._guildDialogFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._guildDialogFrame);
               }
               return true;
            case msg is GuildInvitationStateRecrutedMessage:
               gisredmsg = msg as GuildInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted,gisredmsg.invitationState);
               if(gisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || gisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._guildDialogFrame);
               }
               return true;
            case msg is GuildJoinedMessage:
               gjmsg = msg as GuildJoinedMessage;
               rank = this.getGuildRankById(gjmsg.rankId);
               this._hasGuild = true;
               this._playerGuildRank = rank;
               this._guild = GuildWrapper.create(gjmsg.guildInfo.guildId,gjmsg.guildInfo.guildName,gjmsg.guildInfo.guildEmblem);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               joinMessage = I18n.getUiText("ui.guild.JoinGuildMessage",[gjmsg.guildInfo.guildName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,joinMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               seasonId = !!ServerSeason.getCurrentSeason() ? int(ServerSeason.getCurrentSeason().uid) : -1;
               if(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && seasonId == 14)
               {
                  notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.xpGuild"),I18n.getUiText("ui.social.modifyXpGuild"),NotificationTypeEnum.TUTORIAL,"temporisXpGuild_T" + seasonId);
                  NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.common.modify"),"OpenSocialAction",[DataEnum.SOCIAL_TAB_GUILD_ID]);
                  NotificationManager.getInstance().sendNotification(notificationId);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildJoined);
               return true;
            case msg is GuildInformationsGeneralMessage:
               gigmsg = msg as GuildInformationsGeneralMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral,gigmsg.expLevelFloor,gigmsg.experience,gigmsg.expNextLevelFloor,gigmsg.level,gigmsg.abandonnedPaddock,gigmsg.score);
               this._guild.level = gigmsg.level;
               this._guild.score = gigmsg.score;
               this._guild.experience = gigmsg.experience;
               this._guild.expLevelFloor = gigmsg.expLevelFloor;
               this._guild.expNextLevelFloor = gigmsg.expNextLevelFloor;
               this._guild.creationDate = gigmsg.creationDate;
               return true;
            case msg is GuildInformationsMemberUpdateMessage:
               gimumsg = msg as GuildInformationsMemberUpdateMessage;
               if(this._guildMembers != null)
               {
                  nmu = this._guildMembers.length;
                  for(k = 0; k < nmu; k++)
                  {
                     member = this._guildMembers[k];
                     if(member.id == gimumsg.member.id)
                     {
                        this._guildMembers[k] = gimumsg.member;
                        if(member.id == PlayedCharacterManager.getInstance().id)
                        {
                           this._playerGuildRank = this.getGuildRankById(gimumsg.member.rankId);
                        }
                        break;
                     }
                  }
               }
               else
               {
                  this._guildMembers = new Vector.<GuildMemberInfo>();
                  member = gimumsg.member;
                  if(member.id == PlayedCharacterManager.getInstance().id)
                  {
                     this._playerGuildRank = this.getGuildRankById(gimumsg.member.rankId);
                  }
                  this._guildMembers.push(member);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,gimumsg.member);
               return true;
            case msg is GuildMemberLeavingMessage:
               gmlmsg = msg as GuildMemberLeavingMessage;
               comptgm = 0;
               for each(guildMember in this._guildMembers)
               {
                  if(gmlmsg.memberId == guildMember.id)
                  {
                     if(gmlmsg.memberId == PlayedCharacterManager.getInstance().id)
                     {
                        this._playerGuildRank = null;
                     }
                     this._guildMembers.splice(comptgm,1);
                  }
                  comptgm++;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving,gmlmsg.kicked,gmlmsg.memberId);
               return true;
            case msg is GuildLeftMessage:
               this._hasGuild = false;
               this._playerGuildRank = null;
               this._guild = null;
               this._guildHousesList = false;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLeft);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,false);
               return true;
            case msg is GuildInformationsPaddocksMessage:
               gifmsg = msg as GuildInformationsPaddocksMessage;
               this._guildPaddocksMax = gifmsg.nbPaddockMax;
               this._guildPaddocks = gifmsg.paddocksInformations;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
               return true;
            case msg is GuildPaddockBoughtMessage:
               gpbmsg = msg as GuildPaddockBoughtMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd,gpbmsg.paddockInfo);
               return true;
            case msg is GuildPaddockRemovedMessage:
               gprmsg = msg as GuildPaddockRemovedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved,gprmsg.paddockId);
               return true;
            case msg is ContactLookMessage:
               clmsg = msg as ContactLookMessage;
               if(clmsg.requestId == 0)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,clmsg.playerId,clmsg.playerName,EntityLookAdapter.fromNetwork(clmsg.look));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,clmsg.playerId,clmsg.playerName,EntityLookAdapter.fromNetwork(clmsg.look));
               }
               return true;
            case msg is ContactLookErrorMessage:
               return true;
            case msg is GuildGetInformationsAction:
               ggia = msg as GuildGetInformationsAction;
               askInformation = true;
               switch(ggia.infoType)
               {
                  case GuildInformationsTypeEnum.INFO_HOUSES:
                     if(this._guildHousesList)
                     {
                        askInformation = false;
                        if(this._guildHousesListUpdate)
                        {
                           this._guildHousesListUpdate = false;
                           KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                        }
                     }
               }
               if(askInformation)
               {
                  ggimsg = new GuildGetInformationsMessage();
                  ggimsg.initGuildGetInformationsMessage(ggia.infoType);
                  ConnectionsHandler.getConnection().send(ggimsg);
               }
               return true;
            case msg is GuildInvitationAction:
               gia = msg as GuildInvitationAction;
               ginvitationmsg = new GuildInvitationMessage();
               ginvitationmsg.initGuildInvitationMessage(gia.targetId);
               ConnectionsHandler.getConnection().send(ginvitationmsg);
               return true;
            case msg is GuildDeleteApplicationRequestAction:
               gdarmsg = new GuildDeleteApplicationRequestMessage();
               ConnectionsHandler.getConnection().send(gdarmsg);
               return true;
            case msg is GuildApplicationDeletedMessage:
               gadm = msg as GuildApplicationDeletedMessage;
               if(gadm.deleted)
               {
                  PlayedCharacterManager.getInstance().applicationInfo = null;
                  PlayedCharacterManager.getInstance().guildApplicationInfo = null;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPlayerApplicationDeleted,gadm.deleted);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.social.applyDeleteDelay"),this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp(),false);
               }
               return true;
            case msg is GuildJoinRequestAction:
               gjra = msg as GuildJoinRequestAction;
               gjarmsg = new GuildJoinAutomaticallyRequestMessage();
               gjarmsg.initGuildJoinAutomaticallyRequestMessage(gjra.guildId);
               ConnectionsHandler.getConnection().send(gjarmsg);
               return true;
            case msg is GuildSubmitApplicationAction:
               gsaa = msg as GuildSubmitApplicationAction;
               gsamsg = new GuildSubmitApplicationMessage();
               if(gsaa.filters)
               {
                  filters = gsaa.filters.formatForData();
                  gsamsg.initGuildSubmitApplicationMessage(gsaa.applyText,gsaa.guildId,gsaa.timeSpent,filters.languageFilters,filters.ambianceFilters,filters.playtimeFilters,filters.interestFilters,filters.guildLevelMinMax,filters.recruitmentType,filters.playerLevelMinMax,filters.achievementMinMax,filters.searchText,filters.lastSort);
               }
               else
               {
                  gsamsg.initGuildSubmitApplicationMessage(gsaa.applyText,gsaa.guildId,gsaa.timeSpent);
               }
               ConnectionsHandler.getConnection().send(gsamsg);
               return true;
            case msg is GuildUpdateApplicationAction:
               guaa = msg as GuildUpdateApplicationAction;
               guamsg = new GuildUpdateApplicationMessage();
               guamsg.initGuildUpdateApplicationMessage(guaa.applyText,guaa.guildId);
               ConnectionsHandler.getConnection().send(guamsg);
               return true;
            case msg is GuildApplicationIsAnsweredMessage:
               gaiamsg = msg as GuildApplicationIsAnsweredMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.application"),I18n.getUiText(!!gaiamsg.accepted ? "ui.guild.applyAccepted" : "ui.guild.applyRejected",[HyperlinkShowGuildManager.getLink(gaiamsg.guildInformation,gaiamsg.guildInformation.guildName)]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplyAnswer");
               NotificationManager.getInstance().sendNotification(notificationId);
               if(gaiamsg.accepted)
               {
                  ds = new DataStoreType("SocialBase",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(ds,"SocialBase_GuildWarning",true);
               }
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationIsAnswered);
               return true;
            case msg is GuildApplicationReceivedMessage:
               garmsg = msg as GuildApplicationReceivedMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.applicationReceived"),I18n.getUiText("ui.guild.applicationReceivedNotif",["{player," + garmsg.playerName + "," + garmsg.playerId + "::" + garmsg.playerName + "}"]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplicationReceived");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.social.seeApplication"),"GuildApplicationsUiRequested",null,true,140,0,"hook");
               if(!PlayedCharacterManager.getInstance().isInKoli)
               {
                  NotificationManager.getInstance().sendNotification(notificationId);
               }
               return true;
            case msg is GuildRecruitmentInvalidateMessage:
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.recruitmentInvalidate"),I18n.getUiText("ui.guild.recruitment.rulesBreak"),NotificationTypeEnum.SERVER_INFORMATION,"notifRecruitmentInvalidate");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.social.setUpRecruitment"),"OpenGuildPrezAndRecruitAction",null,true,200,0,"action");
               NotificationManager.getInstance().sendNotification(notificationId);
               return true;
            case msg is GuildKickRequestAction:
               gkra = msg as GuildKickRequestAction;
               gkrmsg = new GuildKickRequestMessage();
               gkrmsg.initGuildKickRequestMessage(gkra.targetId);
               ConnectionsHandler.getConnection().send(gkrmsg);
               return true;
            case msg is GuildChangeMemberParametersAction:
               gcmpa = msg as GuildChangeMemberParametersAction;
               gcmpmsg = new GuildChangeMemberParametersMessage();
               gcmpmsg.initGuildChangeMemberParametersMessage(gcmpa.memberId,gcmpa.rankId,gcmpa.experienceGivenPercent);
               ConnectionsHandler.getConnection().send(gcmpmsg);
               return true;
            case msg is GuildSpellUpgradeRequestAction:
               gsura = msg as GuildSpellUpgradeRequestAction;
               gsurmsg = new GuildSpellUpgradeRequestMessage();
               gsurmsg.initGuildSpellUpgradeRequestMessage(gsura.spellId);
               ConnectionsHandler.getConnection().send(gsurmsg);
               return true;
            case msg is GuildCharacsUpgradeRequestAction:
               gcura = msg as GuildCharacsUpgradeRequestAction;
               gcurmsg = new GuildCharacsUpgradeRequestMessage();
               gcurmsg.initGuildCharacsUpgradeRequestMessage(gcura.charaTypeTarget);
               ConnectionsHandler.getConnection().send(gcurmsg);
               return true;
            case msg is GuildFarmTeleportRequestAction:
               gftra = msg as GuildFarmTeleportRequestAction;
               gftrmsg = new GuildPaddockTeleportRequestMessage();
               gftrmsg.initGuildPaddockTeleportRequestMessage(gftra.farmId);
               ConnectionsHandler.getConnection().send(gftrmsg);
               return true;
            case msg is HouseTeleportRequestAction:
               ghtra = msg as HouseTeleportRequestAction;
               ghtrmsg = new HouseTeleportRequestMessage();
               ghtrmsg.initHouseTeleportRequestMessage(ghtra.houseId,ghtra.houseInstanceId);
               ConnectionsHandler.getConnection().send(ghtrmsg);
               return true;
            case msg is GuildSetApplicationUpdatesRequestAction:
               if(!this._guild)
               {
                  return true;
               }
               galmsg = new GuildApplicationListenMessage();
               galmsg.initGuildApplicationListenMessage((msg as GuildSetApplicationUpdatesRequestAction).areEnabled);
               ConnectionsHandler.getConnection().send(galmsg);
               return true;
               break;
            case msg is GuildAreThereApplicationsAction:
               gitaamsg = new GuildIsThereAnyApplicationMessage();
               gitaamsg.initGuildIsThereAnyApplicationMessage();
               ConnectionsHandler.getConnection().send(gitaamsg);
               return true;
            case msg is GuildApplicationPresenceMessage:
               gataamsg = msg as GuildApplicationPresenceMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildAreThereApplications,gataamsg.isApplication);
               return true;
            case msg is GuildApplicationsRequestAction:
               garaction = msg as GuildApplicationsRequestAction;
               glarmsg = new GuildListApplicationRequestMessage();
               glarmsg.initGuildListApplicationRequestMessage(garaction.timestamp,garaction.limit);
               ConnectionsHandler.getConnection().send(glarmsg);
               return true;
            case msg is GuildListApplicationAnswerMessage:
               glaamsg = msg as GuildListApplicationAnswerMessage;
               guildApplicationDescrs = new Vector.<SocialApplicationWrapper>(0);
               for each(guildApplicationInfo in glaamsg.applies)
               {
                  guildApplicationDescrs.push(SocialApplicationWrapper.wrap(guildApplicationInfo));
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationsReceived,guildApplicationDescrs,glaamsg.offset,glaamsg.count,glaamsg.total);
               return true;
            case msg is GuildApplicationReplyAction:
               guildApplicationReplyAction = msg as GuildApplicationReplyAction;
               guildApplicationAnswerMessage = new GuildApplicationAnswerMessage();
               guildApplicationAnswerMessage.initGuildApplicationAnswerMessage(guildApplicationReplyAction.isAccepted,guildApplicationReplyAction.playerId);
               ConnectionsHandler.getConnection().send(guildApplicationAnswerMessage);
               return true;
            case msg is GuildListApplicationModifiedMessage:
               glammsg = msg as GuildListApplicationModifiedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationUpdated,SocialApplicationWrapper.wrap(glammsg.apply),glammsg.state,glammsg.playerId);
               return true;
            case msg is GuildSummaryRequestAction:
               gsra = msg as GuildSummaryRequestAction;
               gsrm = new GuildSummaryRequestMessage();
               gsrm.initGuildSummaryRequestMessage();
               gsrm.offset = gsra.offset;
               gsrm.count = gsra.count;
               gsrm.nameFilter = gsra.filters.textFilter;
               gsrm.minLevelFilter = gsra.filters.minLevelFilter;
               gsrm.maxLevelFilter = gsra.filters.maxLevelFilter;
               gsrm.recruitmentTypeFilter = gsra.filters.recruitmentTypeFilter;
               gsrm.languagesFilter = gsra.filters.languagesFilter;
               gsrm.criterionFilter = gsra.filters.criterionFilter;
               gsrm.minPlayerLevelFilter = gsra.filters.minPlayerLevelFilter;
               gsrm.maxPlayerLevelFilter = gsra.filters.maxPlayerLevelFilter;
               gsrm.minSuccessFilter = gsra.filters.minSuccessFilter;
               gsrm.maxSuccessFilter = gsra.filters.maxSuccessFilter;
               gsrm.sortType = gsra.filters.sortType;
               gsrm.sortDescending = gsra.filters.sortDescending;
               gsrm.hideFullFilter = gsra.filters.hideFullFilter;
               gsrm.followingGuildCriteria = gsra.filters.followingSocialGroupCriteria;
               ConnectionsHandler.getConnection().send(gsrm);
               return true;
            case msg is GuildSummaryMessage:
               gsm = msg as GuildSummaryMessage;
               allGuildsInDirectory = new Vector.<SocialGroupWrapper>(0);
               for each(guildFactInfo in gsm.guilds)
               {
                  guildWrapper = GuildWrapper.getFromNetwork(guildFactInfo);
                  if(guildWrapper)
                  {
                     allGuildsInDirectory.push(guildWrapper as SocialGroupWrapper);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.GuildsReceived,allGuildsInDirectory,gsm.offset,gsm.count,gsm.total);
               return true;
            case msg is GuildGetPlayerApplicationAction:
               ggpam = new GuildGetPlayerApplicationMessage();
               ConnectionsHandler.getConnection().send(ggpam);
               return true;
            case msg is GuildPlayerApplicationInformationMessage:
               gpaim = msg as GuildPlayerApplicationInformationMessage;
               PlayedCharacterManager.getInstance().applicationInfo = gpaim.apply;
               PlayedCharacterManager.getInstance().guildApplicationInfo = gpaim.guildInformation;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPlayerApplicationReceived,gpaim.guildInformation,gpaim.apply);
               return true;
            case msg is GuildPlayerNoApplicationInformationMessage:
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               return true;
            case msg is GuildNoteUpdateAction:
               gnuaction = msg as GuildNoteUpdateAction;
               gunmsg = new GuildUpdateNoteMessage();
               gunmsg.initGuildUpdateNoteMessage(gnuaction.memberId,gnuaction.text);
               ConnectionsHandler.getConnection().send(gunmsg);
               return true;
            case msg is GuildHouseUpdateInformationMessage:
               if(this._guildHousesList)
               {
                  ghuimsg = msg as GuildHouseUpdateInformationMessage;
                  toUpdate = false;
                  for each(house1 in this._guildHouses)
                  {
                     if(house1.houseId == ghuimsg.housesInformations.houseId && house1.houseInstanceId == ghuimsg.housesInformations.instanceId)
                     {
                        house1.update(ghuimsg.housesInformations);
                        toUpdate = true;
                     }
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                  }
                  if(!toUpdate)
                  {
                     ghw1 = GuildHouseWrapper.create(ghuimsg.housesInformations);
                     this._guildHouses.push(ghw1);
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd,ghw1);
                  }
                  this._guildHousesListUpdate = true;
               }
               return true;
            case msg is GuildHouseRemoveMessage:
               if(this._guildHousesList)
               {
                  ghrmsg = msg as GuildHouseRemoveMessage;
                  for(iGHR = 0; iGHR < this._guildHouses.length; iGHR++)
                  {
                     if(this._guildHouses[iGHR].houseId == ghrmsg.houseId && this._guildHouses[iGHR].houseInstanceId == ghrmsg.instanceId)
                     {
                        this._guildHouses.splice(iGHR,1);
                     }
                  }
                  this._guildHousesListUpdate = true;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved,ghrmsg.houseId);
               }
               return true;
            case msg is GuildFactsRequestAction:
               gfra = msg as GuildFactsRequestAction;
               gfrmsg = new GuildFactsRequestMessage();
               gfrmsg.initGuildFactsRequestMessage(gfra.guildId);
               ConnectionsHandler.getConnection().send(gfrmsg);
               return true;
            case msg is GuildFactsMessage:
               gfmsg = msg as GuildFactsMessage;
               guildSheet = this._allGuilds[gfmsg.infos.guildId];
               guildUpEmblem = EmblemWrapper.create(gfmsg.infos.guildEmblem.symbolShape,EmblemWrapper.UP,gfmsg.infos.guildEmblem.symbolColor);
               guildBackEmblem = EmblemWrapper.create(gfmsg.infos.guildEmblem.backgroundShape,EmblemWrapper.BACK,gfmsg.infos.guildEmblem.backgroundColor);
               if(guildSheet)
               {
                  guildSheet.updateWrapper(gfmsg.infos.guildId,gfmsg.infos.guildName,guildUpEmblem,guildBackEmblem,gfmsg.infos.leaderId,gfmsg.infos.nbMembers,gfmsg.creationDate,gfmsg.members,GuildRecruitmentDataWrapper.wrap(gfmsg.infos.recruitment),gfmsg.infos.guildLevel);
                  this._allGuilds[gfmsg.infos.guildId] = guildSheet;
               }
               else
               {
                  guildSheet = new GuildFactSheetWrapper(gfmsg.infos.guildId,gfmsg.infos.guildName,guildUpEmblem,guildBackEmblem,gfmsg.infos.leaderId,gfmsg.infos.nbMembers,gfmsg.creationDate,gfmsg.members,GuildRecruitmentDataWrapper.wrap(gfmsg.infos.recruitment),gfmsg.infos.guildLevel);
                  this._allGuilds[gfmsg.infos.guildId] = guildSheet;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneGuild,guildSheet);
               return true;
            case msg is GuildFactsErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.guild.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is GuildMotdSetRequestAction:
               gmsra = msg as GuildMotdSetRequestAction;
               gmsrmsg = new GuildMotdSetRequestMessage();
               gmsrmsg.initGuildMotdSetRequestMessage(gmsra.content);
               ConnectionsHandler.getConnection().send(gmsrmsg);
               return true;
            case msg is GuildMotdMessage:
               gmomsg = msg as GuildMotdMessage;
               guildMotdContent = gmomsg.content;
               pattern = /</g;
               guildMotdContent = guildMotdContent.replace(pattern,"&lt;");
               motdContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(guildMotdContent,ChatActivableChannelsEnum.CHANNEL_GUILD,gmomsg.memberId,gmomsg.memberName);
               this._guild.motd = gmomsg.content;
               this._guild.formattedMotd = motdContent[0];
               this._guild.motdWriterId = gmomsg.memberId;
               this._guild.motdWriterName = gmomsg.memberName;
               this._guild.motdTimestamp = gmomsg.timestamp;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMotd);
               if(gmomsg.content != "" && !OptionManager.getOptionManager("dofus").getOption("disableGuildMotd"))
               {
                  textMotd = I18n.getUiText("ui.motd.guild") + I18n.getUiText("ui.common.colon") + motdContent[0];
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,textMotd,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is GuildMotdSetErrorMessage:
               gmosemsg = msg as GuildMotdSetErrorMessage;
               switch(gmosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     reason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     reason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     reason = I18n.getUiText("ui.alliance.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is GuildBulletinSetRequestAction:
               gbsra = msg as GuildBulletinSetRequestAction;
               gbsrmsg = new GuildBulletinSetRequestMessage();
               gbsrmsg.initGuildBulletinSetRequestMessage(gbsra.content);
               ConnectionsHandler.getConnection().send(gbsrmsg);
               return true;
            case msg is GuildBulletinMessage:
               gbomsg = msg as GuildBulletinMessage;
               guildBulletinContent = gbomsg.content;
               pattern = /</g;
               guildBulletinContent = guildBulletinContent.replace(pattern,"&lt;");
               bulletinContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(guildBulletinContent,ChatActivableChannelsEnum.CHANNEL_GUILD,gbomsg.memberId,gbomsg.memberName);
               this._guild.bulletin = gbomsg.content;
               this._guild.formattedBulletin = bulletinContent[0];
               this._guild.bulletinWriterId = gbomsg.memberId;
               this._guild.bulletinWriterName = gbomsg.memberName;
               this._guild.bulletinTimestamp = gbomsg.timestamp * 1000;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildBulletin);
               return true;
            case msg is GuildBulletinSetErrorMessage:
               gbosemsg = msg as GuildBulletinSetErrorMessage;
               switch(gbosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     reason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     reason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     reason = I18n.getUiText("ui.alliance.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is PlayerStatusUpdateMessage:
               psum = msg as PlayerStatusUpdateMessage;
               message = "";
               if(psum.status is PlayerStatusExtended)
               {
                  message = PlayerStatusExtended(psum.status).message;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.PlayerStatusUpdate,psum.accountId,psum.playerId,psum.status.statusId,message);
               if(this._guildMembers != null)
               {
                  snm = this._guildMembers.length;
                  for(istatus = 0; istatus < snm; istatus++)
                  {
                     if(this._guildMembers[istatus].id == psum.playerId)
                     {
                        this._guildMembers[istatus].status = psum.status;
                        members = this._guildMembers[istatus];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,members);
                        break;
                     }
                  }
               }
               if(this._friendsList != null)
               {
                  for each(frdstatus in this._friendsList)
                  {
                     if(frdstatus.accountId == psum.accountId)
                     {
                        frdstatus.statusId = psum.status.statusId;
                        if(psum.status is PlayerStatusExtended)
                        {
                           frdstatus.awayMessage = PlayerStatusExtended(psum.status).message;
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        break;
                     }
                  }
               }
               if(this._contactsList != null)
               {
                  for each(ctcStatus in this._contactsList)
                  {
                     if(ctcStatus.accountId == psum.accountId)
                     {
                        ctcStatus.statusId = psum.status.statusId;
                        if(psum.status is PlayerStatusExtended)
                        {
                           ctcStatus.awayMessage = PlayerStatusExtended(psum.status).message;
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                        break;
                     }
                  }
               }
               return false;
            case msg is PlayerStatusUpdateErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.chat.status.awaymessageerror"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return false;
            case msg is PlayerStatusUpdateRequestAction:
               psura = msg as PlayerStatusUpdateRequestAction;
               if(psura.message)
               {
                  status = new PlayerStatusExtended();
                  PlayerStatusExtended(status).initPlayerStatusExtended(psura.status,psura.message);
               }
               else
               {
                  status = new PlayerStatus();
                  status.initPlayerStatus(psura.status);
               }
               psurmsg = new PlayerStatusUpdateRequestMessage();
               psurmsg.initPlayerStatusUpdateRequestMessage(status);
               ConnectionsHandler.getConnection().send(psurmsg);
               return true;
            case msg is ContactLookRequestByIdAction:
               clrbia = msg as ContactLookRequestByIdAction;
               if(clrbia.entityId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,PlayedCharacterManager.getInstance().id,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  clrbim = new ContactLookRequestByIdMessage();
                  clrbim.initContactLookRequestByIdMessage(1,clrbia.contactType,clrbia.entityId);
                  ConnectionsHandler.getConnection().send(clrbim);
               }
               return true;
            case msg is RecruitmentInformationMessage:
               recruitmentData = GuildRecruitmentDataWrapper.wrap((msg as RecruitmentInformationMessage).recruitmentData);
               if(this._guild)
               {
                  this._guild.guildRecruitmentInfo = recruitmentData;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildRecruitmentDataReceived,recruitmentData);
               return true;
            case msg is SendGuildRecruitmentDataAction:
               newRecruitmentData = (msg as SendGuildRecruitmentDataAction).recruitmentData;
               if(newRecruitmentData === null)
               {
                  return true;
               }
               urimsg = new UpdateRecruitmentInformationMessage();
               urimsg.initUpdateRecruitmentInformationMessage(newRecruitmentData.unwrap());
               ConnectionsHandler.getConnection().send(urimsg);
               return true;
               break;
            case msg is GuildRanksRequestAction:
               grrm = new GuildRanksRequestMessage();
               grrm.initGuildRanksRequestMessage();
               ConnectionsHandler.getConnection().send(grrm);
               return true;
            case msg is GuildRanksMessage:
               grm = msg as GuildRanksMessage;
               lastRankCount = this._guildRanksSorted.length;
               this._guildRanks = new Dictionary(true);
               this._guildRanksSorted = new Vector.<RankInformation>();
               for each(guildRankInfo in grm.ranks)
               {
                  if(guildRankInfo.name.indexOf("guild.rank.") != -1)
                  {
                     guildRankData = GuildRank.getGuildRankById(guildRankInfo.id);
                     if(guildRankData)
                     {
                        guildRankInfo.name = guildRankData.name;
                     }
                  }
                  this._guildRanks[guildRankInfo.id] = guildRankInfo;
                  this._guildRanksSorted.push(guildRankInfo);
                  if(this._playerGuildRank && this._playerGuildRank.id == guildRankInfo.id)
                  {
                     this._playerGuildRank = guildRankInfo;
                  }
               }
               this._guildRanksSorted = this._guildRanksSorted.sort(function(rank1:RankInformation, rank2:RankInformation):int
               {
                  return rank1.order - rank2.order;
               });
               if(this._guildMembers != null && lastRankCount == this._guildRanksSorted.length)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildRanksReceived,this._guildRanksSorted);
               return true;
            case msg is CreateGuildRankRequestAction:
               cgrra = msg as CreateGuildRankRequestAction;
               cgrrm = new CreateGuildRankRequestMessage();
               cgrrm.initCreateGuildRankRequestMessage(cgrra.parentRankId,cgrra.gfxId,cgrra.name);
               ConnectionsHandler.getConnection().send(cgrrm);
               return true;
            case msg is UpdateAllGuildRankRequestAction:
               uagrra = msg as UpdateAllGuildRankRequestAction;
               uagrrm = new UpdateAllGuildRankRequestMessage();
               uagrrm.initUpdateAllGuildRankRequestMessage(uagrra.ranks);
               ConnectionsHandler.getConnection().send(uagrrm);
               return true;
            case msg is UpdateGuildRankRequestAction:
               ugrra = msg as UpdateGuildRankRequestAction;
               ugrrm = new UpdateGuildRankRequestMessage();
               ugrrm.initUpdateGuildRankRequestMessage(ugrra.rank);
               ConnectionsHandler.getConnection().send(ugrrm);
               return true;
            case msg is UpdateGuildRightsAction:
               ugra = msg as UpdateGuildRightsAction;
               ugrm = new UpdateGuildRightsMessage();
               ugrm.initUpdateGuildRightsMessage(ugra.rankId,ugra.rights);
               ConnectionsHandler.getConnection().send(ugrm);
               return true;
            case msg is RemoveGuildRankRequestAction:
               rgrra = msg as RemoveGuildRankRequestAction;
               rgrrm = new RemoveGuildRankRequestMessage();
               rgrrm.initRemoveGuildRankRequestMessage(rgrra.rankId,rgrra.newRankId);
               ConnectionsHandler.getConnection().send(rgrrm);
               return true;
            case msg is GuildLogbookRequestAction:
               glbrmsg = new GuildLogbookInformationRequestMessage();
               glbrmsg.initGuildLogbookInformationRequestMessage();
               ConnectionsHandler.getConnection().send(glbrmsg);
               return true;
            case msg is GuildLogbookInformationMessage:
               glbimsg = msg as GuildLogbookInformationMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLogbookInformationsReceived,glbimsg.globalActivities,glbimsg.chestActivities);
               return true;
            case msg is StartListenGuildChestStructureAction:
               slgcsm = new StartListenGuildChestStructureMessage();
               slgcsm.initStartListenGuildChestStructureMessage();
               ConnectionsHandler.getConnection().send(slgcsm);
               return true;
            case msg is StopListenGuildChestStructureAction:
               splgcsm = new StopListenGuildChestStructureMessage();
               splgcsm.initStopListenGuildChestStructureMessage();
               ConnectionsHandler.getConnection().send(splgcsm);
               return true;
            case msg is AllianceGetRecruitmentInformationAction:
               agrimsg = new AllianceGetRecruitmentInformationMessage();
               agrimsg.initAllianceGetRecruitmentInformationMessage();
               ConnectionsHandler.getConnection().send(agrimsg);
               return true;
            case msg is AllianceCreationStartedMessage:
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,false,false);
               return true;
            case msg is AllianceModificationStartedMessage:
               amsmsg = msg as AllianceModificationStartedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationStarted,amsmsg.canChangeName,amsmsg.canChangeEmblem);
               return true;
            case msg is AllianceCreationResultMessage:
               acrmsg = msg as AllianceCreationResultMessage;
               switch(acrmsg.result)
               {
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_OPERATION_OK:
                     Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                     this._hasAlliance = true;
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_INVALID:
                     errorMessage = I18n.getUiText("ui.alliance.invalidName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_ALREADY_IN_GROUP:
                     errorMessage = I18n.getUiText("ui.alliance.alreadyInAlliance");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.alliance.alreadyUsedName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_LEAVE:
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_CANCEL:
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_REQUIREMENT_UNMET:
                     errorMessage = I18n.getUiText("ui.social.requirementUnmet");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_TAG_INVALID:
                     errorMessage = I18n.getUiText("ui.alliance.invalidTag");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_TAG_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.alliance.alreadyUsedTag");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_UNKNOWN:
                     errorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceCreationResult,acrmsg.result);
               return true;
            case msg is AllianceModificationResultMessage:
               amrmsg = msg as AllianceModificationResultMessage;
               switch(amrmsg.result)
               {
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_OPERATION_OK:
                     Kernel.getWorker().removeFrame(this._allianceDialogFrame);
                     this._hasAlliance = true;
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_INVALID:
                     errorMessage = I18n.getUiText("ui.alliance.invalidName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_NAME_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.alliance.alreadyUsedName");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_LEAVE:
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_CANCEL:
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_REQUIREMENT_UNMET:
                     errorMessage = I18n.getUiText("ui.social.requirementUnmet");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_TAG_INVALID:
                     errorMessage = I18n.getUiText("ui.alliance.invalidTag");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_TAG_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.alliance.alreadyUsedTag");
                     break;
                  case SocialGroupOperationResultEnum.SOCIAL_GROUP_ERROR_UNKNOWN:
                     errorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceModificationResult,amrmsg.result);
               return true;
            case msg is AllianceMembershipMessage:
               ammsg = msg as AllianceMembershipMessage;
               this._alliance = AllianceWrapper.getFromNetwork(ammsg.allianceInfo);
               this._hasAlliance = true;
               this._playerAllianceRank = this.getAllianceRankById(ammsg.rankId);
               Kernel.getWorker().process(AllianceMemberWarningSetAction.create(StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_SNAPSHOT,"warnAllianceMemberConnection" + PlayedCharacterManager.getInstance().id)));
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               return true;
            case msg is AllianceGetPlayerApplicationAction:
               agpam = new AllianceGetPlayerApplicationMessage();
               ConnectionsHandler.getConnection().send(agpam);
               return true;
            case msg is AlliancePlayerApplicationInformationMessage:
               apaim = msg as AlliancePlayerApplicationInformationMessage;
               PlayedCharacterManager.getInstance().applicationInfo = apaim.apply;
               PlayedCharacterManager.getInstance().allianceApplicationInfo = apaim.allianceInformation;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePlayerApplicationReceived,apaim.allianceInformation,apaim.apply);
               return true;
            case msg is AlliancePlayerNoApplicationInformationMessage:
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().allianceApplicationInfo = null;
               return true;
            case msg is AllianceInvitationAction:
               aia = msg as AllianceInvitationAction;
               aimsg = new AllianceInvitationMessage();
               aimsg.initAllianceInvitationMessage(aia.targetId);
               ConnectionsHandler.getConnection().send(aimsg);
               return true;
            case msg is AllianceDeleteApplicationRequestAction:
               adarmsg = new AllianceDeleteApplicationRequestMessage();
               ConnectionsHandler.getConnection().send(adarmsg);
               return true;
            case msg is AllianceApplicationDeletedMessage:
               aadm = msg as AllianceApplicationDeletedMessage;
               if(aadm.deleted)
               {
                  PlayedCharacterManager.getInstance().applicationInfo = null;
                  PlayedCharacterManager.getInstance().allianceApplicationInfo = null;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.AlliancePlayerApplicationDeleted,aadm.deleted);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.social.applyDeleteDelay"),this.ERROR_CHANNEL,TimeManager.getInstance().getTimestamp(),false);
               }
               return true;
            case msg is AllianceApplicationIsAnsweredMessage:
               aaiamsg = msg as AllianceApplicationIsAnsweredMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.application"),I18n.getUiText(!!aaiamsg.accepted ? "ui.alliance.applyAccepted" : "ui.alliance.applyRejected",[HyperlinkShowAllianceManager.getLink(aaiamsg.allianceInformation,aaiamsg.allianceInformation.allianceName)]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplyAnswer");
               NotificationManager.getInstance().sendNotification(notificationId);
               if(aaiamsg.accepted)
               {
                  ds = new DataStoreType("SocialBase",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(ds,"SocialBase_AllianceWarning",true);
               }
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().allianceApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceApplicationIsAnswered);
               return true;
            case msg is AllianceApplicationReceivedMessage:
               aarmsg = msg as AllianceApplicationReceivedMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.applicationReceived"),I18n.getUiText("ui.alliance.applicationReceivedNotif",["{player," + aarmsg.playerName + "," + aarmsg.playerId + "::" + aarmsg.playerName + "}"]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplicationReceived");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.social.seeApplication"),"AllianceApplicationsUiRequested",null,true,140,0,"hook");
               if(!PlayedCharacterManager.getInstance().isInKoli)
               {
                  NotificationManager.getInstance().sendNotification(notificationId);
               }
               timeApi = new TimeApi();
               this._alliance.membersTimestamp = timeApi.getTimestamp();
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceNewApplicationReceived);
               return true;
            case msg is AllianceRecruitmentInvalidateMessage:
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.alliance.recruitmentInvalidate"),I18n.getUiText("ui.alliance.recruitment.rulesBreak"),NotificationTypeEnum.SERVER_INFORMATION,"notifRecruitmentInvalidate");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.social.setUpRecruitment"),"OpenAlliancePrezAndRecruitAction",null,true,200,0,"action");
               NotificationManager.getInstance().sendNotification(notificationId);
               return true;
            case msg is AllianceJoinRequestAction:
               ajra = msg as AllianceJoinRequestAction;
               ajarmsg = new AllianceJoinAutomaticallyRequestMessage();
               ajarmsg.initAllianceJoinAutomaticallyRequestMessage(ajra.allianceId);
               ConnectionsHandler.getConnection().send(ajarmsg);
               return true;
            case msg is AllianceSubmitApplicationAction:
               asaa = msg as AllianceSubmitApplicationAction;
               asamsg = new AllianceSubmitApplicationMessage();
               asamsg.initAllianceSubmitApplicationMessage(asaa.applyText,asaa.allianceId);
               ConnectionsHandler.getConnection().send(asamsg);
               return true;
            case msg is AllianceUpdateApplicationAction:
               auaa = msg as AllianceUpdateApplicationAction;
               auamsg = new AllianceUpdateApplicationMessage();
               auamsg.initAllianceUpdateApplicationMessage(auaa.applyText,auaa.allianceId);
               ConnectionsHandler.getConnection().send(auamsg);
               return true;
            case msg is AllianceInvitedMessage:
               aidmsg = msg as AllianceInvitedMessage;
               Kernel.getWorker().addFrame(this._allianceDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvited,aidmsg.allianceInfo,aidmsg.recruterName);
               return true;
            case msg is AllianceInvitationStateRecruterMessage:
               aisrermsg = msg as AllianceInvitationStateRecruterMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruter,aisrermsg.invitationState,aisrermsg.recrutedName);
               if(aisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || aisrermsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               else
               {
                  Kernel.getWorker().addFrame(this._allianceDialogFrame);
               }
               return true;
            case msg is AllianceInvitationStateRecrutedMessage:
               aisredmsg = msg as AllianceInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInvitationStateRecruted,aisredmsg.invitationState);
               if(aisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || aisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._allianceDialogFrame);
               }
               return true;
            case msg is AllianceJoinedMessage:
               ajmsg = msg as AllianceJoinedMessage;
               this._hasAlliance = true;
               this._playerAllianceRank = this.getAllianceRankById(ajmsg.rankId);
               this._alliance = AllianceWrapper.getFromNetwork(ajmsg.allianceInfo);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,true);
               alliancejoinMessage = I18n.getUiText("ui.alliance.joinAllianceMessage",[ajmsg.allianceInfo.allianceName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,alliancejoinMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceJoined);
               return true;
            case msg is AllianceKickRequestAction:
               akra = msg as AllianceKickRequestAction;
               akrmsg = new AllianceKickRequestMessage();
               akrmsg.initAllianceKickRequestMessage(akra.memberId);
               ConnectionsHandler.getConnection().send(akrmsg);
               return true;
            case msg is AllianceChangeMemberRankAction:
               acmra = msg as AllianceChangeMemberRankAction;
               acmrmsg = new AllianceChangeMemberRankMessage();
               acmrmsg.initAllianceChangeMemberRankMessage(acmra.memberId,acmra.rankId);
               ConnectionsHandler.getConnection().send(acmrmsg);
               return true;
            case msg is AllianceMemberInformationUpdateMessage:
               amiumsg = msg as AllianceMemberInformationUpdateMessage;
               if(this._allianceMembers != null)
               {
                  nbMembers = this._allianceMembers.length;
                  for(j = 0; j < nbMembers; j++)
                  {
                     alliMember = this._allianceMembers[j];
                     if(alliMember.id == amiumsg.member.id)
                     {
                        this._allianceMembers[j] = amiumsg.member;
                        if(alliMember.id == PlayedCharacterManager.getInstance().id)
                        {
                           this._playerAllianceRank = this.getAllianceRankById(amiumsg.member.rankId);
                        }
                        break;
                     }
                  }
               }
               else
               {
                  this._allianceMembers = new Vector.<AllianceMemberInfo>();
                  alliMember = amiumsg.member;
                  if(alliMember.id == PlayedCharacterManager.getInstance().id)
                  {
                     this._playerAllianceRank = this.getAllianceRankById(amiumsg.member.rankId);
                  }
                  this._allianceMembers.push(alliMember);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInformationsMembers,this._allianceMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInformationsMemberUpdate,amiumsg.member);
               return true;
            case msg is AllianceMemberLeavingMessage:
               amlmsg = msg as AllianceMemberLeavingMessage;
               comptam = 0;
               for each(allianceMember in this._allianceMembers)
               {
                  if(amlmsg.memberId == allianceMember.id)
                  {
                     if(amlmsg.memberId == PlayedCharacterManager.getInstance().id)
                     {
                        this._playerAllianceRank = null;
                     }
                     this._allianceMembers.splice(comptam,1);
                  }
                  comptam++;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInformationsMembers,this._allianceMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMemberLeaving,amlmsg.kicked,amlmsg.memberId);
               return true;
            case msg is AllianceLeftMessage:
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceLeft);
               SocialEntitiesManager.getInstance().cleanTaxCollectorsInfos();
               this._hasAlliance = false;
               this._playerAllianceRank = null;
               this._alliance = null;
               rpFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(rpFrame)
               {
                  for each(pid in rpFrame.playersId)
                  {
                     rpFrame.removeIconsCategory(pid,EntityIconEnum.AVA_CATEGORY);
                  }
                  usasmsg = new UpdateSelfAgressableStatusMessage();
                  usasmsg.initUpdateSelfAgressableStatusMessage(AggressableStatusEnum.NON_AGGRESSABLE);
                  rpFrame.process(usasmsg);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMembershipUpdated,false);
               return true;
            case msg is AllianceFactsRequestAction:
               afra = msg as AllianceFactsRequestAction;
               afrmsg = new AllianceFactsRequestMessage();
               afrmsg.initAllianceFactsRequestMessage(afra.allianceId);
               ConnectionsHandler.getConnection().send(afrmsg);
               return true;
            case msg is AllianceFactsMessage:
               afmsg = msg as AllianceFactsMessage;
               allianceSheet = this._allAlliancesFactSheets[afmsg.infos.allianceId];
               allianceUpEmblem = EmblemWrapper.create(afmsg.infos.allianceEmblem.symbolShape,EmblemWrapper.UP,afmsg.infos.allianceEmblem.symbolColor,true);
               allianceBackEmblem = EmblemWrapper.create(afmsg.infos.allianceEmblem.backgroundShape,EmblemWrapper.BACK,afmsg.infos.allianceEmblem.backgroundColor,true);
               if(allianceSheet)
               {
                  allianceSheet.updateWrapper(afmsg.infos.allianceId,afmsg.infos.allianceName,allianceUpEmblem,allianceBackEmblem,afmsg.leaderCharacterId,afmsg.infos.nbMembers,afmsg.infos.creationDate,afmsg.members,afmsg.infos.allianceTag,afmsg.controlledSubareaIds,afmsg.infos.nbTaxCollectors,AllianceRecruitmentDataWrapper.wrap(afmsg.infos.recruitment));
               }
               else
               {
                  allianceSheet = new AllianceFactSheetWrapper(afmsg.infos.allianceId,afmsg.infos.allianceName,allianceUpEmblem,allianceBackEmblem,afmsg.leaderCharacterId,afmsg.infos.nbMembers,afmsg.infos.creationDate,afmsg.members,afmsg.infos.allianceTag,afmsg.controlledSubareaIds,afmsg.infos.nbTaxCollectors,AllianceRecruitmentDataWrapper.wrap(afmsg.infos.recruitment));
               }
               this._allAlliancesFactSheets[afmsg.infos.allianceId] = allianceSheet;
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenOneAlliance,allianceSheet);
               return true;
            case msg is AllianceFactsErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.alliance.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AllianceSetApplicationUpdatesRequestAction:
               if(!this._alliance)
               {
                  return true;
               }
               aalmsg = new AllianceApplicationListenMessage();
               aalmsg.initAllianceApplicationListenMessage((msg as AllianceSetApplicationUpdatesRequestAction).areEnabled);
               ConnectionsHandler.getConnection().send(aalmsg);
               return true;
               break;
            case msg is AllianceAreThereApplicationsAction:
               aitaamsg = new AllianceIsThereAnyApplicationMessage();
               aitaamsg.initAllianceIsThereAnyApplicationMessage();
               ConnectionsHandler.getConnection().send(aitaamsg);
               return true;
            case msg is AllianceApplicationPresenceMessage:
               aataamsg = msg as AllianceApplicationPresenceMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceAreThereApplications,aataamsg.isApplication);
               return true;
            case msg is AllianceApplicationsRequestAction:
               aaraction = msg as AllianceApplicationsRequestAction;
               alarmsg = new AllianceListApplicationRequestMessage();
               alarmsg.initAllianceListApplicationRequestMessage(aaraction.timestamp,aaraction.limit);
               ConnectionsHandler.getConnection().send(alarmsg);
               return true;
            case msg is AllianceListApplicationAnswerMessage:
               alaamsg = msg as AllianceListApplicationAnswerMessage;
               alliApplicationDescrs = new Vector.<SocialApplicationWrapper>(0);
               for each(alliApplicationInfo in alaamsg.applies)
               {
                  alliApplicationDescrs.push(SocialApplicationWrapper.wrap(alliApplicationInfo));
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceApplicationsReceived,alliApplicationDescrs,alaamsg.offset,alaamsg.count,alaamsg.total);
               return true;
            case msg is AllianceApplicationReplyAction:
               aara = msg as AllianceApplicationReplyAction;
               aaamsg = new AllianceApplicationAnswerMessage();
               aaamsg.initAllianceApplicationAnswerMessage(aara.isAccepted,aara.playerId);
               ConnectionsHandler.getConnection().send(aaamsg);
               return true;
            case msg is AllianceListApplicationModifiedMessage:
               alammsg = msg as AllianceListApplicationModifiedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceApplicationUpdated,SocialApplicationWrapper.wrap(alammsg.apply),alammsg.state,alammsg.playerId);
               return true;
            case msg is AllianceSummaryRequestAction:
               asra = msg as AllianceSummaryRequestAction;
               asrmsg = new AllianceSummaryRequestMessage();
               asrmsg.initAllianceSummaryRequestMessage();
               asrmsg.offset = asra.offset;
               asrmsg.count = asra.count;
               asrmsg.filterType = asra.filters.filterType;
               asrmsg.textFilter = asra.filters.textFilter;
               asrmsg.sortType = asra.filters.sortType;
               asrmsg.sortDescending = asra.filters.sortDescending;
               asrmsg.recruitmentTypeFilter = asra.filters.recruitmentTypeFilter;
               asrmsg.languagesFilter = asra.filters.languagesFilter;
               asrmsg.criterionFilter = asra.filters.criterionFilter;
               asrmsg.minPlayerLevelFilter = asra.filters.minPlayerLevelFilter;
               asrmsg.maxPlayerLevelFilter = asra.filters.maxPlayerLevelFilter;
               asrmsg.sortType = asra.filters.sortType;
               asrmsg.sortDescending = asra.filters.sortDescending;
               asrmsg.hideFullFilter = asra.filters.hideFullFilter;
               asrmsg.followingAllianceCriteria = asra.filters.followingSocialGroupCriteria;
               ConnectionsHandler.getConnection().send(asrmsg);
               return true;
            case msg is AllianceSummaryMessage:
               asmsg = msg as AllianceSummaryMessage;
               allAlliancesInDirectory = new Vector.<SocialGroupWrapper>(0);
               for each(alliFactInfo in asmsg.alliances)
               {
                  allianceWrapper = AllianceWrapper.getFromNetwork(alliFactInfo);
                  if(allianceWrapper)
                  {
                     allAlliancesInDirectory.push(allianceWrapper as SocialGroupWrapper);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.AlliancesReceived,allAlliancesInDirectory,asmsg.offset,asmsg.count,asmsg.total);
               return true;
            case msg is AllianceInsiderInfoRequestAction:
               aiirmsg = new AllianceInsiderInfoRequestMessage();
               aiirmsg.initAllianceInsiderInfoRequestMessage();
               ConnectionsHandler.getConnection().send(aiirmsg);
               return true;
            case msg is AllianceInsiderInfoMessage:
               aiimsg = msg as AllianceInsiderInfoMessage;
               this._alliance = AllianceWrapper.getFromNetwork(aiimsg.allianceInfos);
               this._allianceMembers = aiimsg.members;
               this._allAlliances[aiimsg.allianceInfos.allianceId] = this._alliance;
               this._hasAlliance = true;
               prismIdsList = new Vector.<uint>();
               for each(insPrism in aiimsg.prisms)
               {
                  SocialEntitiesManager.getInstance().addOrUpdatePrism(insPrism);
                  if(insPrism.prism is AllianceInsiderPrismInformation)
                  {
                     prismIdsList.push(insPrism.subAreaId);
                  }
               }
               KernelEventsManager.getInstance().processCallback(PrismHookList.PrismsMultipleUpdate,prismIdsList);
               SocialEntitiesManager.getInstance().setTaxCollectors(aiimsg.taxCollectors);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceUpdateInformations);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInformationsMembers,this._allianceMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceRecruitmentDataReceived,AllianceRecruitmentDataWrapper.wrap(aiimsg.allianceInfos.recruitment));
               return true;
            case msg is AllianceRecruitmentInformationMessage:
               allianceRecruitmentData = AllianceRecruitmentDataWrapper.wrap((msg as AllianceRecruitmentInformationMessage).recruitmentData);
               if(this._alliance)
               {
                  this._alliance.allianceRecruitmentInfo = allianceRecruitmentData;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceRecruitmentDataReceived,allianceRecruitmentData);
               return true;
            case msg is SendAllianceRecruitmentDataAction:
               newAllianceRecruitmentData = (msg as SendAllianceRecruitmentDataAction).recruitmentData;
               if(newAllianceRecruitmentData === null)
               {
                  return true;
               }
               aurimsg = new AllianceUpdateRecruitmentInformationMessage();
               aurimsg.initAllianceUpdateRecruitmentInformationMessage(newAllianceRecruitmentData.unwrap());
               ConnectionsHandler.getConnection().send(aurimsg);
               return true;
               break;
            case msg is AllianceRanksRequestAction:
               arrm = new AllianceRanksRequestMessage();
               arrm.initAllianceRanksRequestMessage();
               ConnectionsHandler.getConnection().send(arrm);
               return true;
            case msg is AllianceRanksMessage:
               arm = msg as AllianceRanksMessage;
               lastAllianceRankCount = this._allianceRanksSorted.length;
               this._allianceRanks = new Dictionary(true);
               this._allianceRanksSorted = new Vector.<RankInformation>();
               for each(rankInfo in arm.ranks)
               {
                  if(rankInfo.name.indexOf("alliance.rank.") != -1)
                  {
                     rankData = AllianceRank.getAllianceRankById(rankInfo.id);
                     if(rankData)
                     {
                        rankInfo.name = rankData.name;
                     }
                  }
                  this._allianceRanks[rankInfo.id] = rankInfo;
                  this._allianceRanksSorted.push(rankInfo);
                  if(this._playerAllianceRank && this._playerAllianceRank.id == rankInfo.id)
                  {
                     this._playerAllianceRank = rankInfo;
                  }
               }
               this._allianceRanksSorted = this._allianceRanksSorted.sort(function(rank1:RankInformation, rank2:RankInformation):int
               {
                  return rank1.order - rank2.order;
               });
               if(this._alliance && this._allianceMembers != null && lastAllianceRankCount == this._allianceRanksSorted.length)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceInformationsMembers,this._allianceMembers);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceRanksReceived,this._allianceRanksSorted);
               return true;
            case msg is AllianceRankCreateRequestAction:
               arcra = msg as AllianceRankCreateRequestAction;
               arcrm = new AllianceRankCreateRequestMessage();
               arcrm.initAllianceRankCreateRequestMessage(arcra.parentRankId,arcra.gfxId,arcra.name);
               ConnectionsHandler.getConnection().send(arcrm);
               return true;
            case msg is AllianceAllRanksUpdateRequestAction:
               aarura = msg as AllianceAllRanksUpdateRequestAction;
               aarurm = new AllianceAllRanksUpdateRequestMessage();
               aarurm.initAllianceAllRanksUpdateRequestMessage(aarura.ranks);
               ConnectionsHandler.getConnection().send(aarurm);
               return true;
            case msg is AllianceRankUpdateRequestAction:
               arura = msg as AllianceRankUpdateRequestAction;
               arurm = new AllianceRankUpdateRequestMessage();
               arurm.initAllianceRankUpdateRequestMessage(arura.rank);
               ConnectionsHandler.getConnection().send(arurm);
               return true;
            case msg is AllianceRankRemoveRequestAction:
               arrra = msg as AllianceRankRemoveRequestAction;
               arrrm = new AllianceRankRemoveRequestMessage();
               arrrm.initAllianceRankRemoveRequestMessage(arrra.rankId,arrra.newRankId);
               ConnectionsHandler.getConnection().send(arrrm);
               return true;
            case msg is AllianceRightsUpdateAction:
               arua = msg as AllianceRightsUpdateAction;
               arum = new AllianceRightsUpdateMessage();
               arum.initAllianceRightsUpdateMessage(arua.rankId,arua.rights);
               ConnectionsHandler.getConnection().send(arum);
               return true;
            case msg is AllianceMotdSetRequestAction:
               amsra = msg as AllianceMotdSetRequestAction;
               amsrmsg = new AllianceMotdSetRequestMessage();
               amsrmsg.initAllianceMotdSetRequestMessage(amsra.content);
               ConnectionsHandler.getConnection().send(amsrmsg);
               return true;
            case msg is AllianceMotdMessage:
               amomsg = msg as AllianceMotdMessage;
               allianceMotdContent = amomsg.content;
               allianceMotdPattern = /</g;
               allianceMotdContent = allianceMotdContent.replace(allianceMotdPattern,"&lt;");
               allianceMotd = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(allianceMotdContent,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,amomsg.memberId,amomsg.memberName);
               this._alliance.motd = amomsg.content;
               this._alliance.formattedMotd = allianceMotd[0];
               this._alliance.motdWriterId = amomsg.memberId;
               this._alliance.motdWriterName = amomsg.memberName;
               this._alliance.motdTimestamp = amomsg.timestamp;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceMotd);
               if(amomsg.content != "" && !OptionManager.getOptionManager("dofus").getOption("disableAllianceMotd"))
               {
                  allianceMotdText = I18n.getUiText("ui.motd.alliance") + I18n.getUiText("ui.common.colon") + allianceMotd[0];
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,allianceMotdText,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is AllianceMotdSetErrorMessage:
               amosemsg = msg as AllianceMotdSetErrorMessage;
               switch(amosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     motdErrorReason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     motdErrorReason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     motdErrorReason = I18n.getUiText("ui.alliance.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,motdErrorReason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is AllianceBulletinSetRequestAction:
               absra = msg as AllianceBulletinSetRequestAction;
               absrmsg = new AllianceBulletinSetRequestMessage();
               absrmsg.initAllianceBulletinSetRequestMessage(absra.content);
               ConnectionsHandler.getConnection().send(absrmsg);
               return true;
            case msg is AllianceBulletinMessage:
               abomsg = msg as AllianceBulletinMessage;
               allianceBulletinContent = abomsg.content;
               pattern = /</g;
               allianceBulletinContent = allianceBulletinContent.replace(pattern,"&lt;");
               allianceBulletinContents = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(allianceBulletinContent,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,abomsg.memberId,abomsg.memberName);
               this._alliance.bulletin = abomsg.content;
               this._alliance.formattedBulletin = allianceBulletinContents[0];
               this._alliance.bulletinWriterId = abomsg.memberId;
               this._alliance.bulletinWriterName = abomsg.memberName;
               this._alliance.bulletinTimestamp = abomsg.timestamp * 1000;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceBulletin);
               return true;
            case msg is AllianceBulletinSetErrorMessage:
               abosemsg = msg as AllianceBulletinSetErrorMessage;
               switch(abosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     reason = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     reason = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     reason = I18n.getUiText("ui.alliance.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            default:
               return false;
         }
      }
      
      private function displayError(reason:uint) : void
      {
         var txt:String = null;
         switch(reason)
         {
            case ListAddFailureEnum.LIST_ADD_FAILURE_UNKNOWN:
               txt = I18n.getUiText("ui.common.unknowReason");
               break;
            case ListAddFailureEnum.LIST_ADD_FAILURE_OVER_QUOTA:
               txt = I18n.getUiText("ui.social.friend.addFailureListFull");
               break;
            case ListAddFailureEnum.LIST_ADD_FAILURE_NOT_FOUND:
               txt = I18n.getUiText("ui.social.friend.addFailureNotFound");
               break;
            case ListAddFailureEnum.LIST_ADD_FAILURE_EGOCENTRIC:
               txt = I18n.getUiText("ui.social.friend.addFailureEgocentric");
               break;
            case ListAddFailureEnum.LIST_ADD_FAILURE_IS_DOUBLE:
               txt = I18n.getUiText("ui.social.friend.addFailureAlreadyInList");
               break;
            case ListAddFailureEnum.LIST_ADD_FAILURE_IS_CONFLICTING_DOUBLE:
               txt = I18n.getUiText("ui.social.friend.addFailureAlreadyInConflictedList");
         }
         KernelEventsManager.getInstance().processCallback(SocialHookList.FailInvitation,txt);
      }
      
      public function isMe(name:String, tag:String = "") : Boolean
      {
         return tag == "" && name == PlayedCharacterManager.getInstance().infos.name || name == PlayerManager.getInstance().nickname && tag == PlayerManager.getInstance().tag;
      }
      
      public function isIgnored(name:String, accountId:int = 0) : Boolean
      {
         var loser:IgnoredWrapper = null;
         var accountName:String = AccountManager.getInstance().getAccountName(name);
         for each(loser in this._ignoredList)
         {
            if(accountId != 0 && loser.accountId == accountId || accountName && loser.name.toLowerCase() == accountName.toLowerCase())
            {
               return true;
            }
         }
         return false;
      }
      
      public function isFriendOrContact(playerName:String) : Boolean
      {
         return this.isFriend(playerName) || this.isContact(playerName);
      }
      
      public function isFriend(playerName:String) : Boolean
      {
         var fw:FriendWrapper = null;
         if(this._friendsList == null)
         {
            return false;
         }
         var n:int = this._friendsList.length;
         for(var i:int = 0; i < n; i++)
         {
            fw = this._friendsList[i] as FriendWrapper;
            if(fw.playerName == playerName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isContact(playerName:String) : Boolean
      {
         var cw:ContactWrapper = null;
         if(this._contactsList == null)
         {
            return false;
         }
         var n:int = this._contactsList.length;
         for(var i:int = 0; i < n; i++)
         {
            cw = this._contactsList[i] as ContactWrapper;
            if(cw.playerName == playerName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isEnemy(playerName:String) : Boolean
      {
         var ew:EnemyWrapper = null;
         var n:int = this._enemiesList.length;
         for(var i:int = 0; i < n; i++)
         {
            ew = this._enemiesList[i] as EnemyWrapper;
            if(ew.playerName == playerName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isLenghtCorrect(name:String, tag:String) : Boolean
      {
         if(tag == "" && (name.length < ProtocolConstantsEnum.MIN_PLAYER_NAME_LEN || name.length > ProtocolConstantsEnum.MAX_PLAYER_NAME_LEN))
         {
            return false;
         }
         return !(tag != "" && (name.length < ProtocolConstantsEnum.MIN_ACCOUNT_NAME_LEN || name.length > ProtocolConstantsEnum.MAX_ACCOUNT_NAME_LEN || tag.length != ProtocolConstantsEnum.ACCOUNT_TAG_LEN));
      }
      
      public function createAbstractPlayerSearchInformation(name:String, tag:String) : AbstractPlayerSearchInformation
      {
         if(tag == "")
         {
            return new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(name);
         }
         return new PlayerSearchTagInformation().initPlayerSearchTagInformation(new AccountTagInformation().initAccountTagInformation(name,tag));
      }
      
      private function enableLevelupWarn(enabled:Boolean) : void
      {
         this._warnWhenFriendOrGuildMemberLvlUp = enabled;
         var fswolgmsg:FriendSetWarnOnLevelGainMessage = new FriendSetWarnOnLevelGainMessage();
         fswolgmsg.initFriendSetWarnOnLevelGainMessage(enabled);
         ConnectionsHandler.getConnection().send(fswolgmsg);
      }
      
      private function enableAchievementWarn(enabled:Boolean) : void
      {
         this._warnWhenFriendOrGuildMemberAchieve = enabled;
         var fgswoacmsg:FriendGuildSetWarnOnAchievementCompleteMessage = new FriendGuildSetWarnOnAchievementCompleteMessage();
         fgswoacmsg.initFriendGuildSetWarnOnAchievementCompleteMessage(enabled);
         ConnectionsHandler.getConnection().send(fgswoacmsg);
      }
      
      private function enablePermaDeathWarn(enabled:Boolean) : void
      {
         this._warnOnHardcoreDeath = enabled;
         var wopdmsg:WarnOnPermaDeathMessage = new WarnOnPermaDeathMessage();
         wopdmsg.initWarnOnPermaDeathMessage(enabled);
         ConnectionsHandler.getConnection().send(wopdmsg);
      }
      
      private function enableFriendConnectionWarn(enabled:Boolean) : void
      {
         this._warnOnFrienConnec = enabled;
         var fsocmsg:FriendSetWarnOnConnectionMessage = new FriendSetWarnOnConnectionMessage();
         fsocmsg.initFriendSetWarnOnConnectionMessage(enabled);
         ConnectionsHandler.getConnection().send(fsocmsg);
      }
      
      private function enableShareStatusToFriends(enabled:Boolean) : void
      {
         this._shareStatus = enabled;
         var fsssm:FriendSetStatusShareMessage = new FriendSetStatusShareMessage();
         fsssm.initFriendSetStatusShareMessage(enabled);
         ConnectionsHandler.getConnection().send(fsssm);
      }
   }
}

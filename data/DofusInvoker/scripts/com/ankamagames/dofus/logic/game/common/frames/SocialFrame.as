package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.guild.GuildRank;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.servers.ServerTemporisSeason;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildApplicationWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.ContactWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SocialCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowGuildManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuildPrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.CreateGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildApplicationsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildChangeMemberParametersAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCharacsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildDeleteApplicationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFactsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFarmTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetPlayerApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationByNameAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.social.StartListenGuildChestStructureAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StatusShareSetAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.StopListenGuildChestStructureAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.WarnOnHardcoreDeathAction;
   import com.ankamagames.dofus.logic.game.common.managers.ChatAutocompleteNameManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.ListAddFailureEnum;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
   import com.ankamagames.dofus.network.enums.SocialGroupInvitationStateEnum;
   import com.ankamagames.dofus.network.enums.SocialNoticeErrorEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorErrorReasonEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorMovementTypeEnum;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildSetWarnOnAchievementCompleteMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.FriendGuildWarnOnAchievementCompleteStateMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateErrorMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.WarnOnPermaDeathMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.AllianceTaxCollectorDialogQuestionExtendedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionBasicMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.TaxCollectorDialogQuestionExtendedMessage;
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
   import com.ankamagames.dofus.network.messages.game.friend.GuildMemberSetWarnOnConnectionMessage;
   import com.ankamagames.dofus.network.messages.game.friend.GuildMemberWarnOnConnectionStateMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.GuildInAllianceFactsMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsGeneralMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMemberUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsMembersMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInformationsPaddocksMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInfosUpgradeMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationSearchMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecrutedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationStateRecruterMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildJoinAutomaticallyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildJoinedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildKickRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildLeftMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberLeavingMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMemberOnlineStatusMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildMembershipMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildApplicationReceivedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildDeleteApplicationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.application.GuildGetPlayerApplicationMessage;
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
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightLeaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersEnemiesListMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersEnemyRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersHelpersJoinMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightPlayersHelpersLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.GuildFightTakePlaceRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorAttackedMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorAttackedResultMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorErrorMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorListMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementAddMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorMovementsOfflineMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TaxCollectorStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.guild.tax.TopTaxCollectorListMessage;
   import com.ankamagames.dofus.network.messages.game.house.HouseTeleportRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeGuildTaxCollectorGetMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookErrorMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
   import com.ankamagames.dofus.network.types.common.AbstractPlayerSearchInformation;
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.common.PlayerSearchTagInformation;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceInformation;
   import com.ankamagames.dofus.network.types.game.friend.AcquaintanceOnlineInformation;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.network.types.game.guild.application.GuildApplicationInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorMovement;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
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
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.filesystem.File;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SocialFrame implements Frame
   {
      
      public static const MAX_MEMBERS:uint = 240;
      
      private static const MAX_LEVEL:uint = 200;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));
      
      private static var _instance:SocialFrame;
       
      
      private var _guildDialogFrame:GuildDialogFrame;
      
      private var _friendsList:Vector.<SocialCharacterWrapper>;
      
      private var _contactsList:Vector.<SocialCharacterWrapper>;
      
      private var _enemiesList:Vector.<SocialCharacterWrapper>;
      
      private var _ignoredList:Vector.<SocialCharacterWrapper>;
      
      private var _spouse:SpouseWrapper;
      
      private var _hasGuild:Boolean = false;
      
      private var _hasSpouse:Boolean = false;
      
      private var _guild:GuildWrapper;
      
      private var _guildMembers:Vector.<GuildMember>;
      
      private var _playerGuildRank:GuildRankInformation;
      
      private var _guildRanks:Dictionary;
      
      private var _guildRanksSorted:Vector.<GuildRankInformation>;
      
      private var _guildHouses:Vector.<GuildHouseWrapper>;
      
      private var _guildHousesList:Boolean = false;
      
      private var _guildHousesListUpdate:Boolean = false;
      
      private var _guildPaddocks:Vector.<PaddockContentInformations>;
      
      private var _guildPaddocksMax:int = 1;
      
      private var _guildRankIconIds:Vector.<uint>;
      
      private var _guildRankIconUri:Dictionary;
      
      private var _shareStatus:Boolean = true;
      
      private var _warnOnFrienConnec:Boolean;
      
      private var _warnOnMemberConnec:Boolean;
      
      private var _warnWhenFriendOrGuildMemberLvlUp:Boolean;
      
      private var _warnWhenFriendOrGuildMemberAchieve:Boolean;
      
      private var _warnOnHardcoreDeath:Boolean;
      
      private var _autoLeaveHelpers:Boolean;
      
      private var _allGuilds:Dictionary;
      
      private var _allGuildsInDirectory:Vector.<GuildWrapper>;
      
      private var _dungeonTopTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _topTaxCollectors:Vector.<TaxCollectorInformations>;
      
      public function SocialFrame()
      {
         this._guildRanks = new Dictionary(true);
         this._guildRanksSorted = new Vector.<GuildRankInformation>();
         this._guildHouses = new Vector.<GuildHouseWrapper>();
         this._guildPaddocks = new Vector.<PaddockContentInformations>();
         this._guildRankIconIds = new Vector.<uint>();
         this._guildRankIconUri = new Dictionary();
         this._allGuilds = new Dictionary(true);
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
      
      public function get guildmembers() : Vector.<GuildMember>
      {
         return this._guildMembers;
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
      
      public function get warnMemberConnec() : Boolean
      {
         return this._warnOnMemberConnec;
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
      
      public function getGuildById(id:int) : GuildFactSheetWrapper
      {
         return this._allGuilds[id];
      }
      
      public function updateGuildById(id:int, guild:GuildFactSheetWrapper) : void
      {
         this._allGuilds[id] = guild;
      }
      
      public function getGuildRankById(id:uint) : GuildRankInformation
      {
         return this._guildRanks[id];
      }
      
      public function getGuildRanks() : Vector.<GuildRankInformation>
      {
         return this._guildRanksSorted;
      }
      
      public function getGuildRanksIconIds() : Vector.<uint>
      {
         return this._guildRankIconIds;
      }
      
      public function get playerGuildRank() : GuildRankInformation
      {
         return this._playerGuildRank;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._enemiesList = new Vector.<SocialCharacterWrapper>();
         this._ignoredList = new Vector.<SocialCharacterWrapper>();
         this._guildDialogFrame = new GuildDialogFrame();
         ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
         ConnectionsHandler.getConnection().send(new AcquaintancesGetListMessage());
         ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
         ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
         ConnectionsHandler.getConnection().send(new GuildGetPlayerApplicationMessage());
         ConnectionsHandler.getConnection().send(new GuildRanksRequestMessage());
         this.fillGuildRanksIconsList();
         return true;
      }
      
      private function fillGuildRanksIconsList() : void
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
                  this._guildRankIconIds.push(iconId);
                  this._guildRankIconUri[iconId] = new Uri(file.nativePath);
               }
            }
         }
         this._guildRankIconIds.sort(Array.NUMERIC);
      }
      
      public function getGuildRankIconUriById(id:uint) : Uri
      {
         return this._guildRankIconUri[id];
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         TaxCollectorsManager.getInstance().destroy();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var reason:String = null;
         var foi:FriendOnlineInformations = null;
         var aoi:AcquaintanceOnlineInformation = null;
         var notificationId:uint = 0;
         var rank:GuildRankInformation = null;
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
         var fsssm:FriendSetStatusShareMessage = null;
         var fwsa:FriendWarningSetAction = null;
         var fsocmsg:FriendSetWarnOnConnectionMessage = null;
         var mwsa:MemberWarningSetAction = null;
         var gmswocmsg:GuildMemberSetWarnOnConnectionMessage = null;
         var fogmwsa:FriendOrGuildMemberLevelUpWarningSetAction = null;
         var fswolgmsg:FriendSetWarnOnLevelGainMessage = null;
         var fgswoaca:FriendGuildSetWarnOnAchievementCompleteAction = null;
         var fgswoacmsg:FriendGuildSetWarnOnAchievementCompleteMessage = null;
         var wohda:WarnOnHardcoreDeathAction = null;
         var wopdmsg:WarnOnPermaDeathMessage = null;
         var ssmsg:SpouseStatusMessage = null;
         var msumsg:MoodSmileyUpdateMessage = null;
         var fsssmsg:FriendStatusShareStateMessage = null;
         var fwocsmsg:FriendWarnOnConnectionStateMessage = null;
         var gmwocsmsg:GuildMemberWarnOnConnectionStateMessage = null;
         var gmosm:GuildMemberOnlineStatusMessage = null;
         var fwolgsmsg:FriendWarnOnLevelGainStateMessage = null;
         var fgwoacsmsg:FriendGuildWarnOnAchievementCompleteStateMessage = null;
         var wopdsmsg:WarnOnPermaDeathStateMessage = null;
         var gimmsg:GuildInformationsMembersMessage = null;
         var ghimsg:GuildHousesInformationMessage = null;
         var gmsmsg:GuildModificationStartedMessage = null;
         var gcrmsg:GuildCreationResultMessage = null;
         var errorMessage:String = null;
         var gimsg:GuildInvitedMessage = null;
         var gisrermsg:GuildInvitationStateRecruterMessage = null;
         var gisredmsg:GuildInvitationStateRecrutedMessage = null;
         var gjmsg:GuildJoinedMessage = null;
         var joinMessage:String = null;
         var seasonNumber:int = 0;
         var gigmsg:GuildInformationsGeneralMessage = null;
         var gimumsg:GuildInformationsMemberUpdateMessage = null;
         var member:GuildMember = null;
         var memberRank:GuildRankInformation = null;
         var gmlmsg:GuildMemberLeavingMessage = null;
         var comptgm:uint = 0;
         var gipmsg:GuildInfosUpgradeMessage = null;
         var gfphjmsg:GuildFightPlayersHelpersJoinMessage = null;
         var gfphlmsg:GuildFightPlayersHelpersLeaveMessage = null;
         var gfpelmsg:GuildFightPlayersEnemiesListMessage = null;
         var gfpermsg:GuildFightPlayersEnemyRemoveMessage = null;
         var tcmmsg:TaxCollectorMovementMessage = null;
         var infoText:String = null;
         var taxCollectorName:String = null;
         var worldMapId:int = 0;
         var playerLink:String = null;
         var mapLink:String = null;
         var tcamsg:TaxCollectorAttackedMessage = null;
         var worldX:int = 0;
         var worldY:int = 0;
         var taxCollectorN:String = null;
         var sentenceToDisplatch:String = null;
         var tcarmsg:TaxCollectorAttackedResultMessage = null;
         var sentenceToDisplatchResultAttack:String = null;
         var taxCName:String = null;
         var guildName:String = null;
         var pointAttacked:WorldPointWrapper = null;
         var worldPosX:int = 0;
         var worldPosY:int = 0;
         var tcemsg:TaxCollectorErrorMessage = null;
         var errorTaxCollectorMessage:String = null;
         var tclmamsg:TaxCollectorListMessage = null;
         var tcmamsg:TaxCollectorMovementAddMessage = null;
         var oldState:int = 0;
         var newTC:Boolean = false;
         var newState:int = 0;
         var tcmrmsg:TaxCollectorMovementRemoveMessage = null;
         var tcsumsg:TaxCollectorStateUpdateMessage = null;
         var tcmomsg:TaxCollectorMovementsOfflineMessage = null;
         var tcm:TaxCollectorMovement = null;
         var tcOffName:String = null;
         var tcOffPlayerLink:String = null;
         var tcOffPoint:WorldPointWrapper = null;
         var tcOffWorldMapId:int = 0;
         var tcOffMapLink:String = null;
         var sentenceToDisplatchDisappearances:String = null;
         var tcHarvestedNamesList:String = null;
         var tcDefeatedNamesList:String = null;
         var harvestedNumber:int = 0;
         var defeatedNumber:int = 0;
         var ttclmsg:TopTaxCollectorListMessage = null;
         var egtcgmsg:ExchangeGuildTaxCollectorGetMessage = null;
         var totalQuantity:uint = 0;
         var taxCollectorObjet:ObjectItemGenericQuantity = null;
         var idFName:Number = NaN;
         var idName:Number = NaN;
         var collectedTaxCollectors:Dictionary = null;
         var taxCollectorWrapper:TaxCollectorWrapper = null;
         var taxcollectorCollectedMsg:String = null;
         var gifmsg:GuildInformationsPaddocksMessage = null;
         var gpbmsg:GuildPaddockBoughtMessage = null;
         var gprmsg:GuildPaddockRemovedMessage = null;
         var atcdqemsg:AllianceTaxCollectorDialogQuestionExtendedMessage = null;
         var tcdqemsg:TaxCollectorDialogQuestionExtendedMessage = null;
         var tcdqbmsg:TaxCollectorDialogQuestionBasicMessage = null;
         var guildw:GuildWrapper = null;
         var clmsg:ContactLookMessage = null;
         var clemsg:ContactLookErrorMessage = null;
         var ggia:GuildGetInformationsAction = null;
         var askInformation:Boolean = false;
         var gia:GuildInvitationAction = null;
         var ginvitationmsg:GuildInvitationMessage = null;
         var gibna:GuildInvitationByNameAction = null;
         var gibnmsg:GuildInvitationSearchMessage = null;
         var player_GIBNMSG:PlayerSearchCharacterNameInformation = null;
         var gdarmsg:GuildDeleteApplicationRequestMessage = null;
         var gadm:GuildApplicationDeletedMessage = null;
         var gjra:GuildJoinRequestAction = null;
         var gjarmsg:GuildJoinAutomaticallyRequestMessage = null;
         var gsaa:GuildSubmitApplicationAction = null;
         var gsamsg:GuildSubmitApplicationMessage = null;
         var guaa:GuildUpdateApplicationAction = null;
         var guamsg:GuildUpdateApplicationMessage = null;
         var gaiamsg:GuildApplicationIsAnsweredMessage = null;
         var notifId:uint = 0;
         var garmsg:GuildApplicationReceivedMessage = null;
         var grimsg:GuildRecruitmentInvalidateMessage = null;
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
         var garaction:GuildApplicationsRequestAction = null;
         var glarmsg:GuildListApplicationRequestMessage = null;
         var glaamsg:GuildListApplicationAnswerMessage = null;
         var applicationDescrs:Vector.<GuildApplicationWrapper> = null;
         var guildApplicationReplyAction:GuildApplicationReplyAction = null;
         var guildApplicationAnswerMessage:GuildApplicationAnswerMessage = null;
         var glammsg:GuildListApplicationModifiedMessage = null;
         var gsra:GuildSummaryRequestAction = null;
         var gsrm:GuildSummaryRequestMessage = null;
         var gsm:GuildSummaryMessage = null;
         var guildWrapper:GuildWrapper = null;
         var ggpam:GuildGetPlayerApplicationMessage = null;
         var gpaim:GuildPlayerApplicationInformationMessage = null;
         var gnuaction:GuildNoteUpdateAction = null;
         var gunmsg:GuildUpdateNoteMessage = null;
         var gfjra:GuildFightJoinRequestAction = null;
         var gfjrmsg:GuildFightJoinRequestMessage = null;
         var gftpra:GuildFightTakePlaceRequestAction = null;
         var gftprmsg:GuildFightTakePlaceRequestMessage = null;
         var gflra:GuildFightLeaveRequestAction = null;
         var gflrmsg:GuildFightLeaveRequestMessage = null;
         var gfra:GuildFactsRequestAction = null;
         var gfrmsg:GuildFactsRequestMessage = null;
         var gfmsg:GuildFactsMessage = null;
         var guildSheet:GuildFactSheetWrapper = null;
         var allianceId:uint = 0;
         var allianceName:String = null;
         var allianceTag:String = null;
         var gmsra:GuildMotdSetRequestAction = null;
         var gmsrmsg:GuildMotdSetRequestMessage = null;
         var gmomsg:GuildMotdMessage = null;
         var content:String = null;
         var pattern:RegExp = null;
         var motdContent:Array = null;
         var gmosemsg:GuildMotdSetErrorMessage = null;
         var gbsra:GuildBulletinSetRequestAction = null;
         var gbsrmsg:GuildBulletinSetRequestMessage = null;
         var gbomsg:GuildBulletinMessage = null;
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
         var grra:GuildRanksRequestAction = null;
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
         var memberm:GuildMember = null;
         var nm:int = 0;
         var imood:int = 0;
         var frdmood:FriendWrapper = null;
         var cttmood:ContactWrapper = null;
         var memberName:String = null;
         var gm:GuildMember = null;
         var friend:Boolean = false;
         var fr:FriendWrapper = null;
         var mb:GuildMember = null;
         var houseInformation:HouseInformationsForGuild = null;
         var ghw:GuildHouseWrapper = null;
         var nmu:int = 0;
         var k:int = 0;
         var guildMember:GuildMember = null;
         var text:String = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         var guildName2:String = null;
         var subareaName:String = null;
         var suba:SubArea = null;
         var nid:uint = 0;
         var openSocialParams:Array = null;
         var taxCollectorInfo:TaxCollectorInformations = null;
         var dungeonTopTaxCollectors:Vector.<TaxCollectorWrapper> = null;
         var topTaxCollectors:Vector.<TaxCollectorWrapper> = null;
         var ggimsg:GuildGetInformationsMessage = null;
         var filters:Object = null;
         var ds:DataStoreType = null;
         var applicationInfo:GuildApplicationInformation = null;
         var guildFactInfo:GuildFactSheetInformations = null;
         var tc2:TaxCollectorWrapper = null;
         var tcInFight:SocialEntityInFightWrapper = null;
         var defender:SocialFightersWrapper = null;
         var ghuimsg:GuildHouseUpdateInformationMessage = null;
         var toUpdate:Boolean = false;
         var house1:GuildHouseWrapper = null;
         var ghw1:GuildHouseWrapper = null;
         var ghrmsg:GuildHouseRemoveMessage = null;
         var iGHR:int = 0;
         var giafmsg:GuildInAllianceFactsMessage = null;
         var textMotd:String = null;
         var members:GuildMember = null;
         var snm:int = 0;
         var istatus:int = 0;
         var frdstatus:FriendWrapper = null;
         var ctcStatus:ContactWrapper = null;
         var clrbim:ContactLookRequestByIdMessage = null;
         var guildRankInfo:GuildRankInformation = null;
         var guildRankData:GuildRank = null;
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
               this._shareStatus = sssa.enable;
               fsssm = new FriendSetStatusShareMessage();
               fsssm.initFriendSetStatusShareMessage(sssa.enable);
               ConnectionsHandler.getConnection().send(fsssm);
               return true;
            case msg is FriendWarningSetAction:
               fwsa = msg as FriendWarningSetAction;
               this._warnOnFrienConnec = fwsa.enable;
               fsocmsg = new FriendSetWarnOnConnectionMessage();
               fsocmsg.initFriendSetWarnOnConnectionMessage(fwsa.enable);
               ConnectionsHandler.getConnection().send(fsocmsg);
               return true;
            case msg is MemberWarningSetAction:
               mwsa = msg as MemberWarningSetAction;
               this._warnOnMemberConnec = mwsa.enable;
               gmswocmsg = new GuildMemberSetWarnOnConnectionMessage();
               gmswocmsg.initGuildMemberSetWarnOnConnectionMessage(mwsa.enable);
               ConnectionsHandler.getConnection().send(gmswocmsg);
               return true;
            case msg is FriendOrGuildMemberLevelUpWarningSetAction:
               fogmwsa = msg as FriendOrGuildMemberLevelUpWarningSetAction;
               this._warnWhenFriendOrGuildMemberLvlUp = fogmwsa.enable;
               fswolgmsg = new FriendSetWarnOnLevelGainMessage();
               fswolgmsg.initFriendSetWarnOnLevelGainMessage(fogmwsa.enable);
               ConnectionsHandler.getConnection().send(fswolgmsg);
               return true;
            case msg is FriendGuildSetWarnOnAchievementCompleteAction:
               fgswoaca = msg as FriendGuildSetWarnOnAchievementCompleteAction;
               this._warnWhenFriendOrGuildMemberAchieve = fgswoaca.enable;
               fgswoacmsg = new FriendGuildSetWarnOnAchievementCompleteMessage();
               fgswoacmsg.initFriendGuildSetWarnOnAchievementCompleteMessage(fgswoaca.enable);
               ConnectionsHandler.getConnection().send(fgswoacmsg);
               return true;
            case msg is WarnOnHardcoreDeathAction:
               wohda = msg as WarnOnHardcoreDeathAction;
               this._warnOnHardcoreDeath = wohda.enable;
               wopdmsg = new WarnOnPermaDeathMessage();
               wopdmsg.initWarnOnPermaDeathMessage(wohda.enable);
               ConnectionsHandler.getConnection().send(wopdmsg);
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
                        memberm = this._guildMembers[imood];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,memberm);
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
            case msg is GuildMemberWarnOnConnectionStateMessage:
               gmwocsmsg = msg as GuildMemberWarnOnConnectionStateMessage;
               this._warnOnMemberConnec = gmwocsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState,gmwocsmsg.enable);
               return true;
            case msg is GuildMemberOnlineStatusMessage:
               if(!this._friendsList)
               {
                  return true;
               }
               gmosm = msg as GuildMemberOnlineStatusMessage;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.MEMBER_CONNECTION) && this._warnOnMemberConnec && gmosm.online)
               {
                  for each(gm in this._guildMembers)
                  {
                     if(gm.id == gmosm.memberId)
                     {
                        memberName = gm.name;
                        break;
                     }
                  }
                  friend = false;
                  for each(fr in this._friendsList)
                  {
                     if(fr.name == memberName)
                     {
                        friend = true;
                        break;
                     }
                  }
                  if(!(friend && !ExternalNotificationManager.getInstance().isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.FRIEND_CONNECTION)))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.MEMBER_CONNECTION,[memberName,gmosm.memberId]);
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
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_ALREADY_IN_GROUP:
                     errorMessage = I18n.getUiText("ui.guild.alreadyInGuild");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.guild.AlreadyUseEmblem");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
                     errorMessage = I18n.getUiText("ui.guild.AlreadyUseName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
                     errorMessage = I18n.getUiText("ui.guild.invalidName");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
                     errorMessage = I18n.getUiText("ui.guild.requirementUnmet");
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
                     Kernel.getWorker().removeFrame(this._guildDialogFrame);
                     this._hasGuild = true;
                     break;
                  case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_UNKNOWN:
                     errorMessage = I18n.getUiText("ui.common.unknownFail");
               }
               if(errorMessage)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationResult,gcrmsg.result);
               return true;
            case msg is GuildInvitedMessage:
               gimsg = msg as GuildInvitedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited,gimsg.guildInfo.guildId,gimsg.guildInfo.guildName,gimsg.recruterId,gimsg.recruterName);
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
               seasonNumber = !!ServerTemporisSeason.getCurrentSeason() ? int(ServerTemporisSeason.getCurrentSeason().seasonNumber) : -1;
               if(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && seasonNumber == 5)
               {
                  notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.xpGuild"),I18n.getUiText("ui.social.modifyXpGuild"),NotificationTypeEnum.TUTORIAL,"temporisXpGuild_T" + seasonNumber);
                  NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.common.modify"),"OpenSocialAction",[DataEnum.SOCIAL_TAB_GUILD_ID]);
                  NotificationManager.getInstance().sendNotification(notificationId);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildJoined);
               return true;
            case msg is GuildInformationsGeneralMessage:
               gigmsg = msg as GuildInformationsGeneralMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral,gigmsg.expLevelFloor,gigmsg.experience,gigmsg.expNextLevelFloor,gigmsg.level,gigmsg.creationDate,gigmsg.abandonnedPaddock,gigmsg.nbConnectedMembers,gigmsg.nbTotalMembers);
               this._guild.level = gigmsg.level;
               this._guild.experience = gigmsg.experience;
               this._guild.expLevelFloor = gigmsg.expLevelFloor;
               this._guild.expNextLevelFloor = gigmsg.expNextLevelFloor;
               this._guild.creationDate = gigmsg.creationDate;
               this._guild.nbMembers = gigmsg.nbTotalMembers;
               this._guild.nbConnectedMembers = gigmsg.nbConnectedMembers;
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
                  this._guildMembers = new Vector.<GuildMember>();
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
            case msg is GuildInfosUpgradeMessage:
               gipmsg = msg as GuildInfosUpgradeMessage;
               TaxCollectorsManager.getInstance().updateGuild(gipmsg.maxTaxCollectorsCount,gipmsg.taxCollectorsCount,gipmsg.taxCollectorLifePoints,gipmsg.taxCollectorDamagesBonuses,gipmsg.taxCollectorPods,gipmsg.taxCollectorProspecting,gipmsg.taxCollectorWisdom);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade,gipmsg.boostPoints,gipmsg.maxTaxCollectorsCount,gipmsg.spellId,gipmsg.spellLevel,gipmsg.taxCollectorDamagesBonuses,gipmsg.taxCollectorLifePoints,gipmsg.taxCollectorPods,gipmsg.taxCollectorProspecting,gipmsg.taxCollectorsCount,gipmsg.taxCollectorWisdom);
               return true;
            case msg is GuildFightPlayersHelpersJoinMessage:
               gfphjmsg = msg as GuildFightPlayersHelpersJoinMessage;
               TaxCollectorsManager.getInstance().addFighter(0,gfphjmsg.fightId,gfphjmsg.playerInfo,true);
               return true;
            case msg is GuildFightPlayersHelpersLeaveMessage:
               gfphlmsg = msg as GuildFightPlayersHelpersLeaveMessage;
               if(this._autoLeaveHelpers)
               {
                  text = I18n.getUiText("ui.social.guild.autoFightLeave");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               TaxCollectorsManager.getInstance().removeFighter(0,gfphlmsg.fightId,gfphlmsg.playerId,true);
               return true;
            case msg is GuildFightPlayersEnemiesListMessage:
               gfpelmsg = msg as GuildFightPlayersEnemiesListMessage;
               for each(enemy in gfpelmsg.playerInfo)
               {
                  TaxCollectorsManager.getInstance().addFighter(0,gfpelmsg.fightId,enemy,false,false);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,0,gfpelmsg.fightId);
               return true;
            case msg is GuildFightPlayersEnemyRemoveMessage:
               gfpermsg = msg as GuildFightPlayersEnemyRemoveMessage;
               TaxCollectorsManager.getInstance().removeFighter(0,gfpermsg.fightId,gfpermsg.playerId,false);
               return true;
            case msg is TaxCollectorMovementMessage:
               tcmmsg = msg as TaxCollectorMovementMessage;
               taxCollectorName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcmmsg.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcmmsg.basicInfos.lastNameId).name;
               worldMapId = SubArea.getSubAreaByMapId(tcmmsg.basicInfos.mapId).worldmap.id;
               playerLink = "{player," + tcmmsg.playerName + "," + tcmmsg.playerId + "}";
               mapLink = HyperlinkMapPosition.getLink(tcmmsg.basicInfos.worldX,tcmmsg.basicInfos.worldY,worldMapId);
               switch(tcmmsg.movementType)
               {
                  case TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HIRED:
                     infoText = I18n.getUiText("ui.social.TaxCollectorAdded",[taxCollectorName,mapLink,playerLink]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infoText,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
                     break;
                  case TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HARVESTED:
                     infoText = I18n.getUiText("ui.social.TaxCollectorRemoved",[taxCollectorName,mapLink,playerLink]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,infoText,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TaxCollectorAttackedMessage:
               tcamsg = msg as TaxCollectorAttackedMessage;
               worldX = tcamsg.worldX;
               worldY = tcamsg.worldY;
               taxCollectorN = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcamsg.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcamsg.lastNameId).name;
               if(!tcamsg.guild || tcamsg.guild.guildId == this._guild.guildId)
               {
                  sentenceToDisplatch = I18n.getUiText("ui.social.TaxCollectorAttacked",[taxCollectorN,worldX + "," + worldY]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,1,2::" + sentenceToDisplatch + "}",ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               else
               {
                  guildName2 = tcamsg.guild.guildName;
                  subareaName = SubArea.getSubAreaById(tcamsg.subAreaId).name;
                  sentenceToDisplatch = I18n.getUiText("ui.guild.taxCollectorAttacked",[guildName2,subareaName,worldX + "," + worldY]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,2,2,0," + tcamsg.mapId + "::" + sentenceToDisplatch + "}",ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK,[taxCollectorN,worldX,worldY]);
               }
               if(OptionManager.getOptionManager("dofus").getOption("warnOnGuildItemAgression"))
               {
                  suba = SubArea.getSubAreaById(tcamsg.subAreaId);
                  nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.taxCollectorAttackedTitle"),I18n.getUiText("ui.guild.taxCollectorAttacked",[tcamsg.guild.guildName,suba.name,worldX + "," + worldY]),NotificationTypeEnum.INVITATION,"TaxCollectorAttacked");
                  openSocialParams = new Array();
                  if(!tcamsg.guild || tcamsg.guild.guildId == this._guild.guildId)
                  {
                     openSocialParams = [1,2];
                  }
                  else
                  {
                     openSocialParams = [2,2,[0,tcamsg.mapId]];
                  }
                  NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.common.join"),"OpenSocial",openSocialParams,true,200,0,"hook");
                  NotificationManager.getInstance().sendNotification(nid);
               }
               return true;
            case msg is TaxCollectorAttackedResultMessage:
               tcarmsg = msg as TaxCollectorAttackedResultMessage;
               taxCName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcarmsg.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcarmsg.basicInfos.lastNameId).name;
               guildName = tcarmsg.guild.guildName;
               if(guildName == "#NONAME#")
               {
                  guildName = I18n.getUiText("ui.guild.noName");
               }
               pointAttacked = new WorldPointWrapper(tcarmsg.basicInfos.mapId,true,tcarmsg.basicInfos.worldX,tcarmsg.basicInfos.worldY);
               worldPosX = pointAttacked.outdoorX;
               worldPosY = pointAttacked.outdoorY;
               if(!tcarmsg.guild || tcarmsg.guild.guildId == this._guild.guildId)
               {
                  if(tcarmsg.deadOrAlive)
                  {
                     sentenceToDisplatchResultAttack = I18n.getUiText("ui.social.TaxCollectorDied",[taxCName,worldPosX + "," + worldPosY]);
                  }
                  else
                  {
                     sentenceToDisplatchResultAttack = I18n.getUiText("ui.social.TaxCollectorSurvived",[taxCName,worldPosX + "," + worldPosY]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchResultAttack,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               else
               {
                  if(tcarmsg.deadOrAlive)
                  {
                     sentenceToDisplatchResultAttack = I18n.getUiText("ui.alliance.taxCollectorDied",[guildName,worldPosX + "," + worldPosY]);
                  }
                  else
                  {
                     sentenceToDisplatchResultAttack = I18n.getUiText("ui.alliance.taxCollectorSurvived",[guildName,worldPosX + "," + worldPosY]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchResultAttack,ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TaxCollectorErrorMessage:
               tcemsg = msg as TaxCollectorErrorMessage;
               errorTaxCollectorMessage = "";
               switch(tcemsg.reason)
               {
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ALREADY_ONE:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.alreadyTaxCollectorOnMap");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_HERE:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireTaxCollecotrHere");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_CANT_HIRE_YET:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireTaxcollectorTooTired");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_ERROR_UNKNOWN:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.unknownErrorTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_MAX_REACHED:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.cantHireMaxTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NO_RIGHTS:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.taxCollectorNoRights");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_ENOUGH_KAMAS:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.notEnougthRichToHireTaxCollector");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_FOUND:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.taxCollectorNotFound");
                     break;
                  case TaxCollectorErrorReasonEnum.TAX_COLLECTOR_NOT_OWNED:
                     errorTaxCollectorMessage = I18n.getUiText("ui.social.notYourTaxcollector");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errorTaxCollectorMessage,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is TaxCollectorListMessage:
               tclmamsg = msg as TaxCollectorListMessage;
               TaxCollectorsManager.getInstance().maxTaxCollectorsCount = tclmamsg.nbcollectorMax;
               TaxCollectorsManager.getInstance().setTaxCollectors(tclmamsg.informations);
               TaxCollectorsManager.getInstance().setTaxCollectorsFighters(tclmamsg.fightersInformations);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate,tclmamsg.infoType);
               return true;
            case msg is TaxCollectorMovementAddMessage:
               tcmamsg = msg as TaxCollectorMovementAddMessage;
               oldState = -1;
               if(TaxCollectorsManager.getInstance().taxCollectors[tcmamsg.informations.uniqueId])
               {
                  oldState = TaxCollectorsManager.getInstance().taxCollectors[tcmamsg.informations.uniqueId].state;
               }
               newTC = TaxCollectorsManager.getInstance().addTaxCollector(tcmamsg.informations);
               newState = TaxCollectorsManager.getInstance().taxCollectors[tcmamsg.informations.uniqueId].state;
               if(newTC || newState != oldState)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorUpdate,tcmamsg.informations.uniqueId);
               }
               if(newTC)
               {
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorAdd,TaxCollectorsManager.getInstance().taxCollectors[tcmamsg.informations.uniqueId]);
               }
               return true;
            case msg is TaxCollectorMovementRemoveMessage:
               tcmrmsg = msg as TaxCollectorMovementRemoveMessage;
               delete TaxCollectorsManager.getInstance().taxCollectors[tcmrmsg.collectorId];
               delete TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[tcmrmsg.collectorId];
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved,tcmrmsg.collectorId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_taxcollector" + tcmrmsg.collectorId,-1);
               return true;
            case msg is TaxCollectorStateUpdateMessage:
               tcsumsg = msg as TaxCollectorStateUpdateMessage;
               if(TaxCollectorsManager.getInstance().taxCollectors[tcsumsg.uniqueId])
               {
                  TaxCollectorsManager.getInstance().taxCollectors[tcsumsg.uniqueId].state = tcsumsg.state;
               }
               if(TaxCollectorsManager.getInstance().allTaxCollectorsInFight[tcsumsg.uniqueId])
               {
                  if(tcsumsg.state == TaxCollectorStateEnum.STATE_COLLECTING)
                  {
                     delete TaxCollectorsManager.getInstance().allTaxCollectorsInFight[tcsumsg.uniqueId];
                     KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorRemoved,tcsumsg.uniqueId);
                  }
               }
               return true;
            case msg is TaxCollectorMovementsOfflineMessage:
               tcmomsg = msg as TaxCollectorMovementsOfflineMessage;
               tcHarvestedNamesList = "";
               tcDefeatedNamesList = "";
               harvestedNumber = 0;
               defeatedNumber = 0;
               for each(tcm in tcmomsg.movements)
               {
                  tcOffName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcm.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcm.basicInfos.lastNameId).name;
                  tcOffPoint = new WorldPointWrapper(tcm.basicInfos.mapId,true,tcm.basicInfos.worldX,tcm.basicInfos.worldY);
                  tcOffWorldMapId = SubArea.getSubAreaByMapId(tcm.basicInfos.mapId).worldmap.id;
                  tcOffMapLink = HyperlinkMapPosition.getLink(tcOffPoint.outdoorX,tcOffPoint.outdoorY,tcOffWorldMapId);
                  if(tcm.movementType == TaxCollectorMovementTypeEnum.TAX_COLLECTOR_HARVESTED)
                  {
                     tcOffPlayerLink = "{player," + tcm.playerName + "," + tcm.playerId + "}";
                     tcHarvestedNamesList += I18n.getUiText("ui.guild.taxCollectorNameWithLocAndPlayer",[tcOffName,tcOffMapLink,tcOffPlayerLink]);
                     tcHarvestedNamesList += ", ";
                     harvestedNumber++;
                  }
                  else if(tcm.movementType == TaxCollectorMovementTypeEnum.TAX_COLLECTOR_DEFEATED)
                  {
                     tcDefeatedNamesList += I18n.getUiText("ui.guild.taxCollectorNameWithLoc",[tcOffName,tcOffMapLink]);
                     tcDefeatedNamesList += ", ";
                     defeatedNumber++;
                  }
               }
               if(harvestedNumber > 0)
               {
                  tcHarvestedNamesList = tcHarvestedNamesList.slice(0,tcHarvestedNamesList.length - 2);
                  if(harvestedNumber == 1)
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorHarvestedWhileAbsence",[tcHarvestedNamesList]);
                  }
                  else
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorsHarvestedWhileAbsence",[tcHarvestedNamesList]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchDisappearances,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               if(defeatedNumber > 0)
               {
                  tcDefeatedNamesList = tcDefeatedNamesList.slice(0,tcDefeatedNamesList.length - 2);
                  if(defeatedNumber == 1)
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorDefeatedWhileAbsence",[tcDefeatedNamesList]);
                  }
                  else
                  {
                     sentenceToDisplatchDisappearances = I18n.getUiText("ui.guild.taxCollectorsDefeatedWhileAbsence",[tcDefeatedNamesList]);
                  }
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,sentenceToDisplatchDisappearances,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TopTaxCollectorListMessage:
               ttclmsg = msg as TopTaxCollectorListMessage;
               if(ttclmsg.isDungeon)
               {
                  this._dungeonTopTaxCollectors = ttclmsg.informations;
               }
               else
               {
                  this._topTaxCollectors = ttclmsg.informations;
               }
               if(this._dungeonTopTaxCollectors && this._topTaxCollectors)
               {
                  dungeonTopTaxCollectors = new Vector.<TaxCollectorWrapper>(0);
                  topTaxCollectors = new Vector.<TaxCollectorWrapper>(0);
                  for each(taxCollectorInfo in this._dungeonTopTaxCollectors)
                  {
                     dungeonTopTaxCollectors.push(TaxCollectorWrapper.create(taxCollectorInfo));
                  }
                  for each(taxCollectorInfo in this._topTaxCollectors)
                  {
                     topTaxCollectors.push(TaxCollectorWrapper.create(taxCollectorInfo));
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.ShowTopTaxCollectors,dungeonTopTaxCollectors,topTaxCollectors);
                  this._dungeonTopTaxCollectors = null;
                  this._topTaxCollectors = null;
               }
               return true;
            case msg is ExchangeGuildTaxCollectorGetMessage:
               egtcgmsg = msg as ExchangeGuildTaxCollectorGetMessage;
               for each(taxCollectorObjet in egtcgmsg.objectsInfos)
               {
                  totalQuantity += taxCollectorObjet.quantity;
               }
               idFName = parseInt(egtcgmsg.collectorName.split(",")[0],36);
               idName = parseInt(egtcgmsg.collectorName.split(",")[1],36);
               collectedTaxCollectors = TaxCollectorsManager.getInstance().collectedTaxCollectors;
               taxCollectorWrapper = new TaxCollectorWrapper();
               taxCollectorWrapper.uniqueId = egtcgmsg.mapId;
               taxCollectorWrapper.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(idFName).firstname;
               taxCollectorWrapper.lastName = TaxCollectorName.getTaxCollectorNameById(idName).name;
               taxCollectorWrapper.mapWorldX = egtcgmsg.worldX;
               taxCollectorWrapper.mapWorldY = egtcgmsg.worldY;
               taxCollectorWrapper.experience = egtcgmsg.experience;
               taxCollectorWrapper.subareaId = egtcgmsg.subAreaId;
               taxCollectorWrapper.collectedItems = egtcgmsg.objectsInfos;
               taxCollectorWrapper.pods = egtcgmsg.pods;
               taxCollectorWrapper.callerId = egtcgmsg.callerId;
               taxCollectorWrapper.callerName = egtcgmsg.callerName;
               collectedTaxCollectors[taxCollectorWrapper.uniqueId] = taxCollectorWrapper;
               taxcollectorCollectedMsg = "{taxcollectorCollected," + taxCollectorWrapper.uniqueId + "::" + PatternDecoder.combine(I18n.getUiText("ui.social.taxCollector.collected",[egtcgmsg.userName,totalQuantity]),"n",totalQuantity <= 1,totalQuantity == 0) + "}";
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,taxcollectorCollectedMsg,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp(),false);
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
            case msg is AllianceTaxCollectorDialogQuestionExtendedMessage:
               atcdqemsg = msg as AllianceTaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorDialogQuestionExtended,atcdqemsg.guildInfo.guildName,atcdqemsg.maxPods,atcdqemsg.prospecting,atcdqemsg.wisdom,atcdqemsg.taxCollectorsCount,atcdqemsg.taxCollectorAttack,atcdqemsg.kamas,atcdqemsg.experience,atcdqemsg.pods,atcdqemsg.itemsValue,atcdqemsg.alliance);
               return true;
            case msg is TaxCollectorDialogQuestionExtendedMessage:
               tcdqemsg = msg as TaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended,tcdqemsg.guildInfo.guildName,tcdqemsg.maxPods,tcdqemsg.prospecting,tcdqemsg.wisdom,tcdqemsg.taxCollectorsCount,tcdqemsg.taxCollectorAttack,tcdqemsg.kamas,tcdqemsg.experience,tcdqemsg.pods,tcdqemsg.itemsValue);
               return true;
            case msg is TaxCollectorDialogQuestionBasicMessage:
               tcdqbmsg = msg as TaxCollectorDialogQuestionBasicMessage;
               guildw = GuildWrapper.create(0,tcdqbmsg.guildInfo.guildName,null);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic,guildw.guildName);
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
               clemsg = msg as ContactLookErrorMessage;
               return true;
            case msg is GuildGetInformationsAction:
               ggia = msg as GuildGetInformationsAction;
               askInformation = true;
               switch(ggia.infoType)
               {
                  case GuildInformationsTypeEnum.INFO_MEMBERS:
                     break;
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
            case msg is GuildInvitationByNameAction:
               gibna = msg as GuildInvitationByNameAction;
               gibnmsg = new GuildInvitationSearchMessage();
               player_GIBNMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(gibna.target);
               gibnmsg.initGuildInvitationSearchMessage(player_GIBNMSG);
               ConnectionsHandler.getConnection().send(gibnmsg);
               return true;
            case msg is GuildDeleteApplicationRequestAction:
               gdarmsg = new GuildDeleteApplicationRequestMessage();
               ConnectionsHandler.getConnection().send(gdarmsg);
               return true;
            case msg is GuildApplicationDeletedMessage:
               gadm = msg as GuildApplicationDeletedMessage;
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPlayerApplicationDeleted,gadm.deleted);
               if(!gadm.deleted)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.guild.applyDeleteDelay"),666,TimeManager.getInstance().getTimestamp(),false);
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
                  gsamsg.initGuildSubmitApplicationMessage(gsaa.applyText,gsaa.guildId,gsaa.timeSpent,filters.languageFilters,filters.ambianceFilters,filters.playtimeFilters,filters.interestFilters,filters.guildLevelMinMax,filters.recruitmentType,filters.playerLevelMinMax,filters.achievementMinMax,filters.searchName,filters.lastSort);
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
               notifId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.application"),I18n.getUiText(!!gaiamsg.accepted ? "ui.guild.applyAccepted" : "ui.guild.applyRejected",[HyperlinkShowGuildManager.getLink(gaiamsg.guildInformation,gaiamsg.guildInformation.guildName)]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplyAnswer");
               NotificationManager.getInstance().sendNotification(notifId);
               if(gaiamsg.accepted)
               {
                  ds = new DataStoreType("SocialBase",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(ds,"SocialBase_GuildWarning",true);
               }
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationIsAnswered,gaiamsg.guildInformation,gaiamsg.accepted);
               return true;
            case msg is GuildApplicationReceivedMessage:
               garmsg = msg as GuildApplicationReceivedMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.applicationReceived"),I18n.getUiText("ui.guild.applicationReceivedNotif",["{player," + garmsg.playerName + "," + garmsg.playerId + "::" + garmsg.playerName + "}"]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplicationReceived");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.guild.seeApplication"),"GuildApplicationsUiRequested",null,true,140,0,"hook");
               if(!PlayedCharacterManager.getInstance().isInKoli)
               {
                  NotificationManager.getInstance().sendNotification(notificationId);
               }
               return true;
            case msg is GuildRecruitmentInvalidateMessage:
               grimsg = msg as GuildRecruitmentInvalidateMessage;
               notificationId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.recruitmentInvalidate"),I18n.getUiText("ui.guild.recruitment.rulesBreak"),NotificationTypeEnum.SERVER_INFORMATION,"notifRecruitmentInvalidate");
               NotificationManager.getInstance().addButtonToNotification(notificationId,I18n.getUiText("ui.guild.setUpRecruitment"),"OpenGuildPrezAndRecruitAction",null,true,200,0,"action");
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
            case msg is GuildApplicationsRequestAction:
               garaction = msg as GuildApplicationsRequestAction;
               glarmsg = new GuildListApplicationRequestMessage();
               glarmsg.initGuildListApplicationRequestMessage(garaction.timestamp,garaction.limit);
               ConnectionsHandler.getConnection().send(glarmsg);
               return true;
            case msg is GuildListApplicationAnswerMessage:
               glaamsg = msg as GuildListApplicationAnswerMessage;
               applicationDescrs = new Vector.<GuildApplicationWrapper>(0);
               for each(applicationInfo in glaamsg.applies)
               {
                  applicationDescrs.push(GuildApplicationWrapper.wrap(applicationInfo));
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationsReceived,applicationDescrs,glaamsg.offset,glaamsg.count,glaamsg.total);
               return true;
            case msg is GuildApplicationReplyAction:
               guildApplicationReplyAction = msg as GuildApplicationReplyAction;
               guildApplicationAnswerMessage = new GuildApplicationAnswerMessage();
               guildApplicationAnswerMessage.initGuildApplicationAnswerMessage(guildApplicationReplyAction.isAccepted,guildApplicationReplyAction.playerId);
               ConnectionsHandler.getConnection().send(guildApplicationAnswerMessage);
               return true;
            case msg is GuildListApplicationModifiedMessage:
               glammsg = msg as GuildListApplicationModifiedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationUpdated,GuildApplicationWrapper.wrap(glammsg.apply),glammsg.state,glammsg.playerId);
               return true;
            case msg is GuildSummaryRequestAction:
               gsra = msg as GuildSummaryRequestAction;
               gsrm = new GuildSummaryRequestMessage();
               gsrm.initGuildSummaryRequestMessage();
               gsrm.offset = gsra.offset;
               gsrm.count = gsra.count;
               gsrm.nameFilter = gsra.filters.nameFilter;
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
               ConnectionsHandler.getConnection().send(gsrm);
               return true;
            case msg is GuildSummaryMessage:
               gsm = msg as GuildSummaryMessage;
               this._allGuildsInDirectory = new Vector.<GuildWrapper>(0);
               for each(guildFactInfo in gsm.guilds)
               {
                  guildWrapper = GuildWrapper.getFromNetwork(guildFactInfo);
                  if(guildWrapper)
                  {
                     this._allGuildsInDirectory.push(guildWrapper);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.GuildsReceived,this._allGuildsInDirectory,gsm.offset,gsm.count,gsm.total);
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
            case msg is GuildFightJoinRequestAction:
               gfjra = msg as GuildFightJoinRequestAction;
               gfjrmsg = new GuildFightJoinRequestMessage();
               gfjrmsg.initGuildFightJoinRequestMessage(gfjra.taxCollectorId);
               ConnectionsHandler.getConnection().send(gfjrmsg);
               return true;
            case msg is GuildFightTakePlaceRequestAction:
               gftpra = msg as GuildFightTakePlaceRequestAction;
               gftprmsg = new GuildFightTakePlaceRequestMessage();
               gftprmsg.initGuildFightTakePlaceRequestMessage(gftpra.taxCollectorId,gftpra.replacedCharacterId);
               ConnectionsHandler.getConnection().send(gftprmsg);
               return true;
            case msg is GuildFightLeaveRequestAction:
               gflra = msg as GuildFightLeaveRequestAction;
               this._autoLeaveHelpers = false;
               if(gflra.warning)
               {
                  for each(tc2 in TaxCollectorsManager.getInstance().taxCollectors)
                  {
                     if(tc2.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                     {
                        tcInFight = TaxCollectorsManager.getInstance().allTaxCollectorsInFight[tc2.uniqueId];
                        for each(defender in tcInFight.allyCharactersInformations)
                        {
                           if(defender.playerCharactersInformations.id == gflra.characterId)
                           {
                              this._autoLeaveHelpers = true;
                              gflrmsg = new GuildFightLeaveRequestMessage();
                              gflrmsg.initGuildFightLeaveRequestMessage(tc2.uniqueId,gflra.characterId);
                              ConnectionsHandler.getConnection().send(gflrmsg);
                           }
                        }
                     }
                  }
               }
               else
               {
                  gflrmsg = new GuildFightLeaveRequestMessage();
                  gflrmsg.initGuildFightLeaveRequestMessage(gflra.taxCollectorId,gflra.characterId);
                  ConnectionsHandler.getConnection().send(gflrmsg);
               }
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
               allianceId = 0;
               allianceName = "";
               allianceTag = "";
               if(msg is GuildInAllianceFactsMessage)
               {
                  giafmsg = msg as GuildInAllianceFactsMessage;
                  allianceId = giafmsg.allianceInfos.allianceId;
                  allianceName = giafmsg.allianceInfos.allianceName;
                  allianceTag = giafmsg.allianceInfos.allianceTag;
               }
               if(guildSheet)
               {
                  guildSheet.update(gfmsg.infos.guildId,gfmsg.infos.guildName,gfmsg.infos.guildEmblem,gfmsg.infos.leaderId,guildSheet.leaderName,gfmsg.infos.guildLevel,gfmsg.infos.nbMembers,gfmsg.creationDate,gfmsg.members,GuildRecruitmentDataWrapper.wrap(gfmsg.infos.recruitment),guildSheet.nbConnectedMembers,gfmsg.nbTaxCollectors,guildSheet.lastActivity,allianceId,allianceName,allianceTag,guildSheet.allianceLeader);
               }
               else
               {
                  guildSheet = GuildFactSheetWrapper.create(gfmsg.infos.guildId,gfmsg.infos.guildName,gfmsg.infos.guildEmblem,gfmsg.infos.leaderId,"",gfmsg.infos.guildLevel,gfmsg.infos.nbMembers,gfmsg.creationDate,gfmsg.members,GuildRecruitmentDataWrapper.wrap(gfmsg.infos.recruitment),0,gfmsg.nbTaxCollectors,0,allianceId,allianceName,allianceTag);
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
               content = gmomsg.content;
               pattern = /</g;
               content = content.replace(pattern,"&lt;");
               motdContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(content,ChatActivableChannelsEnum.CHANNEL_GUILD,gmomsg.memberId,gmomsg.memberName);
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
                     reason = I18n.getUiText("ui.social.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,reason,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is GuildBulletinSetRequestAction:
               gbsra = msg as GuildBulletinSetRequestAction;
               gbsrmsg = new GuildBulletinSetRequestMessage();
               gbsrmsg.initGuildBulletinSetRequestMessage(gbsra.content,gbsra.notifyMembers);
               ConnectionsHandler.getConnection().send(gbsrmsg);
               return true;
            case msg is GuildBulletinMessage:
               gbomsg = msg as GuildBulletinMessage;
               content = gbomsg.content;
               pattern = /</g;
               content = content.replace(pattern,"&lt;");
               bulletinContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(content,ChatActivableChannelsEnum.CHANNEL_GUILD,gbomsg.memberId,gbomsg.memberName);
               this._guild.bulletin = gbomsg.content;
               this._guild.formattedBulletin = bulletinContent[0];
               this._guild.bulletinWriterId = gbomsg.memberId;
               this._guild.bulletinWriterName = gbomsg.memberName;
               this._guild.bulletinTimestamp = gbomsg.timestamp;
               this._guild.lastNotifiedTimestamp = gbomsg.lastNotifiedTimestamp * 1000;
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
                     reason = I18n.getUiText("ui.social.taxCollectorNoRights");
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
               grra = msg as GuildRanksRequestAction;
               grrm = new GuildRanksRequestMessage();
               grrm.initGuildRanksRequestMessage();
               ConnectionsHandler.getConnection().send(grrm);
               return true;
            case msg is GuildRanksMessage:
               grm = msg as GuildRanksMessage;
               lastRankCount = this._guildRanksSorted.length;
               this._guildRanks = new Dictionary(true);
               this._guildRanksSorted = new Vector.<GuildRankInformation>();
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
               this._guildRanksSorted = this._guildRanksSorted.sort(function(rank1:GuildRankInformation, rank2:GuildRankInformation):int
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
   }
}

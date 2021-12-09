package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
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
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowGuildManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuildPrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildMotdSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSetApplicationUpdatesRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSpellUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSubmitApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSummaryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildUpdateApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.SendGuildRecruitmentDataAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.social.StatusShareSetAction;
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
   import com.ankamagames.dofus.network.messages.game.guild.GuildSpellUpgradeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSummaryMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSummaryRequestMessage;
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
   import com.ankamagames.dofus.network.types.game.guild.application.GuildApplicationInformation;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorMovement;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class SocialFrame implements Frame
   {
      
      public static const MAX_MEMBERS:uint = 240;
      
      private static const MAX_LEVEL:uint = 200;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialFrame));
      
      private static var _instance:SocialFrame;
      
      private static var _fakeApplicationData:Vector.<Object> = null;
      
      private static var _fakeApplicationList:Vector.<Object> = null;
      
      private static var _fakeBasicGuildData:Vector.<Object> = null;
      
      private static var _fakeGuildData:Vector.<GuildWrapper> = null;
       
      
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
      
      private var _guildHouses:Vector.<GuildHouseWrapper>;
      
      private var _guildHousesList:Boolean = false;
      
      private var _guildHousesListUpdate:Boolean = false;
      
      private var _guildPaddocks:Vector.<PaddockContentInformations>;
      
      private var _guildPaddocksMax:int = 1;
      
      private var _shareStatus:Boolean = true;
      
      private var _warnOnFrienConnec:Boolean;
      
      private var _warnOnMemberConnec:Boolean;
      
      private var _warnWhenFriendOrGuildMemberLvlUp:Boolean;
      
      private var _warnWhenFriendOrGuildMemberAchieve:Boolean;
      
      private var _warnOnHardcoreDeath:Boolean;
      
      private var _autoLeaveHelpers:Boolean;
      
      private var _allGuilds:Dictionary;
      
      private var _allGuildsInDirectory:Vector.<GuildWrapper>;
      
      private var _socialDatFrame:SocialDataFrame;
      
      private var _dungeonTopTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _topTaxCollectors:Vector.<TaxCollectorInformations>;
      
      private var _sortDescending:Boolean = false;
      
      public function SocialFrame()
      {
         this._guildHouses = new Vector.<GuildHouseWrapper>();
         this._guildPaddocks = new Vector.<PaddockContentInformations>();
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
      
      public function pushed() : Boolean
      {
         _instance = this;
         this._enemiesList = new Vector.<SocialCharacterWrapper>();
         this._ignoredList = new Vector.<SocialCharacterWrapper>();
         this._socialDatFrame = new SocialDataFrame();
         this._guildDialogFrame = new GuildDialogFrame();
         Kernel.getWorker().addFrame(this._socialDatFrame);
         ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
         ConnectionsHandler.getConnection().send(new AcquaintancesGetListMessage());
         ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
         ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
         ConnectionsHandler.getConnection().send(new GuildGetPlayerApplicationMessage());
         return true;
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         TaxCollectorsManager.getInstance().destroy();
         return true;
      }
      
      public function process(subareaName:Message) : Boolean
      {
         var suba:String = null;
         var nid:FriendOnlineInformations = null;
         var openSocialParams:AcquaintanceOnlineInformation = null;
         var taxCollectorInfo:uint = 0;
         var dungeonTopTaxCollectors:GuildMembershipMessage = null;
         var topTaxCollectors:FriendsListMessage = null;
         var ggimsg:AcquaintancesListMessage = null;
         var ds:SpouseRequestAction = null;
         var applicationInfo:SpouseInformationsMessage = null;
         var guildFactInfo:IgnoredListMessage = null;
         var tc2:OpenSocialAction = null;
         var tcInFight:AddFriendAction = null;
         var defender:FriendAddedMessage = null;
         var ghuimsg:FriendWrapper = null;
         var toUpdate:Boolean = false;
         var house1:AcquaintanceAddedMessage = null;
         var ghw1:ContactWrapper = null;
         var ghrmsg:AddEnemyAction = null;
         var iGHR:IgnoredAddedMessage = null;
         var giafmsg:RemoveFriendAction = null;
         var textMotd:FriendDeleteRequestMessage = null;
         var members:FriendDeleteResultMessage = null;
         var snm:FriendUpdateMessage = null;
         var istatus:FriendWrapper = null;
         var frdstatus:Boolean = false;
         var ctcStatus:RemoveEnemyAction = null;
         var cApi:IgnoredDeleteRequestMessage = null;
         var clrbim:IgnoredDeleteResultMessage = null;
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
         var playerLink:* = null;
         var mapLink:* = null;
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
         var tcOffPlayerLink:* = null;
         var tcOffPoint:WorldPointWrapper = null;
         var tcOffWorldMapId:int = 0;
         var tcOffMapLink:* = null;
         var sentenceToDisplatchDisappearances:String = null;
         var tcHarvestedNamesList:* = null;
         var tcDefeatedNamesList:* = null;
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
         var taxcollectorCollectedMsg:* = null;
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
         var filters:Object = null;
         var guaa:GuildUpdateApplicationAction = null;
         var guamsg:GuildUpdateApplicationMessage = null;
         var gaiamsg:GuildApplicationIsAnsweredMessage = null;
         var notifId:uint = 0;
         var garmsg:GuildApplicationReceivedMessage = null;
         var grimsg:GuildRecruitmentInvalidateMessage = null;
         var gkra:GuildKickRequestAction = null;
         var gkrmsg:GuildKickRequestMessage = null;
         var gcmpa:GuildChangeMemberParametersAction = null;
         var newRights:Number = NaN;
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
         var _loc257_:String = null;
         var _loc258_:SubArea = null;
         var _loc259_:uint = 0;
         var _loc260_:Array = null;
         var _loc261_:TaxCollectorInformations = null;
         var _loc262_:Vector.<TaxCollectorWrapper> = null;
         var _loc263_:Vector.<TaxCollectorWrapper> = null;
         var _loc264_:GuildGetInformationsMessage = null;
         var _loc265_:DataStoreType = null;
         var _loc266_:GuildApplicationInformation = null;
         var _loc267_:GuildFactSheetInformations = null;
         var _loc268_:TaxCollectorWrapper = null;
         var _loc269_:SocialEntityInFightWrapper = null;
         var _loc270_:SocialFightersWrapper = null;
         var _loc271_:GuildHouseUpdateInformationMessage = null;
         var _loc272_:Boolean = false;
         var _loc273_:GuildHouseWrapper = null;
         var _loc274_:GuildHouseWrapper = null;
         var _loc275_:GuildHouseRemoveMessage = null;
         var _loc276_:int = 0;
         var _loc277_:GuildInAllianceFactsMessage = null;
         var _loc278_:String = null;
         var _loc279_:GuildMember = null;
         var _loc280_:int = 0;
         var _loc281_:int = 0;
         var _loc282_:FriendWrapper = null;
         var _loc283_:ContactWrapper = null;
         var _loc284_:ChatApi = null;
         var _loc285_:ContactLookRequestByIdMessage = null;
         switch(true)
         {
            case subareaName is GuildMembershipMessage:
               dungeonTopTaxCollectors = subareaName as GuildMembershipMessage;
               if(this._guild != null)
               {
                  this._guild.update(dungeonTopTaxCollectors.guildInfo.guildId,dungeonTopTaxCollectors.guildInfo.guildName,dungeonTopTaxCollectors.guildInfo.guildEmblem,dungeonTopTaxCollectors.memberRights);
               }
               else
               {
                  this._guild = GuildWrapper.create(dungeonTopTaxCollectors.guildInfo.guildId,dungeonTopTaxCollectors.guildInfo.guildName,dungeonTopTaxCollectors.guildInfo.guildEmblem,dungeonTopTaxCollectors.memberRights);
               }
               this._hasGuild = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               return true;
            case subareaName is FriendsListMessage:
               topTaxCollectors = subareaName as FriendsListMessage;
               this._friendsList = new Vector.<SocialCharacterWrapper>();
               for each(f in topTaxCollectors.friendsList)
               {
                  if(f is FriendOnlineInformations)
                  {
                     nid = f as FriendOnlineInformations;
                     AccountManager.getInstance().setAccount(nid.playerName,nid.accountId,nid.accountTag.nickname,nid.accountTag.tagNumber);
                     ChatAutocompleteNameManager.getInstance().addEntry(nid.playerName,2);
                  }
                  fw = new FriendWrapper(f);
                  this._friendsList.push(fw);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case subareaName is AcquaintancesListMessage:
               ggimsg = subareaName as AcquaintancesListMessage;
               this._contactsList = new Vector.<SocialCharacterWrapper>();
               for each(a in ggimsg.acquaintanceList)
               {
                  if(a is AcquaintanceOnlineInformation)
                  {
                     openSocialParams = a as AcquaintanceOnlineInformation;
                     AccountManager.getInstance().setAccount(openSocialParams.playerName,openSocialParams.accountId,openSocialParams.accountTag.nickname,openSocialParams.accountTag.tagNumber);
                     ChatAutocompleteNameManager.getInstance().addEntry(openSocialParams.playerName,2);
                  }
                  cw = new ContactWrapper(a);
                  this._contactsList.push(cw);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
               return true;
            case subareaName is SpouseRequestAction:
               ds = subareaName as SpouseRequestAction;
               ConnectionsHandler.getConnection().send(new SpouseGetInformationsMessage());
               return true;
            case subareaName is SpouseInformationsMessage:
               applicationInfo = subareaName as SpouseInformationsMessage;
               this._spouse = new SpouseWrapper(applicationInfo.spouse);
               this._hasSpouse = true;
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case subareaName is IgnoredListMessage:
               this._enemiesList = new Vector.<SocialCharacterWrapper>();
               guildFactInfo = subareaName as IgnoredListMessage;
               for each(i in guildFactInfo.ignoredList)
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
            case subareaName is OpenSocialAction:
               tc2 = subareaName as OpenSocialAction;
               KernelEventsManager.getInstance().processCallback(SocialHookList.OpenSocial,tc2.id);
               return true;
            case subareaName is OpenGuildPrezAndRecruitAction:
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPrezAndRecruitUiRequested);
               return true;
            case subareaName is FriendsListRequestAction:
               ConnectionsHandler.getConnection().send(new FriendsGetListMessage());
               return true;
            case subareaName is ContactsListRequestAction:
               ConnectionsHandler.getConnection().send(new AcquaintancesGetListMessage());
               return true;
            case subareaName is EnemiesListRequestAction:
               ConnectionsHandler.getConnection().send(new IgnoredGetListMessage());
               return true;
            case subareaName is AddFriendAction:
               tcInFight = subareaName as AddFriendAction;
               if(!this.isLenghtCorrect(tcInFight.name,tcInFight.tag))
               {
                  displayNotFoundError();
               }
               else if(this.isMe(tcInFight.name,tcInFight.tag))
               {
                  displayEgoError();
               }
               else
               {
                  farmsg = new FriendAddRequestMessage();
                  farmsg.initFriendAddRequestMessage(this.createAbstractPlayerSearchInformation(tcInFight.name,tcInFight.tag));
                  ConnectionsHandler.getConnection().send(farmsg);
               }
               return true;
            case subareaName is FriendAddedMessage:
               defender = subareaName as FriendAddedMessage;
               if(defender.friendAdded is FriendOnlineInformations)
               {
                  nid = defender.friendAdded as FriendOnlineInformations;
                  AccountManager.getInstance().setAccount(nid.playerName,nid.accountId,nid.accountTag.nickname,nid.accountTag.tagNumber);
                  ChatAutocompleteNameManager.getInstance().addEntry(nid.playerName,2);
               }
               ghuimsg = new FriendWrapper(defender.friendAdded);
               toUpdate = false;
               for each(friendW in this._friendsList)
               {
                  if(friendW.accountId == ghuimsg.accountId)
                  {
                     toUpdate = true;
                     break;
                  }
               }
               for(contactIndex in this._contactsList)
               {
                  if(this._contactsList[contactIndex].name == ghuimsg.name && this._contactsList[contactIndex].tag == ghuimsg.tag)
                  {
                     this._contactsList.splice(contactIndex,1);
                     KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                     break;
                  }
               }
               if(!toUpdate)
               {
                  this._friendsList.push(ghuimsg);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               return true;
            case subareaName is AcquaintanceAddedMessage:
               house1 = subareaName as AcquaintanceAddedMessage;
               if(house1.acquaintanceAdded is AcquaintanceOnlineInformation)
               {
                  openSocialParams = house1.acquaintanceAdded as AcquaintanceOnlineInformation;
                  AccountManager.getInstance().setAccount(openSocialParams.playerName,openSocialParams.accountId,openSocialParams.accountTag.nickname,openSocialParams.accountTag.tagNumber);
                  ChatAutocompleteNameManager.getInstance().addEntry(openSocialParams.playerName,2);
               }
               ghw1 = new ContactWrapper(house1.acquaintanceAdded);
               this._contactsList.push(ghw1);
               KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
               return true;
            case subareaName is FriendAddFailureMessage:
               this.displayError((subareaName as FriendAddFailureMessage).reason);
               return true;
            case subareaName is ContactAddFailureMessage:
               this.displayError((subareaName as ContactAddFailureMessage).reason);
               return true;
            case subareaName is IgnoredAddFailureMessage:
               this.displayError((subareaName as IgnoredAddFailureMessage).reason);
               return true;
            case subareaName is AddEnemyAction:
               ghrmsg = subareaName as AddEnemyAction;
               if(!this.isLenghtCorrect(ghrmsg.name,ghrmsg.tag))
               {
                  displayNotFoundError();
               }
               else if(this.isMe(ghrmsg.tag,ghrmsg.name))
               {
                  displayEgoError();
               }
               else
               {
                  iarmsg = new IgnoredAddRequestMessage();
                  iarmsg.initIgnoredAddRequestMessage(this.createAbstractPlayerSearchInformation(ghrmsg.name,ghrmsg.tag));
                  ConnectionsHandler.getConnection().send(iarmsg);
               }
               return true;
            case subareaName is IgnoredAddedMessage:
               iGHR = subareaName as IgnoredAddedMessage;
               if(iGHR.ignoreAdded is IgnoredOnlineInformations)
               {
                  ioi = iGHR.ignoreAdded as IgnoredOnlineInformations;
                  AccountManager.getInstance().setAccount(ioi.playerName,ioi.accountId,ioi.accountTag.nickname,ioi.accountTag.tagNumber);
               }
               if(!iGHR.session)
               {
                  enemyToAdd = new EnemyWrapper(iGHR.ignoreAdded);
                  this._enemiesList.push(enemyToAdd);
                  KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
               }
               else
               {
                  for each(ignored in this._ignoredList)
                  {
                     if(ignored.name == iGHR.ignoreAdded.accountTag.nickname)
                     {
                        return true;
                     }
                  }
                  this._ignoredList.push(new IgnoredWrapper(iGHR.ignoreAdded.accountTag.nickname,iGHR.ignoreAdded.accountTag.tagNumber,iGHR.ignoreAdded.accountId));
                  KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredListUpdated);
               }
               return true;
            case subareaName is RemoveFriendAction:
               giafmsg = subareaName as RemoveFriendAction;
               textMotd = new FriendDeleteRequestMessage();
               textMotd.initFriendDeleteRequestMessage(giafmsg.accountId);
               ConnectionsHandler.getConnection().send(textMotd);
               return true;
            case subareaName is FriendDeleteResultMessage:
               members = subareaName as FriendDeleteResultMessage;
               if(members.success)
               {
                  output = I18n.getUiText("ui.social.friend.delete",[PlayerManager.getInstance().formatTagName(members.tag.nickname,members.tag.tagNumber,null,false)]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,output,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
                  for(fd in this._friendsList)
                  {
                     if(this._friendsList[fd].name == members.tag.nickname && this._friendsList[fd].tag == members.tag.tagNumber)
                     {
                        this._friendsList.splice(fd,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        return true;
                     }
                  }
                  for(ct in this._contactsList)
                  {
                     if(this._contactsList[ct].name == members.tag.nickname && this._contactsList[ct].tag == members.tag.tagNumber)
                     {
                        this._contactsList.splice(ct,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                        return true;
                     }
                  }
               }
               return true;
            case subareaName is FriendUpdateMessage:
               snm = subareaName as FriendUpdateMessage;
               istatus = new FriendWrapper(snm.friendUpdated);
               for each(frd in this._friendsList)
               {
                  if(frd.name == istatus.name)
                  {
                     frd = istatus;
                     break;
                  }
               }
               frdstatus = istatus.state == PlayerStateEnum.GAME_TYPE_ROLEPLAY || istatus.state == PlayerStateEnum.GAME_TYPE_FIGHT;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.FRIEND_CONNECTION) && this._warnOnFrienConnec && istatus.online && !frdstatus)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.FRIEND_CONNECTION,[istatus.name,istatus.playerName,istatus.playerId]);
               }
               return true;
            case subareaName is RemoveEnemyAction:
               ctcStatus = subareaName as RemoveEnemyAction;
               cApi = new IgnoredDeleteRequestMessage();
               cApi.initIgnoredDeleteRequestMessage(ctcStatus.accountId);
               ConnectionsHandler.getConnection().send(cApi);
               return true;
            case subareaName is IgnoredDeleteResultMessage:
               clrbim = subareaName as IgnoredDeleteResultMessage;
               if(!clrbim.session)
               {
                  if(clrbim.success)
                  {
                     for(ed in this._enemiesList)
                     {
                        if(this._enemiesList[ed].name == clrbim.tag.nickname && this._enemiesList[ed].tag == clrbim.tag.tagNumber)
                        {
                           this._enemiesList.splice(ed,1);
                           KernelEventsManager.getInstance().processCallback(SocialHookList.EnemiesListUpdated);
                           return true;
                        }
                     }
                  }
               }
               else if(clrbim.success)
               {
                  for(il in this._ignoredList)
                  {
                     if(this._ignoredList[il].name == clrbim.tag.nickname && this._ignoredList[il].tag == clrbim.tag.tagNumber)
                     {
                        this._ignoredList.splice(il,1);
                        KernelEventsManager.getInstance().processCallback(SocialHookList.IgnoredListUpdated);
                        return true;
                     }
                  }
               }
               return true;
            case subareaName is AddIgnoredAction:
               aiga = subareaName as AddIgnoredAction;
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
            case subareaName is RemoveIgnoredAction:
               ria = subareaName as RemoveIgnoredAction;
               idrq2msg = new IgnoredDeleteRequestMessage();
               idrq2msg.initIgnoredDeleteRequestMessage(ria.accountId,true);
               ConnectionsHandler.getConnection().send(idrq2msg);
               return true;
            case subareaName is JoinFriendAction:
               jfa = subareaName as JoinFriendAction;
               fjrmsg = new FriendJoinRequestMessage();
               player_FJRMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(jfa.name);
               fjrmsg.initFriendJoinRequestMessage(player_FJRMSG);
               ConnectionsHandler.getConnection().send(fjrmsg);
               return true;
            case subareaName is JoinSpouseAction:
               ConnectionsHandler.getConnection().send(new FriendSpouseJoinRequestMessage());
               return true;
            case subareaName is FriendSpouseFollowAction:
               fsfa = subareaName as FriendSpouseFollowAction;
               fsfwcmsg = new FriendSpouseFollowWithCompassRequestMessage();
               fsfwcmsg.initFriendSpouseFollowWithCompassRequestMessage(fsfa.enable);
               ConnectionsHandler.getConnection().send(fsfwcmsg);
               return true;
            case subareaName is StatusShareSetAction:
               sssa = subareaName as StatusShareSetAction;
               this._shareStatus = sssa.enable;
               fsssm = new FriendSetStatusShareMessage();
               fsssm.initFriendSetStatusShareMessage(sssa.enable);
               ConnectionsHandler.getConnection().send(fsssm);
               return true;
            case subareaName is FriendWarningSetAction:
               fwsa = subareaName as FriendWarningSetAction;
               this._warnOnFrienConnec = fwsa.enable;
               fsocmsg = new FriendSetWarnOnConnectionMessage();
               fsocmsg.initFriendSetWarnOnConnectionMessage(fwsa.enable);
               ConnectionsHandler.getConnection().send(fsocmsg);
               return true;
            case subareaName is MemberWarningSetAction:
               mwsa = subareaName as MemberWarningSetAction;
               this._warnOnMemberConnec = mwsa.enable;
               gmswocmsg = new GuildMemberSetWarnOnConnectionMessage();
               gmswocmsg.initGuildMemberSetWarnOnConnectionMessage(mwsa.enable);
               ConnectionsHandler.getConnection().send(gmswocmsg);
               return true;
            case subareaName is FriendOrGuildMemberLevelUpWarningSetAction:
               fogmwsa = subareaName as FriendOrGuildMemberLevelUpWarningSetAction;
               this._warnWhenFriendOrGuildMemberLvlUp = fogmwsa.enable;
               fswolgmsg = new FriendSetWarnOnLevelGainMessage();
               fswolgmsg.initFriendSetWarnOnLevelGainMessage(fogmwsa.enable);
               ConnectionsHandler.getConnection().send(fswolgmsg);
               return true;
            case subareaName is FriendGuildSetWarnOnAchievementCompleteAction:
               fgswoaca = subareaName as FriendGuildSetWarnOnAchievementCompleteAction;
               this._warnWhenFriendOrGuildMemberAchieve = fgswoaca.enable;
               fgswoacmsg = new FriendGuildSetWarnOnAchievementCompleteMessage();
               fgswoacmsg.initFriendGuildSetWarnOnAchievementCompleteMessage(fgswoaca.enable);
               ConnectionsHandler.getConnection().send(fgswoacmsg);
               return true;
            case subareaName is WarnOnHardcoreDeathAction:
               wohda = subareaName as WarnOnHardcoreDeathAction;
               this._warnOnHardcoreDeath = wohda.enable;
               wopdmsg = new WarnOnPermaDeathMessage();
               wopdmsg.initWarnOnPermaDeathMessage(wohda.enable);
               ConnectionsHandler.getConnection().send(wopdmsg);
               return true;
            case subareaName is SpouseStatusMessage:
               ssmsg = subareaName as SpouseStatusMessage;
               this._hasSpouse = ssmsg.hasSpouse;
               if(!this._hasSpouse)
               {
                  this._spouse = null;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseFollowStatusUpdated,false);
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_SPOUSE,-1);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.SpouseUpdated);
               return true;
            case subareaName is MoodSmileyUpdateMessage:
               msumsg = subareaName as MoodSmileyUpdateMessage;
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
            case subareaName is FriendStatusShareStateMessage:
               fsssmsg = subareaName as FriendStatusShareStateMessage;
               this._shareStatus = fsssmsg.share;
               KernelEventsManager.getInstance().processCallback(SocialHookList.ShareStatusState,fsssmsg.share);
               return true;
            case subareaName is FriendWarnOnConnectionStateMessage:
               fwocsmsg = subareaName as FriendWarnOnConnectionStateMessage;
               this._warnOnFrienConnec = fwocsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendWarningState,fwocsmsg.enable);
               return true;
            case subareaName is GuildMemberWarnOnConnectionStateMessage:
               gmwocsmsg = subareaName as GuildMemberWarnOnConnectionStateMessage;
               this._warnOnMemberConnec = gmwocsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.MemberWarningState,gmwocsmsg.enable);
               return true;
            case subareaName is GuildMemberOnlineStatusMessage:
               if(!this._friendsList)
               {
                  return true;
               }
               gmosm = subareaName as GuildMemberOnlineStatusMessage;
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
            case subareaName is FriendWarnOnLevelGainStateMessage:
               fwolgsmsg = subareaName as FriendWarnOnLevelGainStateMessage;
               this._warnWhenFriendOrGuildMemberLvlUp = fwolgsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendOrGuildMemberLevelUpWarningState,fwolgsmsg.enable);
               return true;
            case subareaName is FriendGuildWarnOnAchievementCompleteStateMessage:
               fgwoacsmsg = subareaName as FriendGuildWarnOnAchievementCompleteStateMessage;
               this._warnWhenFriendOrGuildMemberAchieve = fgwoacsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.FriendGuildWarnOnAchievementCompleteState,fgwoacsmsg.enable);
               return true;
            case subareaName is WarnOnPermaDeathStateMessage:
               wopdsmsg = subareaName as WarnOnPermaDeathStateMessage;
               this._warnOnHardcoreDeath = wopdsmsg.enable;
               KernelEventsManager.getInstance().processCallback(SocialHookList.WarnOnHardcoreDeathState,wopdsmsg.enable);
               return true;
            case subareaName is GuildInformationsMembersMessage:
               gimmsg = subareaName as GuildInformationsMembersMessage;
               for each(mb in gimmsg.members)
               {
                  ChatAutocompleteNameManager.getInstance().addEntry(mb.name,2);
               }
               this._guildMembers = gimmsg.members;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               return true;
            case subareaName is GuildHousesInformationMessage:
               ghimsg = subareaName as GuildHousesInformationMessage;
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
            case subareaName is GuildCreationStartedMessage:
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,false,false);
               return true;
            case subareaName is GuildModificationStartedMessage:
               gmsmsg = subareaName as GuildModificationStartedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildCreationStarted,gmsmsg.canChangeName,gmsmsg.canChangeEmblem);
               return true;
            case subareaName is GuildCreationResultMessage:
               gcrmsg = subareaName as GuildCreationResultMessage;
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
            case subareaName is GuildInvitedMessage:
               gimsg = subareaName as GuildInvitedMessage;
               Kernel.getWorker().addFrame(this._guildDialogFrame);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvited,gimsg.guildInfo.guildId,gimsg.guildInfo.guildName,gimsg.recruterId,gimsg.recruterName);
               return true;
            case subareaName is GuildInvitationStateRecruterMessage:
               gisrermsg = subareaName as GuildInvitationStateRecruterMessage;
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
            case subareaName is GuildInvitationStateRecrutedMessage:
               gisredmsg = subareaName as GuildInvitationStateRecrutedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInvitationStateRecruted,gisredmsg.invitationState);
               if(gisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_CANCELED || gisredmsg.invitationState == SocialGroupInvitationStateEnum.SOCIAL_GROUP_INVITATION_OK)
               {
                  Kernel.getWorker().removeFrame(this._guildDialogFrame);
               }
               return true;
            case subareaName is GuildJoinedMessage:
               gjmsg = subareaName as GuildJoinedMessage;
               this._hasGuild = true;
               this._guild = GuildWrapper.create(gjmsg.guildInfo.guildId,gjmsg.guildInfo.guildName,gjmsg.guildInfo.guildEmblem,gjmsg.memberRights);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,true);
               joinMessage = I18n.getUiText("ui.guild.JoinGuildMessage",[gjmsg.guildInfo.guildName]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,joinMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               seasonNumber = !!ServerTemporisSeason.getCurrentSeason() ? int(ServerTemporisSeason.getCurrentSeason().seasonNumber) : -1;
               if(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS && seasonNumber == 5)
               {
                  taxCollectorInfo = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.social.xpGuild"),I18n.getUiText("ui.social.modifyXpGuild"),NotificationTypeEnum.TUTORIAL,"temporisXpGuild_T" + seasonNumber);
                  NotificationManager.getInstance().addButtonToNotification(taxCollectorInfo,I18n.getUiText("ui.common.modify"),"OpenSocialAction",[DataEnum.SOCIAL_TAB_GUILD_ID]);
                  NotificationManager.getInstance().sendNotification(taxCollectorInfo);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildJoined);
               return true;
            case subareaName is GuildInformationsGeneralMessage:
               gigmsg = subareaName as GuildInformationsGeneralMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsGeneral,gigmsg.expLevelFloor,gigmsg.experience,gigmsg.expNextLevelFloor,gigmsg.level,gigmsg.creationDate,gigmsg.abandonnedPaddock,gigmsg.nbConnectedMembers,gigmsg.nbTotalMembers);
               this._guild.level = gigmsg.level;
               this._guild.experience = gigmsg.experience;
               this._guild.expLevelFloor = gigmsg.expLevelFloor;
               this._guild.expNextLevelFloor = gigmsg.expNextLevelFloor;
               this._guild.creationDate = gigmsg.creationDate;
               this._guild.nbMembers = gigmsg.nbTotalMembers;
               this._guild.nbConnectedMembers = gigmsg.nbConnectedMembers;
               return true;
            case subareaName is GuildInformationsMemberUpdateMessage:
               gimumsg = subareaName as GuildInformationsMemberUpdateMessage;
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
                           this.guild.memberRightsNumber = gimumsg.member.rights;
                        }
                        break;
                     }
                  }
               }
               else
               {
                  this._guildMembers = new Vector.<GuildMember>();
                  member = gimumsg.member;
                  this._guildMembers.push(member);
                  if(member.id == PlayedCharacterManager.getInstance().id)
                  {
                     this.guild.memberRightsNumber = member.rights;
                  }
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,gimumsg.member);
               return true;
            case subareaName is GuildMemberLeavingMessage:
               gmlmsg = subareaName as GuildMemberLeavingMessage;
               comptgm = 0;
               for each(guildMember in this._guildMembers)
               {
                  if(gmlmsg.memberId == guildMember.id)
                  {
                     this._guildMembers.splice(comptgm,1);
                  }
                  comptgm++;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMembers,this._guildMembers);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMemberLeaving,gmlmsg.kicked,gmlmsg.memberId);
               return true;
            case subareaName is GuildLeftMessage:
               this._hasGuild = false;
               this._guild = null;
               this._guildHousesList = false;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildLeft);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildMembershipUpdated,false);
               return true;
            case subareaName is GuildInfosUpgradeMessage:
               gipmsg = subareaName as GuildInfosUpgradeMessage;
               TaxCollectorsManager.getInstance().updateGuild(gipmsg.maxTaxCollectorsCount,gipmsg.taxCollectorsCount,gipmsg.taxCollectorLifePoints,gipmsg.taxCollectorDamagesBonuses,gipmsg.taxCollectorPods,gipmsg.taxCollectorProspecting,gipmsg.taxCollectorWisdom);
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInfosUpgrade,gipmsg.boostPoints,gipmsg.maxTaxCollectorsCount,gipmsg.spellId,gipmsg.spellLevel,gipmsg.taxCollectorDamagesBonuses,gipmsg.taxCollectorLifePoints,gipmsg.taxCollectorPods,gipmsg.taxCollectorProspecting,gipmsg.taxCollectorsCount,gipmsg.taxCollectorWisdom);
               return true;
            case subareaName is GuildFightPlayersHelpersJoinMessage:
               gfphjmsg = subareaName as GuildFightPlayersHelpersJoinMessage;
               TaxCollectorsManager.getInstance().addFighter(0,gfphjmsg.fightId,gfphjmsg.playerInfo,true);
               return true;
            case subareaName is GuildFightPlayersHelpersLeaveMessage:
               gfphlmsg = subareaName as GuildFightPlayersHelpersLeaveMessage;
               if(this._autoLeaveHelpers)
               {
                  text = I18n.getUiText("ui.social.guild.autoFightLeave");
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               TaxCollectorsManager.getInstance().removeFighter(0,gfphlmsg.fightId,gfphlmsg.playerId,true);
               return true;
            case subareaName is GuildFightPlayersEnemiesListMessage:
               gfpelmsg = subareaName as GuildFightPlayersEnemiesListMessage;
               for each(enemy in gfpelmsg.playerInfo)
               {
                  TaxCollectorsManager.getInstance().addFighter(0,gfpelmsg.fightId,enemy,false,false);
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildFightEnnemiesListUpdate,0,gfpelmsg.fightId);
               return true;
            case subareaName is GuildFightPlayersEnemyRemoveMessage:
               gfpermsg = subareaName as GuildFightPlayersEnemyRemoveMessage;
               TaxCollectorsManager.getInstance().removeFighter(0,gfpermsg.fightId,gfpermsg.playerId,false);
               return true;
            case subareaName is TaxCollectorMovementMessage:
               tcmmsg = subareaName as TaxCollectorMovementMessage;
               taxCollectorName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcmmsg.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcmmsg.basicInfos.lastNameId).name;
               worldMapId = SubArea.getSubAreaByMapId(tcmmsg.basicInfos.mapId).worldmap.id;
               playerLink = "{player," + tcmmsg.playerName + "," + tcmmsg.playerId + "}";
               mapLink = "{map," + tcmmsg.basicInfos.worldX + "," + tcmmsg.basicInfos.worldY + "," + worldMapId + "}";
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
            case subareaName is TaxCollectorAttackedMessage:
               tcamsg = subareaName as TaxCollectorAttackedMessage;
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
                  _loc257_ = SubArea.getSubAreaById(tcamsg.subAreaId).name;
                  sentenceToDisplatch = I18n.getUiText("ui.guild.taxCollectorAttacked",[guildName2,_loc257_,worldX + "," + worldY]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"{openSocial,2,2,0," + tcamsg.mapId + "::" + sentenceToDisplatch + "}",ChatActivableChannelsEnum.CHANNEL_ALLIANCE,TimeManager.getInstance().getTimestamp());
               }
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.TAXCOLLECTOR_ATTACK,[taxCollectorN,worldX,worldY]);
               }
               if(OptionManager.getOptionManager("dofus").getOption("warnOnGuildItemAgression"))
               {
                  _loc258_ = SubArea.getSubAreaById(tcamsg.subAreaId);
                  _loc259_ = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.taxCollectorAttackedTitle"),I18n.getUiText("ui.guild.taxCollectorAttacked",[tcamsg.guild.guildName,_loc258_.name,worldX + "," + worldY]),NotificationTypeEnum.INVITATION,"TaxCollectorAttacked");
                  _loc260_ = new Array();
                  if(!tcamsg.guild || tcamsg.guild.guildId == this._guild.guildId)
                  {
                     _loc260_ = [1,2];
                  }
                  else
                  {
                     _loc260_ = [2,2,[0,tcamsg.mapId]];
                  }
                  NotificationManager.getInstance().addButtonToNotification(_loc259_,I18n.getUiText("ui.common.join"),"OpenSocial",_loc260_,true,200,0,"hook");
                  NotificationManager.getInstance().sendNotification(_loc259_);
               }
               return true;
            case subareaName is TaxCollectorAttackedResultMessage:
               tcarmsg = subareaName as TaxCollectorAttackedResultMessage;
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
            case subareaName is TaxCollectorErrorMessage:
               tcemsg = subareaName as TaxCollectorErrorMessage;
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
            case subareaName is TaxCollectorListMessage:
               tclmamsg = subareaName as TaxCollectorListMessage;
               TaxCollectorsManager.getInstance().maxTaxCollectorsCount = tclmamsg.nbcollectorMax;
               TaxCollectorsManager.getInstance().setTaxCollectors(tclmamsg.informations);
               TaxCollectorsManager.getInstance().setTaxCollectorsFighters(tclmamsg.fightersInformations);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorListUpdate,tclmamsg.infoType);
               return true;
            case subareaName is TaxCollectorMovementAddMessage:
               tcmamsg = subareaName as TaxCollectorMovementAddMessage;
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
            case subareaName is TaxCollectorMovementRemoveMessage:
               tcmrmsg = subareaName as TaxCollectorMovementRemoveMessage;
               delete TaxCollectorsManager.getInstance().taxCollectors[tcmrmsg.collectorId];
               delete TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[tcmrmsg.collectorId];
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildTaxCollectorRemoved,tcmrmsg.collectorId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_taxcollector" + tcmrmsg.collectorId,-1);
               return true;
            case subareaName is TaxCollectorStateUpdateMessage:
               tcsumsg = subareaName as TaxCollectorStateUpdateMessage;
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
            case subareaName is TaxCollectorMovementsOfflineMessage:
               tcmomsg = subareaName as TaxCollectorMovementsOfflineMessage;
               tcHarvestedNamesList = "";
               tcDefeatedNamesList = "";
               harvestedNumber = 0;
               defeatedNumber = 0;
               for each(tcm in tcmomsg.movements)
               {
                  tcOffName = TaxCollectorFirstname.getTaxCollectorFirstnameById(tcm.basicInfos.firstNameId).firstname + " " + TaxCollectorName.getTaxCollectorNameById(tcm.basicInfos.lastNameId).name;
                  tcOffPoint = new WorldPointWrapper(tcm.basicInfos.mapId,true,tcm.basicInfos.worldX,tcm.basicInfos.worldY);
                  tcOffWorldMapId = SubArea.getSubAreaByMapId(tcm.basicInfos.mapId).worldmap.id;
                  tcOffMapLink = "{map," + tcOffPoint.outdoorX + "," + tcOffPoint.outdoorY + "," + tcOffWorldMapId + "}";
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
            case subareaName is TopTaxCollectorListMessage:
               ttclmsg = subareaName as TopTaxCollectorListMessage;
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
                  _loc262_ = new Vector.<TaxCollectorWrapper>(0);
                  _loc263_ = new Vector.<TaxCollectorWrapper>(0);
                  for each(_loc261_ in this._dungeonTopTaxCollectors)
                  {
                     _loc262_.push(TaxCollectorWrapper.create(_loc261_));
                  }
                  for each(_loc261_ in this._topTaxCollectors)
                  {
                     _loc263_.push(TaxCollectorWrapper.create(_loc261_));
                  }
                  KernelEventsManager.getInstance().processCallback(SocialHookList.ShowTopTaxCollectors,_loc262_,_loc263_);
                  this._dungeonTopTaxCollectors = null;
                  this._topTaxCollectors = null;
               }
               return true;
            case subareaName is ExchangeGuildTaxCollectorGetMessage:
               egtcgmsg = subareaName as ExchangeGuildTaxCollectorGetMessage;
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
            case subareaName is GuildInformationsPaddocksMessage:
               gifmsg = subareaName as GuildInformationsPaddocksMessage;
               this._guildPaddocksMax = gifmsg.nbPaddockMax;
               this._guildPaddocks = gifmsg.paddocksInformations;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsFarms);
               return true;
            case subareaName is GuildPaddockBoughtMessage:
               gpbmsg = subareaName as GuildPaddockBoughtMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockAdd,gpbmsg.paddockInfo);
               return true;
            case subareaName is GuildPaddockRemovedMessage:
               gprmsg = subareaName as GuildPaddockRemovedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPaddockRemoved,gprmsg.paddockId);
               return true;
            case subareaName is AllianceTaxCollectorDialogQuestionExtendedMessage:
               atcdqemsg = subareaName as AllianceTaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.AllianceTaxCollectorDialogQuestionExtended,atcdqemsg.guildInfo.guildName,atcdqemsg.maxPods,atcdqemsg.prospecting,atcdqemsg.wisdom,atcdqemsg.taxCollectorsCount,atcdqemsg.taxCollectorAttack,atcdqemsg.kamas,atcdqemsg.experience,atcdqemsg.pods,atcdqemsg.itemsValue,atcdqemsg.alliance);
               return true;
            case subareaName is TaxCollectorDialogQuestionExtendedMessage:
               tcdqemsg = subareaName as TaxCollectorDialogQuestionExtendedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionExtended,tcdqemsg.guildInfo.guildName,tcdqemsg.maxPods,tcdqemsg.prospecting,tcdqemsg.wisdom,tcdqemsg.taxCollectorsCount,tcdqemsg.taxCollectorAttack,tcdqemsg.kamas,tcdqemsg.experience,tcdqemsg.pods,tcdqemsg.itemsValue);
               return true;
            case subareaName is TaxCollectorDialogQuestionBasicMessage:
               tcdqbmsg = subareaName as TaxCollectorDialogQuestionBasicMessage;
               guildw = GuildWrapper.create(0,tcdqbmsg.guildInfo.guildName,null,0);
               KernelEventsManager.getInstance().processCallback(SocialHookList.TaxCollectorDialogQuestionBasic,guildw.guildName);
               return true;
            case subareaName is ContactLookMessage:
               clmsg = subareaName as ContactLookMessage;
               if(clmsg.requestId == 0)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,clmsg.playerId,clmsg.playerName,EntityLookAdapter.fromNetwork(clmsg.look));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,clmsg.playerId,clmsg.playerName,EntityLookAdapter.fromNetwork(clmsg.look));
               }
               return true;
            case subareaName is ContactLookErrorMessage:
               clemsg = subareaName as ContactLookErrorMessage;
               return true;
            case subareaName is GuildGetInformationsAction:
               ggia = subareaName as GuildGetInformationsAction;
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
                  _loc264_ = new GuildGetInformationsMessage();
                  _loc264_.initGuildGetInformationsMessage(ggia.infoType);
                  ConnectionsHandler.getConnection().send(_loc264_);
               }
               return true;
            case subareaName is GuildInvitationAction:
               gia = subareaName as GuildInvitationAction;
               ginvitationmsg = new GuildInvitationMessage();
               ginvitationmsg.initGuildInvitationMessage(gia.targetId);
               ConnectionsHandler.getConnection().send(ginvitationmsg);
               return true;
            case subareaName is GuildInvitationSearchMessage:
               gibna = subareaName as GuildInvitationByNameAction;
               gibnmsg = new GuildInvitationSearchMessage();
               player_GIBNMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(gibna.target);
               gibnmsg.initGuildInvitationSearchMessage(player_GIBNMSG);
               ConnectionsHandler.getConnection().send(gibnmsg);
               return true;
            case subareaName is GuildDeleteApplicationRequestAction:
               gdarmsg = new GuildDeleteApplicationRequestMessage();
               ConnectionsHandler.getConnection().send(gdarmsg);
               return true;
            case subareaName is GuildApplicationDeletedMessage:
               gadm = subareaName as GuildApplicationDeletedMessage;
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPlayerApplicationDeleted,gadm.deleted);
               if(!gadm.deleted)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.guild.applyDeleteDelay"),666,TimeManager.getInstance().getTimestamp(),false);
               }
               return true;
            case subareaName is GuildJoinRequestAction:
               gjra = subareaName as GuildJoinRequestAction;
               gjarmsg = new GuildJoinAutomaticallyRequestMessage();
               gjarmsg.initGuildJoinAutomaticallyRequestMessage(gjra.guildId);
               ConnectionsHandler.getConnection().send(gjarmsg);
               return true;
            case subareaName is GuildSubmitApplicationAction:
               gsaa = subareaName as GuildSubmitApplicationAction;
               gsamsg = new GuildSubmitApplicationMessage();
               filters = gsaa.filters.formatForData();
               gsamsg.initGuildSubmitApplicationMessage(gsaa.applyText,gsaa.guildId,gsaa.timeSpent,filters.languageFilters,filters.ambianceFilters,filters.playtimeFilters,filters.interestFilters,filters.guildLevelMinMax,filters.recruitmentType,filters.playerLevelMinMax,filters.achievementMinMax,filters.searchName,filters.lastSort);
               ConnectionsHandler.getConnection().send(gsamsg);
               return true;
            case subareaName is GuildUpdateApplicationAction:
               guaa = subareaName as GuildUpdateApplicationAction;
               guamsg = new GuildUpdateApplicationMessage();
               guamsg.initGuildUpdateApplicationMessage(guaa.applyText,guaa.guildId);
               ConnectionsHandler.getConnection().send(guamsg);
               return true;
            case subareaName is GuildApplicationIsAnsweredMessage:
               gaiamsg = subareaName as GuildApplicationIsAnsweredMessage;
               notifId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.application"),I18n.getUiText(!!gaiamsg.accepted ? "ui.guild.applyAccepted" : "ui.guild.applyRejected",[HyperlinkShowGuildManager.getLink(gaiamsg.guildInformation,gaiamsg.guildInformation.guildName)]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplyAnswer");
               NotificationManager.getInstance().sendNotification(notifId);
               if(gaiamsg.accepted)
               {
                  _loc265_ = new DataStoreType("SocialBase",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(_loc265_,"SocialBase_GuildWarning",true);
               }
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationIsAnswered,gaiamsg.guildInformation,gaiamsg.accepted);
               return true;
            case subareaName is GuildApplicationReceivedMessage:
               garmsg = subareaName as GuildApplicationReceivedMessage;
               taxCollectorInfo = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.applicationReceived"),I18n.getUiText("ui.guild.applicationReceivedNotif",["{player," + garmsg.playerName + "," + garmsg.playerId + "::" + garmsg.playerName + "}"]),NotificationTypeEnum.SERVER_INFORMATION,"notifApplicationReceived");
               NotificationManager.getInstance().addButtonToNotification(taxCollectorInfo,I18n.getUiText("ui.guild.seeApplication"),"GuildApplicationsUiRequested",null,true,140,0,"hook");
               if(!PlayedCharacterManager.getInstance().isInKoli)
               {
                  NotificationManager.getInstance().sendNotification(taxCollectorInfo);
               }
               return true;
            case subareaName is GuildRecruitmentInvalidateMessage:
               grimsg = subareaName as GuildRecruitmentInvalidateMessage;
               taxCollectorInfo = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.guild.recruitmentInvalidate"),I18n.getUiText("ui.guild.recruitment.rulesBreak"),NotificationTypeEnum.SERVER_INFORMATION,"notifRecruitmentInvalidate");
               NotificationManager.getInstance().addButtonToNotification(taxCollectorInfo,I18n.getUiText("ui.guild.setUpRecruitment"),"OpenGuildPrezAndRecruitAction",null,true,200,0,"action");
               NotificationManager.getInstance().sendNotification(taxCollectorInfo);
               return true;
            case subareaName is GuildKickRequestAction:
               gkra = subareaName as GuildKickRequestAction;
               gkrmsg = new GuildKickRequestMessage();
               gkrmsg.initGuildKickRequestMessage(gkra.targetId);
               ConnectionsHandler.getConnection().send(gkrmsg);
               return true;
            case subareaName is GuildChangeMemberParametersAction:
               gcmpa = subareaName as GuildChangeMemberParametersAction;
               newRights = GuildWrapper.getRightsNumber(gcmpa.rights);
               gcmpmsg = new GuildChangeMemberParametersMessage();
               gcmpmsg.initGuildChangeMemberParametersMessage(gcmpa.memberId,gcmpa.rank,gcmpa.experienceGivenPercent,newRights);
               ConnectionsHandler.getConnection().send(gcmpmsg);
               return true;
            case subareaName is GuildSpellUpgradeRequestAction:
               gsura = subareaName as GuildSpellUpgradeRequestAction;
               gsurmsg = new GuildSpellUpgradeRequestMessage();
               gsurmsg.initGuildSpellUpgradeRequestMessage(gsura.spellId);
               ConnectionsHandler.getConnection().send(gsurmsg);
               return true;
            case subareaName is GuildCharacsUpgradeRequestAction:
               gcura = subareaName as GuildCharacsUpgradeRequestAction;
               gcurmsg = new GuildCharacsUpgradeRequestMessage();
               gcurmsg.initGuildCharacsUpgradeRequestMessage(gcura.charaTypeTarget);
               ConnectionsHandler.getConnection().send(gcurmsg);
               return true;
            case subareaName is GuildFarmTeleportRequestAction:
               gftra = subareaName as GuildFarmTeleportRequestAction;
               gftrmsg = new GuildPaddockTeleportRequestMessage();
               gftrmsg.initGuildPaddockTeleportRequestMessage(gftra.farmId);
               ConnectionsHandler.getConnection().send(gftrmsg);
               return true;
            case subareaName is HouseTeleportRequestAction:
               ghtra = subareaName as HouseTeleportRequestAction;
               ghtrmsg = new HouseTeleportRequestMessage();
               ghtrmsg.initHouseTeleportRequestMessage(ghtra.houseId,ghtra.houseInstanceId);
               ConnectionsHandler.getConnection().send(ghtrmsg);
               return true;
            case subareaName is GuildSetApplicationUpdatesRequestAction:
               if(!this._guild)
               {
                  return true;
               }
               galmsg = new GuildApplicationListenMessage();
               galmsg.initGuildApplicationListenMessage((subareaName as GuildSetApplicationUpdatesRequestAction).areEnabled);
               ConnectionsHandler.getConnection().send(galmsg);
               return true;
               break;
            case subareaName is GuildApplicationsRequestAction:
               garaction = subareaName as GuildApplicationsRequestAction;
               glarmsg = new GuildListApplicationRequestMessage();
               glarmsg.initGuildListApplicationRequestMessage(garaction.timestamp,garaction.limit);
               ConnectionsHandler.getConnection().send(glarmsg);
               return true;
            case subareaName is GuildListApplicationAnswerMessage:
               glaamsg = subareaName as GuildListApplicationAnswerMessage;
               applicationDescrs = new Vector.<GuildApplicationWrapper>(0);
               for each(_loc266_ in glaamsg.applies)
               {
                  applicationDescrs.push(GuildApplicationWrapper.wrap(_loc266_));
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationsReceived,applicationDescrs,glaamsg.offset,glaamsg.count,glaamsg.total);
               return true;
            case subareaName is GuildApplicationReplyAction:
               guildApplicationReplyAction = subareaName as GuildApplicationReplyAction;
               guildApplicationAnswerMessage = new GuildApplicationAnswerMessage();
               guildApplicationAnswerMessage.initGuildApplicationAnswerMessage(guildApplicationReplyAction.isAccepted,guildApplicationReplyAction.playerId);
               ConnectionsHandler.getConnection().send(guildApplicationAnswerMessage);
               return true;
            case subareaName is GuildListApplicationModifiedMessage:
               glammsg = subareaName as GuildListApplicationModifiedMessage;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildApplicationUpdated,GuildApplicationWrapper.wrap(glammsg.apply),glammsg.state,glammsg.playerId);
               return true;
            case subareaName is GuildSummaryRequestAction:
               gsra = subareaName as GuildSummaryRequestAction;
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
            case subareaName is GuildSummaryMessage:
               gsm = subareaName as GuildSummaryMessage;
               this._allGuildsInDirectory = new Vector.<GuildWrapper>(0);
               for each(_loc267_ in gsm.guilds)
               {
                  guildWrapper = GuildWrapper.getFromNetwork(_loc267_);
                  if(guildWrapper)
                  {
                     this._allGuildsInDirectory.push(guildWrapper);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.GuildsReceived,this._allGuildsInDirectory,gsm.offset,gsm.count,gsm.total);
               return true;
            case subareaName is GuildGetPlayerApplicationAction:
               ggpam = new GuildGetPlayerApplicationMessage();
               ConnectionsHandler.getConnection().send(ggpam);
               return true;
            case subareaName is GuildPlayerApplicationInformationMessage:
               gpaim = subareaName as GuildPlayerApplicationInformationMessage;
               PlayedCharacterManager.getInstance().applicationInfo = gpaim.apply;
               PlayedCharacterManager.getInstance().guildApplicationInfo = gpaim.guildInformation;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildPlayerApplicationReceived,gpaim.guildInformation,gpaim.apply);
               return true;
            case subareaName is GuildPlayerNoApplicationInformationMessage:
               PlayedCharacterManager.getInstance().applicationInfo = null;
               PlayedCharacterManager.getInstance().guildApplicationInfo = null;
               return true;
            case subareaName is GuildFightJoinRequestAction:
               gfjra = subareaName as GuildFightJoinRequestAction;
               gfjrmsg = new GuildFightJoinRequestMessage();
               gfjrmsg.initGuildFightJoinRequestMessage(gfjra.taxCollectorId);
               ConnectionsHandler.getConnection().send(gfjrmsg);
               return true;
            case subareaName is GuildFightTakePlaceRequestAction:
               gftpra = subareaName as GuildFightTakePlaceRequestAction;
               gftprmsg = new GuildFightTakePlaceRequestMessage();
               gftprmsg.initGuildFightTakePlaceRequestMessage(gftpra.taxCollectorId,gftpra.replacedCharacterId);
               ConnectionsHandler.getConnection().send(gftprmsg);
               return true;
            case subareaName is GuildFightLeaveRequestAction:
               gflra = subareaName as GuildFightLeaveRequestAction;
               this._autoLeaveHelpers = false;
               if(gflra.warning)
               {
                  for each(_loc268_ in TaxCollectorsManager.getInstance().taxCollectors)
                  {
                     if(_loc268_.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
                     {
                        _loc269_ = TaxCollectorsManager.getInstance().allTaxCollectorsInFight[_loc268_.uniqueId];
                        for each(_loc270_ in _loc269_.allyCharactersInformations)
                        {
                           if(_loc270_.playerCharactersInformations.id == gflra.characterId)
                           {
                              this._autoLeaveHelpers = true;
                              gflrmsg = new GuildFightLeaveRequestMessage();
                              gflrmsg.initGuildFightLeaveRequestMessage(_loc268_.uniqueId,gflra.characterId);
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
            case subareaName is GuildHouseUpdateInformationMessage:
               if(this._guildHousesList)
               {
                  _loc271_ = subareaName as GuildHouseUpdateInformationMessage;
                  _loc272_ = false;
                  for each(_loc273_ in this._guildHouses)
                  {
                     if(_loc273_.houseId == _loc271_.housesInformations.houseId && _loc273_.houseInstanceId == _loc271_.housesInformations.instanceId)
                     {
                        _loc273_.update(_loc271_.housesInformations);
                        _loc272_ = true;
                     }
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHousesUpdate);
                  }
                  if(!_loc272_)
                  {
                     _loc274_ = GuildHouseWrapper.create(_loc271_.housesInformations);
                     this._guildHouses.push(_loc274_);
                     KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseAdd,_loc274_);
                  }
                  this._guildHousesListUpdate = true;
               }
               return true;
            case subareaName is GuildHouseRemoveMessage:
               if(this._guildHousesList)
               {
                  _loc275_ = subareaName as GuildHouseRemoveMessage;
                  for(_loc276_ = 0; _loc276_ < this._guildHouses.length; _loc276_++)
                  {
                     if(this._guildHouses[_loc276_].houseId == _loc275_.houseId && this._guildHouses[_loc276_].houseInstanceId == _loc275_.instanceId)
                     {
                        this._guildHouses.splice(_loc276_,1);
                     }
                  }
                  this._guildHousesListUpdate = true;
                  KernelEventsManager.getInstance().processCallback(SocialHookList.GuildHouseRemoved,_loc275_.houseId);
               }
               return true;
            case subareaName is GuildFactsRequestAction:
               gfra = subareaName as GuildFactsRequestAction;
               gfrmsg = new GuildFactsRequestMessage();
               gfrmsg.initGuildFactsRequestMessage(gfra.guildId);
               ConnectionsHandler.getConnection().send(gfrmsg);
               return true;
            case subareaName is GuildFactsMessage:
               gfmsg = subareaName as GuildFactsMessage;
               guildSheet = this._allGuilds[gfmsg.infos.guildId];
               allianceId = 0;
               allianceName = "";
               allianceTag = "";
               if(subareaName is GuildInAllianceFactsMessage)
               {
                  _loc277_ = subareaName as GuildInAllianceFactsMessage;
                  allianceId = _loc277_.allianceInfos.allianceId;
                  allianceName = _loc277_.allianceInfos.allianceName;
                  allianceTag = _loc277_.allianceInfos.allianceTag;
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
            case subareaName is GuildFactsErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.guild.doesntExistAnymore"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case subareaName is GuildMotdSetRequestAction:
               gmsra = subareaName as GuildMotdSetRequestAction;
               gmsrmsg = new GuildMotdSetRequestMessage();
               gmsrmsg.initGuildMotdSetRequestMessage(gmsra.content);
               ConnectionsHandler.getConnection().send(gmsrmsg);
               return true;
            case subareaName is GuildMotdMessage:
               gmomsg = subareaName as GuildMotdMessage;
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
                  _loc278_ = I18n.getUiText("ui.motd.guild") + I18n.getUiText("ui.common.colon") + motdContent[0];
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc278_,ChatActivableChannelsEnum.CHANNEL_GUILD,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case subareaName is GuildMotdSetErrorMessage:
               gmosemsg = subareaName as GuildMotdSetErrorMessage;
               switch(gmosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     suba = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     suba = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     suba = I18n.getUiText("ui.social.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,suba,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case subareaName is GuildBulletinSetRequestAction:
               gbsra = subareaName as GuildBulletinSetRequestAction;
               gbsrmsg = new GuildBulletinSetRequestMessage();
               gbsrmsg.initGuildBulletinSetRequestMessage(gbsra.content,gbsra.notifyMembers);
               ConnectionsHandler.getConnection().send(gbsrmsg);
               return true;
            case subareaName is GuildBulletinMessage:
               gbomsg = subareaName as GuildBulletinMessage;
               content = gbomsg.content;
               pattern = /</g;
               content = content.replace(pattern,"&lt;");
               bulletinContent = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).checkCensored(content,ChatActivableChannelsEnum.CHANNEL_GUILD,gbomsg.memberId,gbomsg.memberName);
               this._guild.bulletin = gbomsg.content;
               this._guild.formattedBulletin = bulletinContent[0];
               this._guild.bulletinWriterId = gbomsg.memberId;
               this._guild.bulletinWriterName = gbomsg.memberName;
               this._guild.bulletinTimestamp = gbomsg.timestamp;
               this._guild.lastNotifiedTimestamp = gbomsg.lastNotifiedTimestamp;
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildBulletin);
               return true;
            case subareaName is GuildBulletinSetErrorMessage:
               gbosemsg = subareaName as GuildBulletinSetErrorMessage;
               switch(gbosemsg.reason)
               {
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_UNKNOWN_ERROR:
                     suba = I18n.getUiText("ui.common.unknownFail");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_COOLDOWN:
                     suba = I18n.getUiText("ui.motd.errorCooldown");
                     break;
                  case SocialNoticeErrorEnum.SOCIAL_NOTICE_INVALID_RIGHTS:
                     suba = I18n.getUiText("ui.social.taxCollectorNoRights");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,suba,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               return true;
            case subareaName is PlayerStatusUpdateMessage:
               psum = subareaName as PlayerStatusUpdateMessage;
               message = "";
               if(psum.status is PlayerStatusExtended)
               {
                  message = PlayerStatusExtended(psum.status).message;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.PlayerStatusUpdate,psum.accountId,psum.playerId,psum.status.statusId,message);
               if(this._guildMembers != null)
               {
                  _loc280_ = this._guildMembers.length;
                  for(_loc281_ = 0; _loc281_ < _loc280_; _loc281_++)
                  {
                     if(this._guildMembers[_loc281_].id == psum.playerId)
                     {
                        this._guildMembers[_loc281_].status = psum.status;
                        _loc279_ = this._guildMembers[_loc281_];
                        KernelEventsManager.getInstance().processCallback(SocialHookList.GuildInformationsMemberUpdate,_loc279_);
                        break;
                     }
                  }
               }
               if(this._friendsList != null)
               {
                  for each(_loc282_ in this._friendsList)
                  {
                     if(_loc282_.accountId == psum.accountId)
                     {
                        _loc282_.statusId = psum.status.statusId;
                        if(psum.status is PlayerStatusExtended)
                        {
                           _loc282_.awayMessage = PlayerStatusExtended(psum.status).message;
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.FriendsListUpdated);
                        break;
                     }
                  }
               }
               if(this._contactsList != null)
               {
                  for each(_loc283_ in this._contactsList)
                  {
                     if(_loc283_.accountId == psum.accountId)
                     {
                        _loc283_.statusId = psum.status.statusId;
                        if(psum.status is PlayerStatusExtended)
                        {
                           _loc283_.awayMessage = PlayerStatusExtended(psum.status).message;
                        }
                        KernelEventsManager.getInstance().processCallback(SocialHookList.ContactsListUpdated);
                        break;
                     }
                  }
               }
               return false;
            case subareaName is PlayerStatusUpdateErrorMessage:
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.chat.status.awaymessageerror"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return false;
            case subareaName is PlayerStatusUpdateRequestAction:
               psura = subareaName as PlayerStatusUpdateRequestAction;
               if(psura.message)
               {
                  _loc284_ = new ChatApi();
                  psura.message = _loc284_.escapeChatString(psura.message);
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
            case subareaName is ContactLookRequestByIdAction:
               clrbia = subareaName as ContactLookRequestByIdAction;
               if(clrbia.entityId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ContactLook,PlayedCharacterManager.getInstance().id,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  _loc285_ = new ContactLookRequestByIdMessage();
                  _loc285_.initContactLookRequestByIdMessage(1,clrbia.contactType,clrbia.entityId);
                  ConnectionsHandler.getConnection().send(_loc285_);
               }
               return true;
            case subareaName is RecruitmentInformationMessage:
               recruitmentData = GuildRecruitmentDataWrapper.wrap((subareaName as RecruitmentInformationMessage).recruitmentData);
               if(this._guild)
               {
                  this._guild.guildRecruitmentInfo = recruitmentData;
               }
               KernelEventsManager.getInstance().processCallback(SocialHookList.GuildRecruitmentDataReceived,recruitmentData);
               return true;
            case subareaName is SendGuildRecruitmentDataAction:
               newRecruitmentData = (subareaName as SendGuildRecruitmentDataAction).recruitmentData;
               if(newRecruitmentData === null)
               {
                  return true;
               }
               urimsg = new UpdateRecruitmentInformationMessage();
               urimsg.initUpdateRecruitmentInformationMessage(newRecruitmentData.unwrap());
               ConnectionsHandler.getConnection().send(urimsg);
               return true;
               break;
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
      
      public function generateApplicationServerMessage(size:Number) : Vector.<Object>
      {
         var fakeApplication:Object = null;
         var playerInfo:FriendOnlineInformations = null;
         if(_fakeApplicationList !== null)
         {
            return _fakeApplicationList;
         }
         if(_fakeApplicationData === null)
         {
            _fakeApplicationData = new <Object>[{
               "id":42,
               "characterName":"Croquette",
               "characterId":34001424242,
               "accountUsername":"papychat",
               "accountTag":4581,
               "accountId":424242,
               "characterLevel":200,
               "characterSex":1,
               "characterBreedId":2,
               "statusId":10,
               "timestamp":1633425214000,
               "awayMessage":null,
               "text":"Bonjour, je suis Angy. Je cherche une guilde casu pour jouer le we et un soir par semaine, j\'aime faire du PVP et des donjons. J\'aimerais trouver une guilde avec une bonne ambiance sans prise de tête."
            },{
               "id":43,
               "characterName":"Alea",
               "characterId":34001424243,
               "accountUsername":"hackxor",
               "accountTag":4421,
               "accountId":424243,
               "characterLevel":200,
               "characterSex":1,
               "characterBreedId":13,
               "statusId":21,
               "timestamp":1633252414000,
               "awayMessage":"brb 5min",
               "text":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nisl leo, facilisis eget venenatis sit amet, sagittis in nulla. Quisque erat risus, aliquet et tincidunt et, laoreet sit amet."
            },{
               "id":44,
               "characterName":"Jonas",
               "characterId":34001424244,
               "accountUsername":"helloworld",
               "accountTag":9992,
               "accountId":424244,
               "characterLevel":200,
               "characterSex":0,
               "characterBreedId":18,
               "statusId":20,
               "timestamp":1633166014000,
               "awayMessage":null,
               "text":"Donec non tristique libero. Sed nec maximus sem. Proin metus lorem, vestibulum id nibh eu, efficitur pellentesque metus. Suspendisse ex lorem, iaculis in iaculis in, dignissim quis nulla."
            },{
               "id":45,
               "characterName":"FeelGood",
               "characterId":34001424245,
               "accountUsername":"oneorzero",
               "accountTag":1337,
               "accountId":424245,
               "characterLevel":200,
               "characterSex":0,
               "characterBreedId":8,
               "statusId":10,
               "timestamp":1633165474000,
               "awayMessage":null,
               "text":"Cras ornare at lacus eget vehicula. Cras ac massa elit. Maecenas tincidunt laoreet tincidunt. In a nisl dolor. Donec dictum quam sapien, eu tempor tellus euismod sed. Morbi rutrum posuere nunc."
            },{
               "id":46,
               "characterName":"Arthur",
               "characterId":34001424246,
               "accountUsername":"CinemaLover",
               "accountTag":1795,
               "accountId":424246,
               "characterLevel":200,
               "characterSex":0,
               "characterBreedId":16,
               "statusId":21,
               "timestamp":1633079074000,
               "awayMessage":null,
               "text":"Ut eu mattis lacus, quis volutpat sapien. Duis tincidunt magna diam, et malesuada nunc sagittis eget. Sed auctor condimentum sapien eget tincidunt. Vivamus feugiat tempus erat in aliquam."
            }];
         }
         var fakeData:Vector.<Object> = new Vector.<Object>(0);
         var fakeApplicationDataSize:Number = _fakeApplicationData.length;
         for(var index:Number = 0; index < size; index++)
         {
            fakeApplication = _fakeApplicationData[index % fakeApplicationDataSize];
            playerInfo = new FriendOnlineInformations();
            playerInfo.playerName = fakeApplication.characterName;
            playerInfo.breed = fakeApplication.characterBreedId;
            playerInfo.playerId = fakeApplication.characterId;
            playerInfo.level = fakeApplication.characterLevel;
            playerInfo.sex = fakeApplication.characterSex;
            playerInfo.accountId = fakeApplication.accountId;
            playerInfo.accountTag.nickname = fakeApplication.accountUsername;
            playerInfo.accountTag.tagNumber = fakeApplication.accountTag;
            playerInfo.status = new PlayerStatusExtended();
            playerInfo.status.statusId = fakeApplication.statusId;
            (playerInfo.status as PlayerStatusExtended).message = fakeApplication.awayMessage;
            playerInfo.playerName = "Character #" + index;
            fakeApplication.id = index;
            fakeApplication.timestamp = 1633079074000 + index * 200000000;
            fakeData.push({
               "id":fakeApplication.id,
               "playerInfo":playerInfo,
               "text":fakeApplication.text,
               "timestamp":fakeApplication.timestamp
            });
         }
         _fakeApplicationList = fakeData;
         return _fakeApplicationList;
      }
   }
}

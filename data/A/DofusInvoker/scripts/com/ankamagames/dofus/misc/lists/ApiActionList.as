package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
   import com.ankamagames.dofus.logic.common.actions.AgreementAgreedAction;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.actions.DirectSelectionCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.dofus.logic.common.actions.OpenPopupAction;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
   import com.ankamagames.dofus.logic.connection.actions.ForceAccountAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTicketAction;
   import com.ankamagames.dofus.logic.connection.actions.LoginValidationWithTokenAction;
   import com.ankamagames.dofus.logic.connection.actions.NicknameChoiceRequestAction;
   import com.ankamagames.dofus.logic.connection.actions.ReleaseAccountAction;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeselectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRemodelSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterReplayRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignAllRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignCancelAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GiftAssignRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.AccessoryPreviewRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityHideRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivityLockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ActivitySuggestionsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.BasicWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenAction;
   import com.ankamagames.dofus.logic.game.common.actions.CaptureScreenWithoutUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.ChangeScreenshotsDirectoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.CharacterAutoConnectAction;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.ContactLookRequestByIdAction;
   import com.ankamagames.dofus.logic.game.common.actions.FollowQuestAction;
   import com.ankamagames.dofus.logic.game.common.actions.ForgettableSpellClientAction;
   import com.ankamagames.dofus.logic.game.common.actions.GameContextQuitAction;
   import com.ankamagames.dofus.logic.game.common.actions.GoToUrlAction;
   import com.ankamagames.dofus.logic.game.common.actions.GroupTeleportPlayerOfferReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.GuildUpdateChestTabRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsChangeAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseLockFromInsideAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
   import com.ankamagames.dofus.logic.game.common.actions.IncreaseSpellLevelAction;
   import com.ankamagames.dofus.logic.game.common.actions.InteractiveElementActivationAction;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.LockableUseCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationUpdateFlagAction;
   import com.ankamagames.dofus.logic.game.common.actions.NumericWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenAlliancePrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenForgettableSpellsUiAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuideBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuildPrezAndRecruitAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenHousesAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenServerSelectionAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenStatsAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSubhintListAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenTeamSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.PivotCharacterAction;
   import com.ankamagames.dofus.logic.game.common.actions.PlaySoundAction;
   import com.ankamagames.dofus.logic.game.common.actions.RefreshFollowedQuestsOrderAction;
   import com.ankamagames.dofus.logic.game.common.actions.ReportPlayerAction;
   import com.ankamagames.dofus.logic.game.common.actions.StartGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.StartZoomAction;
   import com.ankamagames.dofus.logic.game.common.actions.StopGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.SurveyNotificationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.TeleportPlayerOfferReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.ToggleShowUIAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortDonateAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.CharacterAlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.KohOverAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.SetEnableAVARequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatCommandAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatLoadedAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ClearChatAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.PopupWarningCloseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.GuildSelectChestTabRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeCodeAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeMultipleKardAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeSimpleKardAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiBufferKamasListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiCancelBidRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConfirmationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiConsumeBufferKamasRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.HaapiValidationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenBakRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenCodesAndGiftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.RefreshBakOffersAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopArticlesListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopAuthentificationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopSearchRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.UpdateGiftListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeBonusSelectAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeModSelectAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeSelectionAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeTargetsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.fight.ChallengeValidateAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetChestTabContributionsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAbdicateThroneAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAcceptInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAllStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyCancelInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyFollowMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyNameSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyPledgeLoyaltyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyRefuseInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyShowMenuAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyStopFollowingMemberAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismAttackRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismExchangeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismInfoJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismRecycleTradeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementAlmostFinishedDetailedListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailedListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementRewardRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementsPioneerRanksRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeQuitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.GuidedModeReturnRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestInfosRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestListRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestObjectiveValidationAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestStartRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.WatchQuestInfosRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.PortalUseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntDigRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntGiveUpRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntLegendaryRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.AnomalySubareaInformationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.GameRolePlayFreeSoulRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.SwitchCreatureModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.JoinAsSpectatorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.MapRunningFightDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.StopToListenRunningFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.OrnamentSelectRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitleSelectRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitlesAndOrnamentsListRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.DisableAfkAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameContextKickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementPositionRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsAcceptAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsCancelAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightReadyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellPreviewAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightTurnFinishAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowMountsInFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowTacticModeAction;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderPopupNameAction;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderVoteAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleEntityIconsAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleHelpWantedAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TogglePointCellAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleWitnessForbiddenAction;
   import com.ankamagames.dofus.logic.game.fight.actions.UpdateSpellModifierAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveSetRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.HighlightInteractiveElementsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectDropAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseOnCellAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PresetSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ResetCharacterStatsRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowFightPositionsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.SpellVariantActivationRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.StatsUpgradeRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ZaapRespawnSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.OpenAlterationUiAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.alterations.UpdateAlterationFavoriteFlagAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagClearAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEditModeAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagExitAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagFurnitureSelectedAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagPermissionsUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagResetAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagRoomSelectedAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagSaveAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagThemeSelectedAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.CharacterPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeDeleteRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeInstallRequestAction;
   import com.ankamagames.dofus.themes.utils.actions.ThemeListRequestAction;
   
   public class ApiActionList
   {
      
      public static const OpenPopup:DofusApiAction = new DofusApiAction("OpenPopupAction",OpenPopupAction);
      
      public static const ChatCommand:DofusApiAction = new DofusApiAction("ChatCommandAction",ChatCommandAction);
      
      public static const ChatLoaded:DofusApiAction = new DofusApiAction("ChatLoadedAction",ChatLoadedAction);
      
      public static const ClearChat:DofusApiAction = new DofusApiAction("ClearChatAction",ClearChatAction);
      
      public static const PopupWarningCloseRequest:DofusApiAction = new DofusApiAction("PopupWarningCloseRequestAction",PopupWarningCloseRequestAction);
      
      public static const AuthorizedCommand:DofusApiAction = new DofusApiAction("AuthorizedCommandAction",AuthorizedCommandAction);
      
      public static const LoginValidation:DofusApiAction = new DofusApiAction("LoginValidationAction",LoginValidationAction);
      
      public static const LoginValidationWithTicket:DofusApiAction = new DofusApiAction("LoginValidationWithTicketAction",LoginValidationWithTicketAction);
      
      public static const LoginValidationWithToken:DofusApiAction = new DofusApiAction("LoginValidationWithTokenAction",LoginValidationWithTokenAction);
      
      public static const ForceAccount:DofusApiAction = new DofusApiAction("ForceAccountAction",ForceAccountAction);
      
      public static const ReleaseAccount:DofusApiAction = new DofusApiAction("ReleaseAccountAction",ReleaseAccountAction);
      
      public static const NicknameChoiceRequest:DofusApiAction = new DofusApiAction("NicknameChoiceRequestAction",NicknameChoiceRequestAction);
      
      public static const ServerSelection:DofusApiAction = new DofusApiAction("ServerSelectionAction",ServerSelectionAction);
      
      public static const AcquaintanceSearch:DofusApiAction = new DofusApiAction("AcquaintanceSearchAction",AcquaintanceSearchAction);
      
      public static const ChangeCharacter:DofusApiAction = new DofusApiAction("ChangeCharacterAction",ChangeCharacterAction);
      
      public static const DirectSelectionCharacter:DofusApiAction = new DofusApiAction("DirectSelectionCharacterAction",DirectSelectionCharacterAction);
      
      public static const ChangeServer:DofusApiAction = new DofusApiAction("ChangeServerAction",ChangeServerAction);
      
      public static const QuitGame:DofusApiAction = new DofusApiAction("QuitGameAction",QuitGameAction);
      
      public static const ResetGame:DofusApiAction = new DofusApiAction("ResetGameAction",ResetGameAction);
      
      public static const AgreementAgreed:DofusApiAction = new DofusApiAction("AgreementAgreedAction",AgreementAgreedAction);
      
      public static const CharacterCreation:DofusApiAction = new DofusApiAction("CharacterCreationAction",CharacterCreationAction);
      
      public static const CharacterDeletion:DofusApiAction = new DofusApiAction("CharacterDeletionAction",CharacterDeletionAction);
      
      public static const CharacterNameSuggestionRequest:DofusApiAction = new DofusApiAction("CharacterNameSuggestionRequestAction",CharacterNameSuggestionRequestAction);
      
      public static const CharacterReplayRequest:DofusApiAction = new DofusApiAction("CharacterReplayRequestAction",CharacterReplayRequestAction);
      
      public static const CharacterDeselection:DofusApiAction = new DofusApiAction("CharacterDeselectionAction",CharacterDeselectionAction);
      
      public static const CharacterSelection:DofusApiAction = new DofusApiAction("CharacterSelectionAction",CharacterSelectionAction);
      
      public static const CharacterRemodelSelection:DofusApiAction = new DofusApiAction("CharacterRemodelSelectionAction",CharacterRemodelSelectionAction);
      
      public static const CharacterAutoConnect:DofusApiAction = new DofusApiAction("CharacterAutoConnectAction",CharacterAutoConnectAction);
      
      public static const GameContextQuit:DofusApiAction = new DofusApiAction("GameContextQuitAction",GameContextQuitAction);
      
      public static const OpenCurrentFight:DofusApiAction = new DofusApiAction("OpenCurrentFightAction",OpenCurrentFightAction);
      
      public static const OpenMainMenu:DofusApiAction = new DofusApiAction("OpenMainMenuAction",OpenMainMenuAction);
      
      public static const OpenMount:DofusApiAction = new DofusApiAction("OpenMountAction",OpenMountAction);
      
      public static const OpenInventory:DofusApiAction = new DofusApiAction("OpenInventoryAction",OpenInventoryAction);
      
      public static const CloseInventory:DofusApiAction = new DofusApiAction("CloseInventoryAction",CloseInventoryAction);
      
      public static const OpenMap:DofusApiAction = new DofusApiAction("OpenMapAction",OpenMapAction);
      
      public static const OpenBook:DofusApiAction = new DofusApiAction("OpenBookAction",OpenBookAction);
      
      public static const OpenServerSelection:DofusApiAction = new DofusApiAction("OpenServerSelectionAction",OpenServerSelectionAction);
      
      public static const OpenSmileys:DofusApiAction = new DofusApiAction("OpenSmileysAction",OpenSmileysAction);
      
      public static const OpenTeamSearch:DofusApiAction = new DofusApiAction("OpenTeamSearchAction",OpenTeamSearchAction);
      
      public static const OpenArena:DofusApiAction = new DofusApiAction("OpenArenaAction",OpenArenaAction);
      
      public static const OpenStats:DofusApiAction = new DofusApiAction("OpenStatsAction",OpenStatsAction);
      
      public static const OpenSubhintList:DofusApiAction = new DofusApiAction("OpenSubhintListAction",OpenSubhintListAction);
      
      public static const OpenHouses:DofusApiAction = new DofusApiAction("OpenHousesAction",OpenHousesAction);
      
      public static const IncreaseSpellLevel:DofusApiAction = new DofusApiAction("IncreaseSpellLevelAction",IncreaseSpellLevelAction);
      
      public static const BasicWhoIsRequest:DofusApiAction = new DofusApiAction("BasicWhoIsRequestAction",BasicWhoIsRequestAction);
      
      public static const NumericWhoIsRequest:DofusApiAction = new DofusApiAction("NumericWhoIsRequestAction",NumericWhoIsRequestAction);
      
      public static const AddBehaviorToStack:DofusApiAction = new DofusApiAction("AddBehaviorToStackAction",AddBehaviorToStackAction);
      
      public static const RemoveBehaviorToStack:DofusApiAction = new DofusApiAction("RemoveBehaviorToStackAction",RemoveBehaviorToStackAction);
      
      public static const EmptyStack:DofusApiAction = new DofusApiAction("EmptyStackAction",EmptyStackAction);
      
      public static const GameFightReady:DofusApiAction = new DofusApiAction("GameFightReadyAction",GameFightReadyAction);
      
      public static const GameFightSpellCast:DofusApiAction = new DofusApiAction("GameFightSpellCastAction",GameFightSpellCastAction);
      
      public static const GameFightSpellPreview:DofusApiAction = new DofusApiAction("GameFightSpellPreviewAction",GameFightSpellPreviewAction);
      
      public static const GameFightTurnFinish:DofusApiAction = new DofusApiAction("GameFightTurnFinishAction",GameFightTurnFinishAction);
      
      public static const TimelineEntityClick:DofusApiAction = new DofusApiAction("TimelineEntityClickAction",TimelineEntityClickAction);
      
      public static const GameFightPlacementPositionRequest:DofusApiAction = new DofusApiAction("GameFightPlacementPositionRequestAction",GameFightPlacementPositionRequestAction);
      
      public static const GameFightPlacementSwapPositionsRequest:DofusApiAction = new DofusApiAction("GameFightPlacementSwapPositionsRequestAction",GameFightPlacementSwapPositionsRequestAction);
      
      public static const GameFightPlacementSwapPositionsCancel:DofusApiAction = new DofusApiAction("GameFightPlacementSwapPositionsCancelAction",GameFightPlacementSwapPositionsCancelAction);
      
      public static const GameFightPlacementSwapPositionsAccept:DofusApiAction = new DofusApiAction("GameFightPlacementSwapPositionsAcceptAction",GameFightPlacementSwapPositionsAcceptAction);
      
      public static const BannerEmptySlotClick:DofusApiAction = new DofusApiAction("BannerEmptySlotClickAction",BannerEmptySlotClickAction);
      
      public static const TimelineEntityOver:DofusApiAction = new DofusApiAction("TimelineEntityOverAction",TimelineEntityOverAction);
      
      public static const TimelineEntityOut:DofusApiAction = new DofusApiAction("TimelineEntityOutAction",TimelineEntityOutAction);
      
      public static const ToggleDematerialization:DofusApiAction = new DofusApiAction("ToggleDematerializationAction",ToggleDematerializationAction);
      
      public static const ToggleHelpWanted:DofusApiAction = new DofusApiAction("ToggleHelpWantedAction",ToggleHelpWantedAction);
      
      public static const ToggleLockFight:DofusApiAction = new DofusApiAction("ToggleLockFightAction",ToggleLockFightAction);
      
      public static const SurrenderPopupName:DofusApiAction = new DofusApiAction("SurrenderPopupNameAction",SurrenderPopupNameAction);
      
      public static const SurrenderInfoRequest:DofusApiAction = new DofusApiAction("SurrenderInfoRequestAction",SurrenderInfoRequestAction);
      
      public static const SurrenderVote:DofusApiAction = new DofusApiAction("SurrenderVoteAction",SurrenderVoteAction);
      
      public static const ToggleLockParty:DofusApiAction = new DofusApiAction("ToggleLockPartyAction",ToggleLockPartyAction);
      
      public static const ToggleWitnessForbidden:DofusApiAction = new DofusApiAction("ToggleWitnessForbiddenAction",ToggleWitnessForbiddenAction);
      
      public static const UpdateSpellModifier:DofusApiAction = new DofusApiAction("UpdateSpellModifierAction",UpdateSpellModifierAction);
      
      public static const TogglePointCell:DofusApiAction = new DofusApiAction("TogglePointCellAction",TogglePointCellAction);
      
      public static const GameContextKick:DofusApiAction = new DofusApiAction("GameContextKickAction",GameContextKickAction);
      
      public static const DisableAfk:DofusApiAction = new DofusApiAction("DisableAfkAction",DisableAfkAction);
      
      public static const ShowTacticMode:DofusApiAction = new DofusApiAction("ShowTacticModeAction",ShowTacticModeAction);
      
      public static const LeaveDialogRequest:DofusApiAction = new DofusApiAction("LeaveDialogRequestAction",LeaveDialogRequestAction);
      
      public static const TeleportRequest:DofusApiAction = new DofusApiAction("TeleportRequestAction",TeleportRequestAction);
      
      public static const ZaapRespawnSaveRequest:DofusApiAction = new DofusApiAction("ZaapRespawnSaveRequestAction",ZaapRespawnSaveRequestAction);
      
      public static const ObjectSetPosition:DofusApiAction = new DofusApiAction("ObjectSetPositionAction",ObjectSetPositionAction);
      
      public static const PresetSetPosition:DofusApiAction = new DofusApiAction("PresetSetPositionAction",PresetSetPositionAction);
      
      public static const ObjectDrop:DofusApiAction = new DofusApiAction("ObjectDropAction",ObjectDropAction);
      
      public static const ResetCharacterStatsRequest:DofusApiAction = new DofusApiAction("ResetCharacterStatsRequestAction",ResetCharacterStatsRequestAction);
      
      public static const StatsUpgradeRequest:DofusApiAction = new DofusApiAction("StatsUpgradeRequestAction",StatsUpgradeRequestAction);
      
      public static const DeleteObject:DofusApiAction = new DofusApiAction("DeleteObjectAction",DeleteObjectAction);
      
      public static const ObjectUse:DofusApiAction = new DofusApiAction("ObjectUseAction",ObjectUseAction);
      
      public static const PresetDeleteRequest:DofusApiAction = new DofusApiAction("PresetDeleteRequestAction",PresetDeleteRequestAction);
      
      public static const CharacterPresetSaveRequest:DofusApiAction = new DofusApiAction("CharacterPresetSaveRequestAction",CharacterPresetSaveRequestAction);
      
      public static const PresetUseRequest:DofusApiAction = new DofusApiAction("PresetUseRequestAction",PresetUseRequestAction);
      
      public static const AccessoryPreviewRequest:DofusApiAction = new DofusApiAction("AccessoryPreviewRequestAction",AccessoryPreviewRequestAction);
      
      public static const SwitchCreatureMode:DofusApiAction = new DofusApiAction("SwitchCreatureModeAction",SwitchCreatureModeAction);
      
      public static const NpcDialogReply:DofusApiAction = new DofusApiAction("NpcDialogReplyAction",NpcDialogReplyAction);
      
      public static const InteractiveElementActivation:DofusApiAction = new DofusApiAction("InteractiveElementActivationAction",InteractiveElementActivationAction);
      
      public static const PivotCharacter:DofusApiAction = new DofusApiAction("PivotCharacterAction",PivotCharacterAction);
      
      public static const ShowAllNames:DofusApiAction = new DofusApiAction("ShowAllNamesAction",ShowAllNamesAction);
      
      public static const PartyInvitation:DofusApiAction = new DofusApiAction("PartyInvitationAction",PartyInvitationAction);
      
      public static const PartyInvitationDetailsRequest:DofusApiAction = new DofusApiAction("PartyInvitationDetailsRequestAction",PartyInvitationDetailsRequestAction);
      
      public static const PartyCancelInvitation:DofusApiAction = new DofusApiAction("PartyCancelInvitationAction",PartyCancelInvitationAction);
      
      public static const PartyAcceptInvitation:DofusApiAction = new DofusApiAction("PartyAcceptInvitationAction",PartyAcceptInvitationAction);
      
      public static const PartyRefuseInvitation:DofusApiAction = new DofusApiAction("PartyRefuseInvitationAction",PartyRefuseInvitationAction);
      
      public static const PartyLeaveRequest:DofusApiAction = new DofusApiAction("PartyLeaveRequestAction",PartyLeaveRequestAction);
      
      public static const PartyKickRequest:DofusApiAction = new DofusApiAction("PartyKickRequestAction",PartyKickRequestAction);
      
      public static const PartyAbdicateThrone:DofusApiAction = new DofusApiAction("PartyAbdicateThroneAction",PartyAbdicateThroneAction);
      
      public static const PartyPledgeLoyaltyRequest:DofusApiAction = new DofusApiAction("PartyPledgeLoyaltyRequestAction",PartyPledgeLoyaltyRequestAction);
      
      public static const PartyFollowMember:DofusApiAction = new DofusApiAction("PartyFollowMemberAction",PartyFollowMemberAction);
      
      public static const PartyAllFollowMember:DofusApiAction = new DofusApiAction("PartyAllFollowMemberAction",PartyAllFollowMemberAction);
      
      public static const PartyStopFollowingMember:DofusApiAction = new DofusApiAction("PartyStopFollowingMemberAction",PartyStopFollowingMemberAction);
      
      public static const PartyAllStopFollowingMember:DofusApiAction = new DofusApiAction("PartyAllStopFollowingMemberAction",PartyAllStopFollowingMemberAction);
      
      public static const PartyNameSetRequest:DofusApiAction = new DofusApiAction("PartyNameSetRequestAction",PartyNameSetRequestAction);
      
      public static const PartyShowMenu:DofusApiAction = new DofusApiAction("PartyShowMenuAction",PartyShowMenuAction);
      
      public static const MapRunningFightDetailsRequest:DofusApiAction = new DofusApiAction("MapRunningFightDetailsRequestAction",MapRunningFightDetailsRequestAction);
      
      public static const StopToListenRunningFight:DofusApiAction = new DofusApiAction("StopToListenRunningFightAction",StopToListenRunningFightAction);
      
      public static const JoinFightRequest:DofusApiAction = new DofusApiAction("JoinFightRequestAction",JoinFightRequestAction);
      
      public static const JoinAsSpectatorRequest:DofusApiAction = new DofusApiAction("JoinAsSpectatorRequestAction",JoinAsSpectatorRequestAction);
      
      public static const GameFightSpectatePlayerRequest:DofusApiAction = new DofusApiAction("GameFightSpectatePlayerRequestAction",GameFightSpectatePlayerRequestAction);
      
      public static const HouseGuildShare:DofusApiAction = new DofusApiAction("HouseGuildShareAction",HouseGuildShareAction);
      
      public static const HouseGuildRightsView:DofusApiAction = new DofusApiAction("HouseGuildRightsViewAction",HouseGuildRightsViewAction);
      
      public static const HouseGuildRightsChange:DofusApiAction = new DofusApiAction("HouseGuildRightsChangeAction",HouseGuildRightsChangeAction);
      
      public static const HouseBuy:DofusApiAction = new DofusApiAction("HouseBuyAction",HouseBuyAction);
      
      public static const LeaveDialog:DofusApiAction = new DofusApiAction("LeaveDialogAction",LeaveDialogAction);
      
      public static const HouseSell:DofusApiAction = new DofusApiAction("HouseSellAction",HouseSellAction);
      
      public static const HouseSellFromInside:DofusApiAction = new DofusApiAction("HouseSellFromInsideAction",HouseSellFromInsideAction);
      
      public static const HouseKick:DofusApiAction = new DofusApiAction("HouseKickAction",HouseKickAction);
      
      public static const LockableChangeCode:DofusApiAction = new DofusApiAction("LockableChangeCodeAction",LockableChangeCodeAction);
      
      public static const LockableUseCode:DofusApiAction = new DofusApiAction("LockableUseCodeAction",LockableUseCodeAction);
      
      public static const HouseLockFromInside:DofusApiAction = new DofusApiAction("HouseLockFromInsideAction",HouseLockFromInsideAction);
      
      public static const GameRolePlayFreeSoulRequest:DofusApiAction = new DofusApiAction("GameRolePlayFreeSoulRequestAction",GameRolePlayFreeSoulRequestAction);
      
      public static const QuestInfosRequest:DofusApiAction = new DofusApiAction("QuestInfosRequestAction",QuestInfosRequestAction);
      
      public static const WatchQuestInfosRequest:DofusApiAction = new DofusApiAction("WatchQuestInfosRequestAction",WatchQuestInfosRequestAction);
      
      public static const QuestListRequest:DofusApiAction = new DofusApiAction("QuestListRequestAction",QuestListRequestAction);
      
      public static const QuestStartRequest:DofusApiAction = new DofusApiAction("QuestStartRequestAction",QuestStartRequestAction);
      
      public static const AchievementDetailedListRequest:DofusApiAction = new DofusApiAction("AchievementDetailedListRequestAction",AchievementDetailedListRequestAction);
      
      public static const AchievementAlmostFinishedDetailedListRequest:DofusApiAction = new DofusApiAction("AchievementAlmostFinishedDetailedListRequestAction",AchievementAlmostFinishedDetailedListRequestAction);
      
      public static const AchievementDetailsRequest:DofusApiAction = new DofusApiAction("AchievementDetailsRequestAction",AchievementDetailsRequestAction);
      
      public static const AchievementRewardRequest:DofusApiAction = new DofusApiAction("AchievementRewardRequestAction",AchievementRewardRequestAction);
      
      public static const AchievementsPioneerRanksRequest:DofusApiAction = new DofusApiAction("AchievementsPioneerRanksRequestAction",AchievementsPioneerRanksRequestAction);
      
      public static const QuestObjectiveValidation:DofusApiAction = new DofusApiAction("QuestObjectiveValidationAction",QuestObjectiveValidationAction);
      
      public static const TreasureHuntLegendaryRequest:DofusApiAction = new DofusApiAction("TreasureHuntLegendaryRequestAction",TreasureHuntLegendaryRequestAction);
      
      public static const TreasureHuntDigRequest:DofusApiAction = new DofusApiAction("TreasureHuntDigRequestAction",TreasureHuntDigRequestAction);
      
      public static const PortalUseRequest:DofusApiAction = new DofusApiAction("PortalUseRequestAction",PortalUseRequestAction);
      
      public static const TreasureHuntGiveUpRequest:DofusApiAction = new DofusApiAction("TreasureHuntGiveUpRequestAction",TreasureHuntGiveUpRequestAction);
      
      public static const TreasureHuntFlagRequest:DofusApiAction = new DofusApiAction("TreasureHuntFlagRequestAction",TreasureHuntFlagRequestAction);
      
      public static const TreasureHuntFlagRemoveRequest:DofusApiAction = new DofusApiAction("TreasureHuntFlagRemoveRequestAction",TreasureHuntFlagRemoveRequestAction);
      
      public static const GuidedModeReturnRequest:DofusApiAction = new DofusApiAction("GuidedModeReturnRequestAction",GuidedModeReturnRequestAction);
      
      public static const GuidedModeQuitRequest:DofusApiAction = new DofusApiAction("GuidedModeQuitRequestAction",GuidedModeQuitRequestAction);
      
      public static const SetEnablePVPRequest:DofusApiAction = new DofusApiAction("SetEnablePVPRequestAction",SetEnablePVPRequestAction);
      
      public static const SetEnableAVARequest:DofusApiAction = new DofusApiAction("SetEnableAVARequestAction",SetEnableAVARequestAction);
      
      public static const KohOver:DofusApiAction = new DofusApiAction("KohOverAction",KohOverAction);
      
      public static const PrismInfoJoinLeaveRequest:DofusApiAction = new DofusApiAction("PrismInfoJoinLeaveRequestAction",PrismInfoJoinLeaveRequestAction);
      
      public static const AnomalySubareaInformationRequest:DofusApiAction = new DofusApiAction("AnomalySubareaInformationRequestAction",AnomalySubareaInformationRequestAction);
      
      public static const PrismAttackRequest:DofusApiAction = new DofusApiAction("PrismAttackRequestAction",PrismAttackRequestAction);
      
      public static const PrismTeleportRequest:DofusApiAction = new DofusApiAction("PrismTeleportRequestAction",PrismTeleportRequestAction);
      
      public static const PrismRecycleTradeRequest:DofusApiAction = new DofusApiAction("PrismRecycleTradeRequestAction",PrismRecycleTradeRequestAction);
      
      public static const PrismExchangeRequest:DofusApiAction = new DofusApiAction("PrismExchangeRequestAction",PrismExchangeRequestAction);
      
      public static const ObjectUseOnCell:DofusApiAction = new DofusApiAction("ObjectUseOnCellAction",ObjectUseOnCellAction);
      
      public static const GiftAssignRequest:DofusApiAction = new DofusApiAction("GiftAssignRequestAction",GiftAssignRequestAction);
      
      public static const GiftAssignAllRequest:DofusApiAction = new DofusApiAction("GiftAssignAllRequestAction",GiftAssignAllRequestAction);
      
      public static const GiftAssignCancel:DofusApiAction = new DofusApiAction("GiftAssignCancelAction",GiftAssignCancelAction);
      
      public static const NotificationUpdateFlag:DofusApiAction = new DofusApiAction("NotificationUpdateFlagAction",NotificationUpdateFlagAction);
      
      public static const NotificationReset:DofusApiAction = new DofusApiAction("NotificationResetAction",NotificationResetAction);
      
      public static const SurveyNotificationAnswer:DofusApiAction = new DofusApiAction("SurveyNotificationAnswerAction",SurveyNotificationAnswerAction);
      
      public static const StartZoom:DofusApiAction = new DofusApiAction("StartZoomAction",StartZoomAction);
      
      public static const PlaySound:DofusApiAction = new DofusApiAction("PlaySoundAction",PlaySoundAction);
      
      public static const ShortcutBarAddRequest:DofusApiAction = new DofusApiAction("ShortcutBarAddRequestAction",ShortcutBarAddRequestAction);
      
      public static const ShortcutBarRemoveRequest:DofusApiAction = new DofusApiAction("ShortcutBarRemoveRequestAction",ShortcutBarRemoveRequestAction);
      
      public static const ShortcutBarSwapRequest:DofusApiAction = new DofusApiAction("ShortcutBarSwapRequestAction",ShortcutBarSwapRequestAction);
      
      public static const SpellVariantActivationRequest:DofusApiAction = new DofusApiAction("SpellVariantActivationRequestAction",SpellVariantActivationRequestAction);
      
      public static const FinishMoveListRequest:DofusApiAction = new DofusApiAction("FinishMoveListRequestAction",FinishMoveListRequestAction);
      
      public static const FinishMoveSetRequest:DofusApiAction = new DofusApiAction("FinishMoveSetRequestAction",FinishMoveSetRequestAction);
      
      public static const ShopAuthentificationRequest:DofusApiAction = new DofusApiAction("ShopAuthentificationRequestAction",ShopAuthentificationRequestAction);
      
      public static const ShopArticlesListRequest:DofusApiAction = new DofusApiAction("ShopArticlesListRequestAction",ShopArticlesListRequestAction);
      
      public static const ShopSearchRequest:DofusApiAction = new DofusApiAction("ShopSearchRequestAction",ShopSearchRequestAction);
      
      public static const ShopBuyRequest:DofusApiAction = new DofusApiAction("ShopBuyRequestAction",ShopBuyRequestAction);
      
      public static const ShopOverlayBuyRequest:DofusApiAction = new DofusApiAction("ShopOverlayBuyRequestAction",ShopOverlayBuyRequestAction);
      
      public static const OpenWebService:DofusApiAction = new DofusApiAction("OpenWebServiceAction",OpenWebServiceAction);
      
      public static const TitlesAndOrnamentsListRequest:DofusApiAction = new DofusApiAction("TitlesAndOrnamentsListRequestAction",TitlesAndOrnamentsListRequestAction);
      
      public static const TitleSelectRequest:DofusApiAction = new DofusApiAction("TitleSelectRequestAction",TitleSelectRequestAction);
      
      public static const OrnamentSelectRequest:DofusApiAction = new DofusApiAction("OrnamentSelectRequestAction",OrnamentSelectRequestAction);
      
      public static const ShowEntitiesTooltips:DofusApiAction = new DofusApiAction("ShowEntitiesTooltipsAction",ShowEntitiesTooltipsAction);
      
      public static const ContactLookRequestById:DofusApiAction = new DofusApiAction("ContactLookRequestByIdAction",ContactLookRequestByIdAction);
      
      public static const ShowMountsInFight:DofusApiAction = new DofusApiAction("ShowMountsInFightAction",ShowMountsInFightAction);
      
      public static const CaptureScreen:DofusApiAction = new DofusApiAction("CaptureScreenAction",CaptureScreenAction);
      
      public static const CaptureScreenWithoutUI:DofusApiAction = new DofusApiAction("CaptureScreenWithoutUIAction",CaptureScreenWithoutUIAction);
      
      public static const ChangeScreenshotsDirectory:DofusApiAction = new DofusApiAction("ChangeScreenshotsDirectoryAction",ChangeScreenshotsDirectoryAction);
      
      public static const HighlightInteractiveElements:DofusApiAction = new DofusApiAction("HighlightInteractiveElementsAction",HighlightInteractiveElementsAction);
      
      public static const ThemeListRequest:DofusApiAction = new DofusApiAction("ThemeListRequestAction",ThemeListRequestAction);
      
      public static const ThemeInstallRequest:DofusApiAction = new DofusApiAction("ThemeInstallRequestAction",ThemeInstallRequestAction);
      
      public static const ThemeDeleteRequest:DofusApiAction = new DofusApiAction("ThemeDeleteRequestAction",ThemeDeleteRequestAction);
      
      public static const HavenbagEnter:DofusApiAction = new DofusApiAction("HavenbagEnterAction",HavenbagEnterAction);
      
      public static const HavenbagExit:DofusApiAction = new DofusApiAction("HavenbagExitAction",HavenbagExitAction);
      
      public static const HavenbagEditMode:DofusApiAction = new DofusApiAction("HavenbagEditModeAction",HavenbagEditModeAction);
      
      public static const HavenbagFurnitureSelected:DofusApiAction = new DofusApiAction("HavenbagFurnitureSelectedAction",HavenbagFurnitureSelectedAction);
      
      public static const HavenbagClear:DofusApiAction = new DofusApiAction("HavenbagClearAction",HavenbagClearAction);
      
      public static const HavenbagReset:DofusApiAction = new DofusApiAction("HavenbagResetAction",HavenbagResetAction);
      
      public static const HavenbagSave:DofusApiAction = new DofusApiAction("HavenbagSaveAction",HavenbagSaveAction);
      
      public static const HavenbagRoomSelected:DofusApiAction = new DofusApiAction("HavenbagRoomSelectedAction",HavenbagRoomSelectedAction);
      
      public static const HavenbagThemeSelected:DofusApiAction = new DofusApiAction("HavenbagThemeSelectedAction",HavenbagThemeSelectedAction);
      
      public static const HavenbagInvitePlayer:DofusApiAction = new DofusApiAction("HavenbagInvitePlayerAction",HavenbagInvitePlayerAction);
      
      public static const HavenbagInvitePlayerAnswer:DofusApiAction = new DofusApiAction("HavenbagInvitePlayerAnswerAction",HavenbagInvitePlayerAnswerAction);
      
      public static const HavenbagPermissionsUpdateRequest:DofusApiAction = new DofusApiAction("HavenbagPermissionsUpdateRequestAction",HavenbagPermissionsUpdateRequestAction);
      
      public static const FollowQuest:DofusApiAction = new DofusApiAction("FollowQuestAction",FollowQuestAction);
      
      public static const ShowFightPositions:DofusApiAction = new DofusApiAction("ShowFightPositionsAction",ShowFightPositionsAction);
      
      public static const ToggleShowUI:DofusApiAction = new DofusApiAction("ToggleShowUIAction",ToggleShowUIAction);
      
      public static const RefreshFollowedQuestsOrder:DofusApiAction = new DofusApiAction("RefreshFollowedQuestsOrderAction",RefreshFollowedQuestsOrderAction);
      
      public static const GoToUrl:DofusApiAction = new DofusApiAction("GoToUrlAction",GoToUrlAction);
      
      public static const OpenCodesAndGiftRequest:DofusApiAction = new DofusApiAction("OpenCodesAndGiftRequestAction",OpenCodesAndGiftRequestAction);
      
      public static const ConsumeCode:DofusApiAction = new DofusApiAction("ConsumeCodeAction",ConsumeCodeAction);
      
      public static const UpdateGiftListRequest:DofusApiAction = new DofusApiAction("UpdateGiftListRequestAction",UpdateGiftListRequestAction);
      
      public static const ConsumeSimpleKard:DofusApiAction = new DofusApiAction("ConsumeSimpleKardAction",ConsumeSimpleKardAction);
      
      public static const ConsumeMultipleKard:DofusApiAction = new DofusApiAction("ConsumeMultipleKardAction",ConsumeMultipleKardAction);
      
      public static const AlignmentWarEffortProgressionRequest:DofusApiAction = new DofusApiAction("AlignmentWarEffortProgressionRequestAction",AlignmentWarEffortProgressionRequestAction);
      
      public static const CharacterAlignmentWarEffortProgressionRequest:DofusApiAction = new DofusApiAction("CharacterAlignmentWarEffortProgressionRequestAction",CharacterAlignmentWarEffortProgressionRequestAction);
      
      public static const AlignmentWarEffortDonate:DofusApiAction = new DofusApiAction("AlignmentWarEffortDonateAction",AlignmentWarEffortDonateAction);
      
      public static const ToggleEntityIcons:DofusApiAction = new DofusApiAction("ToggleEntityIconsAction",ToggleEntityIconsAction);
      
      public static const OpenBakRequest:DofusApiAction = new DofusApiAction("OpenBakRequestAction",OpenBakRequestAction);
      
      public static const RefreshBakOffers:DofusApiAction = new DofusApiAction("RefreshBakOffersAction",RefreshBakOffersAction);
      
      public static const HaapiValidationRequest:DofusApiAction = new DofusApiAction("HaapiValidationRequestAction",HaapiValidationRequestAction);
      
      public static const HaapiConfirmationRequest:DofusApiAction = new DofusApiAction("HaapiConfirmationRequestAction",HaapiConfirmationRequestAction);
      
      public static const HaapiConsumeBufferKamasRequest:DofusApiAction = new DofusApiAction("HaapiConsumeBufferKamasRequestAction",HaapiConsumeBufferKamasRequestAction);
      
      public static const HaapiCancelBidRequest:DofusApiAction = new DofusApiAction("HaapiCancelBidRequestAction",HaapiCancelBidRequestAction);
      
      public static const HaapiBufferKamasListRequest:DofusApiAction = new DofusApiAction("HaapiBufferKamasListRequestAction",HaapiBufferKamasListRequestAction);
      
      public static const OpenForgettableSpellsUi:DofusApiAction = new DofusApiAction("OpenForgettableSpellsUiAction",OpenForgettableSpellsUiAction);
      
      public static const ForgettableSpellClient:DofusApiAction = new DofusApiAction("ForgettableSpellClientAction",ForgettableSpellClientAction);
      
      public static const OpenGuideBook:DofusApiAction = new DofusApiAction("OpenGuideBookAction",OpenGuideBookAction);
      
      public static const OpenGuildPrezAndRecruit:DofusApiAction = new DofusApiAction("OpenGuildPrezAndRecruitAction",OpenGuildPrezAndRecruitAction);
      
      public static const OpenAlliancePrezAndRecruit:DofusApiAction = new DofusApiAction("OpenAlliancePrezAndRecruitAction",OpenAlliancePrezAndRecruitAction);
      
      public static const ActivitySuggestionsRequest:DofusApiAction = new DofusApiAction("ActivitySuggestionsRequestAction",ActivitySuggestionsRequestAction);
      
      public static const ActivityLockRequest:DofusApiAction = new DofusApiAction("ActivityLockRequestAction",ActivityLockRequestAction);
      
      public static const ActivityHideRequest:DofusApiAction = new DofusApiAction("ActivityHideRequestAction",ActivityHideRequestAction);
      
      public static const TeleportPlayerOfferReply:DofusApiAction = new DofusApiAction("TeleportPlayerOfferReplyAction",TeleportPlayerOfferReplyAction);
      
      public static const GuildChangeChestTabRequest:DofusApiAction = new DofusApiAction("GuildSelectChestTabRequestAction",GuildSelectChestTabRequestAction);
      
      public static const UpdateGuildChestTabStorage:DofusApiAction = new DofusApiAction("GuildUpdateChestTabRequestAction",GuildUpdateChestTabRequestAction);
      
      public static const StartGuildChestContribution:DofusApiAction = new DofusApiAction("StartGuildChestContributionAction",StartGuildChestContributionAction);
      
      public static const StopGuildChestContribution:DofusApiAction = new DofusApiAction("StopGuildChestContributionAction",StopGuildChestContributionAction);
      
      public static const GuildGetChestTabContributionsRequest:DofusApiAction = new DofusApiAction("GuildGetChestTabContributionsRequestAction",GuildGetChestTabContributionsRequestAction);
      
      public static const OpenAlterationUi:DofusApiAction = new DofusApiAction("OpenAlterationUiAction",OpenAlterationUiAction);
      
      public static const UpdateAlterationFavoriteFlag:DofusApiAction = new DofusApiAction("UpdateAlterationFavoriteFlagAction",UpdateAlterationFavoriteFlagAction);
      
      public static const GroupTeleportPlayerOfferReply:DofusApiAction = new DofusApiAction("GroupTeleportPlayerOfferReplyAction",GroupTeleportPlayerOfferReplyAction);
      
      public static const ChallengeModSelect:DofusApiAction = new DofusApiAction("ChallengeModSelectAction",ChallengeModSelectAction);
      
      public static const ChallengeBonusSelect:DofusApiAction = new DofusApiAction("ChallengeBonusSelectAction",ChallengeBonusSelectAction);
      
      public static const ChallengeSelection:DofusApiAction = new DofusApiAction("ChallengeSelectionAction",ChallengeSelectionAction);
      
      public static const ChallengeReady:DofusApiAction = new DofusApiAction("ChallengeReadyAction",ChallengeReadyAction);
      
      public static const ChallengeValidate:DofusApiAction = new DofusApiAction("ChallengeValidateAction",ChallengeValidateAction);
      
      public static const ChallengeTargetsRequest:DofusApiAction = new DofusApiAction("ChallengeTargetsRequestAction",ChallengeTargetsRequestAction);
      
      public static const ReportPlayer:DofusApiAction = new DofusApiAction("ReportPlayerAction",ReportPlayerAction);
       
      
      public function ApiActionList()
      {
         super();
      }
   }
}

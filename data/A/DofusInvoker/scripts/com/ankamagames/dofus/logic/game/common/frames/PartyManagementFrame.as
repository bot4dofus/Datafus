package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.externalnotification.ExternalNotificationManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.arena.ArenaRankInfosWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkMapPosition;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowPlayerMenuManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.game.common.actions.GroupTeleportPlayerOfferReplyAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaFightAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaUnregisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaXpSwitchModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderAvailableDungeonsAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderListenAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderRegisterAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportBuddiesAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportToBuddyAnswerAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.messages.FightEndingMessage;
   import com.ankamagames.dofus.logic.game.common.types.PartyFightInformationsData;
   import com.ankamagames.dofus.logic.game.roleplay.frames.NpcDialogFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.types.Fight;
   import com.ankamagames.dofus.logic.game.roleplay.types.FightTeam;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.network.enums.PartyJoinErrorEnum;
   import com.ankamagames.dofus.network.enums.PartyNameErrorEnum;
   import com.ankamagames.dofus.network.enums.PartyTypeEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaStepEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatorJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.MapComplementaryInformationsBreachMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting.BreachInvitationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting.BreachInvitationCloseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting.BreachInvitationOfferMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.GameRolePlayRemoveChallengeMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.ArenaFightAnswerAcknowledgementMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaFightAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaFightPropositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaFighterStatusMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaLeagueRewardsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaPlayerBehavioursMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaRegisterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaRegistrationStatusMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaRegistrationWarningMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaUnregisterMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.GameRolePlayArenaUpdatePlayerInfosMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena.SwitchArenaXpRewardsModeMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderAvailableDungeonsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderAvailableDungeonsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderListenErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderListenRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderRegisterErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderRegisterRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderRegisterSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderRoomContentMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.DungeonPartyFinderRoomContentUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyAbdicateThroneMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyAcceptInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyCancelInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyCancelInvitationNotificationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyCannotJoinErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyFollowMemberRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyFollowStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyFollowThisMemberRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationArenaRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationCancelledForGuestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationDetailsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationDetailsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationDungeonDetailsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationDungeonMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationDungeonRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyInvitationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyJoinMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyKickRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyKickedByMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyLeaderUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyLeaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyLocateMembersMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyLoyaltyStatusMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyMemberInStandardFightMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyMemberRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyNameSetErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyNameSetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyNameUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyNewGuestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyNewMemberMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyPledgeLoyaltyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyRefuseInvitationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyRefuseInvitationNotificationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyRestrictedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyStopFollowRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyUpdateLightMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.breach.PartyMemberInBreachFightMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.entity.PartyEntityUpdateLightMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.GroupTeleportPlayerAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.GroupTeleportPlayerCloseMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.GroupTeleportPlayerOfferMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportBuddiesMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportBuddiesRequestedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportToBuddyAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportToBuddyCloseMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.meeting.TeleportToBuddyOfferMessage;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.dofus.network.types.game.character.alignment.ActorAlignmentInformations;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.fight.arena.ArenaRankInfos;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberArenaInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityBaseInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.entity.PartyEntityMemberInformation;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class PartyManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PartyManagementFrame));
      
      private static const GROUP_TELEPORT_PLAYER_OFFER_POPUP_PREFIX:String = "GroupTeleportPlayerOfferPopup_";
      
      private static const DATASTORE_PARTY:DataStoreType = new DataStoreType("Dofus_Party",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
      
      private static const DATA_XP_ACTIVATED:String = "XpActivatedData";
       
      
      private var _playerNameInvited:String;
      
      private var _partyMembers:Vector.<PartyMemberWrapper>;
      
      private var _arenaPartyMembers:Vector.<PartyMemberWrapper>;
      
      private var _previewPartyMembers:Vector.<PartyMemberWrapper>;
      
      private var _arenaReadyPartyMemberIds:Array;
      
      private var _arenaAlliesIds:Array;
      
      private var _timerRegen:BenchmarkTimer;
      
      private var _dicRegen:Dictionary;
      
      private var _dicRegenArena:Dictionary;
      
      private var _currentInvitations:Dictionary;
      
      private var _teleportBuddiesDialogFrame:TeleportBuddiesDialogFrame;
      
      private var _partyLoyalty:Boolean = false;
      
      private var _isArenaRegistered:Boolean = false;
      
      private var _arenaCurrentStatus:int = 3;
      
      private var _playerShouldReceiveRewards:Boolean = false;
      
      private var _playerRewards:Object;
      
      private var _partyId:int = -1;
      
      private var _previewPartyId:int = -1;
      
      private var _arenaPartyId:int = -1;
      
      private var _arenaLeader:PartyMemberWrapper;
      
      private var _currentArenaType:uint;
      
      private var _arenaProposalNotifName:String;
      
      private var _arenaRanksInformation:Dictionary;
      
      private var _banEndDate:Number;
      
      private var _xpActivated:Boolean = true;
      
      private var _playerDungeons:Vector.<uint>;
      
      private var _playerSubscribedDungeons:Vector.<uint>;
      
      private var _dungeonFighters:Vector.<DungeonPartyFinderPlayer>;
      
      private var _lastFightType:int = -1;
      
      private var _wasSpectatorInLastFight:Boolean = false;
      
      public var allMemberFollowPlayerId:Number = 0;
      
      private var _partyFightsInformations:Dictionary;
      
      private var _partyFightNotification:Array;
      
      public function PartyManagementFrame()
      {
         this._partyMembers = new Vector.<PartyMemberWrapper>();
         this._arenaPartyMembers = new Vector.<PartyMemberWrapper>();
         this._previewPartyMembers = new Vector.<PartyMemberWrapper>();
         this._arenaReadyPartyMemberIds = [];
         this._arenaAlliesIds = [];
         this._arenaRanksInformation = new Dictionary();
         this._playerDungeons = new Vector.<uint>();
         this._playerSubscribedDungeons = new Vector.<uint>();
         this._dungeonFighters = new Vector.<DungeonPartyFinderPlayer>();
         super();
         this._dicRegen = new Dictionary();
         this._dicRegenArena = new Dictionary();
         this._currentInvitations = new Dictionary(true);
         this._partyFightsInformations = new Dictionary();
         this._partyFightNotification = new Array();
         this._timerRegen = new BenchmarkTimer(1000,0,"PartyManagementFrame._timerRegen");
         this._timerRegen.addEventListener(TimerEvent.TIMER,this.onTimerTick);
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get partyMembers() : Vector.<PartyMemberWrapper>
      {
         return this._partyMembers;
      }
      
      public function get arenaPartyMembers() : Vector.<PartyMemberWrapper>
      {
         return this._arenaPartyMembers;
      }
      
      public function get subscribedDungeons() : Vector.<uint>
      {
         return this._playerSubscribedDungeons;
      }
      
      public function get partyLoyalty() : Boolean
      {
         return this._partyLoyalty;
      }
      
      public function get isArenaRegistered() : Boolean
      {
         return this._isArenaRegistered;
      }
      
      public function get arenaCurrentStatus() : int
      {
         return this._arenaCurrentStatus;
      }
      
      public function get arenaLeader() : PartyMemberWrapper
      {
         return this._arenaLeader;
      }
      
      public function get arenaPartyId() : int
      {
         return this._arenaPartyId;
      }
      
      public function get partyId() : int
      {
         return this._partyId;
      }
      
      public function get arenaReadyPartyMemberIds() : Array
      {
         return this._arenaReadyPartyMemberIds;
      }
      
      public function get arenaAlliesIds() : Array
      {
         return this._arenaAlliesIds;
      }
      
      public function get banEndDate() : Number
      {
         return this._banEndDate;
      }
      
      public function get arenaRankInfo() : Dictionary
      {
         return this._arenaRanksInformation;
      }
      
      public function get arenaRank1V1Infos() : ArenaRankInfosWrapper
      {
         return this._arenaRanksInformation[PvpArenaTypeEnum.ARENA_TYPE_1VS1];
      }
      
      public function get arenaRank2V2Infos() : ArenaRankInfosWrapper
      {
         return this._arenaRanksInformation[PvpArenaTypeEnum.ARENA_TYPE_2VS2];
      }
      
      public function get arenaRank3V3Infos() : ArenaRankInfosWrapper
      {
         return this._arenaRanksInformation[PvpArenaTypeEnum.ARENA_TYPE_3VS3];
      }
      
      public function get xpActivated() : Boolean
      {
         return this._xpActivated;
      }
      
      public function get playerShouldReceiveRewards() : Boolean
      {
         return this._playerShouldReceiveRewards;
      }
      
      public function get playerRewards() : Object
      {
         return this._playerRewards;
      }
      
      public function set playerShouldReceiveRewards(value:Boolean) : void
      {
         this._playerShouldReceiveRewards = value;
      }
      
      public function set playerRewards(value:Object) : void
      {
         this._playerRewards = value;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
      {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      public function set lastFightType(n:int) : void
      {
         this._lastFightType = n;
      }
      
      public function pushed() : Boolean
      {
         this._teleportBuddiesDialogFrame = new TeleportBuddiesDialogFrame();
         this._xpActivated = StoreDataManager.getInstance().getSetData(DATASTORE_PARTY,DATA_XP_ACTIVATED,true);
         this.sendArenaXpSwitchMessage();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var partyMemberWrapper:PartyMemberWrapper = null;
         var partyCompanionWrapper:PartyCompanionWrapper = null;
         var partyCompanionBaseInfo:PartyEntityBaseInformation = null;
         var partyCompanionMemberInfo:PartyEntityMemberInformation = null;
         var pia:PartyInvitationAction = null;
         var pidmsg:PartyInvitationDungeonMessage = null;
         var pidmsgNid:uint = 0;
         var pimsg:PartyInvitationMessage = null;
         var textInvitationKey:String = null;
         var extNotifType:int = 0;
         var pimsgNid:uint = 0;
         var pcjenmsg:PartyCannotJoinErrorMessage = null;
         var reasonText:String = null;
         var pngmsg:PartyNewGuestMessage = null;
         var hostName:String = null;
         var guestComp:PartyCompanionWrapper = null;
         var serverGuestComp:PartyEntityBaseInformation = null;
         var existingGuest:Boolean = false;
         var pidra:PartyInvitationDetailsRequestAction = null;
         var pidrmsg:PartyInvitationDetailsRequestMessage = null;
         var pidemsg:PartyInvitationDetailsMessage = null;
         var partyMembersD:Vector.<PartyMemberWrapper> = null;
         var partyGuestsD:Vector.<PartyMemberWrapper> = null;
         var memberInvitedD:PartyInvitationMemberInformations = null;
         var guestD:PartyGuestInformations = null;
         var paia:PartyAcceptInvitationAction = null;
         var paimsg:PartyAcceptInvitationMessage = null;
         var pumsg:PartyUpdateMessage = null;
         var newMember:PartyMemberWrapper = null;
         var memberComp:PartyCompanionWrapper = null;
         var existingMember:Boolean = false;
         var companionAddedOrRemoved:Boolean = false;
         var pjmsg:PartyJoinMessage = null;
         var memberJoin:PartyMemberInformations = null;
         var partyGuestInfo:PartyGuestInformations = null;
         var partyGuest:PartyMemberWrapper = null;
         var canBeHostMember2:PartyMemberWrapper = null;
         var arena:Boolean = false;
         var pria:PartyRefuseInvitationAction = null;
         var primsg:PartyRefuseInvitationMessage = null;
         var prinmsg:PartyRefuseInvitationNotificationMessage = null;
         var guestRefusingIndex:Number = NaN;
         var prinGuestName:String = null;
         var iMember:int = 0;
         var pdmsg:PartyDeletedMessage = null;
         var pcia:PartyCancelInvitationAction = null;
         var pcimsg:PartyCancelInvitationMessage = null;
         var pcinmsg:PartyCancelInvitationNotificationMessage = null;
         var guestRefusingIndex2:int = 0;
         var pcinGuestName:String = null;
         var pcinCancelerName:String = null;
         var iMember2:int = 0;
         var picfgmsg:PartyInvitationCancelledForGuestMessage = null;
         var prmsg:PartyRestrictedMessage = null;
         var pka:PartyKickRequestAction = null;
         var pkickrimsg:PartyKickRequestMessage = null;
         var pkbmsg:PartyKickedByMessage = null;
         var plmsg:PartyLeaveMessage = null;
         var pmrmsg:PartyMemberRemoveMessage = null;
         var memberToRemoveIndex:int = 0;
         var iMember3:int = 0;
         var plra:PartyLeaveRequestAction = null;
         var plrmsg:PartyLeaveRequestMessage = null;
         var plulmsg:PartyLeaderUpdateMessage = null;
         var partyMem:PartyMemberWrapper = null;
         var pculmsg:PartyEntityUpdateLightMessage = null;
         var partyMemb:PartyMemberWrapper = null;
         var pulmsg:PartyUpdateLightMessage = null;
         var partyMembUL:PartyMemberWrapper = null;
         var lptmanager:LifePointTickManager = null;
         var pata:PartyAbdicateThroneAction = null;
         var patmsg:PartyAbdicateThroneMessage = null;
         var pplra:PartyPledgeLoyaltyRequestAction = null;
         var pplrmsg:PartyPledgeLoyaltyRequestMessage = null;
         var plsmsg:PartyLoyaltyStatusMessage = null;
         var pfsumsg:PartyFollowStatusUpdateMessage = null;
         var followingPlayerId:Number = NaN;
         var pfma:PartyFollowMemberAction = null;
         var pfmrmsg:PartyFollowMemberRequestMessage = null;
         var psfma:PartyStopFollowingMemberAction = null;
         var psfrmsg:PartyStopFollowRequestMessage = null;
         var pafma:PartyAllFollowMemberAction = null;
         var pftmrmsg:PartyFollowThisMemberRequestMessage = null;
         var pasfma:PartyAllStopFollowingMemberAction = null;
         var pftmrmsg2:PartyFollowThisMemberRequestMessage = null;
         var psma:PartyShowMenuAction = null;
         var modContextMenu:Object = null;
         var menu:Object = null;
         var plmmsg:PartyLocateMembersMessage = null;
         var pnsra:PartyNameSetRequestAction = null;
         var pnsrmsg:PartyNameSetRequestMessage = null;
         var pnumsg:PartyNameUpdateMessage = null;
         var pnsemsg:PartyNameSetErrorMessage = null;
         var nameErrorText:String = null;
         var tbmsg:TeleportBuddiesMessage = null;
         var commonModTp:Object = null;
         var tbrmsg:TeleportBuddiesRequestedMessage = null;
         var tpHostName:String = null;
         var poorBuddiesNames:String = null;
         var dungeonPropName:String = null;
         var prinText:String = null;
         var ttbomsg:TeleportToBuddyOfferMessage = null;
         var buddyName:String = null;
         var dungeonName:String = null;
         var notifyUser:Boolean = false;
         var ttbomsgNid:uint = 0;
         var ttbcmsg:TeleportToBuddyCloseMessage = null;
         var ttbaa:TeleportToBuddyAnswerAction = null;
         var ttbamsg:TeleportToBuddyAnswerMessage = null;
         var dpfada:DungeonPartyFinderAvailableDungeonsAction = null;
         var dpfadrmsg:DungeonPartyFinderAvailableDungeonsRequestMessage = null;
         var dpfadmsg:DungeonPartyFinderAvailableDungeonsMessage = null;
         var dpfla:DungeonPartyFinderListenAction = null;
         var dpflrmsg:DungeonPartyFinderListenRequestMessage = null;
         var dpflemsg:DungeonPartyFinderListenErrorMessage = null;
         var dpfrcmsg:DungeonPartyFinderRoomContentMessage = null;
         var dpfrcumsg:DungeonPartyFinderRoomContentUpdateMessage = null;
         var tempDjFighters:Vector.<DungeonPartyFinderPlayer> = null;
         var dpfra:DungeonPartyFinderRegisterAction = null;
         var dungeons:Vector.<uint> = null;
         var dpfrrmsg:DungeonPartyFinderRegisterRequestMessage = null;
         var dpfrsmsg:DungeonPartyFinderRegisterSuccessMessage = null;
         var resultText:String = null;
         var dpfremsg:DungeonPartyFinderRegisterErrorMessage = null;
         var errortext:String = null;
         var ara:ArenaRegisterAction = null;
         var grparmsg:GameRolePlayArenaRegisterMessage = null;
         var aua:ArenaUnregisterAction = null;
         var grpaumsg:GameRolePlayArenaUnregisterMessage = null;
         var grparsmsg:GameRolePlayArenaRegistrationStatusMessage = null;
         var grpafpmsg:GameRolePlayArenaFightPropositionMessage = null;
         var arenaProposalNotifId:uint = 0;
         var afaa:ArenaFightAnswerAction = null;
         var grpafamsg:GameRolePlayArenaFightAnswerMessage = null;
         var grpafsmsg:GameRolePlayArenaFighterStatusMessage = null;
         var grpaupimsg:GameRolePlayArenaUpdatePlayerInfosMessage = null;
         var gfjmsg:GameFightJoinMessage = null;
         var femsg:FightEndingMessage = null;
         var grpalrmsg:GameRolePlayArenaLeagueRewardsMessage = null;
         var grpapbmsg:GameRolePlayArenaPlayerBehavioursMessage = null;
         var grparwmsg:GameRolePlayArenaRegistrationWarningMessage = null;
         var mcidm:MapComplementaryInformationsDataMessage = null;
         var mapId:* = undefined;
         var partyFight:PartyFightInformationsData = null;
         var mapFight:FightCommonInformations = null;
         var foundFight:Boolean = false;
         var fti:FightTeamInformations = null;
         var teamMember:FightTeamMemberInformations = null;
         var leaderId:Number = NaN;
         var grpcm:GameRolePlayRemoveChallengeMessage = null;
         var notificationId:String = null;
         var fightNotificationIndex:int = 0;
         var biom:BreachInvitationOfferMessage = null;
         var biomsgNid:uint = 0;
         var biaa:BreachInvitationAnswerAction = null;
         var biam:BreachInvitationAnswerMessage = null;
         var bicmsg:BreachInvitationCloseMessage = null;
         var gtpomsg:GroupTeleportPlayerOfferMessage = null;
         var notificationManager:NotificationManager = null;
         var notifId:uint = 0;
         var gtpcmsg:GroupTeleportPlayerCloseMessage = null;
         var replyMsg:GroupTeleportPlayerAnswerMessage = null;
         var gtporaction:GroupTeleportPlayerOfferReplyAction = null;
         var piarmsg:PartyInvitationArenaRequestMessage = null;
         var player_PIARMSG:PlayerSearchCharacterNameInformation = null;
         var pirmsg:PartyInvitationRequestMessage = null;
         var playerPIRMSG:PlayerSearchCharacterNameInformation = null;
         var pidgrmsg:PartyInvitationDungeonRequestMessage = null;
         var player_PIDGRMSG:PlayerSearchCharacterNameInformation = null;
         var serverMemberComp:PartyEntityMemberInformation = null;
         var prinText2:String = null;
         var pcinText:String = null;
         var picfgInviterName:String = null;
         var picfgText:String = null;
         var followingPlayerIndex:int = 0;
         var buddyPropMember:PartyMemberWrapper = null;
         var buddyMember:PartyMemberWrapper = null;
         var fighterDungeon:DungeonPartyFinderPlayer = null;
         var iFD:int = 0;
         var currentfighterDungeon:DungeonPartyFinderPlayer = null;
         var removedfighterId:Number = NaN;
         var addedfighterDungeon:DungeonPartyFinderPlayer = null;
         var dungeonId:uint = 0;
         var paramDonjons:String = null;
         var djId:int = 0;
         var allyId:Number = NaN;
         var rankInfo:ArenaRankInfos = null;
         var commonMod:Object = null;
         var pmibfm:PartyMemberInBreachFightMessage = null;
         var breachFightCause:String = null;
         var breachFightId:int = 0;
         var breachMemberName:String = null;
         var breachFightMapId:String = null;
         var breachFightInformation:PartyFightInformationsData = null;
         var breachChannel:uint = 0;
         var breachTimestamp:Number = NaN;
         var breachParams:Array = null;
         var breachPartyFightMsg:String = null;
         var breachFrame:BreachFrame = null;
         var breachFightTeamLeaderId:Number = NaN;
         var breachEntitiesFrame:RoleplayEntitiesFrame = null;
         var breachFight:Fight = null;
         var breachTeam:FightTeam = null;
         var breachFightTeamMember:FightTeamMemberInformations = null;
         var breachFoundLeader:Boolean = false;
         var pemifmmsg:PartyMemberInStandardFightMessage = null;
         var fightCause:String = null;
         var notifName:String = null;
         var fightId:int = 0;
         var memberName:String = null;
         var fightMapId:Number = NaN;
         var fightInformation:PartyFightInformationsData = null;
         var channel:uint = 0;
         var timestamp:Number = NaN;
         var params:Array = null;
         var partyFightMsg:String = null;
         var fightTeamLeaderId:Number = NaN;
         var entitiesFrame:RoleplayEntitiesFrame = null;
         var fight:Fight = null;
         var notifKey:String = null;
         var team:FightTeam = null;
         var fightTeamMember:FightTeamMemberInformations = null;
         var foundLeader:Boolean = false;
         var fightTeams:Vector.<FightTeamInformations> = null;
         switch(true)
         {
            case msg is PartyInvitationAction:
               pia = msg as PartyInvitationAction;
               this._playerNameInvited = pia.name;
               if(pia.inArena)
               {
                  piarmsg = new PartyInvitationArenaRequestMessage();
                  player_PIARMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(pia.name);
                  piarmsg.initPartyInvitationArenaRequestMessage(player_PIARMSG);
                  ConnectionsHandler.getConnection().send(piarmsg);
               }
               else if(pia.dungeon == 0)
               {
                  pirmsg = new PartyInvitationRequestMessage();
                  playerPIRMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(pia.name);
                  pirmsg.initPartyInvitationRequestMessage(playerPIRMSG);
                  ConnectionsHandler.getConnection().send(pirmsg);
               }
               else
               {
                  pidgrmsg = new PartyInvitationDungeonRequestMessage();
                  player_PIDGRMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(pia.name);
                  pidgrmsg.initPartyInvitationDungeonRequestMessage(player_PIDGRMSG,pia.dungeon);
                  ConnectionsHandler.getConnection().send(pidgrmsg);
               }
               return true;
            case msg is PartyInvitationDungeonMessage:
               pidmsg = msg as PartyInvitationDungeonMessage;
               this._currentInvitations[pidmsg.partyId] = {"fromName":pidmsg.fromName};
               pidmsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText("ui.party.playerInvitationToDungeon",[pidmsg.fromName,Dungeon.getDungeonById(pidmsg.dungeonId).name]),NotificationTypeEnum.INVITATION,"partyInvit_" + pidmsg.partyId);
               NotificationManager.getInstance().addButtonToNotification(pidmsgNid,I18n.getUiText("ui.common.details"),"PartyInvitationDetailsRequestAction",[pidmsg.partyId],false,130);
               NotificationManager.getInstance().addButtonToNotification(pidmsgNid,I18n.getUiText("ui.common.accept"),"PartyAcceptInvitationAction",[pidmsg.partyId],true,130);
               NotificationManager.getInstance().addCallbackToNotification(pidmsgNid,"PartyRefuseInvitationAction",[pidmsg.partyId]);
               NotificationManager.getInstance().sendNotification(pidmsgNid);
               return true;
            case msg is PartyInvitationMessage:
               pimsg = msg as PartyInvitationMessage;
               this._currentInvitations[pimsg.partyId] = {"fromName":pimsg.fromName};
               if(pimsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA)
               {
                  textInvitationKey = "ui.party.playerInvitationArena";
                  extNotifType = ExternalNotificationTypeEnum.KOLO_INVITATION;
               }
               else if(pimsg.partyType == PartyTypeEnum.PARTY_TYPE_CLASSICAL)
               {
                  textInvitationKey = "ui.party.playerInvitation";
                  extNotifType = ExternalNotificationTypeEnum.GROUP_INVITATION;
               }
               if(extNotifType > 0 && ExternalNotificationManager.getInstance().canAddExternalNotification(extNotifType))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,extNotifType,[pimsg.fromName]);
               }
               pimsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText(textInvitationKey,["{player," + pimsg.fromName + "," + pimsg.fromId + "::" + pimsg.fromName + "}"]),NotificationTypeEnum.INVITATION,"partyInvit_" + pimsg.partyId);
               NotificationManager.getInstance().addButtonToNotification(pimsgNid,I18n.getUiText("ui.common.details"),"PartyInvitationDetailsRequestAction",[pimsg.partyId]);
               NotificationManager.getInstance().addButtonToNotification(pimsgNid,I18n.getUiText("ui.common.accept"),"PartyAcceptInvitationAction",[pimsg.partyId],true);
               NotificationManager.getInstance().addCallbackToNotification(pimsgNid,"PartyRefuseInvitationAction",[pimsg.partyId]);
               NotificationManager.getInstance().sendNotification(pimsgNid);
               return true;
            case msg is PartyCannotJoinErrorMessage:
               pcjenmsg = msg as PartyCannotJoinErrorMessage;
               reasonText = "";
               switch(pcjenmsg.reason)
               {
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PARTY_FULL:
                     reasonText = I18n.getUiText("ui.party.partyFull");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PARTY_NOT_FOUND:
                     reasonText = I18n.getUiText("ui.party.cantFindParty");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_BUSY:
                     reasonText = I18n.getUiText("ui.party.cantInvitPlayerBusy");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_NOT_FOUND:
                     reasonText = I18n.getUiText("ui.common.playerNotFound",[this._playerNameInvited]);
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNMET_CRITERION:
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_LOYAL:
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_TOO_SOLLICITED:
                     reasonText = I18n.getUiText("ui.party.playerTooSollicited");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNMODIFIABLE:
                     reasonText = I18n.getUiText("ui.party.partyUnmodifiable");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_PLAYER_ALREADY_INVITED:
                     reasonText = I18n.getUiText("ui.party.playerAlreayBeingInvited");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_NOT_ENOUGH_ROOM:
                     reasonText = I18n.getUiText("ui.party.notEnoughRoom");
                     break;
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_COMPOSITION_CHANGED:
                  case PartyJoinErrorEnum.PARTY_JOIN_ERROR_UNKNOWN:
                  default:
                     reasonText = I18n.getUiText("ui.party.cantInvit");
               }
               if(reasonText != "")
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyCannotJoinError,reasonText);
               }
               return true;
            case msg is PartyNewGuestMessage:
               pngmsg = msg as PartyNewGuestMessage;
               if(pngmsg.partyId == this._arenaPartyId)
               {
                  for each(partyMemberWrapper in this._arenaPartyMembers)
                  {
                     if(partyMemberWrapper.id == pngmsg.guest.hostId)
                     {
                        hostName = partyMemberWrapper.name;
                     }
                  }
               }
               else if(pngmsg.partyId == this._partyId)
               {
                  for each(partyMemberWrapper in this._partyMembers)
                  {
                     if(partyMemberWrapper.id == pngmsg.guest.hostId)
                     {
                        hostName = partyMemberWrapper.name;
                     }
                  }
               }
               else if(pngmsg.partyId == this._previewPartyId)
               {
                  for each(partyMemberWrapper in this._previewPartyMembers)
                  {
                     if(partyMemberWrapper.id == pngmsg.guest.hostId)
                     {
                        hostName = partyMemberWrapper.name;
                     }
                  }
               }
               existingGuest = false;
               if(pngmsg.partyId == this._partyId)
               {
                  for each(partyMemberWrapper in this._partyMembers)
                  {
                     if(partyMemberWrapper.id == pngmsg.guest.guestId)
                     {
                        partyMemberWrapper.name = pngmsg.guest.name;
                        partyMemberWrapper.isMember = false;
                        partyMemberWrapper.level = 0;
                        partyMemberWrapper.status = pngmsg.guest.status.statusId;
                        partyMemberWrapper.breedId = pngmsg.guest.breed;
                        partyMemberWrapper.entityLook = pngmsg.guest.guestLook;
                        partyMemberWrapper.lifePoints = 0;
                        partyMemberWrapper.maxLifePoints = 0;
                        partyMemberWrapper.maxInitiative = 0;
                        partyMemberWrapper.rank = 0;
                        partyMemberWrapper.alignmentSide = 0;
                        partyMemberWrapper.regenRate = 0;
                        partyMemberWrapper.worldX = 0;
                        partyMemberWrapper.worldY = 0;
                        partyMemberWrapper.mapId = 0;
                        partyMemberWrapper.subAreaId = 0;
                        partyMemberWrapper.hostId = pngmsg.guest.hostId;
                        partyMemberWrapper.hostName = hostName;
                        if(pngmsg.guest.entities.length > 0)
                        {
                           for each(serverGuestComp in pngmsg.guest.entities)
                           {
                              if(partyMemberWrapper.companions[serverGuestComp.indexId])
                              {
                                 guestComp = partyMemberWrapper.companions[serverGuestComp.indexId];
                                 guestComp.companionGenericId = serverGuestComp.entityModelId;
                                 guestComp.isMember = false;
                                 guestComp.level = 0;
                                 guestComp.entityLook = serverGuestComp.entityLook;
                                 guestComp.lifePoints = 0;
                                 guestComp.maxLifePoints = 0;
                                 guestComp.maxInitiative = 0;
                                 guestComp.prospecting = 0;
                                 guestComp.regenRate = 0;
                                 guestComp.index = serverGuestComp.indexId;
                              }
                              else
                              {
                                 guestComp = new PartyCompanionWrapper(pngmsg.guest.guestId,pngmsg.guest.name,serverGuestComp.entityModelId,false,0,serverGuestComp.entityLook,0,0,0,0,0);
                                 guestComp.index = serverGuestComp.indexId;
                                 partyMemberWrapper.companions[serverGuestComp.indexId] = guestComp;
                              }
                           }
                        }
                        else if(partyMemberWrapper.companions.length > 0)
                        {
                           partyMemberWrapper.companions = new Array();
                        }
                        existingGuest = true;
                     }
                  }
               }
               if(!existingGuest)
               {
                  partyMemberWrapper = new PartyMemberWrapper(pngmsg.guest.guestId,pngmsg.guest.name,pngmsg.guest.status.statusId,false,false,0,pngmsg.guest.guestLook);
                  partyMemberWrapper.breedId = pngmsg.guest.breed;
                  partyMemberWrapper.hostId = pngmsg.guest.hostId;
                  partyMemberWrapper.hostName = hostName;
                  if(pngmsg.guest.entities.length > 0)
                  {
                     partyMemberWrapper.companions = new Array();
                     for each(serverGuestComp in pngmsg.guest.entities)
                     {
                        guestComp = new PartyCompanionWrapper(pngmsg.guest.guestId,pngmsg.guest.name,serverGuestComp.entityModelId,false,0,serverGuestComp.entityLook);
                        guestComp.index = serverGuestComp.indexId;
                        partyMemberWrapper.companions[serverGuestComp.indexId] = guestComp;
                     }
                  }
                  if(pngmsg.partyId == this._arenaPartyId)
                  {
                     partyMemberWrapper.isInArenaParty = true;
                     this._arenaPartyMembers.push(partyMemberWrapper);
                  }
                  else if(pngmsg.partyId == this._partyId)
                  {
                     this._partyMembers.push(partyMemberWrapper);
                  }
                  else if(pngmsg.partyId == this._previewPartyId)
                  {
                     this._previewPartyMembers.push(partyMemberWrapper);
                  }
               }
               if(pngmsg.partyId == this._previewPartyId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdateDetails,pngmsg.partyId,partyMemberWrapper,false);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate,pngmsg.partyId,partyMemberWrapper.id,true);
               }
               return true;
            case msg is PartyInvitationDetailsRequestAction:
               pidra = msg as PartyInvitationDetailsRequestAction;
               pidrmsg = new PartyInvitationDetailsRequestMessage();
               pidrmsg.initPartyInvitationDetailsRequestMessage(pidra.partyId);
               ConnectionsHandler.getConnection().send(pidrmsg);
               NotificationManager.getInstance().hideNotification("partyInvit_" + pidra.partyId);
               return true;
            case msg is PartyInvitationDetailsMessage:
               pidemsg = msg as PartyInvitationDetailsMessage;
               partyMembersD = new Vector.<PartyMemberWrapper>();
               partyGuestsD = new Vector.<PartyMemberWrapper>();
               this._previewPartyId = pidemsg.partyId;
               for each(memberInvitedD in pidemsg.members)
               {
                  partyMemberWrapper = new PartyMemberWrapper(memberInvitedD.id,memberInvitedD.name,0,true,memberInvitedD.id == pidemsg.leaderId,memberInvitedD.level,memberInvitedD.entityLook,0,0,0,0,0,0,0,memberInvitedD.worldX,memberInvitedD.worldY,0,memberInvitedD.subAreaId,memberInvitedD.breed);
                  if(memberInvitedD.entities.length > 0)
                  {
                     for each(partyCompanionBaseInfo in memberInvitedD.entities)
                     {
                        partyCompanionWrapper = new PartyCompanionWrapper(memberInvitedD.id,memberInvitedD.name,partyCompanionBaseInfo.entityModelId,true,memberInvitedD.level,partyCompanionBaseInfo.entityLook);
                        partyCompanionWrapper.index = partyCompanionBaseInfo.indexId;
                        partyMemberWrapper.companions[partyCompanionBaseInfo.indexId] = partyCompanionWrapper;
                     }
                  }
                  partyMembersD.push(partyMemberWrapper);
               }
               for each(guestD in pidemsg.guests)
               {
                  partyMemberWrapper = new PartyMemberWrapper(guestD.guestId,guestD.name,guestD.status.statusId,false,false,0,guestD.guestLook);
                  partyMemberWrapper.breedId = guestD.breed;
                  partyMemberWrapper.hostId = guestD.hostId;
                  for each(canBeHostMember2 in partyMembersD)
                  {
                     if(canBeHostMember2.id == guestD.hostId)
                     {
                        partyMemberWrapper.hostName = canBeHostMember2.name;
                     }
                  }
                  if(guestD.entities.length > 0)
                  {
                     for each(partyCompanionBaseInfo in guestD.entities)
                     {
                        partyCompanionWrapper = new PartyCompanionWrapper(guestD.guestId,guestD.name,partyCompanionBaseInfo.entityModelId,false,0,partyCompanionBaseInfo.entityLook);
                        partyCompanionWrapper.index = partyCompanionBaseInfo.indexId;
                        partyMemberWrapper.companions[partyCompanionBaseInfo.indexId] = partyCompanionWrapper;
                     }
                  }
                  partyGuestsD.push(partyMemberWrapper);
               }
               if(msg is PartyInvitationDungeonDetailsMessage)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyInvitation,pidemsg.partyId,pidemsg.fromName,pidemsg.leaderId,pidemsg.partyType,partyMembersD,partyGuestsD,(pidemsg as PartyInvitationDungeonDetailsMessage).dungeonId,(pidemsg as PartyInvitationDungeonDetailsMessage).playersDungeonReady,pidemsg.partyName);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyInvitation,pidemsg.partyId,pidemsg.fromName,pidemsg.leaderId,pidemsg.partyType,partyMembersD,partyGuestsD,0,null,pidemsg.partyName);
               }
               return true;
            case msg is PartyAcceptInvitationAction:
               paia = msg as PartyAcceptInvitationAction;
               NotificationManager.getInstance().closeNotification("partyInvit_" + paia.partyId);
               paimsg = new PartyAcceptInvitationMessage();
               paimsg.initPartyAcceptInvitationMessage(paia.partyId);
               ConnectionsHandler.getConnection().send(paimsg);
               delete this._currentInvitations[paimsg.partyId];
               return true;
            case msg is PartyNewMemberMessage:
            case msg is PartyUpdateMessage:
               pumsg = msg as PartyUpdateMessage;
               existingMember = false;
               companionAddedOrRemoved = false;
               if(pumsg.partyId == this._arenaPartyId)
               {
                  for each(partyMemberWrapper in this._arenaPartyMembers)
                  {
                     if(partyMemberWrapper.id == pumsg.memberInformations.id)
                     {
                        partyMemberWrapper.name = pumsg.memberInformations.name;
                        partyMemberWrapper.isMember = true;
                        partyMemberWrapper.level = pumsg.memberInformations.level;
                        partyMemberWrapper.entityLook = pumsg.memberInformations.entityLook;
                        partyMemberWrapper.lifePoints = pumsg.memberInformations.lifePoints;
                        partyMemberWrapper.maxLifePoints = pumsg.memberInformations.maxLifePoints;
                        partyMemberWrapper.maxInitiative = pumsg.memberInformations.initiative;
                        partyMemberWrapper.rank = (pumsg.memberInformations as PartyMemberArenaInformations).rank;
                        partyMemberWrapper.alignmentSide = pumsg.memberInformations.alignmentSide;
                        partyMemberWrapper.regenRate = pumsg.memberInformations.regenRate;
                        partyMemberWrapper.worldX = pumsg.memberInformations.worldX;
                        partyMemberWrapper.worldY = pumsg.memberInformations.worldY;
                        partyMemberWrapper.mapId = pumsg.memberInformations.mapId;
                        partyMemberWrapper.subAreaId = pumsg.memberInformations.subAreaId;
                        existingMember = true;
                        break;
                     }
                  }
                  if(!existingMember)
                  {
                     newMember = new PartyMemberWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,pumsg.memberInformations.status.statusId,true,false,pumsg.memberInformations.level,pumsg.memberInformations.entityLook,pumsg.memberInformations.lifePoints,pumsg.memberInformations.maxLifePoints,pumsg.memberInformations.initiative,0,pumsg.memberInformations.alignmentSide,pumsg.memberInformations.regenRate,(pumsg.memberInformations as PartyMemberArenaInformations).rank,pumsg.memberInformations.worldX,pumsg.memberInformations.worldY,pumsg.memberInformations.mapId,pumsg.memberInformations.subAreaId);
                     newMember.isInArenaParty = true;
                     this._arenaPartyMembers.push(newMember);
                  }
               }
               else if(pumsg.partyId == this._partyId)
               {
                  for each(partyMemberWrapper in this._partyMembers)
                  {
                     if(partyMemberWrapper.id == pumsg.memberInformations.id)
                     {
                        partyMemberWrapper.name = pumsg.memberInformations.name;
                        partyMemberWrapper.isMember = true;
                        partyMemberWrapper.level = pumsg.memberInformations.level;
                        partyMemberWrapper.entityLook = pumsg.memberInformations.entityLook;
                        partyMemberWrapper.lifePoints = pumsg.memberInformations.lifePoints;
                        partyMemberWrapper.maxLifePoints = pumsg.memberInformations.maxLifePoints;
                        partyMemberWrapper.maxInitiative = pumsg.memberInformations.initiative;
                        partyMemberWrapper.prospecting = pumsg.memberInformations.prospecting;
                        partyMemberWrapper.alignmentSide = pumsg.memberInformations.alignmentSide;
                        partyMemberWrapper.regenRate = pumsg.memberInformations.regenRate;
                        partyMemberWrapper.worldX = pumsg.memberInformations.worldX;
                        partyMemberWrapper.worldY = pumsg.memberInformations.worldY;
                        partyMemberWrapper.mapId = pumsg.memberInformations.mapId;
                        partyMemberWrapper.subAreaId = pumsg.memberInformations.subAreaId;
                        if(pumsg.memberInformations.entities.length > 0)
                        {
                           for each(serverMemberComp in pumsg.memberInformations.entities)
                           {
                              if(partyMemberWrapper.companions[serverMemberComp.indexId])
                              {
                                 memberComp = partyMemberWrapper.companions[serverMemberComp.indexId];
                                 memberComp.companionGenericId = serverMemberComp.entityModelId;
                                 memberComp.isMember = true;
                                 memberComp.level = pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level);
                                 memberComp.entityLook = serverMemberComp.entityLook;
                                 memberComp.lifePoints = serverMemberComp.lifePoints;
                                 memberComp.maxLifePoints = serverMemberComp.maxLifePoints;
                                 memberComp.maxInitiative = serverMemberComp.initiative;
                                 memberComp.prospecting = serverMemberComp.prospecting;
                                 memberComp.regenRate = serverMemberComp.regenRate;
                              }
                              else
                              {
                                 partyCompanionWrapper = new PartyCompanionWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,serverMemberComp.entityModelId,true,pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level),serverMemberComp.entityLook,serverMemberComp.lifePoints,serverMemberComp.maxLifePoints,serverMemberComp.initiative,serverMemberComp.prospecting,serverMemberComp.regenRate);
                                 partyCompanionWrapper.index = serverMemberComp.indexId;
                                 partyMemberWrapper.companions[serverMemberComp.indexId] = partyCompanionWrapper;
                                 companionAddedOrRemoved = true;
                              }
                           }
                        }
                        else if(partyMemberWrapper.companions.length > 0)
                        {
                           partyMemberWrapper.companions = new Array();
                           companionAddedOrRemoved = true;
                        }
                        existingMember = true;
                        break;
                     }
                  }
                  if(!existingMember)
                  {
                     newMember = new PartyMemberWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,pumsg.memberInformations.status.statusId,true,false,pumsg.memberInformations.level,pumsg.memberInformations.entityLook,pumsg.memberInformations.lifePoints,pumsg.memberInformations.maxLifePoints,pumsg.memberInformations.initiative,pumsg.memberInformations.prospecting,pumsg.memberInformations.alignmentSide,pumsg.memberInformations.regenRate,0,pumsg.memberInformations.worldX,pumsg.memberInformations.worldY,pumsg.memberInformations.mapId,pumsg.memberInformations.subAreaId,pumsg.memberInformations.breed);
                     if(pumsg.memberInformations.entities.length > 0)
                     {
                        for each(partyCompanionMemberInfo in pumsg.memberInformations.entities)
                        {
                           partyCompanionWrapper = new PartyCompanionWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,partyCompanionMemberInfo.entityModelId,false,pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level),partyCompanionMemberInfo.entityLook,partyCompanionMemberInfo.lifePoints,partyCompanionMemberInfo.maxLifePoints,partyCompanionMemberInfo.initiative,partyCompanionMemberInfo.prospecting,partyCompanionMemberInfo.regenRate);
                           partyCompanionWrapper.index = partyCompanionMemberInfo.indexId;
                           newMember.companions[partyCompanionMemberInfo.indexId] = partyCompanionWrapper;
                        }
                     }
                     this._partyMembers.push(newMember);
                  }
               }
               else if(pumsg.partyId == this._previewPartyId)
               {
                  for each(partyMemberWrapper in this._previewPartyMembers)
                  {
                     if(partyMemberWrapper.id == pumsg.memberInformations.id)
                     {
                        partyMemberWrapper.name = pumsg.memberInformations.name;
                        partyMemberWrapper.isMember = true;
                        partyMemberWrapper.level = pumsg.memberInformations.level;
                        partyMemberWrapper.entityLook = pumsg.memberInformations.entityLook;
                        partyMemberWrapper.lifePoints = pumsg.memberInformations.lifePoints;
                        partyMemberWrapper.maxLifePoints = pumsg.memberInformations.maxLifePoints;
                        partyMemberWrapper.maxInitiative = pumsg.memberInformations.initiative;
                        partyMemberWrapper.prospecting = pumsg.memberInformations.prospecting;
                        partyMemberWrapper.alignmentSide = pumsg.memberInformations.alignmentSide;
                        partyMemberWrapper.regenRate = pumsg.memberInformations.regenRate;
                        partyMemberWrapper.worldX = pumsg.memberInformations.worldX;
                        partyMemberWrapper.worldY = pumsg.memberInformations.worldY;
                        partyMemberWrapper.mapId = pumsg.memberInformations.mapId;
                        partyMemberWrapper.subAreaId = pumsg.memberInformations.subAreaId;
                        if(pumsg.memberInformations.entities.length > 0)
                        {
                           for each(serverMemberComp in pumsg.memberInformations.entities)
                           {
                              if(partyMemberWrapper.companions[serverMemberComp.indexId])
                              {
                                 memberComp = partyMemberWrapper.companions[serverMemberComp.indexId];
                                 memberComp.companionGenericId = serverMemberComp.entityModelId;
                                 memberComp.isMember = true;
                                 memberComp.level = pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level);
                                 memberComp.entityLook = serverMemberComp.entityLook;
                                 memberComp.lifePoints = serverMemberComp.lifePoints;
                                 memberComp.maxLifePoints = serverMemberComp.maxLifePoints;
                                 memberComp.maxInitiative = serverMemberComp.initiative;
                                 memberComp.prospecting = serverMemberComp.prospecting;
                                 memberComp.regenRate = serverMemberComp.regenRate;
                              }
                              else
                              {
                                 partyCompanionWrapper = new PartyCompanionWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,serverMemberComp.entityModelId,true,pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level),serverMemberComp.entityLook,serverMemberComp.lifePoints,serverMemberComp.maxLifePoints,serverMemberComp.initiative,serverMemberComp.prospecting,serverMemberComp.regenRate);
                                 partyCompanionWrapper.index = serverMemberComp.indexId;
                                 partyMemberWrapper.companions[serverMemberComp.indexId] = partyCompanionWrapper;
                                 companionAddedOrRemoved = true;
                              }
                           }
                        }
                        else if(partyMemberWrapper.companions.length > 0)
                        {
                           partyMemberWrapper.companions = new Array();
                           companionAddedOrRemoved = true;
                        }
                        existingMember = true;
                        break;
                     }
                  }
                  if(!existingMember)
                  {
                     newMember = new PartyMemberWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,pumsg.memberInformations.status.statusId,true,false,pumsg.memberInformations.level,pumsg.memberInformations.entityLook,pumsg.memberInformations.lifePoints,pumsg.memberInformations.maxLifePoints,pumsg.memberInformations.initiative,pumsg.memberInformations.prospecting,pumsg.memberInformations.alignmentSide,pumsg.memberInformations.regenRate,0,pumsg.memberInformations.worldX,pumsg.memberInformations.worldY,pumsg.memberInformations.mapId,pumsg.memberInformations.subAreaId,pumsg.memberInformations.breed);
                     if(pumsg.memberInformations.entities.length > 0)
                     {
                        for each(partyCompanionMemberInfo in pumsg.memberInformations.entities)
                        {
                           partyCompanionWrapper = new PartyCompanionWrapper(pumsg.memberInformations.id,pumsg.memberInformations.name,partyCompanionMemberInfo.entityModelId,false,pumsg.memberInformations.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(pumsg.memberInformations.level),partyCompanionMemberInfo.entityLook,partyCompanionMemberInfo.lifePoints,partyCompanionMemberInfo.maxLifePoints,partyCompanionMemberInfo.initiative,partyCompanionMemberInfo.prospecting,partyCompanionMemberInfo.regenRate);
                           partyCompanionWrapper.index = partyCompanionMemberInfo.indexId;
                           newMember.companions[partyCompanionMemberInfo.indexId] = partyCompanionWrapper;
                        }
                     }
                     this._previewPartyMembers.push(newMember);
                  }
               }
               if(pumsg.partyId == this._previewPartyId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdateDetails,pumsg.partyId,!!existingMember ? partyMemberWrapper : newMember,true);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate,pumsg.partyId,pumsg.memberInformations.id,false);
               }
               if(this.roleplayEntitiesFrame && (msg is PartyNewMemberMessage || companionAddedOrRemoved))
               {
                  this.roleplayEntitiesFrame.updateMonstersGroups();
               }
               return true;
            case msg is PartyJoinMessage:
               pjmsg = msg as PartyJoinMessage;
               if(pjmsg.partyId == this._previewPartyId)
               {
                  this._previewPartyId = -1;
               }
               if(pjmsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA)
               {
                  this._arenaPartyMembers = new Vector.<PartyMemberWrapper>();
                  this._arenaPartyId = pjmsg.partyId;
                  for each(memberJoin in pjmsg.members)
                  {
                     partyMemberWrapper = new PartyMemberWrapper(memberJoin.id,memberJoin.name,memberJoin.status.statusId,true,false,memberJoin.level,memberJoin.entityLook,memberJoin.lifePoints,memberJoin.maxLifePoints,memberJoin.initiative,memberJoin.prospecting,memberJoin.alignmentSide,memberJoin.regenRate,(memberJoin as PartyMemberArenaInformations).rank,memberJoin.worldX,memberJoin.worldY,memberJoin.mapId,memberJoin.subAreaId,memberJoin.breed);
                     if(memberJoin.id == pjmsg.partyLeaderId)
                     {
                        partyMemberWrapper.isLeader = true;
                        this._arenaLeader = partyMemberWrapper;
                     }
                     partyMemberWrapper.isInArenaParty = true;
                     this._arenaPartyMembers.push(partyMemberWrapper);
                  }
                  for each(partyGuestInfo in pjmsg.guests)
                  {
                     partyGuest = new PartyMemberWrapper(partyGuestInfo.guestId,partyGuestInfo.name,partyGuestInfo.status.statusId,false,false,0,partyGuestInfo.guestLook);
                     partyGuest.hostId = partyGuestInfo.hostId;
                     for each(canBeHostMember2 in this._arenaPartyMembers)
                     {
                        if(canBeHostMember2.id == partyGuestInfo.hostId)
                        {
                           partyGuest.hostName = canBeHostMember2.name;
                        }
                     }
                     this._arenaPartyMembers.push(partyGuest);
                  }
               }
               else
               {
                  this._partyMembers = new Vector.<PartyMemberWrapper>();
                  this._partyId = pjmsg.partyId;
                  for each(memberJoin in pjmsg.members)
                  {
                     partyMemberWrapper = new PartyMemberWrapper(memberJoin.id,memberJoin.name,memberJoin.status.statusId,true,false,memberJoin.level,memberJoin.entityLook,memberJoin.lifePoints,memberJoin.maxLifePoints,memberJoin.initiative,memberJoin.prospecting,memberJoin.alignmentSide,memberJoin.regenRate,0,memberJoin.worldX,memberJoin.worldY,memberJoin.mapId,memberJoin.subAreaId,memberJoin.breed);
                     if(memberJoin.entities.length > 0)
                     {
                        for each(partyCompanionMemberInfo in memberJoin.entities)
                        {
                           partyCompanionWrapper = new PartyCompanionWrapper(memberJoin.id,memberJoin.name,partyCompanionMemberInfo.entityModelId,true,memberJoin.level > ProtocolConstantsEnum.MAX_LEVEL ? int(ProtocolConstantsEnum.MAX_LEVEL) : int(memberJoin.level),partyCompanionMemberInfo.entityLook,partyCompanionMemberInfo.lifePoints,partyCompanionMemberInfo.maxLifePoints,partyCompanionMemberInfo.initiative,partyCompanionMemberInfo.prospecting,partyCompanionMemberInfo.regenRate);
                           partyCompanionWrapper.index = partyCompanionMemberInfo.indexId;
                           partyMemberWrapper.companions[partyCompanionMemberInfo.indexId] = partyCompanionWrapper;
                        }
                     }
                     if(memberJoin.id == pjmsg.partyLeaderId)
                     {
                        partyMemberWrapper.isLeader = true;
                     }
                     this._partyMembers.push(partyMemberWrapper);
                  }
                  for each(partyGuestInfo in pjmsg.guests)
                  {
                     partyGuest = new PartyMemberWrapper(partyGuestInfo.guestId,partyGuestInfo.name,partyGuestInfo.status.statusId,false,false,0,partyGuestInfo.guestLook);
                     if(partyGuestInfo.entities.length > 0)
                     {
                        for each(partyCompanionBaseInfo in partyGuestInfo.entities)
                        {
                           partyCompanionWrapper = new PartyCompanionWrapper(partyGuestInfo.guestId,partyGuestInfo.name,partyCompanionBaseInfo.entityModelId,false,0,partyCompanionBaseInfo.entityLook);
                           partyCompanionWrapper.index = partyCompanionBaseInfo.indexId;
                           partyGuest.companions[partyCompanionBaseInfo.indexId] = partyCompanionWrapper;
                        }
                     }
                     partyGuest.hostId = partyGuestInfo.hostId;
                     for each(canBeHostMember2 in this._partyMembers)
                     {
                        if(canBeHostMember2.id == partyGuestInfo.hostId)
                        {
                           partyGuest.hostName = canBeHostMember2.name;
                        }
                     }
                     this._partyMembers.push(partyGuest);
                  }
               }
               this._timerRegen.start();
               arena = pjmsg.partyType == PartyTypeEnum.PARTY_TYPE_ARENA;
               KernelEventsManager.getInstance().processCallback(HookList.PartyJoin,pjmsg.partyId,!!arena ? this._arenaPartyMembers : this._partyMembers,pjmsg.restricted,arena,pjmsg.partyName);
               PlayedCharacterManager.getInstance().isInParty = true;
               if(pjmsg.partyLeaderId == PlayedCharacterManager.getInstance().id)
               {
                  PlayedCharacterManager.getInstance().isPartyLeader = true;
               }
               else
               {
                  PlayedCharacterManager.getInstance().isPartyLeader = false;
               }
               if(this.roleplayEntitiesFrame)
               {
                  this.roleplayEntitiesFrame.updateMonstersGroups();
               }
               return true;
            case msg is PartyRefuseInvitationAction:
               pria = msg as PartyRefuseInvitationAction;
               primsg = new PartyRefuseInvitationMessage();
               primsg.initPartyRefuseInvitationMessage(pria.partyId);
               ConnectionsHandler.getConnection().send(primsg);
               NotificationManager.getInstance().closeNotification("partyInvit_" + pria.partyId);
               delete this._currentInvitations[pria.partyId];
               return true;
            case msg is PartyRefuseInvitationNotificationMessage:
               prinmsg = msg as PartyRefuseInvitationNotificationMessage;
               guestRefusingIndex = 0;
               if(prinmsg.partyId == this._arenaPartyId)
               {
                  for(iMember = 0; iMember < this._arenaPartyMembers.length; iMember++)
                  {
                     if(prinmsg.guestId == this._arenaPartyMembers[iMember].id)
                     {
                        guestRefusingIndex = iMember;
                        prinGuestName = this._arenaPartyMembers[iMember].name;
                     }
                  }
                  if(guestRefusingIndex != 0)
                  {
                     this._arenaPartyMembers.splice(guestRefusingIndex,1);
                  }
               }
               else if(prinmsg.partyId == this._partyId)
               {
                  for(iMember = 0; iMember < this._partyMembers.length; iMember++)
                  {
                     if(prinmsg.guestId == this._partyMembers[iMember].id)
                     {
                        guestRefusingIndex = iMember;
                        prinGuestName = this._partyMembers[iMember].name;
                     }
                  }
                  if(guestRefusingIndex != 0)
                  {
                     this._partyMembers.splice(guestRefusingIndex,1);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove,prinmsg.partyId,prinmsg.guestId);
               if(guestRefusingIndex != 0)
               {
                  prinText2 = I18n.getUiText("ui.party.invitationRefused",[prinGuestName]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,prinText2,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is PartyDeletedMessage:
               pdmsg = msg as PartyDeletedMessage;
               this.deleteParty(pdmsg.partyId);
               return true;
            case msg is PartyCancelInvitationAction:
               pcia = msg as PartyCancelInvitationAction;
               pcimsg = new PartyCancelInvitationMessage();
               pcimsg.initPartyCancelInvitationMessage(pcia.partyId,pcia.guestId);
               ConnectionsHandler.getConnection().send(pcimsg);
               return true;
            case msg is PartyCancelInvitationNotificationMessage:
               pcinmsg = msg as PartyCancelInvitationNotificationMessage;
               guestRefusingIndex2 = 0;
               if(pcinmsg.partyId == this._arenaPartyId)
               {
                  for(iMember2 = 0; iMember2 < this._arenaPartyMembers.length; iMember2++)
                  {
                     if(pcinmsg.guestId == this._arenaPartyMembers[iMember2].id)
                     {
                        guestRefusingIndex2 = iMember2;
                        pcinGuestName = this._arenaPartyMembers[iMember2].name;
                     }
                     if(pcinmsg.cancelerId == this._arenaPartyMembers[iMember2].id)
                     {
                        pcinCancelerName = this._arenaPartyMembers[iMember2].name;
                     }
                  }
                  if(guestRefusingIndex2 != 0)
                  {
                     this._arenaPartyMembers.splice(guestRefusingIndex2,1);
                  }
               }
               else if(pcinmsg.partyId == this._partyId)
               {
                  for(iMember2 = 0; iMember2 < this._partyMembers.length; iMember2++)
                  {
                     if(pcinmsg.guestId == this._partyMembers[iMember2].id)
                     {
                        guestRefusingIndex2 = iMember2;
                        pcinGuestName = this._partyMembers[iMember2].name;
                     }
                     if(pcinmsg.cancelerId == this._partyMembers[iMember2].id)
                     {
                        pcinCancelerName = this._partyMembers[iMember2].name;
                     }
                  }
                  if(guestRefusingIndex2 != 0)
                  {
                     this._partyMembers.splice(guestRefusingIndex2,1);
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove,pcinmsg.partyId,pcinmsg.guestId);
               if(guestRefusingIndex2 != 0)
               {
                  pcinText = I18n.getUiText("ui.party.invitationCancelled",[pcinCancelerName,pcinGuestName]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,pcinText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is PartyInvitationCancelledForGuestMessage:
               picfgmsg = msg as PartyInvitationCancelledForGuestMessage;
               KernelEventsManager.getInstance().processCallback(HookList.PartyCancelledInvitation,picfgmsg.partyId);
               NotificationManager.getInstance().closeNotification("partyInvit_" + picfgmsg.partyId);
               if(this._currentInvitations[picfgmsg.partyId])
               {
                  picfgInviterName = this._currentInvitations[picfgmsg.partyId].fromName;
                  picfgText = I18n.getUiText("ui.party.invitationCancelledForGuest",[picfgInviterName]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,picfgText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  delete this._currentInvitations[picfgmsg.partyId];
               }
               return true;
            case msg is PartyRestrictedMessage:
               prmsg = msg as PartyRestrictedMessage;
               KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty,prmsg.restricted);
               return true;
            case msg is PartyKickRequestAction:
               pka = msg as PartyKickRequestAction;
               pkickrimsg = new PartyKickRequestMessage();
               pkickrimsg.initPartyKickRequestMessage(pka.partyId,pka.playerId);
               ConnectionsHandler.getConnection().send(pkickrimsg);
               return true;
            case msg is PartyKickedByMessage:
               pkbmsg = msg as PartyKickedByMessage;
               this.deleteParty(pkbmsg.partyId);
               if(this.roleplayEntitiesFrame)
               {
                  this.roleplayEntitiesFrame.updateMonstersGroups();
               }
               return true;
            case msg is PartyLeaveMessage:
               plmsg = msg as PartyLeaveMessage;
               this.deleteParty(plmsg.partyId);
               if(this.roleplayEntitiesFrame)
               {
                  this.roleplayEntitiesFrame.updateMonstersGroups();
               }
               return true;
            case msg is PartyMemberRemoveMessage:
               pmrmsg = msg as PartyMemberRemoveMessage;
               memberToRemoveIndex = 0;
               if(pmrmsg.partyId == this._arenaPartyId)
               {
                  for(iMember3 = 0; iMember3 < this._arenaPartyMembers.length; iMember3++)
                  {
                     if(pmrmsg.leavingPlayerId == this._arenaPartyMembers[iMember3].id)
                     {
                        memberToRemoveIndex = iMember3;
                     }
                  }
                  this._arenaPartyMembers.splice(memberToRemoveIndex,1);
               }
               else if(pmrmsg.partyId == this._partyId)
               {
                  for(iMember3 = 0; iMember3 < this._partyMembers.length; iMember3++)
                  {
                     if(pmrmsg.leavingPlayerId == this._partyMembers[iMember3].id)
                     {
                        memberToRemoveIndex = iMember3;
                     }
                  }
                  this._partyMembers.splice(memberToRemoveIndex,1);
               }
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberRemove,pmrmsg.partyId,pmrmsg.leavingPlayerId);
               if(this.roleplayEntitiesFrame)
               {
                  this.roleplayEntitiesFrame.updateMonstersGroups();
               }
               return true;
            case msg is PartyLeaveRequestAction:
               plra = msg as PartyLeaveRequestAction;
               plrmsg = new PartyLeaveRequestMessage();
               plrmsg.initPartyLeaveRequestMessage(plra.partyId);
               ConnectionsHandler.getConnection().send(plrmsg);
               return true;
            case msg is PartyLeaderUpdateMessage:
               plulmsg = msg as PartyLeaderUpdateMessage;
               if(plulmsg.partyId == this._arenaPartyId)
               {
                  for each(partyMem in this._arenaPartyMembers)
                  {
                     if(partyMem.id == plulmsg.partyLeaderId)
                     {
                        partyMem.isLeader = true;
                        this._arenaLeader = partyMem;
                     }
                     else
                     {
                        partyMem.isLeader = false;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.PartyUpdate,plulmsg.partyId,this._arenaPartyMembers);
               }
               else if(plulmsg.partyId == this._partyId)
               {
                  for each(partyMem in this._partyMembers)
                  {
                     if(partyMem.id == plulmsg.partyLeaderId)
                     {
                        partyMem.isLeader = true;
                     }
                     else
                     {
                        partyMem.isLeader = false;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.PartyUpdate,plulmsg.partyId,this._partyMembers);
               }
               if(plulmsg.partyLeaderId == PlayedCharacterManager.getInstance().id)
               {
                  PlayedCharacterManager.getInstance().isPartyLeader = true;
               }
               else
               {
                  PlayedCharacterManager.getInstance().isPartyLeader = false;
               }
               KernelEventsManager.getInstance().processCallback(HookList.PartyLeaderUpdate,plulmsg.partyId,plulmsg.partyLeaderId);
               return true;
            case msg is PartyEntityUpdateLightMessage:
               pculmsg = msg as PartyEntityUpdateLightMessage;
               if(pculmsg.partyId == this._partyId)
               {
                  for each(partyMemb in this._partyMembers)
                  {
                     if(partyMemb.id == pculmsg.id)
                     {
                        if(partyMemb.companions[pculmsg.indexId])
                        {
                           partyMemb.companions[pculmsg.indexId].lifePoints = pculmsg.lifePoints;
                           partyMemb.companions[pculmsg.indexId].maxLifePoints = pculmsg.maxLifePoints;
                           partyMemb.companions[pculmsg.indexId].prospecting = pculmsg.prospecting;
                           partyMemb.companions[pculmsg.indexId].regenRate = pculmsg.regenRate;
                           break;
                        }
                        _log.error("Trying to update a non-existing companion is problem.");
                        return true;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.PartyCompanionMemberUpdate,pculmsg.partyId,pculmsg.id,pculmsg.indexId,partyMemb.companions[pculmsg.indexId]);
               }
               return true;
            case msg is PartyUpdateLightMessage:
               pulmsg = msg as PartyUpdateLightMessage;
               if(pulmsg.partyId == this._arenaPartyId)
               {
                  for each(partyMembUL in this._arenaPartyMembers)
                  {
                     if(partyMembUL.id == pulmsg.id)
                     {
                        partyMembUL.lifePoints = pulmsg.lifePoints;
                        partyMembUL.maxLifePoints = pulmsg.maxLifePoints;
                        partyMembUL.prospecting = pulmsg.prospecting;
                        partyMembUL.regenRate = pulmsg.regenRate;
                     }
                     if(this._dicRegenArena[partyMembUL.id] == null)
                     {
                        lptmanager = new LifePointTickManager();
                     }
                     else
                     {
                        lptmanager = this._dicRegenArena[partyMembUL.id];
                     }
                     lptmanager.originalLifePoint = partyMembUL.lifePoints;
                     lptmanager.regenRate = partyMembUL.regenRate;
                     lptmanager.tickNumber = 1;
                     this._dicRegenArena[partyMembUL.id] = lptmanager;
                  }
               }
               else if(pulmsg.partyId == this._partyId)
               {
                  for each(partyMembUL in this._partyMembers)
                  {
                     if(partyMembUL.id == pulmsg.id)
                     {
                        partyMembUL.lifePoints = pulmsg.lifePoints;
                        partyMembUL.maxLifePoints = pulmsg.maxLifePoints;
                        partyMembUL.prospecting = pulmsg.prospecting;
                        partyMembUL.regenRate = pulmsg.regenRate;
                     }
                     if(this._dicRegen[partyMembUL.id] == null)
                     {
                        lptmanager = new LifePointTickManager();
                     }
                     else
                     {
                        lptmanager = this._dicRegen[partyMembUL.id];
                     }
                     lptmanager.originalLifePoint = partyMembUL.lifePoints;
                     lptmanager.regenRate = partyMembUL.regenRate;
                     lptmanager.tickNumber = 1;
                     this._dicRegen[partyMembUL.id] = lptmanager;
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberUpdate,pulmsg.partyId,pulmsg.id,false);
               return true;
            case msg is PartyAbdicateThroneAction:
               pata = msg as PartyAbdicateThroneAction;
               patmsg = new PartyAbdicateThroneMessage();
               patmsg.initPartyAbdicateThroneMessage(pata.partyId,pata.playerId);
               ConnectionsHandler.getConnection().send(patmsg);
               return true;
            case msg is PartyPledgeLoyaltyRequestAction:
               pplra = msg as PartyPledgeLoyaltyRequestAction;
               pplrmsg = new PartyPledgeLoyaltyRequestMessage();
               pplrmsg.initPartyPledgeLoyaltyRequestMessage(pplra.partyId,pplra.loyal);
               ConnectionsHandler.getConnection().send(pplrmsg);
               return true;
            case msg is PartyLoyaltyStatusMessage:
               plsmsg = msg as PartyLoyaltyStatusMessage;
               this._partyLoyalty = plsmsg.loyal;
               KernelEventsManager.getInstance().processCallback(HookList.PartyLoyaltyStatus,plsmsg.partyId,plsmsg.loyal);
               return true;
            case msg is PartyFollowStatusUpdateMessage:
               pfsumsg = msg as PartyFollowStatusUpdateMessage;
               if(pfsumsg.success)
               {
                  if(pfsumsg.followedId == 0 && !pfsumsg.isFollowed)
                  {
                     for each(followingPlayerId in PlayedCharacterManager.getInstance().followingPlayerIds)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_PARTY + "_" + followingPlayerId,PlayedCharacterManager.getInstance().currentWorldMapId);
                        KernelEventsManager.getInstance().processCallback(HookList.PartyMemberFollowUpdate,pfsumsg.partyId,followingPlayerId,false);
                     }
                     PlayedCharacterManager.getInstance().followingPlayerIds.length = 0;
                  }
                  else
                  {
                     followingPlayerIndex = PlayedCharacterManager.getInstance().followingPlayerIds.indexOf(pfsumsg.followedId);
                     KernelEventsManager.getInstance().processCallback(HookList.PartyMemberFollowUpdate,pfsumsg.partyId,pfsumsg.followedId,pfsumsg.isFollowed);
                     if(pfsumsg.isFollowed && followingPlayerIndex == -1)
                     {
                        PlayedCharacterManager.getInstance().followingPlayerIds.push(pfsumsg.followedId);
                     }
                     else if(followingPlayerIndex != -1)
                     {
                        PlayedCharacterManager.getInstance().followingPlayerIds.splice(followingPlayerIndex,1);
                     }
                  }
               }
               return true;
            case msg is PartyFollowMemberAction:
               pfma = msg as PartyFollowMemberAction;
               pfmrmsg = new PartyFollowMemberRequestMessage();
               pfmrmsg.initPartyFollowMemberRequestMessage(pfma.partyId,pfma.playerId);
               ConnectionsHandler.getConnection().send(pfmrmsg);
               return true;
            case msg is PartyStopFollowingMemberAction:
               psfma = msg as PartyStopFollowingMemberAction;
               psfrmsg = new PartyStopFollowRequestMessage();
               psfrmsg.initPartyStopFollowRequestMessage(psfma.partyId,psfma.playerId);
               ConnectionsHandler.getConnection().send(psfrmsg);
               return true;
            case msg is PartyAllFollowMemberAction:
               pafma = msg as PartyAllFollowMemberAction;
               pftmrmsg = new PartyFollowThisMemberRequestMessage();
               pftmrmsg.initPartyFollowThisMemberRequestMessage(pafma.partyId,pafma.playerId,true);
               this.allMemberFollowPlayerId = pafma.playerId;
               ConnectionsHandler.getConnection().send(pftmrmsg);
               return true;
            case msg is PartyAllStopFollowingMemberAction:
               pasfma = msg as PartyAllStopFollowingMemberAction;
               pftmrmsg2 = new PartyFollowThisMemberRequestMessage();
               pftmrmsg2.initPartyFollowThisMemberRequestMessage(pasfma.partyId,pasfma.playerId,false);
               this.allMemberFollowPlayerId = 0;
               ConnectionsHandler.getConnection().send(pftmrmsg2);
               return true;
            case msg is PartyShowMenuAction:
               psma = msg as PartyShowMenuAction;
               modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
               menu = this.createPartyPlayerContextMenu(psma.playerId,psma.partyId);
               modContextMenu.createContextMenu(menu);
               return true;
            case msg is PartyLocateMembersMessage:
               plmmsg = msg as PartyLocateMembersMessage;
               return true;
            case msg is PartyNameSetRequestAction:
               pnsra = msg as PartyNameSetRequestAction;
               pnsrmsg = new PartyNameSetRequestMessage();
               pnsrmsg.initPartyNameSetRequestMessage(pnsra.partyId,pnsra.partyName);
               ConnectionsHandler.getConnection().send(pnsrmsg);
               return true;
            case msg is PartyNameUpdateMessage:
               pnumsg = msg as PartyNameUpdateMessage;
               KernelEventsManager.getInstance().processCallback(HookList.PartyNameUpdate,pnumsg.partyId,pnumsg.partyName);
               return true;
            case msg is PartyNameSetErrorMessage:
               pnsemsg = msg as PartyNameSetErrorMessage;
               nameErrorText = "";
               switch(pnsemsg.result)
               {
                  case PartyNameErrorEnum.PARTY_NAME_UNDEFINED_ERROR:
                     nameErrorText = I18n.getUiText("ui.party.nameError");
                     break;
                  case PartyNameErrorEnum.PARTY_NAME_INVALID:
                     nameErrorText = I18n.getUiText("ui.party.nameInvalid");
                     break;
                  case PartyNameErrorEnum.PARTY_NAME_ALREADY_USED:
                     nameErrorText = I18n.getUiText("ui.party.nameAlreadyUsed");
                     break;
                  case PartyNameErrorEnum.PARTY_NAME_UNALLOWED_RIGHTS:
                     nameErrorText = I18n.getUiText("ui.party.nameUnallowedRights");
                     break;
                  case PartyNameErrorEnum.PARTY_NAME_UNALLOWED_NOW:
                     nameErrorText = I18n.getUiText("ui.party.nameUnallowedNow");
               }
               if(nameErrorText != "")
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,nameErrorText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TeleportBuddiesMessage:
               tbmsg = msg as TeleportBuddiesMessage;
               Kernel.getWorker().addFrame(this._teleportBuddiesDialogFrame);
               commonModTp = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
               commonModTp.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.party.teleportMembersProposition"),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[this.teleportWantedFunction,this.teleportUnwantedFunction],this.teleportWantedFunction,this.teleportUnwantedFunction);
               return true;
            case msg is TeleportBuddiesRequestedMessage:
               tbrmsg = msg as TeleportBuddiesRequestedMessage;
               poorBuddiesNames = "";
               for each(buddyPropMember in this._partyMembers)
               {
                  if(buddyPropMember.id == tbrmsg.inviterId)
                  {
                     tpHostName = buddyPropMember.name;
                  }
                  else if(tbrmsg.invalidBuddiesIds.indexOf(buddyPropMember.id) != -1)
                  {
                     poorBuddiesNames += buddyPropMember.name + ", ";
                  }
               }
               dungeonPropName = Dungeon.getDungeonById(tbrmsg.dungeonId).name;
               prinText = I18n.getUiText("ui.party.teleportWish",[tpHostName,dungeonPropName]);
               if(poorBuddiesNames != "")
               {
                  poorBuddiesNames = poorBuddiesNames.substring(0,poorBuddiesNames.length - 2);
                  prinText += " " + PatternDecoder.combine(I18n.getUiText("ui.party.teleportCriterionFallenAngels",[poorBuddiesNames]),"n",poorBuddiesNames.split(", ").length == 1,poorBuddiesNames.split(", ").length == 0);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,prinText,ChatActivableChannelsEnum.CHANNEL_PARTY,TimeManager.getInstance().getTimestamp());
               if(Kernel.getWorker().contains(TeleportBuddiesDialogFrame))
               {
                  Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(TeleportBuddiesDialogFrame) as TeleportBuddiesDialogFrame);
               }
               return true;
            case msg is TeleportToBuddyOfferMessage:
               ttbomsg = msg as TeleportToBuddyOfferMessage;
               for each(buddyMember in this._partyMembers)
               {
                  if(buddyMember.id == ttbomsg.buddyId)
                  {
                     buddyName = buddyMember.name;
                  }
               }
               dungeonName = Dungeon.getDungeonById(ttbomsg.dungeonId).name;
               notifyUser = true;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.DUNGEON_TELEPORT))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.DUNGEON_TELEPORT,[buddyName,dungeonName]);
                  notifyUser = ExternalNotificationManager.getInstance().notificationNotify(ExternalNotificationTypeEnum.DUNGEON_TELEPORT);
               }
               ttbomsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText("ui.party.teleportProposition",[buddyName,dungeonName]),NotificationTypeEnum.PRIORITY_INVITATION,"teleportProposition");
               NotificationManager.getInstance().addTimerToNotification(ttbomsgNid,ttbomsg.timeLeft,false,false,notifyUser);
               NotificationManager.getInstance().addButtonToNotification(ttbomsgNid,I18n.getUiText("ui.common.refuse"),"TeleportToBuddyAnswerAction",[ttbomsg.dungeonId,ttbomsg.buddyId,false],false,130);
               NotificationManager.getInstance().addButtonToNotification(ttbomsgNid,I18n.getUiText("ui.common.accept"),"TeleportToBuddyAnswerAction",[ttbomsg.dungeonId,ttbomsg.buddyId,true],false,130);
               NotificationManager.getInstance().addCallbackToNotification(ttbomsgNid,"TeleportToBuddyAnswerAction",[ttbomsg.dungeonId,ttbomsg.buddyId,false]);
               NotificationManager.getInstance().sendNotification(ttbomsgNid);
               return true;
            case msg is TeleportToBuddyCloseMessage:
               ttbcmsg = msg as TeleportToBuddyCloseMessage;
               NotificationManager.getInstance().closeNotification("teleportProposition");
               return true;
            case msg is TeleportToBuddyAnswerAction:
               ttbaa = msg as TeleportToBuddyAnswerAction;
               if(ttbaa.accept && Kernel.getWorker().contains(NpcDialogFrame))
               {
                  ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                  Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(NpcDialogFrame) as NpcDialogFrame);
               }
               ttbamsg = new TeleportToBuddyAnswerMessage();
               ttbamsg.initTeleportToBuddyAnswerMessage(ttbaa.dungeonId,ttbaa.buddyId,ttbaa.accept);
               ConnectionsHandler.getConnection().send(ttbamsg);
               return true;
            case msg is DungeonPartyFinderAvailableDungeonsAction:
               dpfada = msg as DungeonPartyFinderAvailableDungeonsAction;
               dpfadrmsg = new DungeonPartyFinderAvailableDungeonsRequestMessage();
               dpfadrmsg.initDungeonPartyFinderAvailableDungeonsRequestMessage();
               ConnectionsHandler.getConnection().send(dpfadrmsg);
               return true;
            case msg is DungeonPartyFinderAvailableDungeonsMessage:
               dpfadmsg = msg as DungeonPartyFinderAvailableDungeonsMessage;
               if(dpfadmsg.dungeonIds != this._playerDungeons)
               {
                  this._playerDungeons = dpfadmsg.dungeonIds;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderAvailableDungeons,this._playerDungeons);
               return true;
            case msg is DungeonPartyFinderListenAction:
               dpfla = msg as DungeonPartyFinderListenAction;
               dpflrmsg = new DungeonPartyFinderListenRequestMessage();
               dpflrmsg.initDungeonPartyFinderListenRequestMessage(dpfla.dungeonId);
               ConnectionsHandler.getConnection().send(dpflrmsg);
               return true;
            case msg is DungeonPartyFinderListenErrorMessage:
               dpflemsg = msg as DungeonPartyFinderListenErrorMessage;
               return true;
            case msg is DungeonPartyFinderRoomContentMessage:
               dpfrcmsg = msg as DungeonPartyFinderRoomContentMessage;
               this._dungeonFighters = new Vector.<DungeonPartyFinderPlayer>();
               for each(fighterDungeon in dpfrcmsg.players)
               {
                  this._dungeonFighters.push(fighterDungeon);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRoomContent,this._dungeonFighters);
               return true;
            case msg is DungeonPartyFinderRoomContentUpdateMessage:
               dpfrcumsg = msg as DungeonPartyFinderRoomContentUpdateMessage;
               tempDjFighters = this._dungeonFighters.concat();
               for(iFD = tempDjFighters.length - 1; iFD >= 0; iFD--)
               {
                  currentfighterDungeon = tempDjFighters[iFD];
                  for each(removedfighterId in dpfrcumsg.removedPlayersIds)
                  {
                     if(currentfighterDungeon.playerId == removedfighterId)
                     {
                        this._dungeonFighters.splice(iFD,1);
                     }
                  }
               }
               for each(addedfighterDungeon in dpfrcumsg.addedPlayers)
               {
                  this._dungeonFighters.push(addedfighterDungeon);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRoomContent,this._dungeonFighters);
               return true;
            case msg is DungeonPartyFinderRegisterAction:
               dpfra = msg as DungeonPartyFinderRegisterAction;
               dungeons = new Vector.<uint>();
               for each(dungeonId in dpfra.dungeons)
               {
                  dungeons.push(dungeonId);
               }
               dpfrrmsg = new DungeonPartyFinderRegisterRequestMessage();
               dpfrrmsg.initDungeonPartyFinderRegisterRequestMessage(dungeons);
               ConnectionsHandler.getConnection().send(dpfrrmsg);
               return true;
            case msg is DungeonPartyFinderRegisterSuccessMessage:
               dpfrsmsg = msg as DungeonPartyFinderRegisterSuccessMessage;
               if(dpfrsmsg.dungeonIds.length > 0)
               {
                  paramDonjons = "";
                  for each(djId in dpfrsmsg.dungeonIds)
                  {
                     paramDonjons += Dungeon.getDungeonById(djId).name + ", ";
                  }
                  paramDonjons = paramDonjons.substring(0,paramDonjons.length - 2);
                  resultText = I18n.getUiText("ui.teamSearch.registerSuccess",[paramDonjons]);
               }
               else
               {
                  resultText = I18n.getUiText("ui.teamSearch.registerQuit");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,resultText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               this._playerSubscribedDungeons = dpfrsmsg.dungeonIds;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.DungeonPartyFinderRegister,dpfrsmsg.dungeonIds.length > 0);
               return true;
            case msg is DungeonPartyFinderRegisterErrorMessage:
               dpfremsg = msg as DungeonPartyFinderRegisterErrorMessage;
               errortext = I18n.getUiText("ui.teamSearch.registerError");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,errortext,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is ArenaRegisterAction:
               ara = msg as ArenaRegisterAction;
               this._currentArenaType = ara.fightTypeId;
               grparmsg = new GameRolePlayArenaRegisterMessage();
               grparmsg.initGameRolePlayArenaRegisterMessage(ara.fightTypeId);
               ConnectionsHandler.getConnection().send(grparmsg);
               return true;
            case msg is ArenaUnregisterAction:
               aua = msg as ArenaUnregisterAction;
               grpaumsg = new GameRolePlayArenaUnregisterMessage();
               grpaumsg.initGameRolePlayArenaUnregisterMessage();
               ConnectionsHandler.getConnection().send(grpaumsg);
               return true;
            case msg is GameRolePlayArenaRegistrationStatusMessage:
               grparsmsg = msg as GameRolePlayArenaRegistrationStatusMessage;
               if(grparsmsg.registered)
               {
                  this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_REGISTRED;
                  this._isArenaRegistered = true;
               }
               else
               {
                  this._arenaCurrentStatus = grparsmsg.step;
                  this._isArenaRegistered = false;
               }
               this._arenaReadyPartyMemberIds = new Array();
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate,this._isArenaRegistered,this._arenaCurrentStatus);
               return true;
            case msg is GameRolePlayArenaFightPropositionMessage:
               grpafpmsg = msg as GameRolePlayArenaFightPropositionMessage;
               this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaFightProposition,grpafpmsg.alliesId);
               this._arenaAlliesIds = new Array();
               for each(allyId in grpafpmsg.alliesId)
               {
                  this._arenaAlliesIds.push(allyId);
               }
               this._arenaProposalNotifName = "fightProposition_" + grpafpmsg.fightId;
               arenaProposalNotifId = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.koliseum"),I18n.getUiText("ui.party.fightFound"),NotificationTypeEnum.PRIORITY_INVITATION,this._arenaProposalNotifName,false,true);
               NotificationManager.getInstance().addTimerToNotification(arenaProposalNotifId,grpafpmsg.duration,false,true);
               NotificationManager.getInstance().addButtonToNotification(arenaProposalNotifId,I18n.getUiText("ui.common.refuse"),"ArenaFightAnswerAction",[grpafpmsg.fightId,false],true,130);
               NotificationManager.getInstance().addButtonToNotification(arenaProposalNotifId,I18n.getUiText("ui.common.accept"),"ArenaFightAnswerAction",[grpafpmsg.fightId,true],false,130);
               NotificationManager.getInstance().addCallbackToNotification(arenaProposalNotifId,"ArenaFightAnswerAction",[grpafpmsg.fightId,false]);
               NotificationManager.getInstance().sendNotification(arenaProposalNotifId);
               KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_FIGHT,grpafpmsg.duration * 1000);
               return true;
            case msg is ArenaFightAnswerAction:
               afaa = msg as ArenaFightAnswerAction;
               grpafamsg = new GameRolePlayArenaFightAnswerMessage();
               grpafamsg.initGameRolePlayArenaFightAnswerMessage(afaa.fightId,afaa.accept);
               ConnectionsHandler.getConnection().send(grpafamsg);
               return true;
            case msg is GameRolePlayArenaFighterStatusMessage:
               grpafsmsg = msg as GameRolePlayArenaFighterStatusMessage;
               if(!grpafsmsg.accepted)
               {
                  if(grpafsmsg.playerId == PlayedCharacterManager.getInstance().id)
                  {
                     this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_UNREGISTER;
                     this._isArenaRegistered = false;
                  }
                  else
                  {
                     this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_REGISTRED;
                  }
                  NotificationManager.getInstance().closeNotification("fightProposition_" + grpafsmsg.fightId,true);
                  this._arenaReadyPartyMemberIds = new Array();
                  this._arenaAlliesIds = new Array();
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate,this._isArenaRegistered,this._arenaCurrentStatus);
               }
               else
               {
                  this._arenaReadyPartyMemberIds.push(grpafsmsg.playerId);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaFighterStatusUpdate,grpafsmsg.playerId,grpafsmsg.accepted);
               return true;
            case msg is ArenaFightAnswerAcknowledgementMessage:
               if((msg as ArenaFightAnswerAcknowledgementMessage).acknowledged)
               {
                  NotificationManager.getInstance().closeNotification(this._arenaProposalNotifName,true);
               }
               return true;
            case msg is GameRolePlayArenaUpdatePlayerInfosMessage:
               grpaupimsg = msg as GameRolePlayArenaUpdatePlayerInfosMessage;
               this._banEndDate = grpaupimsg.banEndDate;
               for each(rankInfo in grpaupimsg.arenaRanks)
               {
                  this._arenaRanksInformation[rankInfo.arenaType] = ArenaRankInfosWrapper.create(rankInfo);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaUpdateRank,this._arenaRanksInformation);
               return true;
            case msg is ArenaXpSwitchModeAction:
               this._xpActivated = (msg as ArenaXpSwitchModeAction).xpActivated;
               StoreDataManager.getInstance().setData(DATASTORE_PARTY,DATA_XP_ACTIVATED,this._xpActivated);
               this.sendArenaXpSwitchMessage();
               return true;
            case msg is GameFightJoinMessage:
               gfjmsg = msg as GameFightJoinMessage;
               if(gfjmsg.fightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA && !(gfjmsg is GameFightSpectatorJoinMessage))
               {
                  this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT;
                  this._isArenaRegistered = false;
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate,this._isArenaRegistered,this._arenaCurrentStatus);
                  this.clearUis();
               }
               this._wasSpectatorInLastFight = gfjmsg is GameFightSpectatorJoinMessage;
               this.cleanPartyFightNotifications();
               return false;
            case msg is FightEndingMessage:
               femsg = msg as FightEndingMessage;
               if(this._lastFightType == FightTypeEnum.FIGHT_TYPE_PVP_ARENA && !this._wasSpectatorInLastFight)
               {
                  this._arenaCurrentStatus = PvpArenaStepEnum.ARENA_STEP_UNREGISTER;
                  this._isArenaRegistered = false;
                  this._arenaReadyPartyMemberIds = new Array();
                  KernelEventsManager.getInstance().processCallback(RoleplayHookList.ArenaRegistrationStatusUpdate,this._isArenaRegistered,this._arenaCurrentStatus);
                  if(this._arenaLeader && PlayedCharacterManager.getInstance().id == this._arenaLeader.id && this._currentArenaType != 0)
                  {
                     commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     commonMod.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.party.arenaPopupReinscription"),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[this.reinscriptionWantedFunction,null],this.reinscriptionWantedFunction,function():void
                     {
                     });
                  }
               }
               return true;
            case msg is GameRolePlayArenaLeagueRewardsMessage:
               grpalrmsg = msg as GameRolePlayArenaLeagueRewardsMessage;
               this._playerShouldReceiveRewards = true;
               this._playerRewards = grpalrmsg;
               return true;
            case msg is GameRolePlayArenaPlayerBehavioursMessage:
               grpapbmsg = msg as GameRolePlayArenaPlayerBehavioursMessage;
               if(grpapbmsg.flags.length || grpapbmsg.sanctions.length)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.KISPreventAndSanctionPopup,grpapbmsg.flags,grpapbmsg.sanctions,grpapbmsg.banDuration);
               }
               return true;
            case msg is GameRolePlayArenaRegistrationWarningMessage:
               grparwmsg = msg as GameRolePlayArenaRegistrationWarningMessage;
               KernelEventsManager.getInstance().processCallback(HookList.KISMissingEquipementWarning,[grparwmsg.battleMode]);
               return true;
            case msg is PartyMemberInBreachFightMessage:
               if(!PlayedCharacterManager.getInstance().isFighting)
               {
                  pmibfm = msg as PartyMemberInBreachFightMessage;
                  breachFightCause = I18n.getUiText("ui.party.memberStartFightInBreach");
                  breachFightId = pmibfm.fightId;
                  breachMemberName = pmibfm.memberName;
                  breachFightMapId = pmibfm.floor + "-" + pmibfm.room;
                  breachFightInformation = new PartyFightInformationsData(-1,breachFightId,breachMemberName,pmibfm.memberId,pmibfm.timeBeforeFightStart * 100);
                  breachFightInformation.timeUntilFightbegin.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFightStartTimerComplete);
                  breachFightInformation.timeUntilFightbegin.start();
                  if(!this._partyFightsInformations[breachFightMapId])
                  {
                     this._partyFightsInformations[breachFightMapId] = new Array();
                  }
                  this._partyFightsInformations[breachFightMapId].push(breachFightInformation);
                  breachChannel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                  breachTimestamp = TimeManager.getInstance().getTimestamp();
                  breachParams = new Array();
                  breachParams.push(breachMemberName);
                  breachParams.push(pmibfm.memberId);
                  breachParams.push({
                     "floor":pmibfm.floor,
                     "room":pmibfm.room
                  });
                  breachPartyFightMsg = ParamsDecoder.applyParams(breachFightCause,breachParams);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,breachPartyFightMsg,breachChannel,breachTimestamp,false);
                  if(PlayedCharacterManager.getInstance().isInBreach)
                  {
                     breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
                     if(breachFrame.floor == pmibfm.floor && breachFrame.room == pmibfm.room)
                     {
                        breachEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                        breachFight = breachEntitiesFrame.fights[breachFightInformation.fightId];
                        if(!breachFight)
                        {
                           return true;
                        }
                        breachFoundLeader = false;
                        for each(breachTeam in breachFight.teams)
                        {
                           for each(breachFightTeamMember in breachTeam.teamInfos.teamMembers)
                           {
                              if(breachFightTeamMember.id == breachFightInformation.memberId)
                              {
                                 breachFightTeamLeaderId = breachTeam.teamInfos.leaderId;
                                 breachFoundLeader = true;
                                 break;
                              }
                              if(breachFoundLeader)
                              {
                                 break;
                              }
                           }
                        }
                        this.createPartyFightNotification(-1,breachFightInformation,breachFightTeamLeaderId);
                     }
                  }
               }
               return true;
            case msg is PartyMemberInStandardFightMessage:
               if(!PlayedCharacterManager.getInstance().isFighting)
               {
                  pemifmmsg = msg as PartyMemberInStandardFightMessage;
                  notifName = null;
                  switch(pemifmmsg.reason)
                  {
                     case 1:
                        fightCause = I18n.getUiText("ui.party.memberStartFight.monsterAttack");
                        break;
                     case 2:
                        fightCause = I18n.getUiText("ui.party.memberStartFight.playerAttack");
                        break;
                     case 3:
                        fightCause = I18n.getUiText("ui.party.memberStartFight.attackPlayer");
                        break;
                     case 4:
                        notifName = "partyFight" + pemifmmsg.fightId + pemifmmsg.memberName;
                        break;
                     default:
                        fightCause = I18n.getUiText("ui.party.memberStartFight.unknownReason");
                  }
                  fightId = pemifmmsg.fightId;
                  memberName = pemifmmsg.memberName;
                  fightMapId = pemifmmsg.fightMap.mapId;
                  fightInformation = new PartyFightInformationsData(fightMapId,fightId,memberName,pemifmmsg.memberId,pemifmmsg.timeBeforeFightStart * 100);
                  fightInformation.timeUntilFightbegin.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFightStartTimerComplete);
                  fightInformation.timeUntilFightbegin.start();
                  if(!this._partyFightsInformations[fightMapId])
                  {
                     this._partyFightsInformations[fightMapId] = new Array();
                  }
                  this._partyFightsInformations[fightMapId].push(fightInformation);
                  channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                  timestamp = TimeManager.getInstance().getTimestamp();
                  params = new Array();
                  params.push(memberName);
                  params.push(pemifmmsg.memberId);
                  params.push(fightMapId);
                  if(fightCause)
                  {
                     partyFightMsg = ParamsDecoder.applyParams(fightCause,params);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,partyFightMsg,channel,timestamp,false);
                  }
                  if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.PARTY_FIGHT_START))
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.PARTY_FIGHT_START,[memberName,fightMapId]);
                  }
                  if(PlayedCharacterManager.getInstance().currentMap.mapId == fightMapId)
                  {
                     entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                     fight = entitiesFrame.fights[fightInformation.fightId];
                     notifKey = pemifmmsg.reason == 4 ? "ui.party.teamFightChallengeTitle" : "ui.party.teamFightTitle";
                     if(!fight)
                     {
                        return true;
                     }
                     foundLeader = false;
                     for each(team in fight.teams)
                     {
                        for each(fightTeamMember in team.teamInfos.teamMembers)
                        {
                           if(fightTeamMember.id == fightInformation.memberId)
                           {
                              fightTeamLeaderId = team.teamInfos.leaderId;
                              foundLeader = true;
                              break;
                           }
                           if(foundLeader)
                           {
                              break;
                           }
                        }
                     }
                     this.createPartyFightNotification(fightMapId,fightInformation,fightTeamLeaderId,notifKey,notifName);
                  }
               }
               return true;
            case msg is MapComplementaryInformationsDataMessage:
               this.cleanPartyFightNotifications();
               foundFight = false;
               leaderId = -1;
               if(msg is MapComplementaryInformationsBreachMessage)
               {
                  mcidm = msg as MapComplementaryInformationsBreachMessage;
                  mapId = MapComplementaryInformationsBreachMessage(mcidm).floor + "-" + MapComplementaryInformationsBreachMessage(mcidm).room;
               }
               else
               {
                  mcidm = msg as MapComplementaryInformationsDataMessage;
                  mapId = mcidm.mapId;
               }
               if(this._partyFightsInformations)
               {
                  if(this._partyFightsInformations[mapId])
                  {
                     for each(partyFight in this._partyFightsInformations[mapId])
                     {
                        for each(mapFight in mcidm.fights)
                        {
                           if(mapFight.fightId == partyFight.fightId)
                           {
                              foundFight = true;
                              fightTeams = mapFight.fightTeams;
                              for each(fti in fightTeams)
                              {
                                 for each(teamMember in fti.teamMembers)
                                 {
                                    if(teamMember.id == partyFight.memberId)
                                    {
                                       leaderId = fti.leaderId;
                                    }
                                 }
                              }
                              break;
                           }
                        }
                     }
                     if(foundFight)
                     {
                        this.createPartyFightNotification(mapId,partyFight,leaderId);
                     }
                     else
                     {
                        this.deletePartyFightInformation(mapId,partyFight);
                     }
                  }
               }
               return false;
            case msg is GameRolePlayRemoveChallengeMessage:
               grpcm = msg as GameRolePlayRemoveChallengeMessage;
               fightNotificationIndex = this._partyFightNotification.indexOf("partyFight" + grpcm.fightId);
               if(fightNotificationIndex > -1)
               {
                  NotificationManager.getInstance().closeNotification(this._partyFightNotification[fightNotificationIndex],false);
               }
               return false;
            case msg is BreachInvitationOfferMessage:
               biom = msg as BreachInvitationOfferMessage;
               if(ExternalNotificationManager.getInstance().canAddExternalNotification(ExternalNotificationTypeEnum.BREACH_INVITATION))
               {
                  KernelEventsManager.getInstance().processCallback(HookList.ExternalNotification,ExternalNotificationTypeEnum.BREACH_INVITATION,[biom.host.name]);
               }
               biomsgNid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText("ui.breach.playerInvitation",[biom.host.name]),NotificationTypeEnum.INVITATION,"breachInvit_" + biom.host.id);
               NotificationManager.getInstance().addTimerToNotification(biomsgNid,biom.timeLeftBeforeCancel,false,false,false);
               NotificationManager.getInstance().addButtonToNotification(biomsgNid,I18n.getUiText("ui.common.accept"),"BreachInvitationAnswerAction",[true],false);
               NotificationManager.getInstance().addCallbackToNotification(biomsgNid,"BreachInvitationAnswerAction",[false]);
               NotificationManager.getInstance().sendNotification(biomsgNid);
               return true;
            case msg is BreachInvitationAnswerAction:
               biaa = msg as BreachInvitationAnswerAction;
               biam = new BreachInvitationAnswerMessage();
               if(biaa.answer)
               {
                  ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               }
               biam.initBreachInvitationAnswerMessage(biaa.answer);
               ConnectionsHandler.getConnection().send(biam);
               return true;
            case msg is BreachInvitationCloseMessage:
               bicmsg = msg as BreachInvitationCloseMessage;
               NotificationManager.getInstance().closeNotification("breachInvit_" + bicmsg.host.id);
               return true;
            case msg is GroupTeleportPlayerOfferMessage:
               gtpomsg = msg as GroupTeleportPlayerOfferMessage;
               notificationManager = NotificationManager.getInstance();
               notifId = notificationManager.prepareNotification(I18n.getUiText("ui.common.invitation"),I18n.getUiText("ui.teleport.groupTeleportMessage",[HyperlinkShowPlayerMenuManager.getLink(gtpomsg.requesterId,gtpomsg.requesterName),HyperlinkMapPosition.getLink(gtpomsg.worldX,gtpomsg.worldY,gtpomsg.mapId)]),NotificationTypeEnum.INVITATION,GROUP_TELEPORT_PLAYER_OFFER_POPUP_PREFIX + gtpomsg.requesterId.toString() + "_" + gtpomsg.mapId.toString());
               NotificationManager.getInstance().addButtonToNotification(notifId,I18n.getUiText("ui.common.refuse"),"GroupTeleportPlayerOfferReplyAction",[gtpomsg.requesterId,false],false);
               NotificationManager.getInstance().addButtonToNotification(notifId,I18n.getUiText("ui.common.accept"),"GroupTeleportPlayerOfferReplyAction",[gtpomsg.requesterId,true],false,130);
               NotificationManager.getInstance().sendNotification(notifId);
               return true;
            case msg is GroupTeleportPlayerCloseMessage:
               gtpcmsg = msg as GroupTeleportPlayerCloseMessage;
               NotificationManager.getInstance().closeNotification(GROUP_TELEPORT_PLAYER_OFFER_POPUP_PREFIX + gtpcmsg.requesterId.toString() + "_" + gtpcmsg.mapId.toString());
               return true;
            case msg is GroupTeleportPlayerOfferReplyAction:
               replyMsg = new GroupTeleportPlayerAnswerMessage();
               gtporaction = msg as GroupTeleportPlayerOfferReplyAction;
               replyMsg.initGroupTeleportPlayerAnswerMessage(gtporaction.isTeleport,gtporaction.requesterId);
               ConnectionsHandler.getConnection().send(replyMsg);
               return true;
            default:
               return false;
         }
      }
      
      private function sendArenaXpSwitchMessage() : void
      {
         var saxrmmsg:SwitchArenaXpRewardsModeMessage = new SwitchArenaXpRewardsModeMessage();
         saxrmmsg.initSwitchArenaXpRewardsModeMessage(this._xpActivated);
         ConnectionsHandler.getConnection().send(saxrmmsg);
      }
      
      private function cleanPartyFightNotifications() : void
      {
         var notifName:String = null;
         if(this._partyFightNotification.length > 0)
         {
            for each(notifName in this._partyFightNotification)
            {
               NotificationManager.getInstance().closeNotification(notifName,false);
            }
            this._partyFightNotification = new Array();
         }
      }
      
      private function clearUis() : void
      {
         if(Berilia.getInstance().getUi(UIEnum.AUCTIONHOUSE))
         {
            Berilia.getInstance().unloadUi(UIEnum.AUCTIONHOUSE);
         }
         if(Berilia.getInstance().getUi(UIEnum.PVP_ARENA))
         {
            Berilia.getInstance().unloadUi(UIEnum.PVP_ARENA);
         }
         if(Berilia.getInstance().getUi(UIEnum.WEB_BASE))
         {
            Berilia.getInstance().unloadUi(UIEnum.WEB_BASE);
         }
         if(Berilia.getInstance().getUi(UIEnum.CRAFTER_LIST))
         {
            Berilia.getInstance().unloadUi(UIEnum.CRAFTER_LIST);
         }
         if(Berilia.getInstance().getUi(UIEnum.PRISM_MODULE_UI))
         {
            Berilia.getInstance().unloadUi(UIEnum.PRISM_MODULE_UI);
         }
         if(Berilia.getInstance().getUi(UIEnum.NPC_STOCK))
         {
            Berilia.getInstance().unloadUi(UIEnum.NPC_STOCK);
         }
         if(Berilia.getInstance().getUi(UIEnum.NPC_ITEM))
         {
            Berilia.getInstance().unloadUi(UIEnum.NPC_ITEM);
         }
      }
      
      private function createPartyFightNotification(mapId:Number, currentFight:PartyFightInformationsData, fightTeamLeaderId:Number, notifTitleKey:String = "ui.party.teamFightTitle", notifName:String = null) : void
      {
         var notifBaseText:String = I18n.getUiText("ui.party.joinTeamFightQuestion");
         var params:Array = new Array();
         params.push(currentFight.memberName);
         params.push(currentFight.memberId);
         var notifText:String = ParamsDecoder.applyParams(notifBaseText,params);
         var pfimsgNid:uint = NotificationManager.getInstance().prepareNotification(I18n.getUiText(notifTitleKey),notifText,NotificationTypeEnum.PRIORITY_INVITATION,!!notifName ? notifName : "partyFight" + currentFight.fightId);
         var currentDate:Date = new Date();
         var timeTillHiding:int = (currentFight.fightStartDate - currentDate.getTime()) / 1000;
         if(timeTillHiding > 0)
         {
            NotificationManager.getInstance().addTimerToNotification(pfimsgNid,timeTillHiding,false,false,false);
         }
         NotificationManager.getInstance().addButtonToNotification(pfimsgNid,I18n.getUiText("ui.common.join"),"JoinFightRequestAction",[currentFight.fightId,fightTeamLeaderId],false,130);
         this._partyFightNotification.push(!!notifName ? notifName : "partyFight" + currentFight.fightId);
         NotificationManager.getInstance().sendNotification(pfimsgNid);
      }
      
      public function pulled() : Boolean
      {
         this._timerRegen.stop();
         this._timerRegen.removeEventListener(TimerEvent.TIMER,this.onTimerTick);
         this._timerRegen = null;
         return true;
      }
      
      public function reinscriptionWantedFunction() : void
      {
         var action:ArenaRegisterAction = new ArenaRegisterAction();
         action.fightTypeId = this._currentArenaType;
         this.process(action);
      }
      
      public function getGroupMemberById(id:Number) : PartyMemberWrapper
      {
         var m:PartyMemberWrapper = null;
         for each(m in this._partyMembers)
         {
            if(m.id == id)
            {
               return m;
            }
         }
         return null;
      }
      
      private function deleteParty(partyId:int) : void
      {
         var isArena:Boolean = false;
         if(partyId == this._arenaPartyId)
         {
            isArena = true;
            this._arenaPartyMembers = new Vector.<PartyMemberWrapper>();
            this._arenaPartyId = 0;
            this._arenaLeader = null;
         }
         else if(partyId == this._partyId)
         {
            this._partyMembers = new Vector.<PartyMemberWrapper>();
            this._partyId = 0;
         }
         if(this._arenaPartyMembers.length == 0 && this._partyMembers.length == 0)
         {
            this._timerRegen.stop();
            PlayedCharacterManager.getInstance().isInParty = false;
            PlayedCharacterManager.getInstance().isPartyLeader = false;
         }
         KernelEventsManager.getInstance().processCallback(HookList.PartyLeave,partyId,isArena);
      }
      
      private function createPartyPlayerContextMenu(pPlayerId:Number, pPartyId:int) : Object
      {
         var playerAlignmentInfos:ActorAlignmentInformations = null;
         var member:PartyMemberWrapper = null;
         var restrictionInfo:ActorRestrictionsInformations = null;
         var entityId:Number = NaN;
         var playerName:String = "";
         var socialApi:SocialApi = new SocialApi();
         var playerIsOnSameMap:Boolean = false;
         if(pPartyId == this._arenaPartyId)
         {
            for each(member in this._arenaPartyMembers)
            {
               if(member.id == pPlayerId)
               {
                  playerName = member.name;
               }
            }
         }
         else if(pPartyId == this._partyId)
         {
            for each(member in this._partyMembers)
            {
               if(member.id == pPlayerId)
               {
                  playerName = member.name;
               }
            }
         }
         if(playerName == "")
         {
            return null;
         }
         if(this.roleplayEntitiesFrame)
         {
            for each(entityId in this.roleplayEntitiesFrame.playersId)
            {
               if(entityId == pPlayerId)
               {
                  playerIsOnSameMap = true;
                  if(this.roleplayEntitiesFrame.getEntityInfos(entityId) is GameRolePlayCharacterInformations)
                  {
                     playerAlignmentInfos = (this.roleplayEntitiesFrame.getEntityInfos(entityId) as GameRolePlayCharacterInformations).alignmentInfos;
                     restrictionInfo = (this.roleplayEntitiesFrame.getEntityInfos(entityId) as GameRolePlayCharacterInformations).humanoidInfo.restrictions;
                  }
               }
            }
         }
         return MenusFactory.create({
            "id":pPlayerId,
            "name":playerName,
            "onSameMap":playerIsOnSameMap,
            "alignmentInfos":playerAlignmentInfos,
            "cantBeChallenged":restrictionInfo && restrictionInfo.cantChallenge,
            "cantExchange":restrictionInfo && restrictionInfo.cantExchange
         },"partyMember",pPartyId);
      }
      
      private function onTimerTick(pEvent:TimerEvent) : void
      {
         var member:PartyMemberWrapper = null;
         var companionMember:PartyCompanionWrapper = null;
         var playerLPTM:LifePointTickManager = null;
         var additionalLifePoint:uint = 0;
         var newLifePoints:uint = 0;
         var index:* = undefined;
         var lptm:LifePointTickManager = null;
         var playerLPTM2:LifePointTickManager = null;
         var additionalLifePoint2:uint = 0;
         var newLifePoints2:uint = 0;
         var lptm2:LifePointTickManager = null;
         for each(member in this._partyMembers)
         {
            if(member.lifePoints < member.maxLifePoints && member.regenRate > 0)
            {
               if(this._dicRegen[member.id] == null)
               {
                  lptm = new LifePointTickManager();
                  lptm.originalLifePoint = member.lifePoints;
                  lptm.regenRate = member.regenRate;
                  lptm.tickNumber = 1;
                  this._dicRegen[member.id] = lptm;
               }
               playerLPTM = this._dicRegen[member.id] as LifePointTickManager;
               additionalLifePoint = Math.floor(playerLPTM.tickNumber * (10 / playerLPTM.regenRate));
               newLifePoints = playerLPTM.originalLifePoint + additionalLifePoint;
               if(newLifePoints >= member.maxLifePoints)
               {
                  newLifePoints = member.maxLifePoints;
               }
               member.lifePoints = newLifePoints;
               ++playerLPTM.tickNumber;
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberLifeUpdate,this._partyId,member.id,member.lifePoints,member.initiative);
               for(index in member.companions)
               {
                  member.companions[index].lifePoints = member.companions[index].maxLifePoints * (member.lifePoints / member.maxLifePoints);
                  KernelEventsManager.getInstance().processCallback(HookList.PartyCompanionMemberUpdate,this._partyId,member.companions[index].id,int(index),member.companions[index]);
               }
            }
         }
         for each(member in this._arenaPartyMembers)
         {
            if(member.lifePoints < member.maxLifePoints && member.regenRate > 0)
            {
               if(this._dicRegenArena[member.id] == null)
               {
                  lptm2 = new LifePointTickManager();
                  lptm2.originalLifePoint = member.lifePoints;
                  lptm2.regenRate = member.regenRate;
                  lptm2.tickNumber = 1;
                  this._dicRegenArena[member.id] = lptm2;
               }
               playerLPTM2 = this._dicRegenArena[member.id] as LifePointTickManager;
               additionalLifePoint2 = Math.floor(playerLPTM2.tickNumber * (10 / playerLPTM2.regenRate));
               newLifePoints2 = playerLPTM2.originalLifePoint + additionalLifePoint2;
               if(newLifePoints2 >= member.maxLifePoints)
               {
                  newLifePoints2 = member.maxLifePoints;
               }
               member.lifePoints = newLifePoints2;
               ++playerLPTM2.tickNumber;
               KernelEventsManager.getInstance().processCallback(HookList.PartyMemberLifeUpdate,this._arenaPartyId,member.id,member.lifePoints,member.initiative);
            }
         }
      }
      
      private function onFightStartTimerComplete(pEvent:TimerEvent) : void
      {
         var key:* = null;
         var fight:PartyFightInformationsData = null;
         for(key in this._partyFightsInformations)
         {
            for each(fight in this._partyFightsInformations[key])
            {
               if(fight.timeUntilFightbegin == pEvent.currentTarget)
               {
                  this.deletePartyFightInformation(key,fight);
                  return;
               }
            }
         }
      }
      
      private function deletePartyFightInformation(key:Object, fight:PartyFightInformationsData) : void
      {
         if(!fight || !fight.timeUntilFightbegin)
         {
            return;
         }
         fight.timeUntilFightbegin.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFightStartTimerComplete);
         if(this._partyFightsInformations[key] && this._partyFightsInformations[key].length > 1)
         {
            this._partyFightsInformations[key].splice(this._partyFightsInformations[key].indexOf(fight));
         }
         else
         {
            delete this._partyFightsInformations[key];
         }
      }
      
      public function teleportWantedFunction() : void
      {
         var action:TeleportBuddiesAnswerAction = new TeleportBuddiesAnswerAction();
         action.accept = true;
         this._teleportBuddiesDialogFrame.process(action);
      }
      
      public function teleportUnwantedFunction() : void
      {
         var action:TeleportBuddiesAnswerAction = new TeleportBuddiesAnswerAction();
         action.accept = false;
         this._teleportBuddiesDialogFrame.process(action);
      }
   }
}

import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
import com.ankamagames.tiphon.types.look.TiphonEntityLook;

class PartyMember
{
    
   
   public var isLeader:Boolean = false;
   
   public var infos:PartyMemberInformations;
   
   public var skin:TiphonEntityLook;
   
   public var skinModified:Boolean = false;
   
   function PartyMember()
   {
      super();
   }
}

class LifePointTickManager
{
    
   
   public var originalLifePoint:uint;
   
   public var regenRate:uint;
   
   public var tickNumber:uint;
   
   function LifePointTickManager()
   {
      super();
   }
}

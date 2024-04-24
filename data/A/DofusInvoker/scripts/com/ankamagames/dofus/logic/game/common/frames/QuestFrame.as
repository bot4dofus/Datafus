package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
   import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.TreasureHuntStepWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.TreasureHuntWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowPlayerMenuManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.FollowQuestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationUpdateFlagAction;
   import com.ankamagames.dofus.logic.game.common.actions.RefreshFollowedQuestsOrderAction;
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
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntDigRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntFlagRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntGiveUpRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntLegendaryRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdProtocol;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntDigRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntFlagRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntFlagStateEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntRequestEnum;
   import com.ankamagames.dofus.network.enums.TreasureHuntTypeEnum;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementAlmostFinishedDetailedListMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementAlmostFinishedDetailedListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailedListMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailedListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailsMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementDetailsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementFinishedInformationMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementFinishedMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementListMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardErrorMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardRequestMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementRewardSuccessMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementsPioneerRanksMessage;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementsPioneerRanksRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.notification.NotificationResetMessage;
   import com.ankamagames.dofus.network.messages.game.context.notification.NotificationUpdateFlagMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.FollowQuestObjectiveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.FollowedQuestsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.GuidedModeQuitRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.GuidedModeReturnRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestObjectiveValidatedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestObjectiveValidationMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStartRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStartedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepInfoMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepInfoRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepStartedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestStepValidatedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestValidatedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.RefreshFollowedQuestsOrderRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.UnfollowQuestObjectiveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.WatchQuestListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.WatchQuestStepInfoMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.WatchQuestStepInfoRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntAvailableRetryCountUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestAnswerFailedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntDigRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFinishedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRemoveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRequestAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntFlagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntGiveUpRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntLegendaryRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntRequestAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt.TreasureHuntShowLegendaryUIMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectAddedMessage;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementPioneerRank;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveDetailedInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestObjectiveInformationsWithCompletion;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.DictionaryUtils;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class QuestFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(QuestFrame));
      
      protected static const FIRST_TEMPORIS_REWARD_ACHIEVEMENT_ID:int = 2903;
      
      protected static const FIRST_TEMPORIS_COMPANION_REWARD_ACHIEVEMENT_ID:int = 2906;
      
      protected static const TEMPORIS_ACHIEVEMENT_STARTER_ONE:int = 7000;
      
      protected static const TEMPORIS_ACHIEVEMENT_STARTER_TWO:int = 7002;
      
      protected static const TEMPORIS_ACHIEVEMENT_STARTER_THREE:int = 7004;
      
      protected static const TEMPORIS_ACHIEVEMENT_STARTER_FOUR:int = 7006;
      
      private static const TEMPORIS_CATEGORY:uint = 107;
      
      private static const KOLIZEUM_CATEGORY_ID:uint = 153;
      
      private static const EXPEDITION_ACHIEVEMENT_CATEGORY_ID:uint = 136;
      
      private static const STORAGE_NEW_REWARD:String = "storageNewReward";
      
      public static var notificationList:Array;
       
      
      private var _nbAllAchievements:int;
      
      private var _activeQuests:Vector.<QuestActiveInformations>;
      
      private var _completedQuests:Vector.<uint>;
      
      private var _reinitDoneQuests:Vector.<uint>;
      
      private var _followedQuests:Vector.<uint>;
      
      private var _questsInformations:Dictionary;
      
      private var _finishedAchievements:Vector.<AchievementAchieved>;
      
      private var _activeObjectives:Vector.<uint>;
      
      private var _completedObjectives:Vector.<uint>;
      
      private var _finishedAccountAchievementIds:Array;
      
      private var _finishedCharacterAchievementIds:Array;
      
      private var _finishedCharacterAchievementByIds:Dictionary;
      
      private var _rewardableAchievements:Vector.<AchievementAchievedRewardable>;
      
      private var _rewardableAchievementsVisible:Boolean;
      
      private var _pioneerRanks:Dictionary;
      
      private var _treasureHunts:Dictionary;
      
      private var _flagColors:Array;
      
      private var _followedQuestsCallback:Callback;
      
      private var _achievementsFinishedCache:Array = null;
      
      private var _achievementsList:AchievementListMessage;
      
      private var _achievementsListProcessed:Boolean = false;
      
      public function QuestFrame()
      {
         this._followedQuests = new Vector.<uint>();
         this._questsInformations = new Dictionary();
         this._activeObjectives = new Vector.<uint>();
         this._completedObjectives = new Vector.<uint>();
         this._finishedCharacterAchievementByIds = new Dictionary();
         this._pioneerRanks = new Dictionary();
         this._treasureHunts = new Dictionary();
         this._flagColors = new Array();
         super();
      }
      
      private static function displayFinishedAchievementInChat(finishedAchievement:Achievement, isTemporis:Boolean = false) : void
      {
         var itemAwardIndex:uint = 0;
         var itemQuantity:uint = 0;
         var itemId:uint = 0;
         var spellId:uint = 0;
         var emoteId:uint = 0;
         var ornamentId:uint = 0;
         var titleId:uint = 0;
         if(finishedAchievement === null)
         {
            return;
         }
         var chatMessage:String = null;
         var currentAchievementReward:AchievementReward = null;
         var currentItemAward:ItemWrapper = null;
         var currentEmoteAward:EmoteWrapper = null;
         var currentOrnamentAward:OrnamentWrapper = null;
         var currentSpellAward:SpellWrapper = null;
         var currentTitleAward:TitleWrapper = null;
         for(var jndex:uint = 0; jndex < finishedAchievement.rewardIds.length; jndex++)
         {
            currentAchievementReward = AchievementReward.getAchievementRewardById(finishedAchievement.rewardIds[jndex]);
            if(currentAchievementReward !== null)
            {
               itemAwardIndex = 0;
               itemQuantity = 0;
               for each(itemId in currentAchievementReward.itemsReward)
               {
                  itemQuantity = currentAchievementReward.itemsQuantityReward.length > itemAwardIndex ? uint(currentAchievementReward.itemsQuantityReward[itemAwardIndex]) : uint(1);
                  currentItemAward = ItemWrapper.create(0,0,itemId,itemQuantity,new Vector.<ObjectEffect>(),false);
                  if(currentItemAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardObtained",["{item," + currentItemAward.id + "::" + currentItemAward.name + "}","{" + (!!isTemporis ? "openTemporisQuestTab" : "openArenaRewards") + "::" + I18n.getUiText("ui.temporis.getReward") + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(spellId in currentAchievementReward.spellsReward)
               {
                  currentSpellAward = SpellWrapper.create(spellId,1,false,0,false);
                  if(currentSpellAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardObtained",["{spell," + currentSpellAward.id + "," + currentSpellAward.spellLevel + "}","{openTemporisQuestTab::" + I18n.getUiText("ui.temporis.getReward") + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(emoteId in currentAchievementReward.emotesReward)
               {
                  currentEmoteAward = EmoteWrapper.create(emoteId,0);
                  if(currentEmoteAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardObtained",["{showEmote," + currentEmoteAward.id + "::" + currentEmoteAward.emote.name + "}","{openTemporisQuestTab::" + I18n.getUiText("ui.temporis.getReward") + "}","{openTemporisQuestTab::" + I18n.getUiText("ui.temporis.getReward") + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(ornamentId in currentAchievementReward.ornamentsReward)
               {
                  currentOrnamentAward = OrnamentWrapper.create(ornamentId);
                  if(currentOrnamentAward !== null)
                  {
                     chatMessage = ParamsDecoder.applyParams(I18n.getUiText("ui.temporis.rewardObtained",["$ornament%1","{openTemporisQuestTab::" + I18n.getUiText("ui.temporis.getReward") + "}"]),[currentOrnamentAward.id]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(titleId in currentAchievementReward.titlesReward)
               {
                  currentTitleAward = TitleWrapper.create(titleId);
                  if(currentTitleAward !== null)
                  {
                     chatMessage = ParamsDecoder.applyParams(I18n.getUiText("ui.temporis.rewardObtained",["$title%1","{openTemporisQuestTab::" + I18n.getUiText("ui.temporis.getReward") + "}"]),[currentTitleAward.id]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
            }
         }
      }
      
      private static function displayRewardedAchievementInChat(rewardedAchievement:Achievement) : void
      {
         var itemAwardIndex:uint = 0;
         var itemQuantity:uint = 0;
         var itemId:uint = 0;
         var spellId:uint = 0;
         var emoteId:uint = 0;
         var ornamentId:uint = 0;
         var titleId:uint = 0;
         if(rewardedAchievement === null)
         {
            return;
         }
         var chatMessage:String = null;
         var currentAchievementReward:AchievementReward = null;
         var currentItemAward:ItemWrapper = null;
         var currentEmoteAward:EmoteWrapper = null;
         var currentOrnamentAward:OrnamentWrapper = null;
         var currentSpellAward:SpellWrapper = null;
         var currentTitleAward:TitleWrapper = null;
         for(var jndex:uint = 0; jndex < rewardedAchievement.rewardIds.length; jndex++)
         {
            currentAchievementReward = AchievementReward.getAchievementRewardById(rewardedAchievement.rewardIds[jndex]);
            if(currentAchievementReward !== null)
            {
               itemAwardIndex = 0;
               itemQuantity = 0;
               for each(itemId in currentAchievementReward.itemsReward)
               {
                  itemQuantity = currentAchievementReward.itemsQuantityReward.length > itemAwardIndex ? uint(currentAchievementReward.itemsQuantityReward[itemAwardIndex]) : uint(1);
                  currentItemAward = ItemWrapper.create(0,0,itemId,itemQuantity,new Vector.<ObjectEffect>(),false);
                  if(currentItemAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardSuccess",["{item," + currentItemAward.id + "::" + currentItemAward.name + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(spellId in currentAchievementReward.spellsReward)
               {
                  currentSpellAward = SpellWrapper.create(spellId,1,false,0,false);
                  if(currentSpellAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardSuccess",["{spell," + currentSpellAward.id + "," + currentSpellAward.spellLevel + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(emoteId in currentAchievementReward.emotesReward)
               {
                  currentEmoteAward = EmoteWrapper.create(emoteId,0);
                  if(currentEmoteAward !== null)
                  {
                     chatMessage = I18n.getUiText("ui.temporis.rewardSuccess",["{showEmote," + currentEmoteAward.id + "::" + currentEmoteAward.emote.name + "}"]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(ornamentId in currentAchievementReward.ornamentsReward)
               {
                  currentOrnamentAward = OrnamentWrapper.create(ornamentId);
                  if(currentOrnamentAward !== null)
                  {
                     chatMessage = ParamsDecoder.applyParams(I18n.getUiText("ui.temporis.rewardSuccess",["$ornament%1"]),[currentOrnamentAward.id]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               for each(titleId in currentAchievementReward.titlesReward)
               {
                  currentTitleAward = TitleWrapper.create(titleId);
                  if(currentTitleAward !== null)
                  {
                     chatMessage = ParamsDecoder.applyParams(I18n.getUiText("ui.temporis.rewardSuccess",["$title%1"]),[currentTitleAward.id]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
            }
         }
      }
      
      public function get achievmentsList() : AchievementListMessage
      {
         return this._achievementsList;
      }
      
      public function get achievmentsListProcessed() : Boolean
      {
         return this._achievementsListProcessed;
      }
      
      public function get followedQuestsCallback() : Callback
      {
         return this._followedQuestsCallback;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get finishedAchievements() : Vector.<AchievementAchieved>
      {
         return this._finishedAchievements;
      }
      
      public function get finishedAccountAchievementIds() : Array
      {
         return this._finishedAccountAchievementIds;
      }
      
      public function get finishedCharacterAchievementIds() : Array
      {
         return this._finishedCharacterAchievementIds;
      }
      
      public function get finishedCharacterAchievementByIds() : Dictionary
      {
         return this._finishedCharacterAchievementByIds;
      }
      
      public function get achievementPioneerRanks() : Dictionary
      {
         return this._pioneerRanks;
      }
      
      public function getActiveQuests() : Vector.<QuestActiveInformations>
      {
         return this._activeQuests;
      }
      
      public function getCompletedQuests() : Vector.<uint>
      {
         return this._completedQuests;
      }
      
      public function getReinitDoneQuests() : Vector.<uint>
      {
         return this._reinitDoneQuests;
      }
      
      public function getFollowedQuests() : Vector.<uint>
      {
         return this._followedQuests;
      }
      
      public function getQuestInformations(questId:uint) : Object
      {
         return this._questsInformations[questId];
      }
      
      public function getActiveObjectives() : Vector.<uint>
      {
         return this._activeObjectives;
      }
      
      public function getCompletedObjectives() : Vector.<uint>
      {
         return this._completedObjectives;
      }
      
      public function get rewardableAchievements() : Vector.<AchievementAchievedRewardable>
      {
         return this._rewardableAchievements;
      }
      
      public function getTreasureHuntById(typeId:uint) : TreasureHuntWrapper
      {
         return this._treasureHunts[typeId];
      }
      
      public function pushed() : Boolean
      {
         this._rewardableAchievements = new Vector.<AchievementAchievedRewardable>();
         this._finishedAchievements = new Vector.<AchievementAchieved>();
         this._finishedAccountAchievementIds = new Array();
         this._finishedCharacterAchievementIds = new Array();
         this._treasureHunts = new Dictionary();
         this._nbAllAchievements = Achievement.getAchievements().length;
         this._achievementsList = new AchievementListMessage();
         this._achievementsList.initAchievementListMessage(new Vector.<AchievementAchieved>());
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_UNKNOWN] = XmlConfig.getInstance().getEntry("colors.flag.unknown");
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_OK] = XmlConfig.getInstance().getEntry("colors.flag.right");
         this._flagColors[TreasureHuntFlagStateEnum.TREASURE_HUNT_FLAG_STATE_WRONG] = XmlConfig.getInstance().getEntry("colors.flag.wrong");
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var aca:AuthorizedCommandAction = null;
         var qlrmsg:QuestListRequestMessage = null;
         var wqlmsg:WatchQuestListMessage = null;
         var activeQuests:Vector.<QuestActiveInformations> = null;
         var completedQuests:Vector.<uint> = null;
         var module:UiModule = null;
         var qlmsg:QuestListMessage = null;
         var qira:QuestInfosRequestAction = null;
         var qsirmsg:QuestStepInfoRequestMessage = null;
         var wqira:WatchQuestInfosRequestAction = null;
         var wqsirmsg:WatchQuestStepInfoRequestMessage = null;
         var wqsim:WatchQuestStepInfoMessage = null;
         var qsimsg:QuestStepInfoMessage = null;
         var questAlreadyInArray:Boolean = false;
         var qsra:QuestStartRequestAction = null;
         var qsrmsg:QuestStartRequestMessage = null;
         var qova:QuestObjectiveValidationAction = null;
         var qovmsg:QuestObjectiveValidationMessage = null;
         var gmrrmsg:GuidedModeReturnRequestMessage = null;
         var gmqrmsg:GuidedModeQuitRequestMessage = null;
         var qsmsg:QuestStartedMessage = null;
         var qvmsg:QuestValidatedMessage = null;
         var questValidated:Quest = null;
         var qovmsg2:QuestObjectiveValidatedMessage = null;
         var qsvmsg:QuestStepValidatedMessage = null;
         var objectivesIds:Object = null;
         var qssmsg:QuestStepStartedMessage = null;
         var fqa:FollowQuestAction = null;
         var questIndex:int = 0;
         var rfqoa:RefreshFollowedQuestsOrderAction = null;
         var rfqormsg:RefreshFollowedQuestsOrderRequestMessage = null;
         var fqmsg:FollowedQuestsMessage = null;
         var followedQuests:Array = null;
         var j:int = 0;
         var k:int = 0;
         var numQuests:uint = 0;
         var mod:UiModule = null;
         var dst:DataStoreType = null;
         var questListMinimized:Boolean = false;
         var oamsg:ObjectAddedMessage = null;
         var oeff:ObjectEffect = null;
         var nufa:NotificationUpdateFlagAction = null;
         var nufmsg:NotificationUpdateFlagMessage = null;
         var nrmsg:NotificationResetMessage = null;
         var player:PlayedCharacterManager = null;
         var adlra:AchievementDetailedListRequestAction = null;
         var adlrmsg:AchievementDetailedListRequestMessage = null;
         var adlmsg:AchievementDetailedListMessage = null;
         var aafdlrmsg:AchievementAlmostFinishedDetailedListRequestMessage = null;
         var aafdlm:AchievementAlmostFinishedDetailedListMessage = null;
         var adra:AchievementDetailsRequestAction = null;
         var adrmsg:AchievementDetailsRequestMessage = null;
         var admsg:AchievementDetailsMessage = null;
         var afimsg:AchievementFinishedInformationMessage = null;
         var achievement:Achievement = null;
         var afmsg:AchievementFinishedMessage = null;
         var nid:uint = 0;
         var finishedAchievement:Achievement = null;
         var arra:AchievementRewardRequestAction = null;
         var arrmsg:AchievementRewardRequestMessage = null;
         var arsmsg:AchievementRewardSuccessMessage = null;
         var rewardedAchievementIndex:int = 0;
         var achievementIndex:int = 0;
         var achievementAchieved:AchievementAchieved = null;
         var rewardedAchievement:Achievement = null;
         var aremsg:AchievementRewardErrorMessage = null;
         var aprmsg:AchievementsPioneerRanksMessage = null;
         var aprrmsg:AchievementsPioneerRanksRequestMessage = null;
         var thslumsg:TreasureHuntShowLegendaryUIMessage = null;
         var thlra:TreasureHuntLegendaryRequestAction = null;
         var thlrmsg:TreasureHuntLegendaryRequestMessage = null;
         var thramsg:TreasureHuntRequestAnswerMessage = null;
         var treasureHuntRequestAnswerText:String = null;
         var thfra:TreasureHuntFlagRequestAction = null;
         var thfrmsg:TreasureHuntFlagRequestMessage = null;
         var thfrra:TreasureHuntFlagRemoveRequestAction = null;
         var thfrrmsg:TreasureHuntFlagRemoveRequestMessage = null;
         var thframsg:TreasureHuntFlagRequestAnswerMessage = null;
         var treasureHuntFlagRequestAnswerText:String = null;
         var thmsg:TreasureHuntMessage = null;
         var mp:MapPosition = null;
         var th:TreasureHuntWrapper = null;
         var i:int = 0;
         var tharcumsg:TreasureHuntAvailableRetryCountUpdateMessage = null;
         var thfmsg:TreasureHuntFinishedMessage = null;
         var thgura:TreasureHuntGiveUpRequestAction = null;
         var thgurmsg:TreasureHuntGiveUpRequestMessage = null;
         var thdra:TreasureHuntDigRequestAction = null;
         var thdrmsg:TreasureHuntDigRequestMessage = null;
         var thdramsg:TreasureHuntDigRequestAnswerMessage = null;
         var wrongFlagCount:int = 0;
         var treasureHuntDigAnswerText:String = null;
         var args:Array = null;
         var questId:uint = 0;
         var questUi:UiRootContainer = null;
         var questInfosDetailed:QuestActiveDetailedInformations = null;
         var obj:QuestObjectiveInformations = null;
         var id:uint = 0;
         var quest:Quest = null;
         var steps:Vector.<QuestStep> = null;
         var qs:QuestStep = null;
         var qai:QuestActiveInformations = null;
         var qid:uint = 0;
         var stepsInfos:QuestActiveDetailedInformations = null;
         var objective:QuestObjectiveInformations = null;
         var dialogParams:Array = null;
         var nbParams:int = 0;
         var compl:Object = null;
         var index:int = 0;
         var activeQuest:QuestActiveInformations = null;
         var step:QuestStep = null;
         var questStepObjId:int = 0;
         var stepObjId:int = 0;
         var fqor:FollowQuestObjectiveRequestMessage = null;
         var ufqor:UnfollowQuestObjectiveRequestMessage = null;
         var questParam:Object = null;
         var numObjectives:uint = 0;
         var questObjective:QuestObjective = null;
         var objectiveFlagInfos:Object = null;
         var idQuest:uint = 0;
         var questInfosRequestMsg:QuestStepInfoRequestMessage = null;
         var achievementFinishedRewardable:AchievementAchievedRewardable = null;
         var info3:String = null;
         var shortcut:* = null;
         var characterDst:DataStoreType = null;
         var companion:Companion = null;
         var param:Object = null;
         var characDst:DataStoreType = null;
         var achievementId:int = 0;
         var playerId:Number = NaN;
         var achievementFinished:Achievement = null;
         var info:String = null;
         var achievementRewardable:AchievementAchievedRewardable = null;
         var pioneerRank:AchievementPioneerRank = null;
         var l:int = 0;
         var st:TreasureHuntStepWrapper = null;
         var fl:TreasureHuntFlag = null;
         switch(true)
         {
            case msg is AuthorizedCommandAction:
               aca = msg as AuthorizedCommandAction;
               if(aca.command.indexOf("quest reset quest") == 0)
               {
                  args = aca.command.split(" ");
                  if(args.length > 3)
                  {
                     questId = parseInt(args[3]);
                     if(this._followedQuests.indexOf(questId) != -1)
                     {
                        questUi = Berilia.getInstance().getUi("questList");
                        if(questUi && questUi.uiClass)
                        {
                           questUi.uiClass.unfollowQuest(questId);
                        }
                     }
                  }
               }
               return false;
            case msg is QuestListRequestAction:
               qlrmsg = new QuestListRequestMessage();
               qlrmsg.initQuestListRequestMessage();
               ConnectionsHandler.getConnection().send(qlrmsg);
               return true;
            case msg is WatchQuestListMessage:
               wqlmsg = msg as WatchQuestListMessage;
               activeQuests = wqlmsg.activeQuests;
               completedQuests = wqlmsg.finishedQuestsIds;
               completedQuests = completedQuests.concat(wqlmsg.reinitDoneQuestsIds);
               module = UiModuleManager.getInstance().getModule("Ankama_Grimoire");
               Berilia.getInstance().loadUi(module,module.uis["watchQuestTab"],"watchQuestTab",{
                  "activeQuests":activeQuests,
                  "completedQuests":completedQuests,
                  "playerId":wqlmsg.playerId
               },false,StrataEnum.STRATA_TOP);
               return true;
            case msg is QuestListMessage:
               qlmsg = msg as QuestListMessage;
               this._activeQuests = qlmsg.activeQuests;
               this._completedQuests = qlmsg.finishedQuestsIds;
               this._completedQuests = this._completedQuests.concat(qlmsg.reinitDoneQuestsIds);
               this._reinitDoneQuests = qlmsg.reinitDoneQuestsIds;
               this._activeObjectives = new Vector.<uint>();
               this._completedObjectives = new Vector.<uint>();
               for each(questInfosDetailed in this._activeQuests)
               {
                  if(questInfosDetailed)
                  {
                     for each(obj in questInfosDetailed.objectives)
                     {
                        if(obj.objectiveStatus)
                        {
                           if(this._activeObjectives.indexOf(obj.objectiveId) == -1)
                           {
                              if(this._completedObjectives.indexOf(obj.objectiveId) != -1)
                              {
                                 this._completedObjectives.splice(this._completedObjectives.indexOf(obj.objectiveId),1);
                              }
                              this._activeObjectives.push(obj.objectiveId);
                           }
                        }
                        else if(this._completedObjectives.indexOf(obj.objectiveId) == -1)
                        {
                           if(this._activeObjectives.indexOf(obj.objectiveId) != -1)
                           {
                              this._activeObjectives.splice(this._activeObjectives.indexOf(obj.objectiveId),1);
                           }
                           this._completedObjectives.push(obj.objectiveId);
                        }
                     }
                  }
               }
               for each(id in this._completedQuests)
               {
                  quest = Quest.getQuestById(id);
                  if(quest)
                  {
                     steps = quest.steps;
                     for each(qs in steps)
                     {
                        this._completedObjectives = this._completedObjectives.concat(qs.objectiveIds);
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestListUpdated);
               return true;
            case msg is QuestInfosRequestAction:
               qira = msg as QuestInfosRequestAction;
               qsirmsg = new QuestStepInfoRequestMessage();
               qsirmsg.initQuestStepInfoRequestMessage(qira.questId);
               ConnectionsHandler.getConnection().send(qsirmsg);
               return true;
            case msg is WatchQuestInfosRequestAction:
               wqira = msg as WatchQuestInfosRequestAction;
               wqsirmsg = new WatchQuestStepInfoRequestMessage();
               wqsirmsg.initWatchQuestStepInfoRequestMessage(wqira.questId,wqira.playerId);
               ConnectionsHandler.getConnection().send(wqsirmsg);
               return true;
            case msg is WatchQuestStepInfoMessage:
               wqsim = msg as WatchQuestStepInfoMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.WatchQuestInfosUpdated,wqsim.infos,wqsim.playerId);
               return true;
            case msg is QuestStepInfoMessage:
               qsimsg = msg as QuestStepInfoMessage;
               questAlreadyInArray = false;
               for each(qai in this._activeQuests)
               {
                  if(qai.questId == qsimsg.infos.questId)
                  {
                     questAlreadyInArray = true;
                  }
               }
               for each(qid in this._completedQuests)
               {
                  if(qid == qsimsg.infos.questId)
                  {
                     questAlreadyInArray = true;
                  }
               }
               if(!questAlreadyInArray)
               {
                  this._activeQuests.push(qsimsg.infos);
               }
               if(qsimsg.infos is QuestActiveDetailedInformations)
               {
                  stepsInfos = qsimsg.infos as QuestActiveDetailedInformations;
                  this._questsInformations[stepsInfos.questId] = {
                     "questId":stepsInfos.questId,
                     "stepId":stepsInfos.stepId
                  };
                  this._questsInformations[stepsInfos.questId].objectives = new Dictionary();
                  this._questsInformations[stepsInfos.questId].objectivesData = new Array();
                  this._questsInformations[stepsInfos.questId].objectivesDialogParams = new Array();
                  for each(objective in stepsInfos.objectives)
                  {
                     if(objective.objectiveStatus)
                     {
                        if(this._activeObjectives.indexOf(objective.objectiveId) == -1)
                        {
                           if(this._completedObjectives.indexOf(objective.objectiveId) != -1)
                           {
                              this._completedObjectives.splice(this._completedObjectives.indexOf(objective.objectiveId),1);
                           }
                           this._activeObjectives.push(objective.objectiveId);
                        }
                     }
                     else if(this._completedObjectives.indexOf(objective.objectiveId) == -1)
                     {
                        if(this._activeObjectives.indexOf(objective.objectiveId) != -1)
                        {
                           this._activeObjectives.splice(this._activeObjectives.indexOf(objective.objectiveId),1);
                        }
                        this._completedObjectives.push(objective.objectiveId);
                     }
                     this._questsInformations[stepsInfos.questId].objectives[objective.objectiveId] = objective.objectiveStatus;
                     if(objective.dialogParams && objective.dialogParams.length > 0)
                     {
                        dialogParams = new Array();
                        nbParams = objective.dialogParams.length;
                        for(i = 0; i < nbParams; i++)
                        {
                           dialogParams.push(objective.dialogParams[i]);
                        }
                     }
                     this._questsInformations[stepsInfos.questId].objectivesDialogParams[objective.objectiveId] = dialogParams;
                     if(objective is QuestObjectiveInformationsWithCompletion)
                     {
                        compl = new Object();
                        compl.current = (objective as QuestObjectiveInformationsWithCompletion).curCompletion;
                        compl.max = (objective as QuestObjectiveInformationsWithCompletion).maxCompletion;
                        this._questsInformations[stepsInfos.questId].objectivesData[objective.objectiveId] = compl;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,stepsInfos.questId,true);
               }
               else if(qsimsg.infos is QuestActiveInformations)
               {
                  KernelEventsManager.getInstance().processCallback(QuestHookList.QuestInfosUpdated,(qsimsg.infos as QuestActiveInformations).questId,false);
               }
               return true;
            case msg is QuestStartRequestAction:
               qsra = msg as QuestStartRequestAction;
               qsrmsg = new QuestStartRequestMessage();
               qsrmsg.initQuestStartRequestMessage(qsra.questId);
               ConnectionsHandler.getConnection().send(qsrmsg);
               return true;
            case msg is QuestObjectiveValidationAction:
               qova = msg as QuestObjectiveValidationAction;
               qovmsg = new QuestObjectiveValidationMessage();
               qovmsg.initQuestObjectiveValidationMessage(qova.questId,qova.objectiveId);
               ConnectionsHandler.getConnection().send(qovmsg);
               return true;
            case msg is GuidedModeReturnRequestAction:
               gmrrmsg = new GuidedModeReturnRequestMessage();
               gmrrmsg.initGuidedModeReturnRequestMessage();
               ConnectionsHandler.getConnection().send(gmrrmsg);
               return true;
            case msg is GuidedModeQuitRequestAction:
               gmqrmsg = new GuidedModeQuitRequestMessage();
               gmqrmsg.initGuidedModeQuitRequestMessage();
               ConnectionsHandler.getConnection().send(gmqrmsg);
               return true;
            case msg is QuestStartedMessage:
               qsmsg = msg as QuestStartedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStarted,qsmsg.questId);
               return true;
            case msg is QuestValidatedMessage:
               qvmsg = msg as QuestValidatedMessage;
               if(!this._completedQuests)
               {
                  this._completedQuests = new Vector.<uint>();
               }
               else
               {
                  for each(activeQuest in this._activeQuests)
                  {
                     if(activeQuest.questId == qvmsg.questId)
                     {
                        break;
                     }
                     index++;
                  }
                  if(this._activeQuests && index < this._activeQuests.length)
                  {
                     this._activeQuests.splice(index,1);
                  }
               }
               this._completedQuests.push(qvmsg.questId);
               questValidated = Quest.getQuestById(qvmsg.questId);
               if(!questValidated)
               {
                  return true;
               }
               for each(step in questValidated.steps)
               {
                  for each(questStepObjId in step.objectiveIds)
                  {
                     if(this._completedObjectives.indexOf(questStepObjId) == -1)
                     {
                        if(this._activeObjectives.indexOf(questStepObjId) != -1)
                        {
                           KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated,qvmsg.questId,questStepObjId);
                           this._activeObjectives.splice(this._activeObjectives.indexOf(questStepObjId),1);
                        }
                        this._completedObjectives.push(questStepObjId);
                     }
                     KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qvmsg.questId + "_" + questStepObjId,PlayedCharacterManager.getInstance().currentWorldMapId);
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestValidated,qvmsg.questId);
               return true;
               break;
            case msg is QuestObjectiveValidatedMessage:
               qovmsg2 = msg as QuestObjectiveValidatedMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestObjectiveValidated,qovmsg2.questId,qovmsg2.objectiveId);
               KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qovmsg2.questId + "_" + qovmsg2.objectiveId,PlayedCharacterManager.getInstance().currentWorldMapId);
               return true;
            case msg is QuestStepValidatedMessage:
               qsvmsg = msg as QuestStepValidatedMessage;
               if(this._questsInformations[qsvmsg.questId])
               {
                  this._questsInformations[qsvmsg.questId].stepId = qsvmsg.stepId;
               }
               objectivesIds = QuestStep.getQuestStepById(qsvmsg.stepId).objectiveIds;
               for each(stepObjId in objectivesIds)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + qsvmsg.questId + "_" + stepObjId,PlayedCharacterManager.getInstance().currentWorldMapId);
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepValidated,qsvmsg.questId,qsvmsg.stepId);
               return true;
            case msg is QuestStepStartedMessage:
               qssmsg = msg as QuestStepStartedMessage;
               if(this._questsInformations[qssmsg.questId])
               {
                  this._questsInformations[qssmsg.questId].stepId = qssmsg.stepId;
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestStepStarted,qssmsg.questId,qssmsg.stepId);
               return true;
            case msg is FollowQuestAction:
               fqa = msg as FollowQuestAction;
               questIndex = this._followedQuests.indexOf(fqa.questId);
               if(fqa.follow)
               {
                  if(questIndex == -1)
                  {
                     this._followedQuests.push(fqa.questId);
                  }
                  fqor = new FollowQuestObjectiveRequestMessage();
                  fqor.initFollowQuestObjectiveRequestMessage(fqa.questId,fqa.objectiveId);
                  ConnectionsHandler.getConnection().send(fqor);
               }
               else if(questIndex != -1)
               {
                  if(fqa.objectiveId == -1)
                  {
                     this._followedQuests.splice(questIndex,1);
                  }
                  ufqor = new UnfollowQuestObjectiveRequestMessage();
                  ufqor.initUnfollowQuestObjectiveRequestMessage(fqa.questId,fqa.objectiveId);
                  ConnectionsHandler.getConnection().send(ufqor);
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.QuestFollowed,fqa.questId,fqa.follow);
               return true;
            case msg is RefreshFollowedQuestsOrderAction:
               rfqoa = msg as RefreshFollowedQuestsOrderAction;
               rfqormsg = new RefreshFollowedQuestsOrderRequestMessage();
               rfqormsg.initRefreshFollowedQuestsOrderRequestMessage(rfqoa.questsIds);
               ConnectionsHandler.getConnection().send(rfqormsg);
               return true;
            case msg is FollowedQuestsMessage:
               if(!PlayedCharacterManager.getInstance().currentMap)
               {
                  this._followedQuestsCallback = new Callback(this.process,msg);
                  return false;
               }
               fqmsg = msg as FollowedQuestsMessage;
               followedQuests = new Array();
               numQuests = fqmsg.quests.length;
               for(j = fqmsg.quests.length - 1; j >= 0; j--)
               {
                  questParam = {
                     "questId":fqmsg.quests[j].questId,
                     "objectives":new Array(),
                     "fromServer":true
                  };
                  numObjectives = fqmsg.quests[j].objectives.length;
                  for(k = 0; k < numObjectives; k++)
                  {
                     if(fqmsg.quests[j].objectives[k].objectiveStatus)
                     {
                        questObjective = QuestObjective.getQuestObjectiveById(fqmsg.quests[j].objectives[k].objectiveId);
                        if(questObjective)
                        {
                           objectiveFlagInfos = questObjective.coords || questObjective.mapId ? QuestApi.getInstance().getQuestObjectiveFlagInfos(questParam.questId,questObjective.id) : null;
                           questParam.objectives.push({
                              "id":questObjective.id,
                              "flagData":(!!objectiveFlagInfos ? {
                                 "id":objectiveFlagInfos.id,
                                 "text":objectiveFlagInfos.text,
                                 "worldMapId":objectiveFlagInfos.worldMapId,
                                 "x":objectiveFlagInfos.x,
                                 "y":objectiveFlagInfos.y
                              } : null)
                           });
                        }
                     }
                  }
                  followedQuests.push(questParam);
                  this._followedQuests.push(questParam.questId);
               }
               mod = UiModuleManager.getInstance().getModule("Ankama_Grimoire");
               dst = new DataStoreType("AccountModule_" + mod.id,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
               questListMinimized = StoreDataManager.getInstance().getSetData(dst,"questListMinimized",false);
               if(questListMinimized)
               {
                  Berilia.getInstance().loadUi(mod,mod.uis["questListMinimized"],"questListMinimized",null,false,StrataEnum.STRATA_TOP);
               }
               Berilia.getInstance().loadUi(mod,mod.uis["questList"],"questList",{
                  "visible":!questListMinimized && !PlayedCharacterApi.getInstance().isInFight(),
                  "quests":followedQuests
               },false,StrataEnum.STRATA_TOP);
               this._followedQuestsCallback = null;
               return true;
               break;
            case msg is ObjectAddedMessage:
               oamsg = msg as ObjectAddedMessage;
               for each(oeff in oamsg.object.effects)
               {
                  if(oeff.actionId == ActionIdProtocol.ACTION_QUEST_CHECK_STARTED_OBJECTIVES)
                  {
                     idQuest = (oeff as ObjectEffectInteger).value;
                     if(this._followedQuests.indexOf(idQuest) != -1)
                     {
                        questInfosRequestMsg = new QuestStepInfoRequestMessage();
                        questInfosRequestMsg.initQuestStepInfoRequestMessage(idQuest);
                        ConnectionsHandler.getConnection().send(questInfosRequestMsg);
                     }
                  }
               }
               return false;
            case msg is NotificationUpdateFlagAction:
               nufa = msg as NotificationUpdateFlagAction;
               nufmsg = new NotificationUpdateFlagMessage();
               nufmsg.initNotificationUpdateFlagMessage(nufa.index);
               ConnectionsHandler.getConnection().send(nufmsg);
               return true;
            case msg is NotificationResetAction:
               notificationList = new Array();
               nrmsg = new NotificationResetMessage();
               nrmsg.initNotificationResetMessage();
               ConnectionsHandler.getConnection().send(nrmsg);
               KernelEventsManager.getInstance().processCallback(HookList.NotificationReset);
               return true;
            case msg is AchievementListMessage:
               this._achievementsList = msg as AchievementListMessage;
               if(this._achievementsFinishedCache !== null)
               {
                  for each(achievementFinishedRewardable in this._achievementsFinishedCache)
                  {
                     this._achievementsList.finishedAchievements.push(achievementFinishedRewardable);
                  }
                  this._achievementsFinishedCache = null;
               }
               player = PlayedCharacterManager.getInstance();
               if(player && player.characteristics)
               {
                  this.processAchievements(true);
               }
               return true;
            case msg is AchievementDetailedListRequestAction:
               adlra = msg as AchievementDetailedListRequestAction;
               adlrmsg = new AchievementDetailedListRequestMessage();
               adlrmsg.initAchievementDetailedListRequestMessage(adlra.categoryId);
               ConnectionsHandler.getConnection().send(adlrmsg);
               return true;
            case msg is AchievementDetailedListMessage:
               adlmsg = msg as AchievementDetailedListMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetailedList,adlmsg.finishedAchievements,adlmsg.startedAchievements);
               return true;
            case msg is AchievementAlmostFinishedDetailedListRequestAction:
               aafdlrmsg = new AchievementAlmostFinishedDetailedListRequestMessage();
               ConnectionsHandler.getConnection().send(aafdlrmsg);
               return true;
            case msg is AchievementAlmostFinishedDetailedListMessage:
               aafdlm = msg as AchievementAlmostFinishedDetailedListMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementAlmostFinishedDetailedList,aafdlm.almostFinishedAchievements);
               return true;
            case msg is AchievementDetailsRequestAction:
               adra = msg as AchievementDetailsRequestAction;
               adrmsg = new AchievementDetailsRequestMessage();
               adrmsg.initAchievementDetailsRequestMessage(adra.achievementId);
               ConnectionsHandler.getConnection().send(adrmsg);
               return true;
            case msg is AchievementDetailsMessage:
               admsg = msg as AchievementDetailsMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementDetails,admsg.achievement);
               return true;
            case msg is AchievementFinishedInformationMessage:
               afimsg = msg as AchievementFinishedInformationMessage;
               achievement = Achievement.getAchievementById(afimsg.achievement.id);
               if(achievement && achievement.categoryId != DataEnum.ACHIEVEMENT_CAT_MODSTERS_HIDDEN)
               {
                  info3 = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.characterUnlocksAchievement",[HyperlinkShowPlayerMenuManager.getLink(afimsg.playerId,afimsg.name)]),[afimsg.name,afimsg.achievement.id]);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,info3,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is AchievementFinishedMessage:
               afmsg = msg as AchievementFinishedMessage;
               finishedAchievement = Achievement.getAchievementById(afmsg.achievement.id);
               if(PlayerManager.getInstance().server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
               {
                  if(finishedAchievement.id == FIRST_TEMPORIS_REWARD_ACHIEVEMENT_ID)
                  {
                     nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.temporis.popupFirstRewardTitle"),I18n.getUiText("ui.temporis.popupFirstRewardContent"),NotificationTypeEnum.TUTORIAL,"FirstTemporisRewardNotif");
                     NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.achievement.rewardsGet"),"OpenGuideBookAction",["temporisTab"]);
                     NotificationManager.getInstance().sendNotification(nid);
                  }
               }
               if(finishedAchievement.category.id === DataEnum.ACHIEVEMENT_CAT_MODSTERS_HIDDEN)
               {
                  if((finishedAchievement.id == TEMPORIS_ACHIEVEMENT_STARTER_ONE || finishedAchievement.id == TEMPORIS_ACHIEVEMENT_STARTER_TWO || finishedAchievement.id == TEMPORIS_ACHIEVEMENT_STARTER_THREE || finishedAchievement.id == TEMPORIS_ACHIEVEMENT_STARTER_FOUR) && (!this.achievementIsFinished(TEMPORIS_ACHIEVEMENT_STARTER_ONE) && !this.achievementIsFinished(TEMPORIS_ACHIEVEMENT_STARTER_TWO) && !this.achievementIsFinished(TEMPORIS_ACHIEVEMENT_STARTER_THREE) && !this.achievementIsFinished(TEMPORIS_ACHIEVEMENT_STARTER_FOUR)))
                  {
                     shortcut = this.getShortcutBindString(ShortcutHookListEnum.OPEN_SPELLS);
                     if(shortcut != "")
                     {
                        shortcut = " (" + shortcut + ")";
                     }
                     nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.temporis.pushup.equipModsterTitle"),I18n.getUiText("ui.temporis.pushup.equipModsterDescription"),NotificationTypeEnum.TUTORIAL,"FirstModsterTemporisSpellNotif");
                     NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.temporis.pushup.equipModsterButton") + shortcut,"OpenBookAction",["forgettableModstersUi"],true,160);
                     NotificationManager.getInstance().sendNotification(nid);
                     shortcut = this.getShortcutBindString(ShortcutHookListEnum.OPEN_GUIDEBOOK);
                     if(shortcut != "")
                     {
                        shortcut = " (" + shortcut + ")";
                     }
                     nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.temporis.pushup.collectionTitle"),I18n.getUiText("ui.temporis.pushup.collectionDescription"),NotificationTypeEnum.TUTORIAL,"FirstModsterTemporisCollectionNotif");
                     NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.temporis.pushup.collectionButton") + shortcut,"OpenGuideBookAction",["collectionTab"],true,160);
                     NotificationManager.getInstance().sendNotification(nid);
                  }
               }
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.EXPEDITION) && finishedAchievement.category.id === EXPEDITION_ACHIEVEMENT_CATEGORY_ID)
               {
                  nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.expedition.pushup.rewardTitle"),I18n.getUiText("ui.expedition.pushup.rewardContent"),NotificationTypeEnum.GENERAL_INFORMATION,"ExpeditionRewardNotif");
                  NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.expedition.pushup.rewardButton"),"OpenBookAction",["expeditionTab"],true,220);
                  NotificationManager.getInstance().sendNotification(nid);
               }
               this._achievementsList.finishedAchievements.push(new AchievementAchieved().initAchievementAchieved(afmsg.achievement.id,afmsg.achievement.achievedBy,afmsg.achievement.achievedPioneerRank));
               if(this._achievementsFinishedCache === null)
               {
                  this._achievementsFinishedCache = [];
               }
               this._achievementsFinishedCache.push(new AchievementAchievedRewardable().initAchievementAchievedRewardable(afmsg.achievement.id,afmsg.achievement.achievedBy,afmsg.achievement.achievedPioneerRank,afmsg.achievement.finishedLevel));
               if(finishedAchievement.category.id === TEMPORIS_CATEGORY)
               {
                  if(finishedAchievement.id == FIRST_TEMPORIS_COMPANION_REWARD_ACHIEVEMENT_ID)
                  {
                     companion = this.getCompanion(finishedAchievement);
                     if(companion != null)
                     {
                        param = {};
                        param.companion = companion;
                        nid = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.companion.notif.newCompanionTitle"),I18n.getUiText("ui.companion.notif.newCompanionContent",["{openCompanion," + companion.id + "::" + companion.name + "}"]),NotificationTypeEnum.TUTORIAL,"FirstCompanionTemporisRewardNotif");
                        NotificationManager.getInstance().addButtonToNotification(nid,I18n.getUiText("ui.companion.notif.newCompanionButton"),"OpenBookAction",["companionTab",param],false,160);
                        NotificationManager.getInstance().sendNotification(nid);
                     }
                  }
                  characterDst = new DataStoreType("Module_Ankama_Grimoire",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(characterDst,STORAGE_NEW_REWARD,true);
                  KernelEventsManager.getInstance().processCallback(HookList.AreTemporisRewardsAvailable,true);
               }
               if(finishedAchievement.category.id === KOLIZEUM_CATEGORY_ID)
               {
                  characDst = new DataStoreType("Module_Ankama_Grimoire",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
                  StoreDataManager.getInstance().setData(characDst,STORAGE_NEW_REWARD,true);
                  KernelEventsManager.getInstance().processCallback(HookList.AreKolizeumRewardsAvailable,true);
               }
               if(finishedAchievement.category.visible || finishedAchievement.category.id === EXPEDITION_ACHIEVEMENT_CATEGORY_ID || finishedAchievement.category.id === KOLIZEUM_CATEGORY_ID)
               {
                  for each(achievementId in this._finishedCharacterAchievementIds)
                  {
                     if(achievementId == afmsg.achievement.id)
                     {
                        return true;
                     }
                  }
                  this._finishedAchievements.push(afmsg.achievement);
                  this._rewardableAchievements.push(afmsg.achievement);
                  KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementFinished,afmsg.achievement);
                  if(!this._rewardableAchievementsVisible && this.doesRewardsUiNeedOpening())
                  {
                     this._rewardableAchievementsVisible = true;
                     KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
                  }
                  if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_ACHIEVEMENT_PROGRESS) && finishedAchievement.category.id === TEMPORIS_CATEGORY || FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.PVP_KIS) && finishedAchievement.category.id === KOLIZEUM_CATEGORY_ID)
                  {
                     displayFinishedAchievementInChat(finishedAchievement,finishedAchievement.category.id === TEMPORIS_CATEGORY);
                  }
                  else
                  {
                     info = ParamsDecoder.applyParams(I18n.getUiText("ui.achievement.achievementUnlockWithLink"),[afmsg.achievement.id]);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,info,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  playerId = PlayedCharacterManager.getInstance().id;
                  AccountManager.getInstance().achievementPercent = Math.floor(this._finishedAchievements.length / this._nbAllAchievements * 100);
                  if(this._finishedAccountAchievementIds.indexOf(afmsg.achievement.id) == -1)
                  {
                     this._finishedAccountAchievementIds.push(afmsg.achievement.id);
                  }
                  if(afmsg.achievement.achievedBy == playerId)
                  {
                     this._finishedCharacterAchievementIds.push(afmsg.achievement.id);
                     this._finishedCharacterAchievementByIds[afmsg.achievement.id] = afmsg.achievement;
                     PlayedCharacterManager.getInstance().achievementPercent = Math.floor(this._finishedCharacterAchievementIds.length / this._nbAllAchievements * 100);
                  }
                  achievementFinished = Achievement.getAchievementById(afmsg.achievement.id);
                  if(achievementFinished)
                  {
                     AccountManager.getInstance().achievementPoints = AccountManager.getInstance().achievementPoints + achievementFinished.points;
                     if(afmsg.achievement.achievedBy == playerId)
                     {
                        PlayedCharacterManager.getInstance().achievementPoints = PlayedCharacterManager.getInstance().achievementPoints + achievementFinished.points;
                     }
                  }
               }
               return true;
            case msg is AchievementRewardRequestAction:
               arra = msg as AchievementRewardRequestAction;
               arrmsg = new AchievementRewardRequestMessage();
               arrmsg.initAchievementRewardRequestMessage(arra.achievementId);
               ConnectionsHandler.getConnection().send(arrmsg);
               return true;
            case msg is AchievementRewardSuccessMessage:
               arsmsg = msg as AchievementRewardSuccessMessage;
               for each(achievementRewardable in this._rewardableAchievements)
               {
                  if(achievementRewardable.id == arsmsg.achievementId)
                  {
                     rewardedAchievementIndex = this._rewardableAchievements.indexOf(achievementRewardable);
                     break;
                  }
               }
               this._rewardableAchievements.splice(rewardedAchievementIndex,1);
               for(achievementIndex = 0; achievementIndex < this._achievementsList.finishedAchievements.length; achievementIndex++)
               {
                  achievementAchieved = this._achievementsList.finishedAchievements[achievementIndex];
                  if(achievementAchieved.id == arsmsg.achievementId && achievementAchieved is AchievementAchievedRewardable)
                  {
                     this._achievementsList.finishedAchievements[achievementIndex] = new AchievementAchieved();
                     this._achievementsList.finishedAchievements[achievementIndex].initAchievementAchieved(achievementAchieved.id,achievementAchieved.achievedBy,achievementAchieved.achievedPioneerRank);
                     break;
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementRewardSuccess,arsmsg.achievementId);
               if(this._rewardableAchievementsVisible && !this.doesRewardsUiNeedOpening())
               {
                  this._rewardableAchievementsVisible = false;
                  KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
               }
               rewardedAchievement = Achievement.getAchievementById(arsmsg.achievementId);
               if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_ACHIEVEMENT_PROGRESS) && rewardedAchievement !== null && rewardedAchievement.category.id === TEMPORIS_CATEGORY)
               {
                  displayRewardedAchievementInChat(rewardedAchievement);
               }
               return true;
            case msg is AchievementRewardErrorMessage:
               aremsg = msg as AchievementRewardErrorMessage;
               return true;
            case msg is AchievementsPioneerRanksMessage:
               aprmsg = msg as AchievementsPioneerRanksMessage;
               for each(pioneerRank in aprmsg.achievementsPioneerRanks)
               {
                  this._pioneerRanks[pioneerRank.achievementId] = pioneerRank.pioneerRank;
               }
               return true;
            case msg is AchievementsPioneerRanksRequestAction:
               aprrmsg = new AchievementsPioneerRanksRequestMessage();
               aprrmsg.initAchievementsPioneerRanksRequestMessage();
               ConnectionsHandler.getConnection().send(aprrmsg);
               return true;
            case msg is TreasureHuntShowLegendaryUIMessage:
               thslumsg = msg as TreasureHuntShowLegendaryUIMessage;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntLegendaryUiUpdate,thslumsg.availableLegendaryIds);
               return true;
            case msg is TreasureHuntLegendaryRequestAction:
               thlra = msg as TreasureHuntLegendaryRequestAction;
               thlrmsg = new TreasureHuntLegendaryRequestMessage();
               thlrmsg.initTreasureHuntLegendaryRequestMessage(thlra.legendaryId);
               ConnectionsHandler.getConnection().send(thlrmsg);
               return true;
            case msg is TreasureHuntRequestAnswerMessage:
               thramsg = msg as TreasureHuntRequestAnswerMessage;
               if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_ALREADY_HAVE_QUEST)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.alreadyHaveQuest");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NO_QUEST_FOUND)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.noQuestFound");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_UNDEFINED)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.popup.impossible_action");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_NOT_AVAILABLE)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.huntNotAvailable");
               }
               else if(thramsg.result == TreasureHuntRequestEnum.TREASURE_HUNT_ERROR_DAILY_LIMIT_EXCEEDED)
               {
                  treasureHuntRequestAnswerText = I18n.getUiText("ui.treasureHunt.huntLimitExceeded");
               }
               if(treasureHuntRequestAnswerText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,treasureHuntRequestAnswerText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TreasureHuntFlagRequestAction:
               thfra = msg as TreasureHuntFlagRequestAction;
               thfrmsg = new TreasureHuntFlagRequestMessage();
               thfrmsg.initTreasureHuntFlagRequestMessage(thfra.questType,thfra.index);
               ConnectionsHandler.getConnection().send(thfrmsg);
               return true;
            case msg is TreasureHuntFlagRemoveRequestAction:
               thfrra = msg as TreasureHuntFlagRemoveRequestAction;
               thfrrmsg = new TreasureHuntFlagRemoveRequestMessage();
               thfrrmsg.initTreasureHuntFlagRemoveRequestMessage(thfrra.questType,thfrra.index);
               ConnectionsHandler.getConnection().send(thfrrmsg);
               return true;
            case msg is TreasureHuntFlagRequestAnswerMessage:
               thframsg = msg as TreasureHuntFlagRequestAnswerMessage;
               switch(thframsg.result)
               {
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_OK:
                     break;
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_UNDEFINED:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_TOO_MANY:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_ERROR_IMPOSSIBLE:
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_WRONG_INDEX:
                     treasureHuntFlagRequestAnswerText = I18n.getUiText("ui.treasureHunt.flagFail");
                     break;
                  case TreasureHuntFlagRequestEnum.TREASURE_HUNT_FLAG_SAME_MAP:
                     treasureHuntFlagRequestAnswerText = I18n.getUiText("ui.treasureHunt.flagFailSameMap");
               }
               if(treasureHuntFlagRequestAnswerText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,treasureHuntFlagRequestAnswerText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is TreasureHuntMessage:
               thmsg = msg as TreasureHuntMessage;
               Atouin.getInstance().setWorldMaskDimensions(StageShareManager.startWidth + AtouinConstants.CELL_HALF_WIDTH / 2,FrustumManager.getInstance().frustum.marginBottom,0,0.7,"treasureHinting");
               if(DictionaryUtils.getLength(this._treasureHunts) <= 0)
               {
                  Atouin.getInstance().toggleWorldMask("treasureHinting",true);
               }
               if(this._treasureHunts[thmsg.questType] && this._treasureHunts[thmsg.questType].stepList.length)
               {
                  l = 0;
                  for each(st in this._treasureHunts[thmsg.questType].stepList)
                  {
                     if(st.flagState > -1)
                     {
                        l++;
                        if(!mp)
                        {
                           mp = MapPosition.getMapPositionById(st.mapId);
                        }
                        if(mp.worldMap > -1)
                        {
                           KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_hunt_" + thmsg.questType + "_" + l,mp.worldMap);
                        }
                     }
                  }
               }
               th = TreasureHuntWrapper.create(thmsg.questType,thmsg.startMapId,thmsg.checkPointCurrent,thmsg.checkPointTotal,thmsg.totalStepCount,thmsg.availableRetryCount,thmsg.knownStepsList,thmsg.flags);
               this._treasureHunts[thmsg.questType] = th;
               i = 0;
               for each(fl in thmsg.flags)
               {
                  i++;
                  mp = MapPosition.getMapPositionById(fl.mapId);
                  if(mp.worldMap > -1)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_hunt_" + thmsg.questType + "_" + i,I18n.getUiText("ui.treasureHunt.huntType" + thmsg.questType) + " - " + I18n.getUiText("ui.treasureHunt.hint",[i]) + " [" + mp.posX + "," + mp.posY + "]",mp.worldMap,mp.posX,mp.posY,this._flagColors[fl.state],false,false,false);
                  }
               }
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntUpdate,th.questType);
               return true;
            case msg is TreasureHuntAvailableRetryCountUpdateMessage:
               tharcumsg = msg as TreasureHuntAvailableRetryCountUpdateMessage;
               this._treasureHunts[tharcumsg.questType].availableRetryCount = tharcumsg.availableRetryCount;
               KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntAvailableRetryCountUpdate,tharcumsg.questType,tharcumsg.availableRetryCount);
               return true;
            case msg is TreasureHuntFinishedMessage:
               thfmsg = msg as TreasureHuntFinishedMessage;
               if(this._treasureHunts[thfmsg.questType])
               {
                  if(this._treasureHunts[thfmsg.questType].stepList.length)
                  {
                     j = 0;
                     for each(st in this._treasureHunts[thfmsg.questType].stepList)
                     {
                        if(st.flagState > -1)
                        {
                           j++;
                           if(!mp)
                           {
                              mp = MapPosition.getMapPositionById(st.mapId);
                           }
                           if(mp.worldMap > -1)
                           {
                              KernelEventsManager.getInstance().processCallback(HookList.RemoveMapFlag,"flag_hunt_" + thfmsg.questType + "_" + j,mp.worldMap);
                           }
                        }
                     }
                  }
                  this._treasureHunts[thfmsg.questType] = null;
                  delete this._treasureHunts[thfmsg.questType];
                  if(!this.hasTreasureHunt())
                  {
                     Atouin.getInstance().toggleWorldMask("treasureHinting",false);
                  }
                  KernelEventsManager.getInstance().processCallback(QuestHookList.TreasureHuntFinished,thfmsg.questType);
               }
               return true;
            case msg is TreasureHuntGiveUpRequestAction:
               thgura = msg as TreasureHuntGiveUpRequestAction;
               thgurmsg = new TreasureHuntGiveUpRequestMessage();
               thgurmsg.initTreasureHuntGiveUpRequestMessage(thgura.questType);
               ConnectionsHandler.getConnection().send(thgurmsg);
               return true;
            case msg is TreasureHuntDigRequestAction:
               thdra = msg as TreasureHuntDigRequestAction;
               thdrmsg = new TreasureHuntDigRequestMessage();
               thdrmsg.initTreasureHuntDigRequestMessage(thdra.questType);
               ConnectionsHandler.getConnection().send(thdrmsg);
               return true;
            case msg is TreasureHuntDigRequestAnswerMessage:
               thdramsg = msg as TreasureHuntDigRequestAnswerMessage;
               if(thdramsg is TreasureHuntDigRequestAnswerFailedMessage)
               {
                  wrongFlagCount = (thdramsg as TreasureHuntDigRequestAnswerFailedMessage).wrongFlagCount;
               }
               if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_IMPOSSIBLE)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.fight.wrongMap");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_ERROR_UNDEFINED)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.popup.impossible_action");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_LOST)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.huntFail");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_NEW_HINT)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.stepSuccess");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG)
               {
                  if(wrongFlagCount > 1)
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.digWrongFlags",[wrongFlagCount]);
                  }
                  else if(wrongFlagCount > 0)
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.digWrongFlag");
                  }
                  else
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.digFail");
                  }
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_WRONG_AND_YOU_KNOW_IT)
               {
                  treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.noNewFlag");
               }
               else if(thdramsg.result == TreasureHuntDigRequestEnum.TREASURE_HUNT_DIG_FINISHED)
               {
                  if(thdramsg.questType == TreasureHuntTypeEnum.TREASURE_HUNT_CLASSIC)
                  {
                     treasureHuntDigAnswerText = I18n.getUiText("ui.treasureHunt.huntSuccess");
                  }
               }
               if(treasureHuntDigAnswerText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,treasureHuntDigAnswerText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function hasTreasureHunt() : Boolean
      {
         var key:* = undefined;
         for(key in this._treasureHunts)
         {
            if(key != null)
            {
               return true;
            }
         }
         return false;
      }
      
      public function processAchievements(resetRewards:Boolean = false) : void
      {
         var ach:Achievement = null;
         var achievedAchievement:AchievementAchieved = null;
         var rewardsUiNeedOpening:Boolean = false;
         var playerAchievementsCount:int = 0;
         var accountAchievementsCount:int = 0;
         var playerPoints:int = 0;
         var accountPoints:int = 0;
         var achievementDone:Dictionary = new Dictionary();
         this._finishedAchievements = new Vector.<AchievementAchieved>();
         this._finishedCharacterAchievementIds = [];
         if(resetRewards)
         {
            this._rewardableAchievements = new Vector.<AchievementAchievedRewardable>();
         }
         for each(achievedAchievement in this._achievementsList.finishedAchievements)
         {
            ach = Achievement.getAchievementById(achievedAchievement.id);
            if(ach != null && ach && ach.category && (ach.category.visible || ach.category.id == EXPEDITION_ACHIEVEMENT_CATEGORY_ID))
            {
               if(achievedAchievement is AchievementAchievedRewardable && this._rewardableAchievements.indexOf(achievedAchievement) === -1)
               {
                  this._rewardableAchievements.push(achievedAchievement);
               }
               if(this._finishedAchievements.indexOf(achievedAchievement) === -1)
               {
                  this._finishedAchievements.push(achievedAchievement);
               }
               accountPoints += ach.points;
               accountAchievementsCount++;
               if(this._finishedAccountAchievementIds.indexOf(ach.id) == -1)
               {
                  this._finishedAccountAchievementIds.push(ach.id);
               }
               if(achievedAchievement.achievedBy == PlayedCharacterManager.getInstance().id)
               {
                  playerPoints += ach.points;
                  playerAchievementsCount++;
                  this._finishedCharacterAchievementIds.push(ach.id);
                  this._finishedCharacterAchievementByIds[ach.id] = achievedAchievement;
               }
               achievementDone[achievedAchievement.id] = true;
            }
            else if(ach == null)
            {
               _log.warn("Succés " + achievedAchievement.id + " non exporté");
            }
         }
         PlayedCharacterManager.getInstance().achievementPercent = Math.floor(playerAchievementsCount / this._nbAllAchievements * 100);
         PlayedCharacterManager.getInstance().achievementPoints = playerPoints;
         AccountManager.getInstance().achievementPercent = Math.floor(accountAchievementsCount / this._nbAllAchievements * 100);
         AccountManager.getInstance().achievementPoints = accountPoints;
         KernelEventsManager.getInstance().processCallback(QuestHookList.AchievementList);
         rewardsUiNeedOpening = this.doesRewardsUiNeedOpening();
         if(!this._rewardableAchievementsVisible && rewardsUiNeedOpening)
         {
            this._rewardableAchievementsVisible = true;
            KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
         }
         if(this._rewardableAchievementsVisible && !rewardsUiNeedOpening)
         {
            this._rewardableAchievementsVisible = false;
            KernelEventsManager.getInstance().processCallback(QuestHookList.RewardableAchievementsVisible,this._rewardableAchievementsVisible);
         }
         this._achievementsListProcessed = true;
      }
      
      private function getCompanion(achievement:Achievement) : Companion
      {
         var rewardId:int = 0;
         var reward:AchievementReward = null;
         var itemRewardIndex:int = 0;
         var itemQuantity:int = 0;
         var currentItemReward:Item = null;
         var itemId:int = 0;
         var compId:int = 0;
         var ei:EffectInstance = null;
         var companion:Companion = null;
         loop0:
         for each(rewardId in achievement.rewardIds)
         {
            reward = AchievementReward.getAchievementRewardById(rewardId);
            if(reward != null)
            {
               itemRewardIndex = 0;
               itemQuantity = 0;
               var _loc13_:int = 0;
               var _loc14_:* = reward.itemsReward;
               loop1:
               while(true)
               {
                  for each(itemId in _loc14_)
                  {
                     itemQuantity = reward.itemsQuantityReward.length > itemRewardIndex ? int(reward.itemsQuantityReward[itemRewardIndex]) : 1;
                     currentItemReward = Item.getItemById(itemId);
                     itemRewardIndex++;
                     if(currentItemReward.typeId == DataEnum.ITEM_TYPE_COMPANION)
                     {
                        for each(ei in currentItemReward.possibleEffects)
                        {
                           if(ei.effectId == ActionIds.ACTION_SET_COMPANION)
                           {
                              compId = int(ei.parameter2);
                              break;
                           }
                        }
                        if(compId > 0)
                        {
                           break loop1;
                        }
                     }
                  }
                  continue loop0;
               }
               return Companion.getCompanionById(compId);
            }
         }
         return null;
      }
      
      private function doesRewardsUiNeedOpening() : Boolean
      {
         var rewardable:AchievementAchievedRewardable = null;
         var achievement:Achievement = null;
         var category:AchievementCategory = null;
         for each(rewardable in this._rewardableAchievements)
         {
            if(rewardable !== null)
            {
               achievement = Achievement.getAchievementById(rewardable.id);
               if(achievement !== null)
               {
                  category = achievement.category;
                  if(category !== null && category.id !== TEMPORIS_CATEGORY && category.id !== EXPEDITION_ACHIEVEMENT_CATEGORY_ID && category.id !== KOLIZEUM_CATEGORY_ID)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private function achievementIsFinished(achievementId:uint) : Boolean
      {
         var achievement:AchievementAchievedRewardable = null;
         for each(achievement in this._achievementsFinishedCache)
         {
            if(achievementId == achievement.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getShortcutBindString(shortcutName:String) : String
      {
         var bind:Bind = BindsManager.getInstance().getBindFromShortcut(shortcutName,false);
         if(bind != null && bind.key != null)
         {
            return bind.toString();
         }
         return "";
      }
   }
}

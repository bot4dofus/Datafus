package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class QuestHookList
   {
      
      public static const QuestListUpdated:String = "QuestListUpdated";
      
      public static const QuestInfosUpdated:String = "QuestInfosUpdated";
      
      public static const WatchQuestInfosUpdated:String = "WatchQuestInfosUpdated";
      
      public static const QuestStarted:String = "QuestStarted";
      
      public static const QuestValidated:String = "QuestValidated";
      
      public static const QuestObjectiveValidated:String = "QuestObjectiveValidated";
      
      public static const QuestStepValidated:String = "QuestStepValidated";
      
      public static const QuestStepStarted:String = "QuestStepStarted";
      
      public static const AchievementList:String = "AchievementList";
      
      public static const AchievementDetailedList:String = "AchievementDetailedList";
      
      public static const AchievementAlmostFinishedDetailedList:String = "AchievementAlmostFinishedDetailedList";
      
      public static const AchievementDetails:String = "AchievementDetails";
      
      public static const AchievementFinished:String = "AchievementFinished";
      
      public static const AchievementRewardSuccess:String = "AchievementRewardSuccess";
      
      public static const AchievementRewardError:String = "AchievementRewardError";
      
      public static const RewardableAchievementsVisible:String = "RewardableAchievementsVisible";
      
      public static const TitlesListUpdated:String = "TitlesListUpdated";
      
      public static const OrnamentsListUpdated:String = "OrnamentsListUpdated";
      
      public static const TitleUpdated:String = "TitleUpdated";
      
      public static const OrnamentUpdated:String = "OrnamentUpdated";
      
      public static const TreasureHuntLegendaryUiUpdate:String = "TreasureHuntLegendaryUiUpdate";
      
      public static const TreasureHuntUpdate:String = "TreasureHuntUpdate";
      
      public static const TreasureHuntFinished:String = "TreasureHuntFinished";
      
      public static const TreasureHuntAvailableRetryCountUpdate:String = "TreasureHuntAvailableRetryCountUpdate";
      
      public static const AreaFightModificatorUpdate:String = "AreaFightModificatorUpdate";
      
      public static const QuestFollowed:String = "QuestFollowed";
       
      
      public function QuestHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(QuestListUpdated);
         Hook.createHook(QuestInfosUpdated);
         Hook.createHook(QuestStarted);
         Hook.createHook(QuestValidated);
         Hook.createHook(QuestObjectiveValidated);
         Hook.createHook(QuestStepValidated);
         Hook.createHook(QuestStepStarted);
         Hook.createHook(AchievementList);
         Hook.createHook(AchievementDetailedList);
         Hook.createHook(AchievementAlmostFinishedDetailedList);
         Hook.createHook(AchievementDetails);
         Hook.createHook(AchievementFinished);
         Hook.createHook(AchievementRewardSuccess);
         Hook.createHook(AchievementRewardError);
         Hook.createHook(RewardableAchievementsVisible);
         Hook.createHook(TitlesListUpdated);
         Hook.createHook(OrnamentsListUpdated);
         Hook.createHook(TitleUpdated);
         Hook.createHook(OrnamentUpdated);
         Hook.createHook(TreasureHuntLegendaryUiUpdate);
         Hook.createHook(TreasureHuntUpdate);
         Hook.createHook(TreasureHuntFinished);
         Hook.createHook(TreasureHuntAvailableRetryCountUpdate);
         Hook.createHook(AreaFightModificatorUpdate);
         Hook.createHook(QuestFollowed);
         Hook.createHook(WatchQuestInfosUpdated);
      }
   }
}

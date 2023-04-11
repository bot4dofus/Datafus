package com.ankamagames.dofus.misc.stats.custom
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.IStatsClass;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightStartingMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.quest.QuestValidatedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.Dictionary;
   
   public class AdvancedTutorialStats implements IStatsClass, IHookStats
   {
      
      private static const TUTORIAL_STEP_VALIDATION_EVENT_ID:uint = 9;
      
      private static const STEP_DETAIL:String = "stepDetail";
      
      private static const FOLLOW_INSTRUCTIONS:String = "followInstructions";
      
      private static const QUEST_JOB_ID:uint = 1629;
      
      private static const QUEST_FIGHT_ID:uint = 1630;
      
      private static const TUTORIAL_STEP_OPEN_REWARDS_UI:uint = 3100;
      
      private static const TUTORIAL_STEP_ACCEPT_ALL_REWARDS:uint = 3200;
      
      private static const TUTORIAL_STEP_CLICK_ON_JORIS_4:uint = 3300;
      
      private static const TUTORIAL_STEP_START_JOB_QUEST:uint = 3400;
      
      private static const TUTORIAL_STEP_CHANGE_MAP_3:uint = 3500;
      
      private static const TUTORIAL_STEP_CLICK_ON_HOBOULO:uint = 3600;
      
      private static const TUTORIAL_STEP_START_END_NPC_DIALOG:uint = 3700;
      
      private static const TUTORIAL_STEP_END_JOB_QUEST:uint = 3800;
      
      private static const TUTORIAL_STEP_USE_CRAFT_STATION:uint = 3900;
      
      private static const TUTORIAL_STEP_SELECT_IDOL_RECIPE:uint = 4000;
      
      private static const TUTORIAL_STEP_CRAFT_IDOL:uint = 4100;
      
      private static const TUTORIAL_STEP_OPEN_REWARDS_UI_2:uint = 4200;
      
      private static const TUTORIAL_STEP_ACCEPT_ALL_REWARDS_2:uint = 4300;
      
      private static const TUTORIAL_STEP_CLICK_ON_HOBOULO_2:uint = 4400;
      
      private static const TUTORIAL_STEP_END_CRAFT_TUTORIAL:uint = 4500;
      
      private static const TUTORIAL_STEP_CHANGE_MAP_4:uint = 4600;
      
      private static const TUTORIAL_STEP_CLICK_ON_JORIS_5:uint = 4700;
      
      private static const TUTORIAL_STEP_START_FIGHT_QUEST:uint = 4800;
      
      private static const TUTORIAL_STEP_CHANGE_MAP_5:uint = 4900;
      
      private static const TUTORIAL_STEP_CLICK_ON_DARM:uint = 5000;
      
      private static const TUTORIAL_STEP_TALK_TO_DARM:uint = 5100;
      
      private static const TUTORIAL_STEP_CLICK_ON_MONSTERS:uint = 6400;
      
      private static const TUTORIAL_STEP_START_FIGHT:uint = 6500;
      
      private static const TUTORIAL_STEP_FIGHT_WIN:uint = 6600;
      
      private static const TUTORIAL_STEP_FIGHT_WIN_BIS:uint = 6600;
      
      private static const TUTORIAL_STEP_CLICK_ON_DARM_2:uint = 6700;
      
      private static const TUTORIAL_STEP_TALK_TO_DARM_2:uint = 6800;
      
      private static const TUTORIAL_STEP_CHANGE_MAP_6:uint = 6900;
      
      private static const TUTORIAL_STEP_CLICK_ON_JORIS_6:uint = 7000;
      
      private static const TUTORIAL_STEP_END_TUTORIAL:uint = 7100;
      
      private static const HUB_MAP_ID:uint = 153092354;
      
      private static const JOB_MAP_ID:int = 153093380;
      
      private static const FIGHT_MAP_ID:int = 153092356;
      
      private static const EXIT_MAP_ID:int = 154010883;
      
      private static const CRAFT_STATION_ELEMENT_ID:uint = 508989;
      
      private static const CRAFT_IDOL_ITEM_ID:uint = 16358;
       
      
      private var _jobStepsHarvest:Array;
      
      private var _currentStep:uint;
      
      private var _waitingStep:uint;
      
      private var _currentQuest:Object;
      
      private var _stepInfos:Dictionary;
      
      private var _currentFightId:int;
      
      private var _activeQuestId:uint;
      
      public function AdvancedTutorialStats(pArgs:Array)
      {
         this._jobStepsHarvest = [];
         this._stepInfos = new Dictionary(true);
         super();
         var firstTutorialCharacter:* = StatisticsManager.getInstance().getData("firstTutorialCharacter-" + PlayerManager.getInstance().accountId);
         if(PlayedCharacterManager.getInstance().currentMap.mapId != HUB_MAP_ID && PlayedCharacterManager.getInstance().currentMap.mapId != JOB_MAP_ID && PlayedCharacterManager.getInstance().currentMap.mapId != FIGHT_MAP_ID && PlayedCharacterManager.getInstance().currentMap.mapId != EXIT_MAP_ID || PlayedCharacterManager.getInstance().infos.id != firstTutorialCharacter)
         {
            StatisticsManager.getInstance().removeStats("advancedTutorial");
         }
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var target:GraphicContainer = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var iumsg:InteractiveUsedMessage = null;
         var simsg:SelectItemMessage = null;
         var qvmsg:QuestValidatedMessage = null;
         var qlmsg:QuestListMessage = null;
         var activeQuest:QuestActiveInformations = null;
         if(pMessage is MouseClickMessage)
         {
            target = pArgs[1];
            if(target && target.getUi() && target.getUi().name == "rewardsUi" && target.name == "btn_acceptAll")
            {
               if(this._currentStep < TUTORIAL_STEP_CRAFT_IDOL)
               {
                  this.sendStepValidation(TUTORIAL_STEP_ACCEPT_ALL_REWARDS,null,null,false);
               }
               else
               {
                  this.sendStepValidation(TUTORIAL_STEP_ACCEPT_ALL_REWARDS_2,null,null,false);
               }
            }
         }
         else if(pMessage is MapComplementaryInformationsDataMessage)
         {
            mcidmsg = pMessage as MapComplementaryInformationsDataMessage;
            switch(mcidmsg.mapId)
            {
               case JOB_MAP_ID:
                  if(this._currentStep == TUTORIAL_STEP_START_JOB_QUEST)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_CHANGE_MAP_3);
                  }
                  break;
               case HUB_MAP_ID:
                  if(this._currentStep == TUTORIAL_STEP_END_CRAFT_TUTORIAL)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_CHANGE_MAP_4);
                  }
                  else if(this._currentStep == TUTORIAL_STEP_TALK_TO_DARM_2)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_CHANGE_MAP_6);
                  }
                  else if(this._activeQuestId == QUEST_JOB_ID)
                  {
                     this._currentStep = TUTORIAL_STEP_CHANGE_MAP_4;
                  }
                  else if(this._activeQuestId == QUEST_FIGHT_ID)
                  {
                     this._currentStep = TUTORIAL_STEP_CHANGE_MAP_6;
                  }
                  break;
               case FIGHT_MAP_ID:
                  if(this._currentStep == TUTORIAL_STEP_START_FIGHT_QUEST)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_CHANGE_MAP_5);
                  }
                  break;
               case EXIT_MAP_ID:
            }
         }
         else if(pMessage is InteractiveUsedMessage)
         {
            iumsg = pMessage as InteractiveUsedMessage;
            if(iumsg.elemId == CRAFT_STATION_ELEMENT_ID && this._currentStep == TUTORIAL_STEP_END_JOB_QUEST)
            {
               this.sendStepValidation(TUTORIAL_STEP_USE_CRAFT_STATION);
            }
         }
         else if(pMessage is SelectItemMessage)
         {
            simsg = pMessage as SelectItemMessage;
            if(simsg.target.name == "gd_recipes" && (simsg.selectMethod == SelectMethodEnum.CLICK || simsg.selectMethod == SelectMethodEnum.DOUBLE_CLICK) && ((simsg.target as Grid).selectedItem as Recipe).resultId == CRAFT_IDOL_ITEM_ID && this._currentStep == TUTORIAL_STEP_USE_CRAFT_STATION)
            {
               this.sendStepValidation(TUTORIAL_STEP_SELECT_IDOL_RECIPE);
            }
         }
         else if(pMessage is GameFightStartingMessage)
         {
            this._currentFightId = (pMessage as GameFightStartingMessage).fightId;
            if(this._currentStep == TUTORIAL_STEP_CLICK_ON_MONSTERS)
            {
               this.sendStepValidation(TUTORIAL_STEP_START_FIGHT,this._currentFightId);
            }
         }
         else if(pMessage is QuestValidatedMessage)
         {
            qvmsg = pMessage as QuestValidatedMessage;
            if(qvmsg.questId == QUEST_FIGHT_ID && this._currentStep >= TUTORIAL_STEP_CHANGE_MAP_6 && this._currentStep < TUTORIAL_STEP_END_TUTORIAL)
            {
               this.sendStepValidation(TUTORIAL_STEP_END_TUTORIAL);
            }
         }
         else if(pMessage is QuestListMessage)
         {
            qlmsg = pMessage as QuestListMessage;
            for each(activeQuest in qlmsg.activeQuests)
            {
               if(activeQuest.questId == QUEST_JOB_ID || activeQuest.questId == QUEST_FIGHT_ID)
               {
                  this._activeQuestId = activeQuest.questId;
               }
            }
         }
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         var obj:* = undefined;
         var questFrame:QuestFrame = null;
         var resourcesLen:uint = 0;
         var entitiesFrame:RoleplayEntitiesFrame = null;
         var infos:GameRolePlayNpcInformations = null;
         var objective:* = undefined;
         var stepId:uint = 0;
         switch(pHook)
         {
            case QuestHookList.QuestObjectiveValidated:
               if(pArgs[0] == QUEST_JOB_ID || pArgs[0] == QUEST_FIGHT_ID)
               {
                  if(this._currentStep == TUTORIAL_STEP_START_END_NPC_DIALOG)
                  {
                     resourcesLen = this._jobStepsHarvest.length;
                     if(pArgs[1] != this._jobStepsHarvest.shift())
                     {
                        this.setStepInfo(TUTORIAL_STEP_END_JOB_QUEST,FOLLOW_INSTRUCTIONS,false);
                     }
                     else if(!this._stepInfos[stepId] || !this._stepInfos[stepId].hasOwnProperty(FOLLOW_INSTRUCTIONS))
                     {
                        this.setStepInfo(TUTORIAL_STEP_END_JOB_QUEST,FOLLOW_INSTRUCTIONS,true);
                     }
                     if(resourcesLen && this._jobStepsHarvest.length == 0)
                     {
                        stepId = TUTORIAL_STEP_END_JOB_QUEST;
                     }
                  }
                  else
                  {
                     stepId = this.getQuestStepEventId(pArgs[1]);
                  }
                  if(stepId > this._currentStep)
                  {
                     if(this._currentStep == TUTORIAL_STEP_CLICK_ON_DARM_2 && stepId == TUTORIAL_STEP_TALK_TO_DARM_2)
                     {
                        this._waitingStep = stepId;
                        break;
                     }
                     switch(stepId)
                     {
                        case TUTORIAL_STEP_FIGHT_WIN:
                           this.setStepInfo(stepId,STEP_DETAIL,this._currentFightId);
                     }
                     this.sendStepValidation(stepId,this._stepInfos[stepId] && this._stepInfos[stepId].hasOwnProperty(STEP_DETAIL) ? this._stepInfos[stepId].stepDetail : null,this._stepInfos[stepId] && this._stepInfos[stepId].hasOwnProperty(FOLLOW_INSTRUCTIONS) ? this._stepInfos[stepId].followInstructions : null);
                  }
               }
               break;
            case BeriliaHookList.UiLoaded:
               if(pArgs[0] == "rewardsUi")
               {
                  if(this._currentStep < TUTORIAL_STEP_CRAFT_IDOL)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_OPEN_REWARDS_UI,null,null,false);
                  }
                  else
                  {
                     this.sendStepValidation(TUTORIAL_STEP_OPEN_REWARDS_UI_2,null,Berilia.getInstance().isUiDisplayed("craft"),false);
                  }
               }
               break;
            case BeriliaHookList.UiUnloaded:
               if(pArgs[0] == "npcDialog")
               {
                  if(this._currentStep == TUTORIAL_STEP_CLICK_ON_DARM_2 && this._waitingStep == TUTORIAL_STEP_TALK_TO_DARM_2)
                  {
                     this.sendStepValidation(TUTORIAL_STEP_TALK_TO_DARM_2,null,!!this._stepInfos[TUTORIAL_STEP_TALK_TO_DARM_2] ? this._stepInfos[TUTORIAL_STEP_TALK_TO_DARM_2][FOLLOW_INSTRUCTIONS] : false);
                     this._waitingStep = 0;
                  }
               }
               break;
            case HookList.AdvancedTutorialStep:
               stepId = this.getStepFromQuestInfos(this._currentQuest);
               if(stepId > this._currentStep)
               {
                  this._currentStep = stepId;
               }
               break;
            case BeriliaHookList.MouseClick:
               obj = pArgs[0];
               if(obj is AnimatedCharacter)
               {
                  entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                  if(entitiesFrame)
                  {
                     infos = entitiesFrame.getEntityInfos(obj.id) as GameRolePlayNpcInformations;
                     if(infos)
                     {
                        if(infos.npcId == 2897)
                        {
                           if(this._currentStep < TUTORIAL_STEP_CLICK_ON_JORIS_4)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS_4);
                           }
                           else if(this._currentStep > TUTORIAL_STEP_CLICK_ON_JORIS_4 && this._currentStep < TUTORIAL_STEP_CLICK_ON_JORIS_5)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS_5);
                           }
                           else if(this._currentStep > TUTORIAL_STEP_CLICK_ON_JORIS_5 && this._currentStep < TUTORIAL_STEP_CLICK_ON_JORIS_6)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_JORIS_6);
                           }
                        }
                        else if(infos.npcId == 2895)
                        {
                           if(this._currentStep < TUTORIAL_STEP_CLICK_ON_HOBOULO)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_HOBOULO);
                           }
                           else if(this._currentStep < TUTORIAL_STEP_CLICK_ON_HOBOULO_2)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_HOBOULO_2);
                           }
                        }
                        else if(infos.npcId == 2896)
                        {
                           if(this._currentStep < TUTORIAL_STEP_CLICK_ON_DARM)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_DARM);
                           }
                           else if(this._currentStep < TUTORIAL_STEP_CLICK_ON_DARM_2)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_DARM_2);
                           }
                        }
                        else if(infos.npcId == 2927)
                        {
                           if(this._currentStep < TUTORIAL_STEP_CLICK_ON_MONSTERS)
                           {
                              this.sendStepValidation(TUTORIAL_STEP_CLICK_ON_MONSTERS);
                           }
                        }
                     }
                  }
               }
               break;
            case QuestHookList.QuestStarted:
               if(pArgs[0] == QUEST_JOB_ID)
               {
                  this.sendStepValidation(TUTORIAL_STEP_START_JOB_QUEST);
               }
               break;
            case QuestHookList.QuestInfosUpdated:
               questFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
               if(pArgs[0] == QUEST_JOB_ID || pArgs[0] == QUEST_FIGHT_ID)
               {
                  this._currentQuest = questFrame.getQuestInformations(pArgs[0]);
                  stepId = this.getStepFromQuestInfos(this._currentQuest);
                  if(stepId > this._currentStep)
                  {
                     this._currentStep = stepId;
                  }
                  if(this._currentQuest.questId == QUEST_JOB_ID)
                  {
                     for(objective in this._currentQuest.objectives)
                     {
                        if(this._currentQuest.objectives[objective] == true && (objective == 9657 || objective == 9658 || objective == 9659 || objective == 9660 || objective == 9661) && this._jobStepsHarvest.indexOf(objective) == -1)
                        {
                           this._jobStepsHarvest.push(objective);
                        }
                     }
                     if(this._currentQuest.objectives[9662] == true)
                     {
                        this._currentStep = TUTORIAL_STEP_END_JOB_QUEST;
                     }
                     else if(this._jobStepsHarvest.length)
                     {
                        this._currentStep = TUTORIAL_STEP_START_END_NPC_DIALOG;
                     }
                  }
               }
               break;
            case HookList.DisplayUiArrow:
               if(this._currentStep == TUTORIAL_STEP_CLICK_ON_HOBOULO && pArgs[0].uiName == "bannerMenu" && pArgs[0].componentName == "gd_btnUis|uriName|btn_book")
               {
                  this.setStepInfo(TUTORIAL_STEP_START_END_NPC_DIALOG,FOLLOW_INSTRUCTIONS,true);
               }
         }
      }
      
      public function remove() : void
      {
      }
      
      private function sendStepValidation(pStep:uint, pStepDetail:* = null, pFollowInstructions:* = null, pUpdateStep:Boolean = true) : void
      {
         var stepAction:StatsAction = new StatsAction(InternalStatisticTypeEnum.TUTORIAL_STEP_VALIDATION);
         stepAction.user = StatsAction.getUserId();
         stepAction.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
         stepAction.setParam("account_id",PlayerManager.getInstance().accountId);
         stepAction.setParam("server_id",PlayerManager.getInstance().server.id);
         stepAction.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
         stepAction.setParam("map_id",PlayedCharacterManager.getInstance().currentMap.mapId);
         stepAction.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
         stepAction.setParam("step_id",pStep);
         stepAction.setParam("step_detail",pStepDetail);
         stepAction.setParam("follow_instructions",pFollowInstructions);
         stepAction.send();
         if(pUpdateStep)
         {
            this._currentStep = pStep;
         }
      }
      
      private function getQuestStepEventId(pQuestStep:uint) : uint
      {
         var stepId:uint = 0;
         switch(pQuestStep)
         {
            case 9655:
               stepId = TUTORIAL_STEP_CHANGE_MAP_3;
               break;
            case 9656:
               stepId = TUTORIAL_STEP_START_END_NPC_DIALOG;
               break;
            case 9657:
            case 9658:
            case 9659:
            case 9660:
            case 9661:
               break;
            case 9662:
               stepId = TUTORIAL_STEP_CRAFT_IDOL;
               break;
            case 10015:
               stepId = TUTORIAL_STEP_END_CRAFT_TUTORIAL;
               break;
            case 9663:
               stepId = TUTORIAL_STEP_CHANGE_MAP_4;
               break;
            case 9680:
               stepId = TUTORIAL_STEP_CHANGE_MAP_5;
               break;
            case 9685:
               stepId = TUTORIAL_STEP_TALK_TO_DARM;
               break;
            case 9720:
               stepId = TUTORIAL_STEP_FIGHT_WIN;
               break;
            case 10121:
               stepId = TUTORIAL_STEP_FIGHT_WIN_BIS;
               break;
            case 10016:
               stepId = TUTORIAL_STEP_TALK_TO_DARM_2;
               break;
            case 9734:
               stepId = TUTORIAL_STEP_CHANGE_MAP_6;
         }
         return stepId;
      }
      
      private function setStepInfo(pStep:uint, pPropertyName:String, pValue:*) : void
      {
         if(!this._stepInfos[pStep])
         {
            this._stepInfos[pStep] = {};
         }
         this._stepInfos[pStep][pPropertyName] = pValue;
      }
      
      private function getStepFromQuestInfos(pQuestInfos:Object) : uint
      {
         var stepId:uint = 0;
         var q:Quest = null;
         var step:QuestStep = null;
         var i:int = 0;
         if(pQuestInfos)
         {
            q = Quest.getQuestById(pQuestInfos.questId);
            for each(step in q.steps)
            {
               if(step.id == pQuestInfos.stepId)
               {
                  break;
               }
            }
            for(i = 0; i < step.objectives.length; i++)
            {
               if(pQuestInfos.objectives[step.objectives[i].id] == false)
               {
                  stepId = step.objectives[i].id;
               }
            }
            if(stepId > 0)
            {
               stepId = this.getQuestStepEventId(stepId);
            }
         }
         return stepId;
      }
   }
}

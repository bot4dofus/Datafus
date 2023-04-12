package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.FrustumManager;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.bonus.Bonus;
   import com.ankamagames.dofus.datacenter.bonus.QuestKamasBonus;
   import com.ankamagames.dofus.datacenter.bonus.QuestXPBonus;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.TreasureHuntWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.managers.AlmanaxManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class QuestApi implements IApi
   {
      
      private static var _instance:QuestApi;
       
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function QuestApi()
      {
         this._log = Log.getLogger(getQualifiedClassName(QuestApi));
         super();
      }
      
      public static function getInstance() : QuestApi
      {
         if(!_instance)
         {
            _instance = new QuestApi();
         }
         return _instance;
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      public function destroy() : void
      {
         this._module = null;
      }
      
      public function getQuestInformations(questId:int) : Object
      {
         return this.getQuestFrame().getQuestInformations(questId);
      }
      
      public function getAllQuests() : Vector.<Object>
      {
         var activeQuest:QuestActiveInformations = null;
         var completedQuests:Vector.<uint> = null;
         var completedQuest:uint = 0;
         var r:Vector.<Object> = new Vector.<Object>(0,false);
         var activeQuests:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
         for each(activeQuest in activeQuests)
         {
            r.push({
               "id":activeQuest.questId,
               "status":true
            });
         }
         completedQuests = this.getQuestFrame().getCompletedQuests();
         for each(completedQuest in completedQuests)
         {
            r.push({
               "id":completedQuest,
               "status":false
            });
         }
         return r;
      }
      
      public function getActiveQuests() : Vector.<uint>
      {
         var activeQuest:QuestActiveInformations = null;
         var data:Vector.<uint> = new Vector.<uint>();
         var activeQuests:Vector.<QuestActiveInformations> = this.getQuestFrame().getActiveQuests();
         for each(activeQuest in activeQuests)
         {
            data.push(activeQuest.questId);
         }
         return data;
      }
      
      public function getCompletedQuests() : Vector.<uint>
      {
         return this.getQuestFrame().getCompletedQuests();
      }
      
      public function getReinitDoneQuests() : Vector.<uint>
      {
         return this.getQuestFrame().getReinitDoneQuests();
      }
      
      public function getAllQuestsOrderByCategory(withCompletedQuests:Boolean = false, withActiveQuests:Boolean = true) : Array
      {
         var quest:Quest = null;
         var questInfos:QuestActiveInformations = null;
         var category:Object = null;
         var activeQuests:Vector.<QuestActiveInformations> = null;
         var questId:uint = 0;
         var completedQuests:Vector.<uint> = null;
         var catsListWithQuests:Array = new Array();
         var tabIndex:uint = 0;
         if(withActiveQuests)
         {
            activeQuests = this.getQuestFrame().getActiveQuests();
            for each(questInfos in activeQuests)
            {
               quest = Quest.getQuestById(questInfos.questId);
               if(quest)
               {
                  tabIndex = quest.category.order;
                  if(tabIndex > catsListWithQuests.length || !catsListWithQuests[tabIndex])
                  {
                     category = new Object();
                     category.data = new Array();
                     category.id = quest.categoryId;
                     catsListWithQuests[tabIndex] = category;
                  }
                  catsListWithQuests[tabIndex].data.push({
                     "id":questInfos.questId,
                     "status":true
                  });
               }
            }
         }
         if(withCompletedQuests)
         {
            completedQuests = this.getQuestFrame().getCompletedQuests();
            for each(questId in completedQuests)
            {
               quest = Quest.getQuestById(questId);
               if(quest)
               {
                  tabIndex = quest.category.order;
                  if(tabIndex > catsListWithQuests.length || !catsListWithQuests[tabIndex])
                  {
                     category = new Object();
                     category.data = new Array();
                     category.id = quest.categoryId;
                     catsListWithQuests[tabIndex] = category;
                  }
                  catsListWithQuests[tabIndex].data.push({
                     "id":questId,
                     "status":false
                  });
               }
            }
         }
         return catsListWithQuests;
      }
      
      public function getTutorialReward() : Vector.<ItemWrapper>
      {
         var itemWrapperList:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         itemWrapperList.push(ItemWrapper.create(0,0,10785,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10794,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10797,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10798,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10799,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10784,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10800,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10801,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10792,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10793,2,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10795,1,null,false));
         itemWrapperList.push(ItemWrapper.create(0,0,10796,1,null,false));
         return itemWrapperList;
      }
      
      public function getNotificationList() : Array
      {
         return QuestFrame.notificationList;
      }
      
      public function getFinishedAchievements() : Vector.<AchievementAchieved>
      {
         return this.getQuestFrame().finishedAchievements;
      }
      
      public function getFinishedCharacterAchievementIds() : Array
      {
         return this.getQuestFrame().finishedCharacterAchievementIds;
      }
      
      public function getFinishedAccountAchievementIds() : Array
      {
         return this.getQuestFrame().finishedAccountAchievementIds;
      }
      
      public function isAchievementConditionRespectedForSpecificLevel(achievementReward:AchievementReward, level:int = 0) : Boolean
      {
         return achievementReward.isConditionRespectedForSpecificLevel(level);
      }
      
      public function getAchievementKamasReward(achievement:Achievement, level:int = 0) : Number
      {
         if(level == 0)
         {
            level = PlayedCharacterManager.getInstance().limitedLevel;
         }
         return achievement.getKamasReward(level);
      }
      
      public function getAchievementExperienceReward(achievement:Achievement, level:int = 0) : Number
      {
         if(level == 0)
         {
            level = PlayedCharacterManager.getInstance().limitedLevel;
         }
         return achievement.getExperienceReward(level,PlayedCharacterManager.getInstance().experiencePercent);
      }
      
      public function getAchievementReward(achievement:Achievement, level:int = 0, showAllReward:Boolean = false) : AchievementRewardsWrapper
      {
         if(level == 0)
         {
            level = PlayedCharacterManager.getInstance().limitedLevel;
         }
         return achievement.getAchievementRewardByLevel(level,showAllReward);
      }
      
      public function getAchievementRewardsText(achievementRewards:AchievementRewardsWrapper) : String
      {
         var id:uint = 0;
         var reward:AchievementReward = null;
         var result:String = "";
         for each(reward in achievementRewards.rewardsList)
         {
            for each(id in reward.itemsReward)
            {
               result += "\r" + I18n.getUiText("ui.common.item",[Item.getItemById(id).name]);
            }
            for each(id in reward.emotesReward)
            {
               result += "\r" + I18n.getUiText("ui.common.emote",[Emoticon.getEmoticonById(id).name]);
            }
            for each(id in reward.ornamentsReward)
            {
               result += "\r" + I18n.getUiText("ui.common.ornament",[Ornament.getOrnamentById(id).name]);
            }
            for each(id in reward.spellsReward)
            {
               result += "\r" + I18n.getUiText("ui.common.spell",[Spell.getSpellById(id).name]);
            }
            for each(id in reward.titlesReward)
            {
               result += "\r" + I18n.getUiText("ui.common.title",[Title.getTitleById(id).name]);
            }
         }
         if(result.length > 0)
         {
            result = result.slice(1);
         }
         return result;
      }
      
      public function getRewardableAchievements() : Vector.<AchievementAchievedRewardable>
      {
         return !!this.getQuestFrame() ? this.getQuestFrame().rewardableAchievements : null;
      }
      
      public function getAchievementObjectivesNames(achId:int) : String
      {
         var objId:int = 0;
         var objAch:AchievementObjective = null;
         var text:String = "-";
         var a:Achievement = Achievement.getAchievementById(achId);
         for each(objId in a.objectiveIds)
         {
            objAch = AchievementObjective.getAchievementObjectiveById(objId);
            if(objAch && objAch.name)
            {
               text += " " + StringUtils.noAccent(objAch.name).toLowerCase();
            }
         }
         return text;
      }
      
      public function getTreasureHunt(typeId:int) : TreasureHuntWrapper
      {
         return this.getQuestFrame().getTreasureHuntById(typeId);
      }
      
      public function getAlmanaxQuestXpBonusMultiplier(pQuestId:uint) : Number
      {
         var bonusId:int = 0;
         var bonus:Bonus = null;
         var mul:Number = NaN;
         for each(bonusId in AlmanaxManager.getInstance().calendar.bonusesIds)
         {
            bonus = Bonus.getBonusById(bonusId);
            if(bonus is QuestXPBonus && bonus.isRespected(Quest.getQuestById(pQuestId).categoryId))
            {
               if(isNaN(mul))
               {
                  mul = 1;
               }
               mul *= bonus.amount / 100;
            }
         }
         return !isNaN(mul) ? Number(mul) : Number(0);
      }
      
      public function getAlmanaxQuestKamasBonusMultiplier(pQuestId:uint) : Number
      {
         var bonusId:int = 0;
         var bonus:Bonus = null;
         var mul:Number = NaN;
         for each(bonusId in AlmanaxManager.getInstance().calendar.bonusesIds)
         {
            bonus = Bonus.getBonusById(bonusId);
            if(bonus is QuestKamasBonus && bonus.isRespected(Quest.getQuestById(pQuestId).categoryId))
            {
               if(isNaN(mul))
               {
                  mul = 1;
               }
               mul *= bonus.amount / 100;
            }
         }
         return !isNaN(mul) ? Number(mul) : Number(0);
      }
      
      public function toggleWorldMask(name:String) : void
      {
         var worldMask:Sprite = Atouin.getInstance().getWorldMask(name);
         if(!worldMask.visible)
         {
            Atouin.getInstance().setWorldMaskDimensions(StageShareManager.startWidth + AtouinConstants.CELL_HALF_WIDTH / 2,FrustumManager.getInstance().frustum.marginBottom,0,0.7,name);
         }
         Atouin.getInstance().toggleWorldMask(name,!worldMask.visible);
      }
      
      public function getQuestObjectiveFlagInfos(questId:uint, objectiveId:uint) : Object
      {
         var mapPos:MapPosition = null;
         var subArea:SubArea = null;
         var objective:QuestObjective = QuestObjective.getQuestObjectiveById(objectiveId);
         if(!objective || !PlayedCharacterManager.getInstance().currentWorldMap || !PlayedCharacterManager.getInstance().currentSubArea || objective.mapId && !MapPosition.getMapPositionById(objective.mapId))
         {
            return null;
         }
         var newFlagId:String = "flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST + "_" + questId + "_" + objective.id;
         var flagX:Number = !!objective.coords ? Number(objective.coords.x) : Number(NaN);
         var flagY:Number = !!objective.coords ? Number(objective.coords.y) : Number(NaN);
         var worldMapId:int = 1;
         var flagText:String = I18n.getUiText("ui.common.quests") + "\n" + HyperlinkFactory.decode(objective.text,false);
         if(objective.mapId)
         {
            mapPos = MapPosition.getMapPositionById(objective.mapId);
            subArea = SubArea.getSubAreaById(mapPos.subAreaId);
            worldMapId = subArea.worldmap.id;
            flagX = mapPos.posX;
            flagY = mapPos.posY;
         }
         if(!isNaN(flagX) && !isNaN(flagY))
         {
            flagText += " (" + flagX + "," + flagY + ")";
         }
         return {
            "id":newFlagId,
            "text":flagText,
            "worldMapId":worldMapId,
            "x":flagX,
            "y":flagY
         };
      }
      
      public function getFollowedQuests() : Vector.<uint>
      {
         var questFrame:QuestFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         return questFrame.getFollowedQuests();
      }
      
      public function refreshAchievementsCriterions() : void
      {
         (Kernel.getWorker().getFrame(QuestFrame) as QuestFrame).processAchievements();
      }
      
      private function getQuestFrame() : QuestFrame
      {
         return Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
      }
   }
}

package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Quest implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Quest));
      
      public static const MODULE:String = "Quests";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getQuestById,getQuests);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var stepIds:Vector.<uint>;
      
      public var categoryId:uint;
      
      public var repeatType:uint;
      
      public var repeatLimit:uint;
      
      public var isDungeonQuest:Boolean;
      
      public var levelMin:uint;
      
      public var levelMax:uint;
      
      public var isPartyQuest:Boolean;
      
      public var startCriterion:String;
      
      public var followable:Boolean;
      
      private var _name:String;
      
      private var _steps:Vector.<QuestStep>;
      
      private var _conditions:GroupItemCriterion;
      
      public function Quest()
      {
         super();
      }
      
      public static function getFirstValidQuest(questFlag:GameRolePlayNpcQuestFlag) : Quest
      {
         var validQuest:Quest = null;
         var quest:Quest = null;
         var questId:int = 0;
         var res1:int = 0;
         var res2:int = 0;
         var validQuestRes:int = 0;
         for each(questId in questFlag.questsToValidId)
         {
            quest = Quest.getQuestById(questId);
            if(quest != null)
            {
               res1 = quest.getPriorityValue();
               if(validQuestRes < res1 || validQuest == null)
               {
                  validQuest = quest;
                  validQuestRes = res1;
               }
            }
         }
         for each(questId in questFlag.questsToStartId)
         {
            quest = Quest.getQuestById(questId);
            if(quest != null)
            {
               res2 = quest.getPriorityValue();
               if(validQuestRes < res2 || validQuest == null)
               {
                  validQuest = quest;
                  validQuestRes = res2;
               }
            }
         }
         return validQuest;
      }
      
      public static function getQuestById(id:int) : Quest
      {
         return GameData.getObject(MODULE,id) as Quest;
      }
      
      public static function getQuests() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get steps() : Vector.<QuestStep>
      {
         var i:uint = 0;
         if(!this._steps)
         {
            this._steps = new Vector.<QuestStep>(this.stepIds.length,true);
            for(i = 0; i < this.steps.length; i++)
            {
               this._steps[i] = QuestStep.getQuestStepById(this.stepIds[i]);
            }
         }
         return this._steps;
      }
      
      public function get category() : QuestCategory
      {
         return QuestCategory.getQuestCategoryById(this.categoryId);
      }
      
      public function get canBeStarted() : Boolean
      {
         if(!this._conditions && this.startCriterion)
         {
            this._conditions = new GroupItemCriterion(this.startCriterion);
         }
         return !!this._conditions ? Boolean(this._conditions.isRespected) : true;
      }
      
      public function getPriorityValue() : int
      {
         var playerLvl:int = PlayedCharacterManager.getInstance().limitedLevel;
         var res:int = 0;
         if(playerLvl >= this.levelMin && playerLvl <= this.levelMax)
         {
            res += 10000;
         }
         if(this.repeatType != 0)
         {
            res += 1000;
         }
         return res;
      }
   }
}

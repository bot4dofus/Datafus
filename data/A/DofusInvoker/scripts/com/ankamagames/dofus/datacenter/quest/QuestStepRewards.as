package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class QuestStepRewards implements IDataCenter
   {
      
      public static const MODULE:String = "QuestStepRewards";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getQuestStepRewardsById,getQuestStepRewards);
       
      
      public var id:uint;
      
      public var stepId:uint;
      
      public var levelMin:int;
      
      public var levelMax:int;
      
      public var kamasRatio:Number;
      
      public var experienceRatio:Number;
      
      public var kamasScaleWithPlayerLevel:Boolean;
      
      public var itemsReward:Vector.<Vector.<uint>>;
      
      public var emotesReward:Vector.<uint>;
      
      public var jobsReward:Vector.<uint>;
      
      public var spellsReward:Vector.<uint>;
      
      public var titlesReward:Vector.<uint>;
      
      protected var _questStep:QuestStep;
      
      public function QuestStepRewards()
      {
         super();
      }
      
      public static function getQuestStepRewardsById(id:int) : QuestStepRewards
      {
         return GameData.getObject(MODULE,id) as QuestStepRewards;
      }
      
      public static function getQuestStepRewards() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get questStep() : QuestStep
      {
         if(!this._questStep)
         {
            this._questStep = QuestStep.getQuestStepById(this.stepId);
         }
         return this._questStep;
      }
      
      public function get kamasReward() : Number
      {
         return RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel,this.questStep.optimalLevel,this.kamasRatio,this.questStep.duration);
      }
      
      public function get experienceReward() : uint
      {
         return RoleplayManager.getInstance().getExperienceReward(PlayedCharacterManager.getInstance().limitedLevel,PlayedCharacterManager.getInstance().experiencePercent,this.questStep.optimalLevel,this.experienceRatio,this.questStep.duration);
      }
      
      public function getKamasReward(pPlayerLevel:int) : Number
      {
         return RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel,this.questStep.optimalLevel,this.kamasRatio,this.questStep.duration,pPlayerLevel);
      }
      
      public function getExperienceReward(pPlayerLevel:int, pXpBonus:int) : Number
      {
         return RoleplayManager.getInstance().getExperienceReward(pPlayerLevel,pXpBonus,this.questStep.optimalLevel,this.experienceRatio,this.questStep.duration);
      }
   }
}

package com.ankamagames.dofus.datacenter.quest
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.ItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.LevelItemCriterion;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementReward implements IDataCenter
   {
      
      public static const MODULE:String = "AchievementRewards";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAchievementRewardById,getAchievementRewards);
       
      
      public var id:uint;
      
      public var achievementId:uint;
      
      public var criteria:String;
      
      public var kamasRatio:Number;
      
      public var experienceRatio:Number;
      
      public var kamasScaleWithPlayerLevel:Boolean;
      
      public var itemsReward:Vector.<uint>;
      
      public var itemsQuantityReward:Vector.<uint>;
      
      public var emotesReward:Vector.<uint>;
      
      public var spellsReward:Vector.<uint>;
      
      public var titlesReward:Vector.<uint>;
      
      public var ornamentsReward:Vector.<uint>;
      
      public var guildPoints:uint;
      
      private var _achievement:Achievement;
      
      private var _conditions:GroupItemCriterion;
      
      public function AchievementReward()
      {
         super();
      }
      
      public static function getAchievementRewardById(id:int) : AchievementReward
      {
         return GameData.getObject(MODULE,id) as AchievementReward;
      }
      
      public static function getAchievementRewards() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get achievement() : Achievement
      {
         if(!this._achievement)
         {
            this._achievement = Achievement.getAchievementById(this.achievementId);
         }
         return this._achievement;
      }
      
      public function get conditions() : GroupItemCriterion
      {
         if(!this.criteria)
         {
            return null;
         }
         if(!this._conditions)
         {
            this._conditions = new GroupItemCriterion(this.criteria);
         }
         return this._conditions;
      }
      
      public function getKamasReward(pPlayerLevel:int) : Number
      {
         return RoleplayManager.getInstance().getKamasReward(this.kamasScaleWithPlayerLevel,this.achievement.level,this.kamasRatio,1,pPlayerLevel);
      }
      
      public function getExperienceReward(pPlayerLevel:int, pXpBonus:int) : Number
      {
         return RoleplayManager.getInstance().getExperienceReward(pPlayerLevel,pXpBonus,this.achievement.level,this.experienceRatio);
      }
      
      public function getGuildPointsReward() : Number
      {
         return this.guildPoints;
      }
      
      public function isConditionRespectedForSpecificLevel(level:uint) : Boolean
      {
         var levelCriterion:LevelItemCriterion = null;
         var levelCriterionResult:Boolean = false;
         var criterion:IItemCriterion = null;
         if(this.conditions == null)
         {
            return true;
         }
         if(this.conditions.criteria && this.conditions.criteria.length == 1 && this.conditions.criteria[0] is ItemCriterion)
         {
            if(this.conditions.criteria[0] is LevelItemCriterion)
            {
               levelCriterion = this.conditions.criteria[0] as LevelItemCriterion;
               return levelCriterion.operator.compare(level,levelCriterion.criterionValue as Number);
            }
            return (this.conditions.criteria[0] as ItemCriterion).isRespected;
         }
         if(this.conditions.operators.length > 0 && this.conditions.operators[0] == "|")
         {
            for each(criterion in this.conditions.criteria)
            {
               if(criterion is LevelItemCriterion)
               {
                  levelCriterion = criterion as LevelItemCriterion;
                  levelCriterionResult = levelCriterion.operator.compare(level,levelCriterion.criterionValue as Number);
                  if(levelCriterionResult)
                  {
                     return true;
                  }
               }
               else if(criterion.isRespected)
               {
                  return true;
               }
            }
            return false;
         }
         for each(criterion in this.conditions.criteria)
         {
            if(criterion is LevelItemCriterion)
            {
               levelCriterion = criterion as LevelItemCriterion;
               levelCriterionResult = levelCriterion.operator.compare(level,levelCriterion.criterionValue as Number);
               if(!levelCriterionResult)
               {
                  return false;
               }
            }
            else if(!criterion.isRespected)
            {
               return false;
            }
         }
         return true;
      }
      
      public function toString() : String
      {
         var text:* = "Reward " + this.id + " (" + this.criteria + ") : ";
         if(this.kamasRatio > 0)
         {
            text += "     kamasRatio " + this.kamasRatio + "   (scale with player ? " + this.kamasScaleWithPlayerLevel + ")";
         }
         if(this.experienceRatio > 0)
         {
            text += "     experienceRatio " + this.experienceRatio;
         }
         if(this.itemsReward.length > 0)
         {
            text += "     itemsReward " + this.itemsReward;
         }
         if(this.emotesReward.length > 0)
         {
            text += "     emotesReward " + this.emotesReward;
         }
         if(this.spellsReward.length > 0)
         {
            text += "     spellsReward " + this.spellsReward;
         }
         if(this.titlesReward.length > 0)
         {
            text += "     titlesReward " + this.titlesReward;
         }
         if(this.ornamentsReward.length > 0)
         {
            text += "     ornamentsReward " + this.ornamentsReward;
         }
         return text;
      }
   }
}

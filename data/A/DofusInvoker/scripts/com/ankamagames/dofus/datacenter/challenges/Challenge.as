package com.ankamagames.dofus.datacenter.challenges
{
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getQualifiedClassName;
   
   public class Challenge implements IDataCenter
   {
      
      public static const MODULE:String = "Challenges";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Challenge));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getChallengeById,getChallenges);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var incompatibleChallenges:Vector.<uint>;
      
      public var categoryId:int;
      
      public var iconId:uint;
      
      public var activationCriterion:String;
      
      public var completionCriterion:String;
      
      public var targetMonsterId:uint;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _boundAchievements:Vector.<Achievement> = null;
      
      private var _uri:Uri = null;
      
      public function Challenge()
      {
         super();
      }
      
      public static function getChallengeById(id:int) : Challenge
      {
         return GameData.getObject(MODULE,id) as Challenge;
      }
      
      public static function getChallenges() : Array
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
      
      public function get description() : String
      {
         if(!this._description)
         {
            this._description = I18n.getText(this.descriptionId);
         }
         return this._description;
      }
      
      public function get boundAchievements() : Vector.<Achievement>
      {
         var criterionId:int = 0;
         if(this._boundAchievements !== null)
         {
            return this._boundAchievements;
         }
         var achievementObjectiveIds:Vector.<uint> = GameDataQuery.queryString(AchievementObjective,"criterion","EH>" + this.id.toString());
         var achievementObjective:AchievementObjective = null;
         var achievement:Achievement = null;
         var achievements:Vector.<Achievement> = new Vector.<Achievement>();
         if(achievementObjectiveIds === null)
         {
            return achievements;
         }
         for(var index:uint = 0; index < achievementObjectiveIds.length; index++)
         {
            achievementObjective = AchievementObjective.getAchievementObjectiveById(achievementObjectiveIds[index]);
            criterionId = parseInt(achievementObjective.criterion.substring(achievementObjective.criterion.indexOf("EH>") + 3,achievementObjective.criterion.indexOf(",",achievementObjective.criterion.indexOf("EH>") + 3)));
            if(!(achievementObjective === null || criterionId != this.id))
            {
               achievement = Achievement.getAchievementById(achievementObjective.achievementId);
               if(achievement !== null)
               {
                  achievements.push(achievement);
               }
            }
         }
         this._boundAchievements = achievements;
         return this._boundAchievements;
      }
      
      public function get iconUri() : Uri
      {
         var basePath:String = null;
         if(!this._uri)
         {
            basePath = XmlConfig.getInstance().getEntry("config.gfx.path.challenges");
            if(basePath === null)
            {
               return null;
            }
            this._uri = new Uri(basePath.concat(this.iconId).concat(".png"));
         }
         return this._uri;
      }
      
      public function getTurnsNumberForCompletion() : Number
      {
         var criteria:String = null;
         var criteriaData:Array = null;
         if(!this.completionCriterion)
         {
            return Number.NaN;
         }
         var criterion:Array = this.completionCriterion.split("&");
         for each(criteria in criterion)
         {
            if(criteria.indexOf("ST<") !== -1)
            {
               criteriaData = criteria.split("ST<");
               if(criteriaData.length < 2)
               {
                  return Number.NaN;
               }
               return Number(criteriaData[1]);
            }
         }
         return Number.NaN;
      }
      
      public function getBoundBossId() : Number
      {
         var criteria:String = null;
         var criteriaData:Array = null;
         if(!this.activationCriterion)
         {
            return Number.NaN;
         }
         var criterion:Array = this.activationCriterion.split("&");
         for each(criteria in criterion)
         {
            if(criteria.indexOf("GM>") !== -1)
            {
               criteriaData = criteria.split(",");
               if(criteriaData.length < 2)
               {
                  return Number.NaN;
               }
               return Number(criteriaData[1]);
            }
         }
         return Number.NaN;
      }
      
      public function getTargetMonsterId() : Number
      {
         return this.targetMonsterId;
      }
      
      public function getPlayersNumberType() : Number
      {
         var criteria:String = null;
         var criteriaData:Array = null;
         var criteriaParams:String = null;
         if(!this.activationCriterion)
         {
            return Number.NaN;
         }
         var criterion:Array = this.activationCriterion.split("&");
         for each(criteria in criterion)
         {
            if(criteria.indexOf("GN<") !== -1)
            {
               criteriaData = criteria.split("<");
               if(criteriaData.length < 2)
               {
                  return Number.NaN;
               }
               criteriaParams = criteriaData[1];
               if(criteriaParams)
               {
                  return Number(criteriaParams.split(",")[0]);
               }
               return Number.NaN;
            }
         }
         return Number.NaN;
      }
   }
}

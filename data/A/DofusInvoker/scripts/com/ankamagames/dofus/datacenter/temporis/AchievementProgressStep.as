package com.ankamagames.dofus.datacenter.temporis
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AchievementProgressStep implements IDataCenter
   {
      
      public static const MODULE:String = "AchievementProgressSteps";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAchievementProgressStepById,getAchievementProgressSteps);
       
      
      public var id:int;
      
      public var progressId:int;
      
      public var score:int;
      
      public var isCosmetic:Boolean;
      
      public var achievementId:int;
      
      public var isBuyable:Boolean;
      
      public function AchievementProgressStep()
      {
         super();
      }
      
      public static function getAchievementProgressStepById(id:int) : AchievementProgressStep
      {
         return GameData.getObject(MODULE,id) as AchievementProgressStep;
      }
      
      public static function getAchievementProgressSteps() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public static function getAchievementProgressStepsByProgressId(id:int) : Array
      {
         var achievementProgressStep:AchievementProgressStep = null;
         var achievementProgressSteps:Array = getAchievementProgressSteps();
         var filteredAchievementProgressSteps:Array = [];
         for each(achievementProgressStep in achievementProgressSteps)
         {
            if(achievementProgressStep.progressId === id)
            {
               filteredAchievementProgressSteps.push(achievementProgressStep);
            }
         }
         return filteredAchievementProgressSteps;
      }
   }
}

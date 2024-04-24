package com.ankamagames.dofus.internalDatacenter.fight
{
   public class EnumChallengeCategory
   {
      
      public static const FIGHT:uint = 1;
      
      public static const ACHIEVEMENT_DUNGEON:uint = 3;
      
      public static const ACHIEVEMENT_ANOMALY:uint = 9;
      
      public static const ACHIEVEMENT_COMPANION:uint = 11;
      
      public static const ACHIEVEMENT_EXPEDITION:uint = 10;
      
      public static const ACHIEVEMENT_SHADOW_EVENT:uint = 14;
      
      public static const ACHIEVEMENT_BETA:uint = 15;
      
      public static const PANDALA:uint = 4;
      
      public static const TEST:uint = 5;
       
      
      public function EnumChallengeCategory()
      {
         super();
      }
      
      public static function isAchievementCategoryId(id:uint) : Boolean
      {
         return id == ACHIEVEMENT_DUNGEON || id == ACHIEVEMENT_ANOMALY || id == ACHIEVEMENT_COMPANION || id == ACHIEVEMENT_EXPEDITION || id == ACHIEVEMENT_SHADOW_EVENT || id == ACHIEVEMENT_BETA;
      }
   }
}

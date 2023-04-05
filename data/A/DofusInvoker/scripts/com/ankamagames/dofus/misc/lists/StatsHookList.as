package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class StatsHookList
   {
      
      public static const GameGuideArticleSelectionType:String = "GameGuideArticleSelectionType";
      
      public static const LogBookHistoryStats:String = "LogBookHistoryStats";
       
      
      public function StatsHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(GameGuideArticleSelectionType);
         Hook.createHook(LogBookHistoryStats);
      }
   }
}

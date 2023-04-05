package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.dofus.network.messages.connection.IdentificationSuccessMessage;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   
   public class StatisticsFrame implements Frame
   {
       
      
      private var _stats:Dictionary;
      
      public function StatisticsFrame(pStats:Dictionary)
      {
         super();
         this._stats = pStats;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var stats:IStatsClass = null;
         var ftue:* = undefined;
         var uiName:* = null;
         if(msg is IdentificationSuccessMessage)
         {
            ftue = StatisticsManager.getInstance().getData("firstTimeUserExperience-" + StatsAction.getUserId());
            if(ftue)
            {
               for(uiName in ftue)
               {
                  StatisticsManager.getInstance().setFirstTimeUserExperience(uiName,ftue[uiName]);
               }
            }
         }
         for each(stats in this._stats)
         {
            if(!(msg is HumanInputMessage) && !(msg is Action))
            {
               stats.process(msg);
            }
         }
         return false;
      }
      
      public function get priority() : int
      {
         return Priority.LOG;
      }
   }
}

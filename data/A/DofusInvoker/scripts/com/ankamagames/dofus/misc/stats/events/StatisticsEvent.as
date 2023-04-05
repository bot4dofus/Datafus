package com.ankamagames.dofus.misc.stats.events
{
   import flash.events.Event;
   
   public class StatisticsEvent extends Event
   {
      
      public static const ALL_DATA_SENT:String = "StatisticsEvent.ALL_DATA_SENT";
       
      
      public function StatisticsEvent(pType:String, pBubbles:Boolean = false, pCancelable:Boolean = false)
      {
         super(pType,pBubbles,pCancelable);
      }
   }
}

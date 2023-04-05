package com.ankamagames.berilia.types.tooltip.event
{
   import flash.events.Event;
   
   public class TooltipEvent extends Event
   {
      
      public static const TOOLTIPS_ORDERED:String = "TooltipEvent.TOOLTIPS_ORDERED";
       
      
      public function TooltipEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}

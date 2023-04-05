package com.ankamagames.berilia.types.event
{
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import flash.events.Event;
   
   public class CssEvent extends Event
   {
      
      public static const CSS_PARSED:String = "event_css_parsed";
       
      
      private var _stylesheet:ExtendedStyleSheet;
      
      public function CssEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, stylesheet:ExtendedStyleSheet = null)
      {
         super(type,bubbles,cancelable);
         this._stylesheet = stylesheet;
      }
      
      public function get stylesheet() : ExtendedStyleSheet
      {
         return this._stylesheet;
      }
   }
}

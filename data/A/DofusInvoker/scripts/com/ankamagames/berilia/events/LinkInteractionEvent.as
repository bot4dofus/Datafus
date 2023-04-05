package com.ankamagames.berilia.events
{
   import flash.events.Event;
   
   public class LinkInteractionEvent extends Event
   {
      
      public static const ROLL_OVER:String = "RollOverLink";
      
      public static const ROLL_OUT:String = "RollOutLink";
       
      
      public var text:String;
      
      public function LinkInteractionEvent(type:String, pText:String = "")
      {
         this.text = pText;
         super(type,false,false);
      }
   }
}

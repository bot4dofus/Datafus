package com.ankamagames.tiphon.events
{
   import flash.events.Event;
   
   public class SwlEvent extends Event
   {
      
      public static const SWL_LOADED:String = "onSwfLoaded";
       
      
      private var _url:String;
      
      public function SwlEvent(type:String, pUrl:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this._url = pUrl;
      }
      
      override public function clone() : Event
      {
         return new SwlEvent(type,this.url,bubbles,cancelable);
      }
      
      public function get url() : String
      {
         return this._url;
      }
   }
}

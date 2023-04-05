package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   
   public class LangFileEvent extends Event
   {
      
      public static var ALL_COMPLETE:String = "LangFileEvent_ALL_COMPLETE";
      
      public static var COMPLETE:String = "LangFileEvent_COMPLETE";
       
      
      private var _sUrl:String;
      
      private var _sUrlProvider:String;
      
      public function LangFileEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, sUrl:String = null, sUrlProvider:String = null)
      {
         super(type,bubbles,cancelable);
         this._sUrl = sUrl;
         this._sUrlProvider = sUrlProvider;
      }
      
      override public function clone() : Event
      {
         return new LangFileEvent(type,bubbles,cancelable,this._sUrl,this._sUrlProvider);
      }
      
      public function get url() : String
      {
         return this._sUrl;
      }
      
      public function get urlProvider() : String
      {
         return this._sUrlProvider;
      }
   }
}

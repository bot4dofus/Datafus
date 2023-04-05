package com.ankamagames.berilia.types.event
{
   import flash.events.Event;
   
   public class ParsingErrorEvent extends Event
   {
      
      public static const ERROR:String = "ParsingErrorEvent_Error";
       
      
      private var _url:String;
      
      private var _msg:String;
      
      public function ParsingErrorEvent(url:String, msg:String)
      {
         super(ERROR);
         this._url = url;
         this._msg = msg;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function get msg() : String
      {
         return this._msg;
      }
   }
}

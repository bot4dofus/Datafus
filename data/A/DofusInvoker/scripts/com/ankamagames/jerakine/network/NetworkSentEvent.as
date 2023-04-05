package com.ankamagames.jerakine.network
{
   import flash.events.Event;
   
   public class NetworkSentEvent extends Event
   {
      
      public static const EVENT_SENT:String = "messageSent";
       
      
      private var _message:INetworkMessage;
      
      public function NetworkSentEvent(type:String, msg:INetworkMessage)
      {
         super(type,false,false);
         this._message = msg;
      }
      
      public function get message() : INetworkMessage
      {
         return this._message;
      }
   }
}

package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import flash.events.Event;
   
   public class NetworkLogEvent extends LogEvent
   {
       
      
      private var _msg:INetworkMessage;
      
      private var _isServerMsg:Boolean;
      
      public function NetworkLogEvent(msg:INetworkMessage, isServerMsg:Boolean)
      {
         super(null,null,0);
         this._msg = msg;
         this._isServerMsg = isServerMsg;
         FpsManager.getInstance().watchObject(this,false,"NetworkLogEvent");
      }
      
      public function get networkMessage() : INetworkMessage
      {
         return this._msg;
      }
      
      public function get isServerMsg() : Boolean
      {
         return this._isServerMsg;
      }
      
      override public function clone() : Event
      {
         return new NetworkLogEvent(this._msg,this._isServerMsg);
      }
   }
}

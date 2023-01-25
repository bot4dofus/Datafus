package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.AsyncErrorEvent;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.SecurityErrorEvent;
   import flash.events.StatusEvent;
   import flash.events.TimerEvent;
   import flash.net.LocalConnection;
   import flash.utils.getQualifiedClassName;
   
   public class InterClientSlave
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientSlave));
       
      
      private var _receiving_lc:LocalConnection;
      
      private var _sending_lc:LocalConnection;
      
      private var _statusTimer:BenchmarkTimer;
      
      private var _waitingFocusMessage:Array;
      
      public var connId:String;
      
      public function InterClientSlave()
      {
         this._waitingFocusMessage = new Array();
         super();
         this._sending_lc = new LocalConnection();
         this._sending_lc.allowDomain("*");
         this._sending_lc.allowInsecureDomain("*");
         this._sending_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._sending_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._sending_lc.addEventListener(StatusEvent.STATUS,this.onSendingStatusChange);
         this._receiving_lc = new LocalConnection();
         this._receiving_lc.allowDomain("*");
         this._receiving_lc.allowInsecureDomain("*");
         this._receiving_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._receiving_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._receiving_lc.addEventListener(StatusEvent.STATUS,this.onStatusChange);
         this._receiving_lc.client = new Object();
         this._receiving_lc.client.pong = this.pong;
         this._receiving_lc.client.updateFocusMessage = this.updateFocusMessage;
         var idIsFree:Boolean = false;
         while(!idIsFree)
         {
            this.connId = "_dofus" + Math.floor(Math.random() * 100000000);
            try
            {
               this._receiving_lc.connect(this.connId);
               idIsFree = true;
            }
            catch(e:Error)
            {
            }
         }
         this._statusTimer = new BenchmarkTimer(10000,0,"InterClientSlave._statusTimer");
         this._statusTimer.addEventListener(TimerEvent.TIMER,this.onTick);
         this._statusTimer.start();
      }
      
      public function destroy() : void
      {
         this._receiving_lc.close();
         this._statusTimer.stop();
         this._statusTimer.removeEventListener(TimerEvent.TIMER,this.onTick);
         this._sending_lc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._sending_lc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._sending_lc.removeEventListener(StatusEvent.STATUS,this.onSendingStatusChange);
         this._receiving_lc.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._receiving_lc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      public function gainFocus(time:Number) : void
      {
         var message:String = null;
         message = this.connId + "," + time;
         try
         {
            this._sending_lc.send("_dofus","clientGainFocus",message);
         }
         catch(e:Error)
         {
            _waitingFocusMessage.push(message);
         }
      }
      
      public function updateFocusMessage(focusList:String) : void
      {
         _log.info("Client : " + focusList);
         InterClientManager.getInstance().clientListInfo = focusList.split(",");
         InterClientManager.getInstance().updateFocusList();
      }
      
      private function pong() : void
      {
      }
      
      private function onError(e:ErrorEvent) : void
      {
         _log.error(e.toString());
      }
      
      private function onTick(e:Event) : void
      {
         this._sending_lc.send("_dofus","ping",this.connId);
      }
      
      private function onSendingStatusChange(e:StatusEvent) : void
      {
         if(e.level == "error")
         {
            InterClientManager.getInstance().update();
            while(this._waitingFocusMessage.length)
            {
               this._sending_lc.send("_dofus","clientGainFocus",this._waitingFocusMessage.shift());
            }
         }
      }
      
      private function onStatusChange(e:StatusEvent) : void
      {
      }
   }
}

package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.PanicMessages;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.Metadata;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
   import com.ankamagames.dofus.network.messages.handshake.ProtocolRequired;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.ConnectedMessage;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class HandshakeFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HandshakeFrame));
      
      private static const TIMEOUT_DELAY:uint = 3000;
      
      private static const TIMEOUT_REPEAT_COUNT:uint = 1;
       
      
      private var _timeoutTimer:BenchmarkTimer;
      
      public function HandshakeFrame()
      {
         super();
      }
      
      private static function checkProtocolVersions(serverVersion:String) : void
      {
         _log.info("Server version is " + serverVersion + ". Client version is " + Metadata.PROTOCOL_BUILD + ".");
         if(!serverVersion || !Metadata.PROTOCOL_BUILD)
         {
            _log.fatal("A protocol version is empty or null. What happened?");
            Kernel.panic(PanicMessages.MALFORMED_PROTOCOL,[Metadata.PROTOCOL_BUILD,serverVersion]);
            return;
         }
         if(serverVersion !== Metadata.PROTOCOL_BUILD)
         {
            _log.fatal("Protocol mismatch between the client and the server.");
            Kernel.panic(PanicMessages.PROTOCOL_MISMATCH,[Metadata.PROTOCOL_BUILD,serverVersion]);
         }
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function pushed() : Boolean
      {
         ConnectionsHandler.hasReceivedNetworkMsg = false;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var prmsg:ProtocolRequired = null;
         ConnectionsHandler.hasReceivedMsg = true;
         if(msg is INetworkMessage)
         {
            ConnectionsHandler.hasReceivedNetworkMsg = true;
            if(this._timeoutTimer !== null)
            {
               this._timeoutTimer.stop();
            }
         }
         switch(true)
         {
            case msg is ProtocolRequired:
               prmsg = msg as ProtocolRequired;
               checkProtocolVersions(prmsg.version);
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is ConnectedMessage:
               this._timeoutTimer = new BenchmarkTimer(TIMEOUT_DELAY,TIMEOUT_REPEAT_COUNT,"HandshakeFrame._timeoutTimer");
               this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
               this._timeoutTimer.start();
               return true;
            default:
               return false;
         }
      }
      
      public function onTimeout(timerEvent:TimerEvent) : void
      {
         var pingMsg:BasicPingMessage = new BasicPingMessage();
         pingMsg.initBasicPingMessage(true);
         ConnectionsHandler.getConnection().send(pingMsg);
      }
      
      public function pulled() : Boolean
      {
         if(this._timeoutTimer !== null)
         {
            this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
         }
         return true;
      }
   }
}

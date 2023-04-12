package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.messages.common.basic.BasicPongMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsRequestMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.IServerConnection;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class LatencyFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LatencyFrame));
       
      
      public var pingRequested:uint;
      
      public function LatencyFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var bpmsg:BasicPongMessage = null;
         var pongReceived:uint = 0;
         var delay:uint = 0;
         var blsrmsg:BasicLatencyStatsRequestMessage = null;
         var connection:IServerConnection = null;
         var blsmsg:BasicLatencyStatsMessage = null;
         switch(true)
         {
            case msg is BasicPongMessage:
               bpmsg = msg as BasicPongMessage;
               if(bpmsg.quiet)
               {
                  return true;
               }
               pongReceived = getTimer();
               delay = pongReceived - this.pingRequested;
               this.pingRequested = 0;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,"Pong " + delay + "ms !",ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
               break;
            case msg is BasicLatencyStatsRequestMessage:
               blsrmsg = msg as BasicLatencyStatsRequestMessage;
               connection = ConnectionsHandler.getConnection().getSubConnection(blsrmsg.sourceConnection);
               blsmsg = new BasicLatencyStatsMessage();
               blsmsg.initBasicLatencyStatsMessage(Math.min(32767,connection.latencyAvg),connection.latencySamplesCount,connection.latencySamplesMax);
               ConnectionsHandler.getConnection().send(blsmsg,blsrmsg.sourceConnection);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}

package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.berilia.frames.UiStatsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.net.DisconnectionReason;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.zaap.ZaapApi;
   import com.ankamagames.dofus.logic.common.actions.OpenPopupAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.logic.connection.actions.ShowUpdaterLoginInterfaceAction;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
   import com.ankamagames.jerakine.network.messages.ServerConnectionClosedMessage;
   import com.ankamagames.jerakine.network.messages.UnexpectedSocketClosureMessage;
   import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class DisconnectionHandlerFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisconnectionHandlerFrame));
      
      private static const CONNECTION_ATTEMPTS_NUMBER:int = 4;
      
      public static var messagesAfterReset:Array = new Array();
       
      
      private var _connectionUnexpectedFailureTimes:Array;
      
      private var _numberOfAttemptsAlreadyDone:int = 0;
      
      private var _timer:BenchmarkTimer;
      
      private var _mustShowLoginInterface:Boolean = false;
      
      public function DisconnectionHandlerFrame()
      {
         this._connectionUnexpectedFailureTimes = new Array();
         super();
      }
      
      public function get priority() : int
      {
         return Priority.LOW;
      }
      
      public function resetConnectionAttempts() : void
      {
         this._connectionUnexpectedFailureTimes = new Array();
         StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG,"connection_fail_times",null);
         this._numberOfAttemptsAlreadyDone = 0;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sccmsg:ServerConnectionClosedMessage = null;
         var wscrmsg:WrongSocketClosureReasonMessage = null;
         var uscmsg:UnexpectedSocketClosureMessage = null;
         var rgamsg:ResetGameAction = null;
         var commonMod:Object = null;
         var reason:DisconnectionReason = null;
         var tabMsg:Array = null;
         switch(true)
         {
            case msg is ServerConnectionClosedMessage:
               sccmsg = msg as ServerConnectionClosedMessage;
               if(ConnectionsHandler.getConnection() && ConnectionsHandler.getConnection().mainConnection && (ConnectionsHandler.getConnection().mainConnection.connected || ConnectionsHandler.getConnection().mainConnection.connecting))
               {
                  return false;
               }
               if(sccmsg.closedConnection == ConnectionsHandler.getConnection().getSubConnection(sccmsg))
               {
                  _log.trace("The connection was closed. Checking reasons.");
                  GameServerApproachFrame.authenticationTicketAccepted = false;
                  if(ConnectionsHandler.hasReceivedMsg)
                  {
                     if(!ConnectionsHandler.hasReceivedNetworkMsg && this._numberOfAttemptsAlreadyDone < CONNECTION_ATTEMPTS_NUMBER)
                     {
                        ++this._numberOfAttemptsAlreadyDone;
                        _log.warn("The connection was closed unexpectedly. Reconnection attempt " + this._numberOfAttemptsAlreadyDone + "/" + CONNECTION_ATTEMPTS_NUMBER + " will start in 4s.");
                        this._connectionUnexpectedFailureTimes.push(Math.round(getTimer() / 1000));
                        StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG,"connection_fail_times",this._connectionUnexpectedFailureTimes);
                        this._timer = new BenchmarkTimer(4000,1,"DisconnectionHandlerFrame._timer");
                        this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
                        this._timer.start();
                     }
                     else
                     {
                        reason = ConnectionsHandler.handleDisconnection();
                        if(!reason.expected)
                        {
                           _log.warn("The connection was closed unexpectedly. Reseting.");
                           UiStatsFrame.addStat("server_disconnection");
                           UiStatsFrame.setDateStat("last_server_disconnection");
                           if(this._numberOfAttemptsAlreadyDone == CONNECTION_ATTEMPTS_NUMBER)
                           {
                              this._connectionUnexpectedFailureTimes.push(Math.round(getTimer() / 1000));
                              StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG,"connection_fail_times",this._connectionUnexpectedFailureTimes);
                           }
                           if(messagesAfterReset.length == 0)
                           {
                              messagesAfterReset.unshift(new UnexpectedSocketClosureMessage());
                           }
                           Kernel.getInstance().reset();
                        }
                        else
                        {
                           _log.trace("The connection closure was expected (reason: " + reason.reason + "). Dispatching the message.");
                           if(reason.reason == DisconnectionReasonEnum.DISCONNECTED_BY_POPUP || reason.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                           {
                              Kernel.getInstance().reset();
                           }
                           else
                           {
                              Kernel.getWorker().process(new ExpectedSocketClosureMessage(reason.reason));
                           }
                        }
                     }
                  }
                  else
                  {
                     _log.warn("The connection hasn\'t even start.");
                     KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed,DisconnectionReasonEnum.NEVER_CONNECTED);
                  }
               }
               return true;
               break;
            case msg is WrongSocketClosureReasonMessage:
               wscrmsg = msg as WrongSocketClosureReasonMessage;
               GameServerApproachFrame.authenticationTicketAccepted = false;
               _log.error("Expecting socket closure for reason " + wscrmsg.expectedReason + ", got reason " + wscrmsg.gotReason + "! Reseting.");
               Kernel.getInstance().reset([new UnexpectedSocketClosureMessage()]);
               return true;
            case msg is UnexpectedSocketClosureMessage:
               uscmsg = msg as UnexpectedSocketClosureMessage;
               _log.debug("go hook UnexpectedSocketClosure");
               GameServerApproachFrame.authenticationTicketAccepted = false;
               KernelEventsManager.getInstance().processCallback(HookList.UnexpectedSocketClosure);
               return true;
            case msg is ResetGameAction:
               rgamsg = msg as ResetGameAction;
               _log.fatal("ResetGameAction");
               ChatServiceManager.destroy();
               SoundManager.getInstance().manager.removeAllSounds();
               ConnectionsHandler.closeConnection();
               ZaapApi.disableZaapLogin();
               GameServerApproachFrame.authenticationTicketAccepted = false;
               if(rgamsg.messageToShow != "")
               {
                  tabMsg = [OpenPopupAction.create(rgamsg.messageToShow)];
                  Kernel.getInstance().reset(tabMsg);
               }
               else
               {
                  Kernel.getInstance().reset();
               }
               return true;
            case msg is OpenPopupAction:
               commonMod = UiModuleManager.getInstance().getModule("Ankama_Common");
               if(commonMod == null)
               {
                  messagesAfterReset.push(msg);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(HookList.InformationPopup,[(msg as OpenPopupAction).messageToShow]);
               }
               return true;
            case msg is ShowUpdaterLoginInterfaceAction:
               this._mustShowLoginInterface = true;
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function onTimerComplete(event:TimerEvent) : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         if(AuthentificationManager.getInstance().loginValidationAction)
         {
            Kernel.getWorker().process(AuthentificationManager.getInstance().loginValidationAction);
         }
      }
      
      public function get mustShowLoginInterface() : Boolean
      {
         return this._mustShowLoginInterface;
      }
   }
}

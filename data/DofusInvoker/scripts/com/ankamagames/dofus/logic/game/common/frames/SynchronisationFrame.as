package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.messages.game.basic.SequenceNumberMessage;
   import com.ankamagames.dofus.network.messages.game.basic.SequenceNumberRequestMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class SynchronisationFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SynchronisationFrame));
      
      private static const STEP_TIME:uint = 2000;
       
      
      private var _synchroStepByServer:Dictionary;
      
      private var _creationTimeFlash:uint;
      
      private var _creationTimeOs:uint;
      
      private var _timerSpeedHack:BenchmarkTimer;
      
      private var _timeToTest:BenchmarkTimer;
      
      public function SynchronisationFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function pushed() : Boolean
      {
         this._synchroStepByServer = new Dictionary();
         this._timeToTest = new BenchmarkTimer(30000,1,"SynchronisationFrame._timeToTest");
         this._timeToTest.addEventListener(TimerEvent.TIMER_COMPLETE,this.checkSpeedHack);
         this._timeToTest.start();
         this._timerSpeedHack = new BenchmarkTimer(10000,1,"SynchronisationFrame._timerSpeedHack");
         this._timerSpeedHack.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         return true;
      }
      
      public function resetSynchroStepByServer(connexionId:String) : void
      {
         this._synchroStepByServer[connexionId] = 0;
      }
      
      public function process(msg:Message) : Boolean
      {
         var snrMsg:SequenceNumberRequestMessage = null;
         var snMsg:SequenceNumberMessage = null;
         switch(true)
         {
            case msg is SequenceNumberRequestMessage:
               snrMsg = msg as SequenceNumberRequestMessage;
               if(!this._synchroStepByServer[snrMsg.sourceConnection])
               {
                  this._synchroStepByServer[snrMsg.sourceConnection] = 0;
               }
               this._synchroStepByServer[snrMsg.sourceConnection] += 1;
               snMsg = new SequenceNumberMessage();
               snMsg.initSequenceNumberMessage(this._synchroStepByServer[snrMsg.sourceConnection]);
               ConnectionsHandler.getConnection().send(snMsg,snrMsg.sourceConnection);
               return true;
            default:
               return false;
         }
      }
      
      private function checkSpeedHack(pEvt:TimerEvent) : void
      {
         this._timeToTest.stop();
         this._creationTimeFlash = getTimer();
         this._creationTimeOs = new Date().time;
         this._timerSpeedHack.start();
      }
      
      private function onTimerComplete(pEvt:TimerEvent) : void
      {
         this._timerSpeedHack.stop();
         var flashValue:uint = getTimer() - this._creationTimeFlash;
         var osValue:uint = new Date().time - this._creationTimeOs;
         if(flashValue > osValue + STEP_TIME)
         {
            _log.error("This account is cheating : flash=" + flashValue + ", os=" + osValue + ", diff= flash:" + flashValue + " / os:" + osValue);
            if(BuildInfos.BUILD_TYPE != BuildTypeEnum.DEBUG)
            {
               Kernel.getWorker().process(ResetGameAction.create(I18n.getUiText("ui.error.speedHack")));
            }
            else
            {
               _log.fatal("Reset du jeu annulé mais on sait bien que tu cheat");
            }
         }
         this._timeToTest.start();
      }
      
      public function pulled() : Boolean
      {
         this._timerSpeedHack.stop();
         this._timerSpeedHack.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timerSpeedHack = null;
         this._timeToTest.stop();
         this._timeToTest.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timeToTest = null;
         return true;
      }
   }
}

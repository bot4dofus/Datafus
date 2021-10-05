package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.atouin.messages.MapRenderProgressMessage;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.berilia.types.messages.ModuleExecErrorMessage;
   import com.ankamagames.berilia.types.messages.ModuleLoadedMessage;
   import com.ankamagames.berilia.types.messages.ModuleRessourceLoadFailedMessage;
   import com.ankamagames.berilia.types.messages.UiXmlParsedErrorMessage;
   import com.ankamagames.dofus.datacenter.misc.Tips;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.connection.frames.AuthentificationFrame;
   import com.ankamagames.dofus.logic.connection.frames.GameStartingFrame;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
   import com.ankamagames.dofus.misc.utils.LoadingScreen;
   import com.ankamagames.dofus.misc.utils.SurveyManager;
   import com.ankamagames.dofus.network.messages.connection.ServersListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class LoadingModuleFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LoadingModuleFrame));
       
      
      private var _manageAuthentificationFrame:Boolean;
      
      private var _loadingScreen:LoadingScreen;
      
      private var _tips:Array;
      
      private var _tipsTimer:BenchmarkTimer;
      
      private var _showContinueButton:Boolean = false;
      
      private var _startTime:uint;
      
      private var _waitDone:Boolean;
      
      private var _progressRation:Number;
      
      public function LoadingModuleFrame(manageAuthentificationFrame:Boolean = false)
      {
         this._tips = [];
         this._tipsTimer = new BenchmarkTimer(20 * 1000,0,"LoadingModuleFrame._tipsTimer");
         super();
         this._manageAuthentificationFrame = manageAuthentificationFrame;
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function pushed() : Boolean
      {
         var tip:Tips = null;
         this._waitDone = false;
         this._startTime = getTimer();
         this._loadingScreen = new LoadingScreen(true);
         Dofus.getInstance().addChild(this._loadingScreen);
         for each(tip in Tips.getAllTips())
         {
            this._tips.push(tip);
         }
         this._tipsTimer.addEventListener(TimerEvent.TIMER,this.changeTip);
         this._tipsTimer.start();
         this.changeTip(null);
         this._progressRation = 1 / 2;
         return true;
      }
      
      private function changeTip(e:Event) : void
      {
         var tip:Tips = this._tips[Math.floor(this._tips.length * Math.random())] as Tips;
         if(tip)
         {
            this._loadingScreen.tip = tip.description;
         }
      }
      
      public function process(msg:Message) : Boolean
      {
         var mrlfm:ModuleRessourceLoadFailedMessage = null;
         switch(true)
         {
            case msg is ModuleLoadedMessage:
               this._loadingScreen.value += 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
               this._loadingScreen.log(ModuleLoadedMessage(msg).moduleName + " script loaded",LoadingScreen.IMPORTANT);
               return true;
            case msg is ModuleExecErrorMessage:
               this._loadingScreen.value += 100 / UiModuleManager.getInstance().moduleCount * this._progressRation;
               this._loadingScreen.log("Error while executing " + ModuleExecErrorMessage(msg).moduleName + "\'s main script :\n" + ModuleExecErrorMessage(msg).stackTrace,LoadingScreen.ERROR);
               this._showContinueButton = true;
               return true;
            case msg is ModuleRessourceLoadFailedMessage:
               mrlfm = msg as ModuleRessourceLoadFailedMessage;
               this._loadingScreen.log("Module " + mrlfm.moduleName + " : Cannot load " + mrlfm.uri,!!mrlfm.isImportant ? uint(LoadingScreen.ERROR) : uint(LoadingScreen.WARNING));
               if(mrlfm.isImportant)
               {
                  this._showContinueButton = true;
               }
               return true;
            case msg is AllModulesLoadedMessage:
               _log.warn("LoadingModuleFrame AllModulesLoaded");
               if(this._manageAuthentificationFrame)
               {
                  if(!this._showContinueButton)
                  {
                     this.launchGame();
                  }
                  else
                  {
                     this._showContinueButton = false;
                     this._loadingScreen.continueCallbak = this.launchGame;
                  }
                  return true;
               }
               if(this._showContinueButton)
               {
                  this._showContinueButton = false;
                  this._loadingScreen.continueCallbak = this.dispatchEnd;
                  return true;
               }
               break;
            case msg is UiXmlParsedErrorMessage:
               this._loadingScreen.log("Error while parsing  " + UiXmlParsedErrorMessage(msg).url + " : " + UiXmlParsedErrorMessage(msg).msg,LoadingScreen.ERROR);
               return true;
            case msg is MapRenderProgressMessage:
               this._loadingScreen.value += MapRenderProgressMessage(msg).percent * this._progressRation;
               return true;
            case msg is GameStartingMessage:
               Kernel.getWorker().removeFrame(this);
               return true;
            case msg is ServersListMessage:
            case msg is MapComplementaryInformationsDataMessage:
               Kernel.getWorker().removeFrame(this);
               SurveyManager.getInstance().pullSurveys();
               return false;
         }
         return false;
      }
      
      public function pulled() : Boolean
      {
         if(this._tipsTimer)
         {
            this._tipsTimer.stop();
            this._tipsTimer.removeEventListener(TimerEvent.TIMER,this.changeTip);
         }
         this._tipsTimer = null;
         if(this._loadingScreen)
         {
            this._loadingScreen.parent.removeChild(this._loadingScreen);
         }
         this._loadingScreen = null;
         return true;
      }
      
      private function dispatchEnd() : void
      {
         Kernel.getWorker().process(new AllModulesLoadedMessage());
      }
      
      private function launchGame() : void
      {
         if(getTimer() - this._startTime < 2000 && !this._waitDone)
         {
            setTimeout(this.launchGame,2000 - (getTimer() - this._startTime));
            this._waitDone = true;
            return;
         }
         this._manageAuthentificationFrame = false;
         Kernel.getWorker().addFrame(new AuthentificationFrame(AuthentificationManager.getInstance().loginValidationAction == null));
         Kernel.getWorker().addFrame(new QueueFrame());
         Kernel.getWorker().addFrame(new GameStartingFrame());
         var nb:int = DisconnectionHandlerFrame.messagesAfterReset.length;
         for(var i:int = 0; i < nb; i++)
         {
            Kernel.getWorker().process(DisconnectionHandlerFrame.messagesAfterReset.shift());
         }
         if(AuthentificationManager.getInstance().loginValidationAction)
         {
            Kernel.getWorker().process(AuthentificationManager.getInstance().loginValidationAction);
         }
      }
   }
}

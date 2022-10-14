package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.DiceRollRequestMessage;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   import mx.utils.StringUtil;
   
   public class DieRollInstructionHandler implements ConsoleInstructionHandler
   {
      
      public static const ROLL_COMMAND:String = "roll";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DieRollInstructionHandler));
      
      private static const ROLL_REGEXP:RegExp = /^\s*(\d+)d(\d+)\s*$/;
      
      private static const ROLL_ONE_REGEXP:RegExp = /^\s*(\d+)\s*$/;
      
      private static const MIN_ROLL_INTERVAL:uint = 3;
      
      private static const MIN_DIE_NUMBER:uint = 1;
      
      private static const MIN_FACE_NUMBER:uint = 1;
      
      private static const MAX_DIE_NUMBER:uint = 100;
      
      private static const MAX_FACE_NUMBER:uint = 10000000;
       
      
      private var _rollTimer:BenchmarkTimer;
      
      private var _isRollTimerLock:Boolean = false;
      
      public function DieRollInstructionHandler()
      {
         this._rollTimer = new BenchmarkTimer(MIN_ROLL_INTERVAL * 1000,1,"DieRollInstructionHandler._rollTimer");
         super();
      }
      
      private static function getRollParams(rollDescr:String) : Object
      {
         var rollParams:Object = null;
         var regResult:Array = ROLL_REGEXP.exec(rollDescr);
         if(regResult === null)
         {
            regResult = ROLL_ONE_REGEXP.exec(rollDescr);
            if(regResult !== null && regResult.length === 2)
            {
               rollParams = {
                  "dieNumber":1,
                  "faceNumber":Number(regResult[1])
               };
            }
         }
         else if(regResult.length === 3)
         {
            rollParams = {
               "dieNumber":Number(regResult[1]),
               "faceNumber":Number(regResult[2])
            };
         }
         return rollParams;
      }
      
      private static function getSubmittedCommand(command:String, args:Array) : String
      {
         return StringUtil.trim("/" + command + " " + args.join(" "));
      }
      
      private static function getCurrentChannel() : Number
      {
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         if(chatFrame === null)
         {
            return Number.NaN;
         }
         return chatFrame.currentChannel;
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case ROLL_COMMAND:
               this.execRollCommand(console,args);
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case ROLL_COMMAND:
               return I18n.getUiText("ui.command.roll.exampleOneRoll",["/" + ROLL_COMMAND]) + "\n" + I18n.getUiText("ui.command.roll.exampleMultipleRolls",["/" + ROLL_COMMAND]);
            default:
               return "";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
      
      private function startRollTimer() : void
      {
         this.stopRollTimer();
         this._rollTimer.start();
         this._rollTimer.addEventListener(TimerEvent.TIMER,this.onRollTimer);
         this._isRollTimerLock = true;
      }
      
      private function stopRollTimer() : void
      {
         this._rollTimer.reset();
         this._rollTimer.removeEventListener(TimerEvent.TIMER,this.onRollTimer);
         this._isRollTimerLock = false;
      }
      
      private function execRollCommand(console:ConsoleHandler, args:Array) : void
      {
         var channelId:Number = getCurrentChannel();
         if(isNaN(channelId) || channelId < 0)
         {
            _log.error("Unable to get channel ID for " + ROLL_COMMAND + " command");
            console.output(I18n.getUiText("ui.command.error",["/" + ROLL_COMMAND]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         if(this._isRollTimerLock)
         {
            console.output(I18n.getUiText("ui.command.roll.spamError",[MIN_ROLL_INTERVAL]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         if(args.length !== 1)
         {
            console.output(I18n.getUiText("ui.command.roll.invalid",[getSubmittedCommand(ROLL_COMMAND,args)]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            console.output(this.getHelp(ROLL_COMMAND),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return;
         }
         var rollParams:Object = getRollParams(args.shift());
         if(rollParams === null)
         {
            console.output(I18n.getUiText("ui.command.roll.invalid",[getSubmittedCommand(ROLL_COMMAND,args)]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            console.output(this.getHelp(ROLL_COMMAND),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return;
         }
         var dieNumber:Number = rollParams.dieNumber;
         var faceNumber:Number = rollParams.faceNumber;
         if(isNaN(dieNumber) || isNaN(faceNumber))
         {
            console.output(I18n.getUiText("ui.command.roll.invalid",[getSubmittedCommand(ROLL_COMMAND,args)]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            console.output(this.getHelp(ROLL_COMMAND),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return;
         }
         if(dieNumber < MIN_DIE_NUMBER)
         {
            console.output(I18n.getUiText("ui.command.roll.minDieNumberError",[MIN_DIE_NUMBER]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         if(faceNumber < MIN_FACE_NUMBER)
         {
            console.output(I18n.getUiText("ui.command.roll.minFaceNumberError",[MIN_FACE_NUMBER]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         if(dieNumber > MAX_DIE_NUMBER)
         {
            console.output(I18n.getUiText("ui.command.roll.maxDieNumberError",[MAX_DIE_NUMBER]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         if(faceNumber > MAX_FACE_NUMBER)
         {
            console.output(I18n.getUiText("ui.command.roll.maxFaceNumberError",[MAX_FACE_NUMBER]),ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
            return;
         }
         var message:DiceRollRequestMessage = new DiceRollRequestMessage();
         message.initDiceRollRequestMessage(dieNumber,faceNumber,channelId);
         ConnectionsHandler.getConnection().send(message);
         this.startRollTimer();
      }
      
      private function onRollTimer(timerEvent:TimerEvent = null) : void
      {
         this.stopRollTimer();
      }
   }
}

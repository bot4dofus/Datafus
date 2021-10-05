package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class LivingObjectInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));
       
      
      public function LivingObjectInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "floodlivingobject":
               if(SpeakingItemManager.getInstance().speakTimerMinuteDelay != SpeakingItemManager.MINUTE_DELAY)
               {
                  SpeakingItemManager.getInstance().speakTimerMinuteDelay = SpeakingItemManager.MINUTE_DELAY;
               }
               else
               {
                  SpeakingItemManager.getInstance().speakTimerMinuteDelay = 100;
               }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "floodlivingobject":
               return "Make a flood of talk from living objects.";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

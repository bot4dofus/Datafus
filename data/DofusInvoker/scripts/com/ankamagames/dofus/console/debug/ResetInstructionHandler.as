package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   
   public class ResetInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function ResetInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "reset":
               Kernel.getWorker().process(new ResetGameAction());
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "reset":
               return "Resets the Kernel and restart the game.";
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

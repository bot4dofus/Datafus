package com.ankamagames.jerakine.console
{
   public class UnhandledConsoleInstructionError extends Error
   {
       
      
      public function UnhandledConsoleInstructionError(message:String = "", id:uint = 0)
      {
         super(message,id);
      }
   }
}

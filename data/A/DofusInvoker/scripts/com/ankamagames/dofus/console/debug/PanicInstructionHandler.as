package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class PanicInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function PanicInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var errorId:uint = 0;
         switch(cmd)
         {
            case "panic":
               errorId = uint(args[0]);
               console.output("Kernel panic #" + errorId);
               Kernel.panic(errorId);
               break;
            case "throw":
               throw new Error(args.join(" "));
         }
      }
      
      public function getArgs(cmd:String) : Array
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return [];
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "panic":
               return "Make a kernel panic.";
            case "throw":
               return "Throw an exception";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getMan(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noMan",[cmd]);
      }
      
      public function getExamples(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noExample",[cmd]);
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

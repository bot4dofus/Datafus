package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ConsolesManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConsolesManager));
      
      private static var _consoles:Dictionary = new Dictionary();
       
      
      public function ConsolesManager()
      {
         super();
      }
      
      public static function getConsole(id:String) : ConsoleHandler
      {
         return _consoles[id];
      }
      
      public static function registerConsole(id:String, console:ConsoleHandler, instructionsRegistar:ConsoleInstructionRegistar) : void
      {
         if(getConsole(id))
         {
            getConsole(id).changeOutputHandler(console);
            console.name = id;
            _consoles[id] = console;
            instructionsRegistar.registerInstructions(console);
            return;
         }
         console.name = id;
         _consoles[id] = console;
         instructionsRegistar.registerInstructions(console);
      }
      
      public static function getMessage(input:String) : ConsoleInstructionMessage
      {
         var inputArray:Array = input.split(" ");
         var cmd:String = inputArray[0];
         inputArray.splice(0,1);
         if(inputArray.length && inputArray[inputArray.length - 1].length == 0)
         {
            inputArray.pop();
         }
         return new ConsoleInstructionMessage(cmd,inputArray);
      }
   }
}

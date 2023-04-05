package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.utils.Dictionary;
   
   public class EnterFrameInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function EnterFrameInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var ctrlDic:Dictionary = null;
         var cefl:* = undefined;
         var cname:String = null;
         switch(cmd)
         {
            case "enterframecount":
               console.output("ENTER_FRAME listeners count : " + EnterFrameDispatcher.enterFrameListenerCount);
               console.output("Controled listeners :");
               ctrlDic = EnterFrameDispatcher.controledEnterFrameListeners;
               for(cefl in ctrlDic)
               {
                  cname = ctrlDic[cefl]["name"];
                  console.output("  - " + cname);
               }
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
            case "enterframecount":
               return "Count the ENTER_FRAME listeners.";
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

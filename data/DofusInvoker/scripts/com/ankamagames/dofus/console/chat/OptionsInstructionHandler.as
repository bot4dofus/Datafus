package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class OptionsInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function OptionsInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "clear":
               KernelEventsManager.getInstance().processCallback(ChatHookList.ClearChat);
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "clear":
               return I18n.getUiText("ui.chat.console.help.clear");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class MessagingInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function MessagingInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var _loc4_:* = cmd;
         switch(0)
         {
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
            case "w":
               return I18n.getUiText("ui.chat.console.help.whisper");
            case "t":
               return I18n.getUiText("ui.chat.console.help.teammessage");
            case "g":
               return I18n.getUiText("ui.chat.console.help.guildmessage");
            case "p":
               return I18n.getUiText("ui.chat.console.help.groupmessage");
            case "a":
               return I18n.getUiText("ui.chat.console.help.alliancemessage");
            case "r":
               return I18n.getUiText("ui.chat.console.help.aroundguildmessage");
            case "b":
               return I18n.getUiText("ui.chat.console.help.sellbuymessage");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
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

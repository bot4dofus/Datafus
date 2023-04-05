package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.lua.LuaPlayer;
   import com.ankamagames.jerakine.lua.LuaPlayerEvent;
   import com.ankamagames.jerakine.script.ScriptsManager;
   
   public class LuaInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function LuaInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var luaPlayer:LuaPlayer = null;
         switch(cmd)
         {
            case "lua":
               if(args && args[0])
               {
                  luaPlayer = ScriptsManager.getInstance().getPlayer(ScriptsManager.LUA_PLAYER) as LuaPlayer;
                  luaPlayer.addEventListener(LuaPlayerEvent.PLAY_SUCCESS,this.onScriptSuccess);
                  luaPlayer.addEventListener(LuaPlayerEvent.PLAY_ERROR,this.onScriptError);
                  luaPlayer.playFile(args[0]);
               }
               break;
            case "luarecorder":
               ConsoleLUA.getInstance().toggleDisplay();
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
            case "lua":
               return "Loads and executes a lua script file.";
            case "luarecorder":
               return "Open a separate window to record in game actions and generate a LUA script file.";
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
         return null;
      }
      
      private function onScriptSuccess(pEvent:LuaPlayerEvent) : void
      {
         pEvent.currentTarget.removeEventListener(LuaPlayerEvent.PLAY_ERROR,this.onScriptError);
         pEvent.currentTarget.removeEventListener(LuaPlayerEvent.PLAY_SUCCESS,this.onScriptSuccess);
         ConsolesManager.getConsole("debug").output("Script successfully executed.");
      }
      
      private function onScriptError(pEvent:LuaPlayerEvent) : void
      {
         pEvent.currentTarget.removeEventListener(LuaPlayerEvent.PLAY_SUCCESS,this.onScriptSuccess);
         pEvent.currentTarget.removeEventListener(LuaPlayerEvent.PLAY_ERROR,this.onScriptError);
         ConsolesManager.getConsole("debug").output("Script error.\n" + pEvent.stackTrace);
      }
   }
}

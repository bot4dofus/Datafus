package com.ankamagames.dofus.console
{
   import com.ankamagames.dofus.console.debug.ActionsInstructionHandler;
   import com.ankamagames.dofus.console.debug.DisplayMapInstructionHandler;
   import com.ankamagames.dofus.console.debug.FrameInstructionHandler;
   import com.ankamagames.dofus.console.debug.LuaInstructionHandler;
   import com.ankamagames.dofus.console.debug.SoundInstructionHandler;
   import com.ankamagames.dofus.console.debug.UiHandlerInstructionHandler;
   import com.ankamagames.dofus.console.debug.VersionInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   
   public class BasicConsoleInstructionRegistar implements ConsoleInstructionRegistar
   {
       
      
      public function BasicConsoleInstructionRegistar()
      {
         super();
      }
      
      public function registerInstructions(console:ConsoleHandler) : void
      {
         console.addHandler("version",new VersionInstructionHandler());
         console.addHandler(["mapid","showeverycellid"],new DisplayMapInstructionHandler());
         console.addHandler(["uiinspector","inspectuielement","autoreloadui","loadui","unloadui","clearuicache","resetuisavedusermodification","getthemefingerprint","clearthemedata","clearcsscache","cleartooltipcache","useuicache","uilist","reloadui","modulelist","subhint"],new UiHandlerInstructionHandler());
         console.addHandler(["framelist","framepriority"],new FrameInstructionHandler());
         console.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         console.addHandler(["adduisoundelement"],new SoundInstructionHandler());
         console.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}

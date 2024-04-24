package com.ankamagames.dofus.console
{
   import com.ankamagames.dofus.console.chat.ChatServiceInstructionHandler;
   import com.ankamagames.dofus.console.common.LatencyInstructionHandler;
   import com.ankamagames.dofus.console.debug.ActionsInstructionHandler;
   import com.ankamagames.dofus.console.debug.AlterationInstructionHandler;
   import com.ankamagames.dofus.console.debug.BenchmarkInstructionHandler;
   import com.ankamagames.dofus.console.debug.CinematicInstructionHandler;
   import com.ankamagames.dofus.console.debug.ClearSceneInstructionHandler;
   import com.ankamagames.dofus.console.debug.ClearTextureCacheInstructionHandler;
   import com.ankamagames.dofus.console.debug.ConnectionInstructionHandler;
   import com.ankamagames.dofus.console.debug.CryptoInstructionHandler;
   import com.ankamagames.dofus.console.debug.DisplayMapInstructionHandler;
   import com.ankamagames.dofus.console.debug.EnterFrameInstructionHandler;
   import com.ankamagames.dofus.console.debug.FeatureInstructionHandler;
   import com.ankamagames.dofus.console.debug.FightInstructionHandler;
   import com.ankamagames.dofus.console.debug.FontInstructionHandler;
   import com.ankamagames.dofus.console.debug.FrameInstructionHandler;
   import com.ankamagames.dofus.console.debug.FullScreenInstructionHandler;
   import com.ankamagames.dofus.console.debug.IAInstructionHandler;
   import com.ankamagames.dofus.console.debug.InventoryInstructionHandler;
   import com.ankamagames.dofus.console.debug.LivingObjectInstructionHandler;
   import com.ankamagames.dofus.console.debug.LuaInstructionHandler;
   import com.ankamagames.dofus.console.debug.MiscInstructionHandler;
   import com.ankamagames.dofus.console.debug.PanicInstructionHandler;
   import com.ankamagames.dofus.console.debug.ResetInstructionHandler;
   import com.ankamagames.dofus.console.debug.SoundInstructionHandler;
   import com.ankamagames.dofus.console.debug.SpellModifiersInstructionHandler;
   import com.ankamagames.dofus.console.debug.StatsInstructionHandler;
   import com.ankamagames.dofus.console.debug.SystemInstructionHandler;
   import com.ankamagames.dofus.console.debug.TiphonInstructionHandler;
   import com.ankamagames.dofus.console.debug.UiHandlerInstructionHandler;
   import com.ankamagames.dofus.console.debug.UtilInstructionHandler;
   import com.ankamagames.dofus.console.debug.VersionInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   
   public class DebugConsoleInstructionRegistar implements ConsoleInstructionRegistar
   {
       
      
      public function DebugConsoleInstructionRegistar()
      {
         super();
      }
      
      public function registerInstructions(console:ConsoleHandler) : void
      {
         console.addHandler("version",new VersionInstructionHandler());
         console.addHandler(["crc32","md5","antibot"],new CryptoInstructionHandler());
         console.addHandler(["displaymap","displaymapdebug","getmapcoord","getmapid","testatouin","mapid","showcellid","showeverycellid","playerjump","showtransitions","groundcache","removeblackbars","setmaprenderscale","capturemap","tutofx","debugmapwide","setfrustum","setclientwindowsize","togglebottomuis","subareainfos"],new DisplayMapInstructionHandler());
         console.addHandler(["clearscene","clearentities","countentities"],new ClearSceneInstructionHandler());
         console.addHandler(["inspector","uiinspector","inspectuielement","autoreloadui","changefonttype","resetuisavedusermodification","getthemefingerprint","inspectuielementsos","modulelist","loadui","unloadui","clearuicache","clearthemedata","setuiscale","useuicache","uilist","reloadui","getmoduleinfo","debugvisionneuse","loadprotoxml","clearcsscache","cleartooltipcache","showarrow","texturebitmapcache","subhint"],new UiHandlerInstructionHandler());
         console.addHandler("cleartexturecache",new ClearTextureCacheInstructionHandler());
         console.addHandler(["connectionstatus","inspecttraffic","inspectlowtraffic","setinactivitytimeout"],new ConnectionInstructionHandler());
         console.addHandler(["panic","throw"],new PanicInstructionHandler());
         console.addHandler("fullscreen",new FullScreenInstructionHandler());
         console.addHandler("reset",new ResetInstructionHandler());
         console.addHandler("enterframecount",new EnterFrameInstructionHandler());
         console.addHandler(["parallelsequenceteststart","log","i18nsize","newdofus","clear","config","clearwebcache","geteventmodeparams","setquality","lowdefskin","synchrosequence","throw","debugmouseover","idletime","setmonsterspeed","sosloglevel","sostarget","debugmodule","celebration"],new MiscInstructionHandler());
         console.addHandler(["additem","looklike","relook","castshadow"],new TiphonInstructionHandler());
         console.addHandler(["listinventory","searchitem","makeinventory"],new InventoryInstructionHandler());
         console.addHandler(["enablelogs","info","search","searchmonster","searchspell","enablereport","savereport","loadpacket","reccordpacket","exportcharacter","reccordimage","displayworldgraph"],new UtilInstructionHandler());
         console.addHandler([FeatureInstructionHandler.BASE_COMMAND],new FeatureInstructionHandler());
         console.addHandler([StatsInstructionHandler.BASE_COMMAND],new StatsInstructionHandler());
         console.addHandler([SpellModifiersInstructionHandler.BASE_COMMAND],new SpellModifiersInstructionHandler());
         console.addHandler("jptest",new FontInstructionHandler());
         console.addHandler(["aping","ping"],new LatencyInstructionHandler());
         console.addHandler(["cinematic"],new CinematicInstructionHandler());
         console.addHandler(["searchalteration"],new AlterationInstructionHandler());
         console.addHandler(["friendlist","friendinvite","friend","msg","mystatus","myactivity","friendgroup","listactivities"],new ChatServiceInstructionHandler());
         console.addHandler(["framelist","framepriority"],new FrameInstructionHandler());
         console.addHandler(["addmovingcharacter","switchupdatemode","setanimation","playemote","setdirection","memorylog","bot-spectator","bot-fight","tiphon-error","fps","fpsmanager","tacticmode","creaturemode","chainteleport"],new BenchmarkInstructionHandler());
         console.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         console.addHandler(["debuglos","calculatepath","tracepath","debugcellsinline"],new IAInstructionHandler());
         console.addHandler(["inspectbuffs","haxegeneratetest","detailedfightlog"],new FightInstructionHandler());
         console.addHandler(["playmusic","stopmusic","playambiance","stopambiance","addsoundinplaylist","stopplaylist","playplaylist","activesounds","adduisoundelement","clearsoundcache"],new SoundInstructionHandler());
         console.addHandler(["floodlivingobject"],new LivingObjectInstructionHandler());
         console.addHandler(["getuid"],new SystemInstructionHandler());
         console.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}

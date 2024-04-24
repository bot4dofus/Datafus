package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.misc.utils.GameDebugManager;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class FightInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function FightInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var showFactoring:* = false;
         var showEverything:* = false;
         var showIds:* = false;
         var showBuffsInUi:* = false;
         switch(cmd)
         {
            case "inspectbuffs":
               GameDebugManager.getInstance().buffsDebugActivated = !GameDebugManager.getInstance().buffsDebugActivated;
               console.output("Fight\'s buffs debug mode is " + (!!GameDebugManager.getInstance().buffsDebugActivated ? "ON" : "OFF"));
               break;
            case "haxegeneratetest":
               GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast = true;
               if(args.length > 0)
               {
                  if(args[0].toLowerCase() == "true")
                  {
                     GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_stats = true;
                  }
                  else
                  {
                     GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_stats = false;
                  }
                  if(args.length > 1)
                  {
                     if(args[1].toLowerCase() == "true")
                     {
                        GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_infos = true;
                     }
                     else
                     {
                        GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_infos = false;
                     }
                  }
               }
               console.output("Next spell cast will output a functional test");
               console.output("With stats : " + GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_stats);
               console.output("With infos : " + GameDebugManager.getInstance().haxeGenerateTestFromNextSpellCast_infos);
               break;
            case "detailedfightlog":
               if(args.length == 0)
               {
                  GameDebugManager.getInstance().detailedFightLog_unGroupEffects = !GameDebugManager.getInstance().detailedFightLog_unGroupEffects;
                  GameDebugManager.getInstance().detailedFightLog_showEverything = !GameDebugManager.getInstance().detailedFightLog_showEverything;
                  GameDebugManager.getInstance().detailedFightLog_showIds = !GameDebugManager.getInstance().detailedFightLog_showIds;
                  GameDebugManager.getInstance().detailedFightLog_showBuffsInUi = !GameDebugManager.getInstance().detailedFightLog_showBuffsInUi;
               }
               if(args.length == 1)
               {
                  if(args[0] == "on")
                  {
                     GameDebugManager.getInstance().detailedFightLog_unGroupEffects = true;
                     GameDebugManager.getInstance().detailedFightLog_showEverything = true;
                     GameDebugManager.getInstance().detailedFightLog_showIds = true;
                     GameDebugManager.getInstance().detailedFightLog_showBuffsInUi = true;
                  }
                  else if(args[0] == "off")
                  {
                     GameDebugManager.getInstance().detailedFightLog_unGroupEffects = false;
                     GameDebugManager.getInstance().detailedFightLog_showEverything = false;
                     GameDebugManager.getInstance().detailedFightLog_showIds = false;
                     GameDebugManager.getInstance().detailedFightLog_showBuffsInUi = false;
                  }
               }
               if(args.length == 4)
               {
                  showFactoring = args[0] == "true";
                  showEverything = args[1] == "true";
                  showIds = args[2] == "true";
                  showBuffsInUi = args[3] == "true";
                  GameDebugManager.getInstance().detailedFightLog_unGroupEffects = showFactoring;
                  GameDebugManager.getInstance().detailedFightLog_showEverything = showEverything;
                  GameDebugManager.getInstance().detailedFightLog_showIds = showIds;
                  GameDebugManager.getInstance().detailedFightLog_showBuffsInUi = showBuffsInUi;
               }
               console.output("Fight\'s detailed log mode (ungroup effects) is " + (!!GameDebugManager.getInstance().detailedFightLog_unGroupEffects ? "ON" : "OFF"));
               console.output("Fight\'s detailed log mode (show hidden spells & effects) is " + (!!GameDebugManager.getInstance().detailedFightLog_showEverything ? "ON" : "OFF"));
               console.output("Fight\'s detailed log mode (show ids) is " + (!!GameDebugManager.getInstance().detailedFightLog_showIds ? "ON" : "OFF"));
               console.output("Fight\'s detailed log mode (show buffs in timeline UI) is " + (!!GameDebugManager.getInstance().detailedFightLog_showBuffsInUi ? "ON" : "OFF"));
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
            case "setspellscriptparam":
               return "Change script parameters for given spell";
            case "setspellscript":
               return "Change script id used for given spell";
            case "inspectbuffs":
               return "Show detailled informations about buffs in fight.";
            case "haxegeneratetest":
               return "Generate code to create a new Haxe test which will be outputed in console";
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

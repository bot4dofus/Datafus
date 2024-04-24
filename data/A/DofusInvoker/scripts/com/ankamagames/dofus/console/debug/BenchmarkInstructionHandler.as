package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.console.moduleLogger.ModuleDebugManager;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.frames.BenchmarkFrame;
   import com.ankamagames.dofus.logic.common.frames.DebugBotFrame;
   import com.ankamagames.dofus.logic.common.frames.FightBotFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.TacticModeManager;
   import com.ankamagames.dofus.misc.BenchmarkMovementBehavior;
   import com.ankamagames.dofus.misc.utils.frames.LuaScriptRecorderFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.types.entities.BenchmarkCharacter;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class BenchmarkInstructionHandler implements ConsoleInstructionHandler
   {
      
      private static var id:uint = 50000;
       
      
      protected var _log:Logger;
      
      public function BenchmarkInstructionHandler()
      {
         this._log = Log.getLogger(getQualifiedClassName(BenchmarkInstructionHandler));
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var animEntity:IAnimated = null;
         var lsrf:LuaScriptRecorderFrame = null;
         var fef:FightEntitiesFrame = null;
         var dic:Dictionary = null;
         var dirEntity:IAnimated = null;
         var fps:FpsManager = null;
         var txt:* = null;
         var useCache:* = false;
         var typeZone:int = 0;
         var showFightZone:* = false;
         var showInteractiveCells:* = false;
         var showTacticMode:* = false;
         var showScalezone:* = false;
         var flattenCells:* = false;
         var showBlockMvt:* = false;
         var togglePokemonModeAction:Action = null;
         var rnd:PRNG = null;
         var i:uint = 0;
         var rpCharEntity:BenchmarkCharacter = null;
         var cell:MapPoint = null;
         var fightEntity:GameContextActorInformations = null;
         var gfmi:GameFightMonsterInformations = null;
         var fr:DebugBotFrame = null;
         var chatind:int = 0;
         var time:int = 0;
         var arg:String = null;
         var valueTab:Array = null;
         var cmdValue:String = null;
         switch(cmd)
         {
            case "addmovingcharacter":
               if(args.length > 0)
               {
                  rnd = new ParkMillerCarta(4538651);
                  for(i = 0; i < parseInt(args[1]); i++)
                  {
                     rpCharEntity = new BenchmarkCharacter(id++,TiphonEntityLook.fromString(args[0]));
                     do
                     {
                        cell = MapPoint.fromCellId(rnd.nextIntR(0,AtouinConstants.MAP_CELLS_COUNT));
                     }
                     while(!DataMapProvider.getInstance().pointMov(cell.x,cell.y));
                     
                     rpCharEntity.position = MapPoint.fromCellId(cell.cellId);
                     rpCharEntity.display();
                     rpCharEntity.move(BenchmarkMovementBehavior.getRandomPath(rpCharEntity));
                  }
               }
               break;
            case "setanimation":
               animEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               lsrf = Kernel.getWorker().getFrame(LuaScriptRecorderFrame) as LuaScriptRecorderFrame;
               if(Kernel.getWorker().getFrame(LuaScriptRecorderFrame))
               {
                  lsrf.createLine("player","setAnimation",args[0],true);
               }
               animEntity.setAnimation(args[0]);
               if(animEntity is TiphonSprite && args.length > 1)
               {
                  TiphonSprite(animEntity).stopAnimation(parseInt(args[1]));
               }
               break;
            case "setdirection":
               fef = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
               dic = fef.entities;
               dirEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IAnimated;
               for each(fightEntity in dic)
               {
                  if(fightEntity is GameFightMonsterInformations)
                  {
                     gfmi = fightEntity as GameFightMonsterInformations;
                     if(gfmi.creatureGenericId == parseInt(args[1]))
                     {
                        dirEntity = DofusEntities.getEntity(gfmi.contextualId) as IAnimated;
                        dirEntity.setDirection(args[0]);
                     }
                  }
               }
               dirEntity.setDirection(args[0]);
               break;
            case "tiphon-error":
               TiphonDebugManager.disable();
               break;
            case "bot-spectator":
               if(Kernel.getWorker().contains(DebugBotFrame))
               {
                  Kernel.getWorker().removeFrame(DebugBotFrame.getInstance());
                  console.output("Arret du bot-spectator, " + DebugBotFrame.getInstance().fightCount + " combat(s) vu");
               }
               else
               {
                  fr = DebugBotFrame.getInstance();
                  chatind = args.indexOf("debugchat");
                  if(chatind != -1)
                  {
                     time = 500;
                     if(args.length > chatind + 1)
                     {
                        time = args[chatind + 1];
                     }
                     fr.enableChatMessagesBot(true,time);
                  }
                  Kernel.getWorker().addFrame(fr);
                  console.output("Démarrage du bot-spectator ");
               }
               break;
            case "bot-fight":
               if(Kernel.getWorker().contains(FightBotFrame))
               {
                  Kernel.getWorker().removeFrame(FightBotFrame.getInstance());
                  console.output("Arret du bot-fight, " + FightBotFrame.getInstance().fightCount + " combat(s) effectué");
               }
               else
               {
                  Kernel.getWorker().addFrame(FightBotFrame.getInstance());
                  console.output("Démarrage du bot-fight ");
               }
               break;
            case "fps":
               ModuleDebugManager.display(!ModuleDebugManager.isDisplayed,false);
               break;
            case "fpsmanager":
               fps = FpsManager.getInstance();
               if(StageShareManager.stage.contains(fps))
               {
                  fps.hide();
               }
               else
               {
                  fps.display();
               }
               break;
            case "tacticmode":
               TacticModeManager.getInstance().hide();
               useCache = false;
               typeZone = 0;
               showFightZone = false;
               showInteractiveCells = false;
               showTacticMode = false;
               showScalezone = false;
               flattenCells = true;
               showBlockMvt = true;
               for each(arg in args)
               {
                  valueTab = arg.split("=");
                  if(valueTab != null)
                  {
                     cmdValue = valueTab[1];
                     if(arg.search("fightzone") != -1 && valueTab.length > 1)
                     {
                        showFightZone = cmdValue.toLowerCase() == "true";
                     }
                     else if(arg.search("clearcache") != -1 && valueTab.length > 1)
                     {
                        useCache = cmdValue.toLowerCase() != "true";
                     }
                     else if(arg.search("mode") != -1 && valueTab.length > 1)
                     {
                        typeZone = cmdValue.toLowerCase() == "rp" ? 1 : 0;
                     }
                     else if(arg.search("interactivecells") != -1 && valueTab.length > 1)
                     {
                        showInteractiveCells = cmdValue.toLowerCase() == "true";
                     }
                     else if(arg.search("scalezone") != -1 && valueTab.length > 1)
                     {
                        showScalezone = cmdValue.toLowerCase() == "true";
                     }
                     else if(arg.search("show") != -1 && valueTab.length > 1)
                     {
                        showTacticMode = cmdValue.toLowerCase() == "true";
                     }
                     else if(arg.search("flattencells") != -1 && valueTab.length > 1)
                     {
                        flattenCells = cmdValue.toLowerCase() == "true";
                     }
                     else if(arg.search("blocLDV") != -1 && valueTab.length > 1)
                     {
                        showBlockMvt = cmdValue.toLowerCase() == "true";
                     }
                  }
               }
               if(showTacticMode)
               {
                  TacticModeManager.getInstance().setDebugMode(showFightZone,useCache,typeZone,showInteractiveCells,showScalezone,flattenCells,showBlockMvt);
                  TacticModeManager.getInstance().show(PlayedCharacterManager.getInstance().currentMap,true);
                  txt = "Activation";
               }
               else
               {
                  txt = "Désactivation";
               }
               txt += " du mode tactique.";
               console.output(txt);
               break;
            case "creaturemode":
               togglePokemonModeAction = ToggleDematerializationAction.create();
               Kernel.getWorker().process(togglePokemonModeAction);
               break;
            case "chainteleport":
               if(Kernel.getWorker().contains(BenchmarkFrame))
               {
                  Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(BenchmarkFrame));
               }
               else
               {
                  Kernel.getWorker().addFrame(new BenchmarkFrame());
               }
               break;
            case "memorylog":
               console.output(FpsManager.getInstance().dumpData());
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
            case "setdirection":
               return "Set direction of the player if only one arg is used. You can specifie a second arg that will be the generic ID of a monster (use tab to list them)";
            case "playemote":
               return "Set the animation of the current player. Param 1: Name of the emoticon, param 2 (opt): Frame of the animation";
            case "setanimation":
               return "Set the animation of the current player. Param 1: Name of the animation, param 2 (opt): Frame of the animation";
            case "addmovingcharacter":
               return "Add a new mobile character on scene.";
            case "fps":
               return "Displays the performance of the client.";
            case "fpsmanager":
               return "Displays the performance of the client." + "\n    external";
            case "bot-spectator":
               return "Start/Stop the auto join fight spectator bot" + "\n    debugchat";
            case "tiphon-error":
               return "Désactive l\'affichage des erreurs du moteur d\'animation.";
            case "tacticmode":
               return "Active/Désactive le mode tactique" + "\n    show=[true|false]" + "\n    clearcache=[true|false]" + "\n    mode=[fight|RP]" + "\n    interactivecells=[true|false] " + "\n    fightzone=[true|false]" + "\n    scalezone=[true|false]" + "\n    flattencells=[true|false]";
            case "creaturemode":
               return "Enable/disable creature mode";
            case "chainteleport":
               return "Chain teleport in all game area";
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
         var animEntity:TiphonSprite = null;
         var list:Array = null;
         var animList:Array = null;
         var anim:String = null;
         var fef:FightEntitiesFrame = null;
         var dic:Dictionary = null;
         var monsterList:Array = null;
         var fightEntity:GameContextActorInformations = null;
         var gfmi:GameFightMonsterInformations = null;
         var emotes:Array = null;
         var emoteNames:Array = null;
         var emote:Emoticon = null;
         switch(cmd)
         {
            case "tacticmode":
               return ["show","clearcache","mode","interactivecells","fightzone","scalezone","flattencells"];
            case "setanimation":
               animEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as TiphonSprite;
               list = animEntity.animationList;
               animList = [];
               for each(anim in list)
               {
                  if(anim.indexOf("Anim") != -1)
                  {
                     animList.push(anim);
                  }
               }
               animList.sort();
               return animList;
            case "setdirection":
               if(paramIndex == 0)
               {
                  return [0,1,2,3,4,5,6,7];
               }
               if(paramIndex == 1)
               {
                  fef = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
                  dic = fef.entities;
                  monsterList = [];
                  for each(fightEntity in dic)
                  {
                     if(fightEntity is GameFightMonsterInformations)
                     {
                        gfmi = fightEntity as GameFightMonsterInformations;
                        monsterList.push(Monster.getMonsterById(gfmi.creatureGenericId).id + " " + Monster.getMonsterById(gfmi.creatureGenericId).name);
                     }
                  }
                  monsterList.sort();
                  return monsterList;
               }
               break;
            case "playemote":
               if(paramIndex == 0)
               {
                  emotes = Emoticon.getEmoticons();
                  emoteNames = [];
                  for each(emote in emotes)
                  {
                     emoteNames.push(emote.name);
                  }
                  return emoteNames;
               }
         }
         return [];
      }
   }
}

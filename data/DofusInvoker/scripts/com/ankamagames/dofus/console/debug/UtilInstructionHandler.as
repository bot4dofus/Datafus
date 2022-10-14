package com.ankamagames.dofus.console.debug
{
   import by.blooddy.crypto.image.JPEGEncoder;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.entities.behaviours.movements.AnimatedMovementBehavior;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.console.debug.frames.ReccordNetworkPacketFrame;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.DofusFpsManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.misc.utils.errormanager.DofusErrorHandler;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.targets.SOSTarget;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.FrameIdManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class UtilInstructionHandler implements ConsoleInstructionHandler
   {
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(UtilInstructionHandler));
       
      
      private const _validArgs0:Dictionary = validArgs();
      
      private var _reccordPacketFrame:ReccordNetworkPacketFrame;
      
      private var _sessionDate:Date;
      
      private var _sessionReccordFolder:File;
      
      private var _sessionReccordBitmapData:BitmapData;
      
      public function UtilInstructionHandler()
      {
         this._sessionDate = new Date();
         super();
      }
      
      private static function enablereport(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         if(args.length == 0)
         {
            DofusErrorHandler.debugManuallyActivated = !DofusErrorHandler.debugManuallyActivated;
         }
         else
         {
            if(args.length != 1)
            {
               console.output(cmd + "requires 0 or 1 argument.");
               return;
            }
            switch(args[0])
            {
               case "true":
                  DofusErrorHandler.debugManuallyActivated = true;
                  break;
               case "false":
                  DofusErrorHandler.debugManuallyActivated = false;
                  break;
               case "":
                  DofusErrorHandler.debugManuallyActivated = !DofusErrorHandler.debugManuallyActivated;
                  break;
               default:
                  console.output("Bad arg. Argument must be true, false, or null");
                  return;
            }
         }
         console.output("\tReport have been " + (!!DofusErrorHandler.debugManuallyActivated ? "enabled" : "disabled") + ". Dofus need to restart.");
      }
      
      private static function enableLogs(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         if(args.length == 0)
         {
            SOSTarget.enabled = !SOSTarget.enabled;
            console.output("\tSOS logs have been " + (!!SOSTarget.enabled ? "enabled" : "disabled") + ".");
         }
         else if(args.length == 1)
         {
            switch(args[0])
            {
               case "true":
                  SOSTarget.enabled = true;
                  console.output("\tSOS logs have been enabled.");
                  break;
               case "false":
                  SOSTarget.enabled = false;
                  console.output("\tSOS logs have been disabled.");
                  break;
               case "":
                  SOSTarget.enabled = !SOSTarget.enabled;
                  console.output("\tSOS logs have been " + (!!SOSTarget.enabled ? "enabled" : "disabled") + ".");
                  break;
               default:
                  console.output("Bad arg. Argument must be true, false, or null");
            }
         }
         else
         {
            console.output(cmd + "requires 0 or 1 argument.");
         }
      }
      
      private static function validArgs() : Dictionary
      {
         var constant:Class = null;
         var name:String = null;
         var dico:Dictionary = new Dictionary();
         for each(constant in GameDataList.CLASSES)
         {
            name = getQualifiedClassName(constant);
            dico[name.substring(name.lastIndexOf("::") + 2).toLowerCase()] = name;
         }
         return dico;
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var animEntity:DisplayObject = null;
         var newWidth:Number = NaN;
         var newHeight:Number = NaN;
         var newScale:Number = NaN;
         var m:Matrix = null;
         var mode:String = null;
         var bounds:Rectangle = null;
         var bd:BitmapData = null;
         var ba:ByteArray = null;
         var fileNum:uint = 0;
         var f:File = null;
         var fs:FileStream = null;
         var matchMonsters:Array = null;
         var monsterFilter:String = null;
         var monsters:Vector.<Object> = null;
         var currentMonster:Monster = null;
         var spellFilter:String = null;
         var matchSpells:Vector.<Object> = null;
         var marge:uint = 0;
         var size:Number = NaN;
         var i:uint = 0;
         switch(cmd)
         {
            case "enablereport":
               enablereport(console,cmd,args);
               break;
            case "savereport":
               ErrorManager.addError("Console report",new EmptyError());
               break;
            case "enablelogs":
               enableLogs(console,cmd,args);
               break;
            case "info":
               this.info(console,cmd,args);
               break;
            case "search":
               this.search(console,cmd,args);
               break;
            case "searchmonster":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an argument to search for");
                  break;
               }
               matchMonsters = [];
               monsterFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
               monsters = GameDataQuery.returnInstance(Monster,GameDataQuery.queryString(Monster,"name",monsterFilter));
               for each(currentMonster in monsters)
               {
                  matchMonsters.push("\t" + currentMonster.name + " (id : " + currentMonster.id + ")");
               }
               matchMonsters.sort(Array.CASEINSENSITIVE);
               console.output(matchMonsters.join("\n"));
               console.output("\tRESULT : " + matchMonsters.length + " monsters found");
               break;
            case "searchspell":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an argument to search for");
                  break;
               }
               spellFilter = StringUtils.noAccent(args.join(" ").toLowerCase());
               matchSpells = GameDataQuery.returnInstance(Spell,GameDataQuery.queryString(Spell,"name",spellFilter));
               matchSpells.sort(Array.CASEINSENSITIVE);
               console.output(matchSpells.join("\n"));
               console.output("\tRESULT : " + matchSpells.length + " spells found");
               break;
            case "loadpacket":
               if(args.length < 1)
               {
                  console.output(cmd + " needs an uri argument");
                  break;
               }
               ConnectionsHandler.getHttpConnection().request(new Uri(args[0],false));
               break;
            case "reccordpacket":
               if(!this._reccordPacketFrame)
               {
                  console.output("Start network reccording");
                  this._reccordPacketFrame = new ReccordNetworkPacketFrame();
                  Kernel.getWorker().addFrame(this._reccordPacketFrame);
               }
               else
               {
                  console.output("Stop network reccording");
                  console.output(this._reccordPacketFrame.reccordedMessageCount + " packet(s) reccorded");
                  Kernel.getWorker().removeFrame(this._reccordPacketFrame);
                  this._reccordPacketFrame = null;
               }
               break;
            case "exportcharacter":
               animEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as DisplayObject;
               if(!animEntity)
               {
                  console.output("Can\'t export this sprite");
                  return;
               }
               m = new Matrix();
               mode = args.length > 0 ? args[0].toUpperCase() : "FIT";
               bounds = animEntity.getBounds(animEntity);
               if(mode == "FIT")
               {
                  marge = args.length > 2 ? uint(parseInt(args[2])) : uint(10);
                  size = Math.max(args.length > 1 ? Number(parseInt(args[1])) : Number(Math.max(bounds.width,bounds.height)));
                  if(bounds.width > bounds.height)
                  {
                     newWidth = size;
                     newHeight = size / (bounds.width / bounds.height);
                     newScale = size / bounds.width;
                  }
                  else
                  {
                     newHeight = size;
                     newWidth = size * bounds.width / bounds.height;
                     newScale = size / bounds.height;
                  }
                  m.scale(newScale,newScale);
                  bd = new BitmapData(newWidth + marge,newHeight + marge,true,0);
                  m.translate((bd.width - bounds.width * newScale) / 2 - bounds.left * newScale,(bd.height - bounds.height * newScale) / 2 - bounds.top * newScale);
               }
               if(mode == "ZOOM")
               {
                  if(args.length != 5)
                  {
                     console.output("Wrong number of arguments : MODE WIDTH HEIGHT ZOOM BOTTOM_MARGIN");
                     break;
                  }
                  newScale = parseFloat(args[3]);
                  bd = new BitmapData(parseInt(args[1]),parseInt(args[2]),true,0);
                  m.scale(newScale,newScale);
                  m.translate((bd.width - bounds.width * newScale) / 2 - bounds.left * newScale,bd.height - bounds.height * newScale - bounds.top * newScale);
               }
               bd.draw(animEntity,m,null,null,null,true);
               ba = PNGEncoder2.encode(bd);
               fileNum = 0;
               while(File.desktopDirectory.resolvePath("exportPlayer_" + fileNum + ".png").exists)
               {
                  fileNum++;
               }
               f = File.desktopDirectory.resolvePath("exportPlayer_" + fileNum + ".png");
               fs = new FileStream();
               fs.open(f,FileMode.WRITE);
               fs.writeBytes(ba);
               fs.close();
               console.output("Export dans le fichier " + f.nativePath);
               break;
            case "reccordimage":
               if(!EnterFrameDispatcher.hasEventListener(this.reccordImage))
               {
                  if(!this._sessionReccordFolder)
                  {
                     i = 1;
                     while(!this._sessionReccordFolder)
                     {
                        this._sessionReccordFolder = File.desktopDirectory.resolvePath("Dofus_" + this._sessionDate.getFullYear() + "-" + this._sessionDate.getMonth() + "-" + this._sessionDate.getDate() + "_session_" + i++);
                        if(!this._sessionReccordFolder.exists)
                        {
                           this._sessionReccordFolder.createDirectory();
                           break;
                        }
                        this._sessionReccordFolder = null;
                     }
                     console.output("Export dans le dossier " + this._sessionReccordFolder.nativePath);
                  }
                  AbstractSequencable.DEFAULT_TIMEOUT = 500000;
                  DofusFpsManager.allowSkipFrame = false;
                  StageShareManager.stage.frameRate = 25;
                  AnimatedMovementBehavior.updateRealtime = false;
                  AnimatedMovementBehavior.updateForcedFps = 25;
                  EnterFrameDispatcher.addEventListener(this.reccordImage,EnterFrameConst.IMAGE_RECCORD);
               }
               else
               {
                  AbstractSequencable.DEFAULT_TIMEOUT = 5000;
                  DofusFpsManager.allowSkipFrame = true;
                  AnimatedMovementBehavior.updateRealtime = true;
                  StageShareManager.stage.frameRate = 50;
                  EnterFrameDispatcher.removeEventListener(this.reccordImage);
               }
               break;
            case "displayworldgraph":
               MapApi.DEBUG_WORLD_GRAPH_SHORTCUTS = !MapApi.DEBUG_WORLD_GRAPH_SHORTCUTS;
               KernelEventsManager.getInstance().processCallback(HookList.MapDebugWorldGraphSortcutToggle);
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "enablelogs":
               return "Enable / Disable logs, param : [true/false]";
            case "info":
               return "List properties on a specific data (monster, weapon, etc), param [Class] [id]";
            case "search":
               return "Generic search function, param : [Class] [Property] [Filter]";
            case "searchmonster":
               return "Search monster name/id, param : [part of monster name]";
            case "searchspell":
               return "Search spell name/id, param : [part of spell name]";
            case "enablereport":
               return "Enable or disable report (see /savereport).";
            case "savereport":
               return "If report are enable, it will show report UI (see /savereport)";
            case "loadpacket":
               return "Load a remote file containing network(s) packets";
            case "reccordpacket":
               return "Reccord network(s) packets into a file (usefull with /loadpacket command)";
            case "exportcharacter":
               return "Export the current player into PNG. Param 1 (opt): FIT or ZOOM\n/exportcharacter FIT SIZE MARGIN\n/exportcharacter ZOOM WIDTH HEIGHT MULTIPLICATOR MARGIN";
            case "reccordimage":
               return "Export each frame in 1920x1080 without lag in order to import them and create Video or Gif";
            case "displayworldgraph":
               return "Display worldGraph shortcuts";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var infoClassName:* = null;
         var searchClassName:* = null;
         var arg0:String = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "enablelogs":
               if(paramIndex == 0)
               {
                  possibilities.push("true");
                  possibilities.push("false");
               }
               break;
            case "info":
               if(paramIndex == 0)
               {
                  for(infoClassName in this._validArgs0)
                  {
                     possibilities.push(infoClassName);
                  }
               }
               break;
            case "search":
               if(paramIndex == 0)
               {
                  for(searchClassName in this._validArgs0)
                  {
                     possibilities.push(searchClassName);
                  }
               }
               else if(paramIndex == 1)
               {
                  arg0 = this._validArgs0[String(currentParams[0]).toLowerCase()];
                  if(arg0)
                  {
                     possibilities.push.apply(null,DescribeTypeCache.getVariables(getDefinitionByName(arg0)));
                  }
               }
         }
         return possibilities;
      }
      
      private function reccordImage(... foo) : void
      {
         var world:DisplayObjectContainer = Atouin.getInstance().worldContainer;
         var bitmapSize:Point = new Point();
         bitmapSize.x = AtouinConstants.WIDESCREEN_BITMAP_WIDTH;
         bitmapSize.y = StageShareManager.startHeight;
         var r:Rectangle = new Rectangle(0,0,bitmapSize.x,bitmapSize.y);
         var m:Matrix = new Matrix();
         m.translate((bitmapSize.x - StageShareManager.startWidth) / 2,(bitmapSize.y - StageShareManager.startHeight) / 2);
         var s:Number = Math.max(1920 / r.width,1080 / r.height);
         m.scale(s,s);
         if(!this._sessionReccordBitmapData)
         {
            this._sessionReccordBitmapData = new BitmapData(1920,1080);
         }
         this._sessionReccordBitmapData.draw(world,m);
         var f:File = this._sessionReccordFolder.resolvePath(FrameIdManager.frameId + ".jpg");
         var fs:FileStream = new FileStream();
         fs.open(f,FileMode.WRITE);
         fs.writeBytes(JPEGEncoder.encode(this._sessionReccordBitmapData,95));
         fs.close();
      }
      
      private function info(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var iDataCenter:String = null;
         var className:String = null;
         var id:int = 0;
         var object:Object = null;
         var varAndAccess:Vector.<String> = null;
         var hasNameField:Boolean = false;
         var property:String = null;
         var currentObject:Object = null;
         var size:int = 0;
         var result:String = "";
         if(args.length != 2)
         {
            console.output(cmd + " needs 2 args.");
            return;
         }
         iDataCenter = args[0];
         className = this._validArgs0[iDataCenter.toLowerCase()];
         id = int(args[1]);
         if(className)
         {
            object = getDefinitionByName(className);
            if(!object.hasOwnProperty("idAccessors") || object.idAccessors.instanceById == null)
            {
               console.output("WARN : " + iDataCenter + " has no getById function !");
               return;
            }
            object = object.idAccessors.instanceById(id);
            if(object == null)
            {
               console.output(iDataCenter + " " + id + " does not exist.");
               return;
            }
            hasNameField = object.hasOwnProperty("name");
            varAndAccess = DescribeTypeCache.getVariables(getDefinitionByName(className));
            varAndAccess.sort(Array.CASEINSENSITIVE);
            for each(property in varAndAccess)
            {
               if(object.hasOwnProperty(property))
               {
                  currentObject = object[property];
                  if(currentObject == null)
                  {
                     result += "\t" + property + " : null\n";
                  }
                  else if(currentObject is Boolean || currentObject is int || currentObject is uint || currentObject is Number || currentObject is String)
                  {
                     result += "\t" + property + " : " + currentObject.toString() + "\n";
                  }
                  else if(currentObject is Vector.<Boolean> || currentObject is Vector.<int> || currentObject is Vector.<uint> || currentObject is Vector.<Number> || currentObject is Vector.<String>)
                  {
                     size = currentObject.length;
                     if(size > 30)
                     {
                        result += "\t" + property + "(" + size + " element(s)) : " + currentObject.slice(0,30).toString() + ", ...\n";
                     }
                     else
                     {
                        result += "\t" + property + "(" + size + " element(s)) : " + currentObject.toString() + "\n";
                     }
                  }
               }
            }
            result = StringUtils.cleanString(result);
            result = "\t<b>" + (!!hasNameField ? object.name : "") + " (id : " + object.id + ")</b>\n" + result;
            console.output(result);
         }
         else
         {
            console.output("Bad args. Can\'t search in \'" + iDataCenter + "\'");
         }
      }
      
      private function search(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var iDataCenter:String = null;
         var member:String = null;
         var filter:String = null;
         var className:String = null;
         var currentObject:Object = null;
         var hasNameField:Boolean = false;
         var object:Object = null;
         var results:Array = null;
         var matchSearch:Array = null;
         if(args.length < 3)
         {
            console.output(cmd + " needs 3 arguments");
            return;
         }
         iDataCenter = String(args.shift());
         member = String(args.shift());
         filter = args.join(" ").toLowerCase();
         className = this._validArgs0[iDataCenter.toLowerCase()];
         if(className)
         {
            object = getDefinitionByName(className);
            if(!object.hasOwnProperty("idAccessors") || object.idAccessors.allInstances == null)
            {
               console.output("WARN : \'" + iDataCenter + "\' has no listing function !");
               return;
            }
            results = object.idAccessors.allInstances();
            matchSearch = [];
            if(results.length == 0)
            {
               console.output("No object found");
               return;
            }
            if(results[0].hasOwnProperty(member))
            {
               if(results[0][member] is int || results[0][member] is uint || results[0][member] is Number)
               {
                  if(isNaN(Number(filter)))
                  {
                     console.output("Bad filter. Attribute \'" + member + "\' is a Number. Use a Number filter.");
                     return;
                  }
                  for each(currentObject in results)
                  {
                     if(currentObject)
                     {
                        hasNameField = currentObject.hasOwnProperty("name");
                        if(currentObject[member] == Number(filter))
                        {
                           matchSearch.push("\t" + (!!hasNameField ? currentObject["name"] : "") + " (id : " + currentObject["id"] + ")");
                        }
                     }
                  }
               }
               else
               {
                  if(!(results[0][member] is String))
                  {
                     console.output("Bad args. Attribute \'" + member + "\' must be int, uint, Number or String in \'" + iDataCenter + "\' (Case sensitive)");
                     return;
                  }
                  for each(currentObject in results)
                  {
                     if(currentObject)
                     {
                        hasNameField = currentObject.hasOwnProperty("name");
                        if(StringUtils.noAccent(String(currentObject[member])).toLowerCase().indexOf(StringUtils.noAccent(filter)) != -1)
                        {
                           matchSearch.push("\t" + (!!hasNameField ? currentObject["name"] : "") + " (id : " + currentObject["id"] + ")");
                        }
                     }
                  }
               }
               matchSearch.sort(Array.CASEINSENSITIVE);
               console.output(matchSearch.join("\n"));
               console.output("\tRESULT : " + matchSearch.length + " objects found");
            }
            else
            {
               console.output("Bad args. Attribute \'" + member + "\' does not exist in \'" + iDataCenter + "\' (Case sensitive)");
            }
         }
         else
         {
            console.output("Bad args. Can\'t search in \'" + iDataCenter + "\'");
         }
      }
   }
}

class EmptyError extends Error
{
    
   
   function EmptyError()
   {
      super();
   }
   
   override public function getStackTrace() : String
   {
      return "";
   }
}

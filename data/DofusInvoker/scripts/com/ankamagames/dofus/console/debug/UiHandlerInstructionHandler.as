package com.ankamagames.dofus.console.debug
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.components.TextureBase;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.managers.UiRenderManager;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.tooltip.TooltipBlock;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkDisplayArrowManager;
   import com.ankamagames.dofus.misc.utils.Inspector;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.BitmapData;
   import flash.filesystem.File;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   
   public class UiHandlerInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiHandlerInstructionHandler));
       
      
      private var _uiInspector:Inspector;
      
      public function UiHandlerInstructionHandler()
      {
         super();
      }
      
      private static function getFilesFingerPrints(target:File) : String
      {
         var f:File = null;
         var result:String = "";
         var files:Array = target.getDirectoryListing();
         files.sortOn("name");
         for each(f in files)
         {
            if(f.isDirectory)
            {
               result += getFilesFingerPrints(f);
            }
            else
            {
               result += f.size;
            }
         }
         return result;
      }
      
      private static function inspectUiElement(target:GraphicContainer, console:ConsoleHandler) : void
      {
         var txt:String = null;
         var property:String = null;
         var type:String = null;
         var properties:Vector.<String> = DescribeTypeCache.getVariables(target);
         properties.sort(function(a:String, b:String):int
         {
            if(a > b)
            {
               return 1;
            }
            if(a < b)
            {
               return -1;
            }
            return 0;
         });
         for each(property in properties)
         {
            try
            {
               type = target[property] != null ? getQualifiedClassName(target[property]).split("::").pop() : "?";
               if(type == "Array")
               {
                  type += ", len: " + target[property].length;
               }
               txt = property + " (" + type + ") : " + target[property];
            }
            catch(e:Error)
            {
               txt = property + " (?) : <Exception throw by getter>";
            }
            if(!console)
            {
               _log.info(txt);
            }
            else
            {
               console.output(txt);
            }
         }
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var uiName:String = null;
         var instanceName:String = null;
         var c:Dictionary = null;
         var totalBitmapsInCache:uint = 0;
         var ramFromBitmapInCache:uint = 0;
         var tmpArr:Array = null;
         var bd:BitmapData = null;
         var bdSize:uint = 0;
         var currentUiList:Dictionary = null;
         var uiOutput:Array = null;
         var ml:Array = null;
         var mod:UiModule = null;
         var m:Dictionary = null;
         var disabledModules:Dictionary = null;
         var um:UiModule = null;
         var uiTarget:UiRootContainer = null;
         var elemTarget:GraphicContainer = null;
         var xmlName:String = null;
         var uiData:UiData = null;
         var _aFiles:Array = null;
         var fingerPrint:String = null;
         var strata:int = 0;
         var module:UiModule = null;
         var uriPath:String = null;
         var tmpOjb:* = undefined;
         var uiList:Array = null;
         var i:String = null;
         var ui:UiData = null;
         var modul:UiModule = null;
         var oldUiData:UiData = null;
         var j:uint = 0;
         var uimodule:UiModule = null;
         switch(cmd)
         {
            case "loadui":
               uiName = args[0];
               instanceName = "";
               if(args[1])
               {
                  instanceName = args[1];
               }
               for each(module in UiModuleManager.getInstance().getModules())
               {
                  if(module.getUi(uiName))
                  {
                     Berilia.getInstance().loadUi(module,module.getUi(uiName),instanceName,null,true);
                     break;
                  }
               }
               break;
            case "showarrow":
               HyperlinkDisplayArrowManager.showArrow.apply(null,args);
               break;
            case "texturebitmapcache":
               c = TextureBase.getBitmapCache();
               totalBitmapsInCache = 0;
               ramFromBitmapInCache = 0;
               tmpArr = [];
               for(uriPath in c)
               {
                  bd = c[uriPath];
                  bdSize = bd.width * bd.height * 4;
                  tmpArr.push({
                     "uri":uriPath,
                     "bitmapData":bd,
                     "size":bdSize
                  });
                  totalBitmapsInCache++;
                  ramFromBitmapInCache += bdSize;
               }
               tmpArr.sortOn(["size","uri"],[Array.DESCENDING | Array.NUMERIC,Array.CASEINSENSITIVE]);
               for each(tmpOjb in tmpArr)
               {
                  console.output(tmpOjb.uri + ", " + tmpOjb.bitmapData.width + "x" + tmpOjb.bitmapData.height + ", size: " + FpsManagerUtils.calculateMB(tmpOjb.size) + "MB");
               }
               console.output(">> " + totalBitmapsInCache + " BitmapData in cache for a total of " + FpsManagerUtils.calculateMB(ramFromBitmapInCache) + "MB");
               break;
            case "unloadui":
               if(args.length == 0)
               {
                  uiList = [];
                  for(i in Berilia.getInstance().uiList)
                  {
                     if(Berilia.getInstance().uiList[i].name != "Console")
                     {
                        uiList.push(Berilia.getInstance().uiList[i].name);
                     }
                  }
                  for each(i in uiList)
                  {
                     Berilia.getInstance().unloadUi(i);
                  }
                  console.output(uiList.length + " UI were unload");
                  break;
               }
               if(Berilia.getInstance().unloadUi(args[0]))
               {
                  console.output("RIP " + args[0]);
               }
               else
               {
                  console.output(args[0] + " does not exist or an error occured while unloading UI");
               }
               break;
            case "autoreloadui":
               Berilia.getInstance().autoReloadUiOnChange = !Berilia.getInstance().autoReloadUiOnChange;
               break;
            case "clearuicache":
               if(args && args[0])
               {
                  UiRenderManager.getInstance().clearCacheFromUiName(args[0]);
               }
               else
               {
                  UiRenderManager.getInstance().clearCache();
               }
               ThemeManager.getInstance().loadThemeData();
               break;
            case "clearcsscache":
               CssManager.clear(true);
               break;
            case "cleartooltipcache":
               TooltipManager.clearCache();
               TooltipBlock.clearCache();
               break;
            case "clearthemedata":
               ThemeManager.getInstance().clearThemeData();
               ThemeManager.getInstance().loadThemeData();
               break;
            case "setuiscale":
               Berilia.getInstance().scale = Number(args[0]);
               break;
            case "useuicache":
               StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION,"useCache",args[0] == "true");
               BeriliaConstants.USE_UI_CACHE = args[0] == "true";
               break;
            case "uilist":
               currentUiList = Berilia.getInstance().uiList;
               uiOutput = [];
               for(uiName in currentUiList)
               {
                  ui = UiRootContainer(currentUiList[uiName]).uiData;
                  uiOutput.push([uiName,ui.name,ui.uiClassName,ui.module.id]);
               }
               console.output(StringUtils.formatArray(uiOutput,["Instance ID","Ui name","Class","Module"]));
               break;
            case "reloadui":
               if(args[0])
               {
                  UiModuleManager.getInstance().loadModule(args[0]);
               }
               else
               {
                  console.output("Failed to reload ui, no id found in command arguments");
               }
               break;
            case "modulelist":
               ml = [];
               m = UiModuleManager.getInstance().getModules();
               for each(mod in m)
               {
                  ml.push([mod.id,mod.author,true]);
               }
               disabledModules = UiModuleManager.getInstance().disabledModules;
               for each(mod in disabledModules)
               {
                  ml.push([mod.id,mod.author,false]);
               }
               console.output(StringUtils.formatArray(ml,["ID","Author","Active"]));
               break;
            case "getmoduleinfo":
               um = UiModuleManager.getInstance().getModule(args[0]);
               if(!um)
               {
                  console.output("Module " + args[0] + " does not exists");
               }
               break;
            case "uiinspector":
            case "inspector":
               if(!this._uiInspector)
               {
                  this._uiInspector = new Inspector();
               }
               this._uiInspector.enable = !this._uiInspector.enable;
               this._uiInspector.hierachicalMode = args.length == 0 ? true : args[1] == "false";
               if(this._uiInspector.enable)
               {
                  console.output("Inspector is ON.\n Use Ctrl-C to save the last hovered element informations.");
               }
               else
               {
                  console.output("Inspector is OFF.");
               }
               break;
            case "inspectuielementsos":
            case "inspectuielement":
               if(args.length == 0)
               {
                  console.output(cmd + " need at least one argument (" + cmd + " uiName [uiElementName])");
                  break;
               }
               uiTarget = Berilia.getInstance().getUi(args[0]);
               if(!uiTarget)
               {
                  console.output("UI " + args[0] + " not found (use /uilist to grab current displayed UI list)");
                  break;
               }
               if(args.length == 1)
               {
                  inspectUiElement(uiTarget,cmd == "inspectuielementsos" ? null : console);
                  break;
               }
               elemTarget = uiTarget.getElement(args[1]);
               if(!elemTarget)
               {
                  console.output("UI Element " + args[0] + " not found on UI " + args[0] + "(use /uiinspector to view elements names)");
                  break;
               }
               inspectUiElement(elemTarget,cmd == "inspectuielementsos" ? null : console);
               break;
            case "loadprotoxml":
               xmlName = args[0];
               UiRenderManager.getInstance().clearCacheFromUiName("proto");
               if(Berilia.getInstance().unloadUi("prototype"))
               {
                  console.output("Déchargement de l\'interface de prototype");
               }
               for each(modul in UiModuleManager.getInstance().getModules())
               {
                  if(modul.getUi("prototype"))
                  {
                     oldUiData = modul.getUi("prototype");
                     if(xmlName.indexOf(".xml") == -1)
                     {
                        xmlName += ".xml";
                     }
                     uiData = new UiData(oldUiData.module,oldUiData.name,xmlName,oldUiData.uiClassName,oldUiData.uiGroupName);
                     uiData.uiClass = oldUiData.uiClass;
                     Berilia.getInstance().loadUi(modul,uiData,"prototype",null,true,StrataEnum.STRATA_TOP,false,null,false,false);
                     console.output("Chargement de l\'interface de prototype");
                     break;
                  }
               }
               break;
            case "changefonttype":
               _aFiles = [];
               _aFiles.push(LangManager.getInstance().getEntry("config.ui.asset.fontsList"));
               for(j = 0; j < _aFiles.length; j++)
               {
                  FontManager.getInstance().loadFile(_aFiles[j]);
               }
               setTimeout(function():void
               {
                  FontManager.getInstance().activeType = args.length == 0 ? FontManager.DEFAULT_FONT_TYPE : args[0];
               },500);
               break;
            case "resetuisavedusermodification":
               Berilia.getInstance().resetUiSavedUserModification(args[0]);
               break;
            case "getthemefingerprint":
               fingerPrint = MD5.hash(getFilesFingerPrints(new Uri(LangManager.getInstance().getEntry("config.ui.skin")).toFile()));
               console.output("Finger print du theme actif : " + fingerPrint);
               break;
            case "subhint":
               if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
               {
                  break;
               }
               if(args.length > 1)
               {
                  console.output("Too many arguments given, " + cmd + " takes 0 or 1 argument only (" + cmd + " [display_strata])");
                  break;
               }
               strata = 3;
               if(args[0])
               {
                  strata = args[0];
               }
               if(strata > 3)
               {
                  strata = 3;
               }
               else if(strata < 0)
               {
                  strata = 0;
               }
               if(!Berilia.getInstance().getUi("SubhintEditorUi"))
               {
                  for each(uimodule in UiModuleManager.getInstance().getModules())
                  {
                     if(uimodule.getUi("SubhintEditorUi"))
                     {
                        Berilia.getInstance().loadUi(uimodule,uimodule.getUi("SubhintEditorUi"),"SubhintEditorUi",null,false,strata);
                     }
                  }
               }
               else
               {
                  Berilia.getInstance().unloadUi("SubhintEditorUi");
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "loadui":
               return "Load an UI. Usage: loadUi <uiId> <uiInstanceName>(optional)";
            case "unloadui":
               return "Unload UI with the given UI instance name.";
            case "clearuicache":
               return "Clear an UI/all UIs (if no paramter) in cache (will force xml parsing)";
            case "setuiscale":
               return "Set scale for all scalable UI. Usage: setUiScale <Number> (100% = 1.0)";
            case "useuicache":
               return "Enable UI caching";
            case "uilist":
               return "Get current UI list";
            case "reloadui":
               return "Unload and reload an UI/all UIs (if no paramter))";
            case "modulelist":
               return "Display activated modules.";
            case "inspector":
            case "uiinspector":
               return "Display a tooltip with informations over each interactive element";
            case "inspectuielement":
               return "Display the property list of an UI element (UI or Component), usage /inspectuielement uiName (elementName)";
            case "inspectuielementsos":
               return "Display the property list of an UI element (UI or Component) to SOS, usage /inspectuielement uiName (elementName)";
            case "autoreloadui":
               return "Reload ui when XML definition file change";
            case "changefonttype":
               return "Change the current font type. @see fonts.xml";
            case "resetuisavedusermodification":
               return "Reset ui user modification (like resize, move). If an instanceId is provided, then the the reset is applyed only on this one";
            case "getthemefingerprint":
               return "Finger print du theme actuel se basant sur le poid des fichiers";
            case "subhint":
               return "Opens the editor window for the UI tutorials \'strata\' (optional)";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var uiName:String = null;
         var uiList:Array = null;
         var i:* = null;
         var module:UiModule = null;
         var uiData:UiData = null;
         var uiInstanceName:String = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "unloadui":
               if(paramIndex == 0)
               {
                  for(i in Berilia.getInstance().uiList)
                  {
                     possibilities.push(Berilia.getInstance().uiList[i].name);
                  }
               }
               break;
            case "loadui":
               uiName = currentParams[0];
               for each(module in UiModuleManager.getInstance().getModules())
               {
                  for each(uiData in module.uis)
                  {
                     if(uiData.name.indexOf(uiName) != -1)
                     {
                        possibilities.push(uiData.name);
                     }
                  }
               }
               break;
            case "":
            case "resetuisavedusermodification":
               uiList = StoreDataManager.getInstance().getKeys(BeriliaConstants.DATASTORE_UI_POSITIONS);
               for each(uiInstanceName in uiList)
               {
                  if(StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_UI_POSITIONS,uiInstanceName))
                  {
                     possibilities.push(uiInstanceName);
                  }
               }
         }
         return possibilities;
      }
   }
}

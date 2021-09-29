package Ankama_Console.ui
{
   import Ankama_Console.Console;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   public class ConsoleUi
   {
      
      private static const SAVE_NAME:String = "consoleOption";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var contextMod:ContextMenu;
      
      private var _maxCmdHistoryIndex:uint = 25;
      
      private var _aHistory:Array;
      
      private var _nHistoryIndex:int = 0;
      
      public var taConsole:TextArea;
      
      public var lblInfo:Label;
      
      public var tiCmd:Input;
      
      public var mainContainer:GraphicContainer;
      
      public var topBar:GraphicContainer;
      
      public var ctr_insideConsole:GraphicContainer;
      
      public var btnReduce:ButtonContainer;
      
      public var btnExtend:ButtonContainer;
      
      public var btnClose:ButtonContainer;
      
      public var btnMenu:ButtonContainer;
      
      public var btnClear:ButtonContainer;
      
      public var btnBlock:ButtonContainer;
      
      public var btnWindow:ButtonContainer;
      
      private var _init:Boolean;
      
      private var _menu:Array;
      
      private var _options:Object;
      
      private var _savePreset:Boolean;
      
      private var _replaceTimer:BenchmarkTimer;
      
      private var _autoCompleteRunning:Boolean;
      
      private var _autoCompleteWithList:Boolean;
      
      private var _autoCompleteWithHistory:Boolean;
      
      private var _inputChanged:Boolean;
      
      private var _autoCompletePossibilities:Array;
      
      private var _autoCompleteIndex:int;
      
      private var _paramsRE:RegExp;
      
      private var _blockScroll:Boolean = false;
      
      private var _lastInput:String;
      
      public function ConsoleUi()
      {
         this._paramsRE = /'[a-zA-Z-*]*'/g;
         super();
      }
      
      public function main(pShowConsole:Boolean) : void
      {
         if(this.uiApi.me().windowOwner)
         {
            this.uiApi.me().windowOwner.title = this.playerApi.getPlayedCharacterInfo().name + " - Dofus " + this.sysApi.getCurrentVersion();
            this.uiApi.me().windowOwner.addDragController(this.mainContainer);
         }
         if(this.sysApi.getOs() == "Linux")
         {
            this.lblInfo.setCssFont("\"Courier New\", Courier, monospace");
            this.taConsole.setCssFont("\"Courier New\", Courier, monospace");
            this.tiCmd.setCssFont("\"Courier New\", Courier, monospace");
         }
         this.sysApi.addHook(HookList.ConsoleAddCmd,this.onConsoleAddCmd);
         this.sysApi.addHook(HookList.ConsoleClear,this.onConsoleClear);
         this.sysApi.addHook(HookList.ConsoleOutput,this.onConsoleOutput);
         this.sysApi.addHook(HookList.CharacterSelectionStart,this.onCharacterSelectionStart);
         this.sysApi.addHook(BeriliaHookList.KeyboardShortcut,this.onKeyBoardShortcut);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("upArrow",this.onShortcut);
         this.uiApi.addShortcutHook("downArrow",this.onShortcut);
         this.uiApi.addShortcutHook("autoComplete",this.onShortcut);
         this.uiApi.addShortcutHook("historySearch",this.onShortcut);
         this.uiApi.addComponentHook(this.btnReduce,"onRelease");
         this.uiApi.addComponentHook(this.btnExtend,"onRelease");
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnMenu,"onRelease");
         this.uiApi.addComponentHook(this.btnClear,"onRelease");
         this.uiApi.addComponentHook(this.btnBlock,"onRelease");
         this.uiApi.addComponentHook(this.btnWindow,"onRelease");
         this.uiApi.addComponentHook(this.topBar,"onDoubleClick");
         this.uiApi.addComponentHook(this.tiCmd,"onChange");
         this._autoCompletePossibilities = [];
         this.taConsole.activeSmallHyperlink();
         this.taConsole.useCustomFormat = true;
         if(!this._aHistory)
         {
            this.init();
         }
         this._options = this.sysApi.getData(SAVE_NAME,DataStoreEnum.BIND_ACCOUNT);
         if(!this._options)
         {
            this._savePreset = true;
            this._autoCompleteWithList = true;
            this._autoCompleteWithHistory = true;
         }
         else
         {
            this._savePreset = this._options.savePreset;
            this._autoCompleteWithList = !!this._options.hasOwnProperty("autoCompleteWithList") ? Boolean(this._options.autoCompleteWithList) : true;
            this._autoCompleteWithHistory = !!this._options.hasOwnProperty("autoCompleteWithHistory") ? Boolean(this._options.autoCompleteWithHistory) : true;
            if(!this._options.hasOwnProperty("fontSize"))
            {
               this._options.fontSize = 14;
            }
         }
         if(!this._options || !this._savePreset)
         {
            this._options = {
               "opacity":66,
               "x":100,
               "y":100,
               "width":1024,
               "height":500,
               "openConsole":false,
               "savePreset":this._savePreset,
               "fontSize":14
            };
         }
         this.updateInfo();
         this.onAlphaChange(this._options.opacity);
         this.onFontSizeChange(this._options.fontSize);
         if(pShowConsole)
         {
            this.setFocus();
         }
         this.extendConsole(this.sysApi.getData("consoleExtended",DataStoreEnum.BIND_ACCOUNT));
      }
      
      public function setFocus() : void
      {
         this.tiCmd.focus();
      }
      
      public function addCmd(cmd:String, send:Boolean, focusOn:Boolean) : void
      {
         if(send)
         {
            this.executeCmd(cmd);
         }
         else
         {
            this.tiCmd.text = cmd;
         }
         if(focusOn)
         {
            this.setFocus();
         }
      }
      
      public function updateInfo() : void
      {
         var playerInfo:Object = null;
         var info:* = "";
         var serverInfo:Server = this.sysApi.getCurrentServer();
         if(serverInfo)
         {
            info = serverInfo.name + " (" + serverInfo.id + ")";
         }
         if(this.playerApi)
         {
            playerInfo = this.playerApi.getPlayedCharacterInfo();
            if(playerInfo)
            {
               info += ", " + playerInfo.name + " (" + playerInfo.id + ")";
            }
         }
         if(!info.length)
         {
            info = "Connection server\'s";
         }
         this.lblInfo.text = info;
      }
      
      private function init() : void
      {
         this._aHistory = this.sysApi.getData("CommandsHistory");
         if(!this._aHistory)
         {
            this._aHistory = [];
         }
         this._nHistoryIndex = this._aHistory.length;
      }
      
      private function validCmd() : Boolean
      {
         if(!this.tiCmd.haveFocus)
         {
            return false;
         }
         var cmd:String = this.tiCmd.text;
         if(cmd.length == 0)
         {
            return true;
         }
         var cmdechap:String = cmd;
         while(cmdechap.indexOf("<") != -1)
         {
            cmdechap = cmdechap.replace("<","&lt;");
         }
         while(cmdechap.indexOf(">") != -1)
         {
            cmdechap = cmdechap.replace(">","&gt;");
         }
         this.output("\n > " + cmdechap + "\n");
         this.tiCmd.text = "";
         this.executeCmd(cmd);
         return true;
      }
      
      private function executeCmd(input:String) : void
      {
         if(!this._aHistory)
         {
            this.init();
         }
         if(!this._aHistory.length || input != this._aHistory[this._aHistory.length - 1])
         {
            this._aHistory.push(input);
            if(this._aHistory.length > this._maxCmdHistoryIndex)
            {
               this._aHistory = this._aHistory.slice(this._aHistory.length - this._maxCmdHistoryIndex,this._aHistory.length);
            }
            this._nHistoryIndex = this._aHistory.length;
            this.sysApi.setData("CommandsHistory",this._aHistory);
         }
         else
         {
            this._nHistoryIndex = this._aHistory.length;
         }
         this.sysApi.sendAction(new AuthorizedCommandAction([input]));
         this.setFocus();
      }
      
      private function output(text:String, type:uint = 0) : void
      {
         var alphaMode:String = this._options.opacity != 100 ? "alpha" : "";
         this.taConsole.appendText(text,type == 0 ? "p" + alphaMode : (type == 1 ? "pinfo" + alphaMode : (type == 2 ? "perror" + alphaMode : "p" + alphaMode)));
         if(!this._blockScroll)
         {
            this.taConsole.scrollV = this.taConsole.maxScrollV;
         }
         if(this.uiApi.me().visible)
         {
            this.tiCmd.focus();
         }
      }
      
      private function trimWhitespace(str:String) : String
      {
         if(str == null)
         {
            return "";
         }
         return str.replace(/^\s+|\s+$/g,"");
      }
      
      private function getParamsAutoCompleteFromHelp(pCmd:String, pServerCmd:Boolean) : Array
      {
         var helpParams:String = null;
         var p:String = null;
         var possibility:String = null;
         var cmdSplit:Array = pCmd.split(" ");
         var cmdParams:String = pCmd.substring(pCmd.lastIndexOf(" ") + 1);
         var help:String = this.sysApi.getCmdHelp(cmdSplit[0],pServerCmd);
         if(help.indexOf("Unknown command") != -1)
         {
            return null;
         }
         var helpSplit:Array = help.split(" ");
         var paramPos:int = cmdSplit.length - 1;
         if(paramPos <= helpSplit.length - 1)
         {
            helpParams = helpSplit[paramPos];
         }
         var params:Array = helpParams.match(this._paramsRE);
         var paramsAutoComplete:Array = [];
         var cmdStart:String = pCmd.substring(0,pCmd.lastIndexOf(" "));
         for each(p in params)
         {
            possibility = cmdStart + " " + p.replace(/\'/g,"");
            if(possibility.indexOf(pCmd) != -1)
            {
               paramsAutoComplete.push(possibility);
            }
         }
         return paramsAutoComplete;
      }
      
      private function autoComplete(onlyHistory:Boolean = false, isDeleting:Boolean = false) : void
      {
         var boldLength:int = 0;
         var serverCmd:Boolean = false;
         var possibilities:Array = null;
         var help:String = null;
         var historyContextMenu:Array = null;
         var historyPossibilities:Array = null;
         var contextMenu:Array = null;
         var cmdPos:uint = 0;
         var sNewCmd:String = null;
         var splittedLine:Array = null;
         var currentCommand:String = null;
         var currentParams:Array = null;
         var entry:String = null;
         var cmd2:String = null;
         var boldStart:Number = NaN;
         var cmd3:String = null;
         var paramsAutoComplete:Array = null;
         var p:String = null;
         var paramPossibility:String = null;
         var possibility:String = null;
         var sStartCmd:String = this.tiCmd.text;
         var possibilitiesCount:uint = 0;
         serverCmd = sStartCmd.length > 0 ? (sStartCmd.charAt(0) == "/" ? false : true) : false;
         if((this._autoCompleteWithList || !this._autoCompleteWithList && this._inputChanged) && sStartCmd.length != 0 && !onlyHistory)
         {
            if(!serverCmd)
            {
               sStartCmd = sStartCmd.substr(1);
            }
            if(sStartCmd.length == 0)
            {
               return;
            }
            cmdPos = sStartCmd.substr(0,this.tiCmd.caretIndex).split(" ").length - 1;
            if(cmdPos == 0)
            {
               possibilities = this.sysApi.getAutoCompletePossibilities(sStartCmd,serverCmd);
            }
            else
            {
               splittedLine = sStartCmd.split(" ");
               currentCommand = splittedLine[0];
               splittedLine.splice(0,1);
               currentParams = splittedLine;
               possibilities = this.sysApi.getAutoCompletePossibilitiesOnParam(currentCommand,serverCmd,cmdPos - 1,currentParams);
            }
            possibilitiesCount = possibilities.length;
            sNewCmd = this.sysApi.getConsoleAutoCompletion(sStartCmd,serverCmd);
         }
         var needle:String = this.tiCmd.text;
         var done:Dictionary = new Dictionary();
         if(this._autoCompleteWithHistory && (this._autoCompleteWithList || !this._autoCompleteWithList && this._inputChanged))
         {
            historyPossibilities = [];
            for each(entry in this._aHistory)
            {
               entry = this.trimWhitespace(entry);
               if(!done[entry.toLowerCase()] && entry.toLowerCase().indexOf(needle) != -1)
               {
                  historyPossibilities.push(entry);
                  done[entry.toLowerCase()] = true;
               }
            }
         }
         if(this._autoCompleteWithList && historyPossibilities && historyPossibilities.length)
         {
            historyContextMenu = [];
            historyContextMenu.push(this.contextMod.createContextMenuTitleObject("History"));
            for each(cmd2 in historyPossibilities)
            {
               boldStart = cmd2.toLowerCase().indexOf(needle);
               boldLength = needle.length;
               historyContextMenu.push(this.contextMod.createContextMenuItemObject(cmd2.substr(0,boldStart) + "<b>" + cmd2.substr(boldStart,boldLength) + "</b>" + cmd2.substr(boldStart + boldLength),this.onPossibilityChoice,[cmd2,true,false],false,null,false,true));
            }
            if(possibilitiesCount == 0 && historyPossibilities.length == 1)
            {
               sNewCmd = cmd2;
               serverCmd = true;
            }
            possibilitiesCount += historyPossibilities.length;
         }
         if(this._autoCompleteWithList)
         {
            contextMenu = [];
            if(possibilitiesCount == 1)
            {
               if(!isDeleting)
               {
                  this.tiCmd.text = (!!serverCmd ? "" : "/") + sNewCmd;
               }
               this.tiCmd.setSelection(this.tiCmd.length,this.tiCmd.length);
               this._autoCompleteRunning = false;
               this.contextMod.closeAllMenu();
            }
            else if(possibilities && possibilities.length > 1)
            {
               contextMenu.push(this.contextMod.createContextMenuTitleObject(!!serverCmd ? "Server commands" : "Client commands"));
               boldLength = this.getBoldLength(sStartCmd,sNewCmd) + (!!serverCmd ? 0 : 1);
               for each(cmd3 in possibilities)
               {
                  help = this.sysApi.getCmdHelp(cmd3,serverCmd);
                  if(help)
                  {
                     help = help.split("[").join("&#91;");
                  }
                  contextMenu.push(this.contextMod.createContextMenuItemObject((!!serverCmd ? "" : "/") + "<b>" + cmd3.substr(0,boldLength) + "</b>" + cmd3.substr(boldLength),this.onPossibilityChoice,[cmd3,serverCmd,cmdPos != 0],false,null,false,true,help));
               }
            }
            if(historyContextMenu)
            {
               contextMenu = contextMenu.concat(historyContextMenu);
            }
            if(contextMenu.length)
            {
               this.contextMod.createContextMenu(contextMenu,{
                  "x":this.mainContainer.x,
                  "y":this.mainContainer.y + this.mainContainer.height
               },this.onContextMenuClose,null,!!this.uiApi.me().windowOwner ? this.uiApi.me().windowOwner.uiRootContainer : null);
               this._autoCompleteRunning = true;
            }
            else
            {
               this.contextMod.closeAllMenu();
            }
         }
         if(!this._autoCompleteWithList && !isDeleting && sStartCmd.length > 0)
         {
            if(this._inputChanged)
            {
               this._autoCompleteIndex = 0;
               this._inputChanged = false;
               this._autoCompletePossibilities = [];
               if(possibilities && possibilities.length > 0)
               {
                  if(cmdPos != 0)
                  {
                     paramsAutoComplete = [];
                     for each(p in possibilities)
                     {
                        paramPossibility = sStartCmd.substring(0,sStartCmd.lastIndexOf(" ")) + " " + p;
                        if(paramPossibility.indexOf(sStartCmd) != -1)
                        {
                           paramsAutoComplete.push(paramPossibility);
                        }
                     }
                     if(paramsAutoComplete.length > 0)
                     {
                        this._autoCompletePossibilities = this._autoCompletePossibilities.concat(paramsAutoComplete);
                     }
                  }
                  else
                  {
                     this._autoCompletePossibilities = this._autoCompletePossibilities.concat(possibilities);
                  }
               }
               else if(sStartCmd.indexOf(" ") != -1)
               {
                  paramsAutoComplete = this.getParamsAutoCompleteFromHelp(sStartCmd,serverCmd);
                  if(paramsAutoComplete)
                  {
                     this._autoCompletePossibilities = this._autoCompletePossibilities.concat(paramsAutoComplete);
                  }
               }
               if(historyPossibilities && historyPossibilities.length > 0)
               {
                  this._autoCompletePossibilities = this._autoCompletePossibilities.concat(historyPossibilities);
               }
            }
            else if(this._autoCompleteIndex < this._autoCompletePossibilities.length - 1)
            {
               ++this._autoCompleteIndex;
            }
            else
            {
               this._autoCompleteIndex = 0;
            }
            if(this._autoCompletePossibilities.length > 0)
            {
               possibility = this._autoCompletePossibilities[this._autoCompleteIndex];
               if(possibility.charAt(0) == "/")
               {
                  possibility = possibility.substr(1);
               }
               this.tiCmd.text = (!serverCmd ? "/" : "") + possibility;
               this.tiCmd.caretIndex = this.tiCmd.text.length;
            }
         }
      }
      
      public function extendConsole(extend:Boolean) : void
      {
         this.mainContainer.x = 30;
         this.mainContainer.y = 32;
         this.mainContainer.width = !!extend ? Number(1) : Number(0.8);
         this.mainContainer.height = !!extend ? Number(0.8) : Number(0.2);
         this.ctr_insideConsole.height = !!extend ? Number(0.98) : Number(0.95);
         this.sysApi.setData("consoleExtended",extend,DataStoreEnum.BIND_ACCOUNT);
         this.uiApi.me().render();
      }
      
      private function onConsoleOutput(msg:String, type:uint) : void
      {
         if(this._options.openConsole)
         {
            Console.getInstance().showConsole(true);
         }
         this.output(msg + "\n",type);
      }
      
      private function onKeyBoardShortcut(b:Bind, keycode:uint) : void
      {
         var registeredBind:Bind = this.bindsApi.getRegisteredBind(b);
         if(!this._autoCompleteWithList && (!registeredBind || registeredBind.targetedShortcut != "autoComplete"))
         {
            this._inputChanged = true;
            this._autoCompleteRunning = false;
         }
      }
      
      private function onKeyUp(target:DisplayObject, pKeyCode:uint) : void
      {
         if(!this._autoCompleteWithList && pKeyCode == Keyboard.BACKSPACE)
         {
            this._inputChanged = true;
            this._autoCompleteRunning = false;
         }
         else if(this._autoCompleteRunning && pKeyCode == Keyboard.ESCAPE)
         {
            this._autoCompleteRunning = false;
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         if(!this.uiApi.me().visible)
         {
            return false;
         }
         switch(s)
         {
            case "validUi":
               return this.validCmd();
            case "upArrow":
            case "downArrow":
               if(!this.tiCmd.haveFocus)
               {
                  return true;
               }
               if(!this._aHistory.length)
               {
                  return true;
               }
               if(s == "upArrow" && this._nHistoryIndex >= 0)
               {
                  --this._nHistoryIndex;
               }
               if(s == "downArrow" && this._nHistoryIndex < this._aHistory.length)
               {
                  ++this._nHistoryIndex;
               }
               if(this._aHistory[this._nHistoryIndex] != null)
               {
                  this.tiCmd.text = this._aHistory[this._nHistoryIndex];
               }
               else
               {
                  this.tiCmd.text = "";
               }
               this.tiCmd.setSelection(this.tiCmd.length,this.tiCmd.length);
               return true;
               break;
            case "autoComplete":
               this.tiCmd.focus();
               this.autoComplete();
               return true;
            case "historySearch":
               this.tiCmd.focus();
               this.autoComplete();
               return true;
            default:
               return false;
         }
      }
      
      private function onPossibilityChoice(cmd:String, isServerCommand:Boolean, justAdd:Boolean = false) : void
      {
         var text:String = null;
         var i:int = 0;
         if(justAdd)
         {
            text = this.tiCmd.text;
            for(i = this.tiCmd.caretIndex; i >= 0; i--)
            {
               if(text.charAt(i) == " ")
               {
                  this.tiCmd.text = text.substr(0,i + 1) + cmd;
                  break;
               }
            }
         }
         else
         {
            this.tiCmd.text = (!!isServerCommand ? "" : "/") + cmd + " ";
         }
         this.tiCmd.caretIndex = this.tiCmd.text.length;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var alphaMenu:Array = null;
         var fontSizeMenu:Array = null;
         var openConsoleMenu:Array = null;
         var autoCompleteMenu:Array = null;
         switch(target)
         {
            case this.btnClose:
               Console.getInstance().showConsole(false);
               break;
            case this.btnExtend:
               this.extendConsole(true);
               break;
            case this.btnReduce:
               this.extendConsole(false);
               break;
            case this.btnClear:
               this.taConsole.text = "";
               break;
            case this.btnMenu:
               this._menu = [];
               alphaMenu = [];
               fontSizeMenu = [];
               openConsoleMenu = [];
               autoCompleteMenu = [];
               this._menu.push(this.contextMod.createContextMenuItemObject("Opacity",null,null,false,alphaMenu));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("33%",this.onAlphaChange,[33],false,null,this._options.opacity == 33));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("66%",this.onAlphaChange,[66],false,null,this._options.opacity == 66));
               alphaMenu.push(this.contextMod.createContextMenuItemObject("100%",this.onAlphaChange,[100],false,null,this._options.opacity == 100));
               this.onAlphaChange(this._options.opacity);
               this._menu.push(this.contextMod.createContextMenuItemObject("Font size",null,null,false,fontSizeMenu));
               fontSizeMenu.push(this.contextMod.createContextMenuItemObject("14",this.onFontSizeChange,[14],false,null,this._options.fontSize == 14));
               fontSizeMenu.push(this.contextMod.createContextMenuItemObject("16",this.onFontSizeChange,[16],false,null,this._options.fontSize == 16));
               fontSizeMenu.push(this.contextMod.createContextMenuItemObject("20",this.onFontSizeChange,[20],false,null,this._options.fontSize == 20));
               this._menu.push(this.contextMod.createContextMenuItemObject("Open console",null,null,false,openConsoleMenu));
               openConsoleMenu.push(this.contextMod.createContextMenuItemObject("Manual",this.onOpenConsoleChange,[false],false,null,!this._options.openConsole));
               openConsoleMenu.push(this.contextMod.createContextMenuItemObject("When receive message",this.onOpenConsoleChange,[true],false,null,this._options.openConsole));
               this._menu.push(this.contextMod.createContextMenuItemObject("Autocomplete mode",null,null,false,autoCompleteMenu));
               autoCompleteMenu.push(this.contextMod.createContextMenuItemObject("Show list",this.onChangeAutocomplete,[true],false,null,this._autoCompleteWithList));
               autoCompleteMenu.push(this.contextMod.createContextMenuItemObject("Command line",this.onChangeAutocomplete,[false],false,null,!this._autoCompleteWithList));
               this._menu.push(this.contextMod.createContextMenuItemObject("Autocomplete with history",this.onChangeAutocompleteWithHistory,null,false,null,this._autoCompleteWithHistory));
               this._menu.push(this.contextMod.createContextMenuItemObject("Save preset",this.onSavePreset,null,false,null,this._savePreset));
               this.contextMod.createContextMenu(this._menu,null,null,null,!!this.uiApi.me().windowOwner ? this.uiApi.me().windowOwner.uiRootContainer : null);
               break;
            case this.btnBlock:
               this._blockScroll = !this._blockScroll;
               this.btnBlock.selected = this._blockScroll;
               break;
            case this.btnWindow:
               Console.getInstance().loadConsole();
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         this.extendConsole(!this.sysApi.getData("consoleExtended",DataStoreEnum.BIND_ACCOUNT));
      }
      
      private function onFontSizeChange(size:uint) : void
      {
         this.taConsole.setCssSize(size);
         this._options.fontSize = size;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onAlphaChange(alpha:uint) : void
      {
         this.mainContainer.bgAlpha = alpha / 100;
         this._options.opacity = alpha;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onOpenConsoleChange(show:Boolean) : void
      {
         this._options.openConsole = show;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onSavePreset() : void
      {
         this._savePreset = !this._savePreset;
         this._options.savePreset = this._savePreset;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onChangeAutocomplete(pAutoCompleteWithList:Boolean) : void
      {
         this._autoCompleteWithList = pAutoCompleteWithList;
         this._options.autoCompleteWithList = this._autoCompleteWithList;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
         if(this._autoCompleteWithList && this._autoCompletePossibilities)
         {
            this._autoCompletePossibilities.length = 0;
         }
         this._autoCompleteRunning = false;
      }
      
      private function onChangeAutocompleteWithHistory() : void
      {
         this._autoCompleteWithHistory = !this._autoCompleteWithHistory;
         this._options.autoCompleteWithHistory = this._autoCompleteWithHistory;
         this.sysApi.setData("consoleOption",this._options,DataStoreEnum.BIND_ACCOUNT);
      }
      
      private function onCharacterSelectionStart(... args) : void
      {
         this.updateInfo();
      }
      
      private function onConsoleClear() : void
      {
         this.taConsole.text = "";
      }
      
      private function onContextMenuClose() : void
      {
         if(this._lastInput != this.tiCmd.text)
         {
            this._autoCompleteRunning = false;
         }
      }
      
      public function onChange(target:Object) : void
      {
         var isDeleting:* = false;
         if(this._lastInput && this.tiCmd.text)
         {
            isDeleting = this._lastInput.length > this.tiCmd.text.length;
         }
         if(this._autoCompleteRunning && this.tiCmd.haveFocus && this._lastInput != this.tiCmd.text)
         {
            this.autoComplete(false,isDeleting);
         }
         this._lastInput = this.tiCmd.text;
      }
      
      private function onConsoleAddCmd(autoExec:Boolean, cmd:String) : void
      {
         this.addCmd(cmd,autoExec,false);
      }
      
      private function getBoldLength(cmd1:String, cmd2:String) : int
      {
         if(cmd1 == null || cmd2 == null)
         {
            return 0;
         }
         var splittedCmd1:Array = cmd1.split(" ");
         var splittedCmd2:Array = cmd2.split(" ");
         var lastArgSizeCmd1:int = String(splittedCmd1.pop()).length;
         var lastArgSizeCmd2:int = String(splittedCmd2.pop()).length;
         return lastArgSizeCmd1 < lastArgSizeCmd2 ? int(lastArgSizeCmd1) : int(lastArgSizeCmd2);
      }
   }
}

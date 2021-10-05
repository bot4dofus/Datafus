package Ankama_Console
{
   import Ankama_Console.ui.ConsoleUi;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Console extends Sprite
   {
      
      private static var _self:Console;
       
      
      protected var console:ConsoleUi = null;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _consoleState:Boolean;
      
      private var _waitingCmd:Array;
      
      public function Console()
      {
         this._waitingCmd = [];
         super();
      }
      
      public static function getInstance() : Console
      {
         return _self;
      }
      
      public function main() : void
      {
         _self = this;
         this.sysApi.addHook(HookList.ToggleConsole,this.onHookConsoleToggle);
         this.uiApi.addShortcutHook("toggleConsole",this.onConsoleToggle);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHRINK_CHAT,this.onShortcut,int.MAX_VALUE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT,this.onShortcut,int.MAX_VALUE);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT2,this.onShortcut,int.MAX_VALUE);
      }
      
      public function showConsole(show:Boolean) : void
      {
         var consoleUi:UiRootContainer = this.uiApi.getUi("console");
         if(consoleUi)
         {
            this._consoleState = consoleUi.visible = show;
            if(consoleUi.windowOwner)
            {
               consoleUi.windowOwner.visible = show;
            }
            if(show)
            {
               ConsoleUi(consoleUi.uiClass).updateInfo();
               this.uiApi.getUi("console").uiClass.setFocus();
            }
            else
            {
               this.sysApi.removeFocus();
            }
         }
         else
         {
            this.uiApi.loadUi("console","console",[show],StrataEnum.STRATA_TOP);
            this._consoleState = show;
         }
      }
      
      public function loadConsole() : void
      {
         if(!this.uiApi.getUi("console").windowOwner)
         {
            this.uiApi.unloadUi("console");
            this.uiApi.loadUi("console","console",[true],StrataEnum.STRATA_TOP,null,false,true);
         }
         else
         {
            this.uiApi.unloadUi("console");
            this.uiApi.loadUi("console","console",[true],StrataEnum.STRATA_TOP);
         }
      }
      
      public function addCommande(cmd:String, send:Boolean, openConsole:Boolean) : void
      {
         var consoleUi:UiRootContainer = this.uiApi.getUi("console");
         if(consoleUi)
         {
            if(openConsole)
            {
               this.showConsole(true);
            }
            ConsoleUi(consoleUi.uiClass).addCmd(cmd,send,openConsole);
         }
         else
         {
            this._waitingCmd.push({
               "cmd":cmd,
               "send":send,
               "openConsole":openConsole
            });
            this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
            this.showConsole(false);
         }
      }
      
      private function onAuthentificationStart(mustDisplaySteamLogin:Boolean) : void
      {
         this.showConsole(false);
      }
      
      private function onConsoleToggle(shortcut:String) : Boolean
      {
         var hasDevMode:Boolean = this.sysApi.getBuildType() == BuildTypeEnum.BETA && this.sysApi.isDevMode();
         if(!this.sysApi.hasRight() && !hasDevMode || !this.sysApi.hasConsoleRight())
         {
            return false;
         }
         if(shortcut != "toggleConsole")
         {
            return true;
         }
         if(this._consoleState)
         {
            this.showConsole(false);
         }
         else
         {
            this.showConsole(true);
         }
         return false;
      }
      
      private function onHookConsoleToggle() : void
      {
         var hasDevMode:Boolean = this.sysApi.getBuildType() == BuildTypeEnum.BETA && this.sysApi.isDevMode();
         if(!this.sysApi.hasRight() && !hasDevMode || !this.sysApi.hasConsoleRight())
         {
            return;
         }
         if(this._consoleState)
         {
            this.showConsole(false);
         }
         else
         {
            this.showConsole(true);
         }
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         var i:uint = 0;
         var console:ConsoleUi = null;
         if(uiName == "console")
         {
            this.sysApi.removeHook(BeriliaHookList.UiLoaded);
            for(i = 0; i < this._waitingCmd.length; i++)
            {
               this.addCommande(this._waitingCmd[i].cmd,this._waitingCmd[i].send,this._waitingCmd[i].openConsole);
            }
            console = this.uiApi.getUi("console").uiClass;
            this.uiApi.getUi("console").visible = this._consoleState;
            this._waitingCmd = [];
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(!this._consoleState)
         {
            return false;
         }
         switch(s)
         {
            case ShortcutHookListEnum.EXTEND_CHAT:
            case ShortcutHookListEnum.EXTEND_CHAT2:
            case ShortcutHookListEnum.SHRINK_CHAT:
               return true;
            default:
               return false;
         }
      }
   }
}

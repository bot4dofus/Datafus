package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.console.BasicConsoleInstructionRegistar;
   import com.ankamagames.dofus.console.DebugConsoleInstructionRegistar;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionType;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.AuthorizedCommandAction;
   import com.ankamagames.dofus.logic.common.actions.QuitGameAction;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkAdminManager;
   import com.ankamagames.dofus.misc.lists.GameDataList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.messages.authorized.AdminCommandMessage;
   import com.ankamagames.dofus.network.messages.authorized.ConsoleMessage;
   import com.ankamagames.dofus.network.messages.security.CheckIntegrityMessage;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleOutputMessage;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.console.UnhandledConsoleInstructionError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class AuthorizedFrame extends RegisteringFrame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AuthorizedFrame));
      
      private static const REG_AT_CLIENT:RegExp = /@client\((\w*)\.(\d*)\.(\w*)\)/gm;
      
      private static var _validClass:Dictionary;
       
      
      private var _hasRights:Boolean;
      
      private var _include_CheckIntegrityMessage:CheckIntegrityMessage = null;
      
      public function AuthorizedFrame()
      {
         super();
      }
      
      private static function getValidClass() : Dictionary
      {
         var constant:Class = null;
         var name:String = null;
         if(_validClass)
         {
            return _validClass;
         }
         _validClass = new Dictionary();
         for each(constant in GameDataList.CLASSES)
         {
            name = getQualifiedClassName(constant);
            _validClass[name.substring(name.lastIndexOf("::") + 2).toLowerCase()] = name;
         }
         return _validClass;
      }
      
      private static function onQuitGameAction(qga:QuitGameAction) : Boolean
      {
         Dofus.getInstance().quit();
         return true;
      }
      
      override public function get priority() : int
      {
         return Priority.LOW;
      }
      
      override public function pushed() : Boolean
      {
         this.hasRights = false;
         return true;
      }
      
      override public function pulled() : Boolean
      {
         return true;
      }
      
      public function set hasRights(b:Boolean) : void
      {
         this._hasRights = b;
         if(b)
         {
            HyperlinkFactory.registerProtocol("admin",HyperlinkAdminManager.addCmd);
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new DebugConsoleInstructionRegistar());
         }
         else
         {
            ConsolesManager.registerConsole("debug",new ConsoleHandler(Kernel.getWorker()),new BasicConsoleInstructionRegistar());
         }
      }
      
      override protected function registerMessages() : void
      {
         register(ConsoleMessage,this.onConsoleMessage);
         register(AuthorizedCommandAction,this.onAuthorizedCommandAction);
         register(ConsoleOutputMessage,this.onConsoleOutputMessage);
         register(QuitGameAction,onQuitGameAction);
      }
      
      private function onConsoleMessage(cmsg:ConsoleMessage) : Boolean
      {
         ConsolesManager.getConsole("debug").output(cmsg.content,cmsg.type);
         return true;
      }
      
      private function onAuthorizedCommandAction(aca:AuthorizedCommandAction) : Boolean
      {
         var command:String = null;
         var acmsg:AdminCommandMessage = null;
         var commands:Array = aca.command.split(" ; ");
         for each(command in commands)
         {
            if(command.substr(0,1) == "/")
            {
               try
               {
                  ConsolesManager.getConsole("debug").process(ConsolesManager.getMessage(command));
               }
               catch(ucie:UnhandledConsoleInstructionError)
               {
                  ConsolesManager.getConsole("debug").output("Unknown command: " + ConsolesManager.getMessage(command) + "\n");
               }
            }
            else if(ConnectionsHandler.connectionType != ConnectionType.DISCONNECTED)
            {
               if(this._hasRights)
               {
                  if(command.length >= 1 && command.length <= ProtocolConstantsEnum.MAX_CMD_LEN)
                  {
                     acmsg = new AdminCommandMessage();
                     acmsg.initAdminCommandMessage(command);
                     ConnectionsHandler.getConnection().send(acmsg);
                  }
                  else
                  {
                     ConsolesManager.getConsole("debug").output("Too long command is too long, try again.");
                  }
               }
               else
               {
                  ConsolesManager.getConsole("debug").output("You have no admin rights, please use only client side commands. (/help)");
               }
            }
            else
            {
               ConsolesManager.getConsole("debug").output("You are disconnected, use only client side commands.");
            }
         }
         return true;
      }
      
      private function onConsoleOutputMessage(comsg:ConsoleOutputMessage) : Boolean
      {
         var match:Array = null;
         var m:String = null;
         var transformText:* = null;
         var params:Array = null;
         var className:String = null;
         var dataClass:Object = null;
         var data:Object = null;
         if(comsg.consoleId != "debug")
         {
            return false;
         }
         var t:String = comsg.text;
         var change:* = true;
         var changeCount:uint = 0;
         while(change && changeCount++ < 100)
         {
            match = t.match(REG_AT_CLIENT);
            change = match.length != 0;
            for each(m in match)
            {
               transformText = null;
               params = m.substring(8,m.length - 1).split(".");
               className = getValidClass()[params[0].toLowerCase()];
               if(className != null)
               {
                  dataClass = getDefinitionByName(className);
                  if(dataClass.hasOwnProperty("idAccessors") && dataClass.idAccessors.instanceById != null)
                  {
                     data = dataClass.idAccessors.instanceById(parseInt(params[1]));
                     if(data != null)
                     {
                        if(data.hasOwnProperty(params[2]))
                        {
                           transformText = data[params[2]];
                        }
                        else
                        {
                           transformText = m.substr(0,m.length - 1) + ".bad field)";
                        }
                     }
                     else
                     {
                        transformText = m.substr(0,m.length - 1) + ".bad ID)";
                     }
                  }
                  else
                  {
                     transformText = m.substr(0,m.length - 1) + ".not compatible class)";
                  }
               }
               else
               {
                  transformText = m.substr(0,m.length - 1) + ".bad class)";
               }
               t = t.split(m).join(transformText);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ConsoleOutput,t,comsg.type);
         return true;
      }
   }
}

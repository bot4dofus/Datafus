package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.network.ServerConnection;
   
   public class ConnectionInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function ConnectionInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "connectionstatus":
               console.output("" + (!!ConnectionsHandler.getConnection() ? ConnectionsHandler.getConnection() : "There is currently no connection."));
               break;
            case "inspecttraffic":
               ServerConnection.DEBUG_VERBOSE = !ServerConnection.DEBUG_VERBOSE;
               console.output("Inspect traffic is " + (!!ServerConnection.DEBUG_VERBOSE ? "ON" : "OFF"));
               break;
            case "inspectlowtraffic":
               ServerConnection.DEBUG_LOW_LEVEL_VERBOSE = !ServerConnection.DEBUG_LOW_LEVEL_VERBOSE;
               console.output("Inspect low traffic is " + (!!ServerConnection.DEBUG_LOW_LEVEL_VERBOSE ? "ON" : "OFF"));
               break;
            case "setinactivitytimeout":
               if(args.length == 1)
               {
                  InactivityManager.getInstance().inactivityDelay = int(args[0]) * 1000;
                  console.output("Set the inactivity timeout to " + args[0] + " seconds");
                  break;
               }
               if(args.length < 1)
               {
                  InactivityManager.getInstance().inactivityDelay = DataEnum.INACTIVITY_DEFAULT_DELAY;
                  console.output("Inactivity timeout set to default value of " + TimeManager.getInstance().getDuration(InactivityManager.getInstance().inactivityDelay));
                  break;
               }
               console.output("Too many arguments",ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
               console.showMan(console,this,cmd);
               break;
         }
      }
      
      public function getArgs(cmd:String) : Array
      {
         var argList:Array = [];
         switch(cmd)
         {
            case "setinactivitytimeout":
               argList.push("[time] : Value, in seconds, of the inactivity disconnection delay. (optional)");
         }
         return argList;
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "connectionstatus":
               return "Print the status of the current connection (if any).";
            case "inspecttraffic":
               return "Show detailled informations about network activities.";
            case "inspectlowtraffic":
               return "Show detailled informations about network message parsing.";
            case "setinactivitytimeout":
               return "Set the time it takes to be disconnected for inactivity (in seconds)";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getMan(cmd:String) : String
      {
         switch(cmd)
         {
            case "setinactivitytimeout":
               return "Set the time it takes to be disconnected for inactivity (in seconds)";
            default:
               return I18n.getUiText("ui.chat.console.noMan",[cmd]);
         }
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

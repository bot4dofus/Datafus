package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.utils.getQualifiedClassName;
   
   public class ActionsInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ActionsInstructionHandler));
       
      
      public function ActionsInstructionHandler()
      {
         super();
      }
      
      private static function getParams(data:Array) : Array
      {
         var params:Array = [];
         for(var i:uint = 0; i < data.length; i++)
         {
            params[i] = getParam(data[i]);
         }
         return params;
      }
      
      private static function getParam(value:String) : *
      {
         var intParam:Number = parseInt(value);
         if(!isNaN(intParam))
         {
            return intParam;
         }
         if(value == "true" || value == "false")
         {
            return value == "true";
         }
         return value;
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var actionName:String = null;
         var apiAction:DofusApiAction = null;
         var params:Array = null;
         var accessors:Array = null;
         var longestAccessor:uint = 0;
         var hookName:String = null;
         var hparams:Array = null;
         var lookFor:String = null;
         var actionsList:Array = null;
         var foundCount:uint = 0;
         var action:Action = null;
         var acc:String = null;
         var prop:String = null;
         var padding:String = null;
         var i:uint = 0;
         var a:String = null;
         switch(cmd)
         {
            case "sendaction":
               if(args.length == 0)
               {
                  console.output("You must specify an action to send.");
                  return;
               }
               actionName = args[0];
               apiAction = DofusApiAction.getApiActionByName(actionName);
               if(!apiAction)
               {
                  console.output("The action \'<i>" + actionName + "</i>\' does not exists.");
                  return;
               }
               args.shift();
               params = getParams(args);
               try
               {
                  action = CallWithParameters.callR(apiAction.actionClass["create"],params);
                  if(!action)
                  {
                     throw new Error();
                  }
               }
               catch(e:Error)
               {
                  console.output("Unable to instanciate the action. Maybe some parameters were invalid ?");
                  return;
               }
               accessors = [];
               longestAccessor = 0;
               for each(acc in DescribeTypeCache.getAccessors(apiAction.actionClass))
               {
                  if(acc != "prototype")
                  {
                     if(acc.length > longestAccessor)
                     {
                        longestAccessor = acc.length;
                     }
                     accessors.push(acc);
                  }
               }
               accessors.sort();
               console.output("Sending action <b>" + apiAction.name + "</b>:");
               for each(prop in accessors)
               {
                  padding = "";
                  for(i = prop.length; i < longestAccessor; i++)
                  {
                     padding += " ";
                  }
                  console.output("    <b>" + padding + prop + "</b> : " + action[prop]);
               }
               Kernel.getWorker().process(action);
               break;
            case "sendhook":
               if(args.length == 0)
               {
                  console.output("You must specify an hook to send.");
                  return;
               }
               hookName = args[0];
               hparams = args.slice(1);
               if(!Hook.checkIfHookExists(hookName))
               {
                  throw new ApiError("Hook [" + hookName + "] does not exist");
               }
               CallWithParameters.call(KernelEventsManager.getInstance().processCallback,new Array(hookName).concat(hparams));
               break;
            case "listactions":
               lookFor = "";
               if(args.length > 0)
               {
                  lookFor = args.join(" ").toLowerCase();
                  console.output("Registered actions matching \'" + lookFor + "\':");
               }
               else
               {
                  console.output("Registered actions:");
               }
               actionsList = DofusApiAction.getApiActionsList();
               foundCount = 0;
               for(a in actionsList)
               {
                  if(!(lookFor.length > 0 && a.toLowerCase().indexOf(lookFor) == -1))
                  {
                     console.output("    <b>" + a + "</b>");
                     foundCount++;
                  }
               }
               if(foundCount == 0)
               {
                  console.output("   No match.");
               }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "sendaction":
               return "Send an actions to the worker.";
            case "sendhook":
               return "Send a hook to the worker.";
            case "listactions":
               return "List all valid actions.";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var actionsList:Array = null;
         var a:* = null;
         var possibilities:Array = [];
         switch(cmd)
         {
            case "sendaction":
               if(paramIndex == 0)
               {
                  actionsList = DofusApiAction.getApiActionsList();
                  for(a in actionsList)
                  {
                     possibilities.push(a);
                  }
               }
         }
         return possibilities;
      }
   }
}

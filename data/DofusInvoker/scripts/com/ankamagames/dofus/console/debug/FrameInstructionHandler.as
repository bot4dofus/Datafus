package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.getQualifiedClassName;
   
   public class FrameInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function FrameInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var fl:Array = null;
         var priority:int = 0;
         var f:Frame = null;
         var className:String = null;
         var split:Array = null;
         switch(cmd)
         {
            case "framelist":
               fl = [];
               for each(f in Kernel.getWorker().framesList)
               {
                  className = getQualifiedClassName(f);
                  split = className.split("::");
                  fl.push([split[split.length - 1],Priority.toString(f.priority)]);
               }
               console.output(StringUtils.formatArray(fl,["Class","Priority"]));
               break;
            case "framepriority":
               if(args.length != 2)
               {
                  console.output("You must specify a frame and a priority to set.");
                  return;
               }
               priority = Priority.fromString(args[1]);
               if(priority == 666)
               {
                  console.output(args[1] + " : invalid priority (available priority are LOG, ULTIMATE_HIGHEST_DEPTH_OF_DOOM, HIGHEST, HIGH, NORMAL, LOW and LOWEST");
                  return;
               }
               for each(f in Kernel.getWorker().framesList)
               {
                  className = getQualifiedClassName(f);
                  split = className.split("::");
                  if(split[split.length - 1] == args[0])
                  {
                     try
                     {
                        f["priority"] = priority;
                     }
                     catch(e:Error)
                     {
                        console.output("Priority set not available for frame " + args[0]);
                     }
                     return;
                  }
               }
               console.output(args[0] + " : frame not found");
               return;
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "framelist":
               return "list all enabled frame";
            case "framepriority":
               return "overwrite a frame priority";
            default:
               return "Unknown command \'" + cmd + "\'.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

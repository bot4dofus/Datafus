package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   
   public class ClearTextureCacheInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function ClearTextureCacheInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         switch(cmd)
         {
            case "cleartexturecache":
               if(args.length > 0)
               {
                  console.output("No arguments needed.");
               }
               console.output("Texture cache cleared.");
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "cleartexturecache":
               return "Empty the textures cache.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

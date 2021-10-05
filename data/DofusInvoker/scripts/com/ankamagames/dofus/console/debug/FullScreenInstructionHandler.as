package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.StageDisplayState;
   import flash.geom.Rectangle;
   
   public class FullScreenInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function FullScreenInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var resX:uint = 0;
         var resY:uint = 0;
         switch(cmd)
         {
            case "fullscreen":
               if(args.length == 0)
               {
                  if(StageShareManager.stage.displayState == StageDisplayState["FULL_SCREEN_INTERACTIVE"])
                  {
                     StageShareManager.stage.displayState = StageDisplayState["NORMAL"];
                  }
                  else
                  {
                     console.output("Resolution needed.");
                  }
               }
               else if(args.length == 2)
               {
                  resX = uint(args[0]);
                  resY = uint(args[1]);
                  StageShareManager.stage.fullScreenSourceRect = new Rectangle(0,0,resX,resY);
                  StageShareManager.stage.displayState = StageDisplayState["FULL_SCREEN_INTERACTIVE"];
               }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "fullscreen":
               return "Toggle the full-screen display mode.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

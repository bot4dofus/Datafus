package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObjectContainer;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class ClearSceneInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function ClearSceneInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var scene:DisplayObjectContainer = null;
         var count:uint = 0;
         var totalCount:uint = 0;
         var charCount:uint = 0;
         var othersCount:uint = 0;
         var entities:Array = null;
         var entitiesFrame:RoleplayEntitiesFrame = null;
         var o:* = undefined;
         var entity:* = undefined;
         switch(cmd)
         {
            case "clearscene":
               if(args.length > 0)
               {
                  console.output("No arguments needed.");
               }
               scene = Dofus.getInstance().getWorldContainer();
               while(scene.numChildren > 0)
               {
                  scene.removeChildAt(0);
               }
               console.output("Scene cleared.");
               break;
            case "clearentities":
               count = 0;
               for each(o in EntitiesManager.getInstance().entities)
               {
                  count++;
               }
               console.output("EntitiesManager : " + count + " entities");
               Atouin.getInstance().clearEntities();
               Atouin.getInstance().display(PlayedCharacterManager.getInstance().currentMap);
               System.gc();
               setTimeout(this.asynchInfo,2000,console);
               break;
            case "countentities":
               totalCount = 0;
               charCount = 0;
               othersCount = 0;
               entities = EntitiesManager.getInstance().entities;
               for each(entity in entities)
               {
                  totalCount++;
                  if(entity is TiphonSprite)
                  {
                     if(entity.id >= 0)
                     {
                        charCount++;
                     }
                     else
                     {
                        othersCount++;
                     }
                  }
               }
               console.output(totalCount + " entities : " + charCount + " characters, " + othersCount + " monsters & npc.");
               entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(entitiesFrame)
               {
                  console.output("Switch to creature mode : " + entitiesFrame.entitiesNumber + " of " + entitiesFrame.creaturesLimit + " -> " + entitiesFrame.creaturesMode);
               }
         }
      }
      
      private function asynchInfo(console:ConsoleHandler) : void
      {
         var sprite:* = undefined;
         var ts:Dictionary = TiphonSprite.MEMORY_LOG;
         for(sprite in ts)
         {
            console.output(sprite + " : " + TiphonSprite(sprite).look);
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "clearscene":
               return "Clear the World Scene.";
            case "clearentities":
               return "Clear all entities from the scene.";
            case "countentities":
               return "Count all entities from the scene.";
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

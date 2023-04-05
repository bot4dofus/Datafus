package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.Chrono;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.getQualifiedClassName;
   
   public class AlterationInstructionHandler implements ConsoleInstructionHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlterationInstructionHandler));
       
      
      public function AlterationInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var matchAlterations:Array = null;
         var searchWord:String = null;
         var ids:Vector.<uint> = null;
         var alterations:Vector.<Object> = null;
         var currentAlteration:Alteration = null;
         switch(cmd)
         {
            case "searchalteration":
               if(args.length < 1)
               {
                  console.output(cmd + " need an argument to search for");
                  break;
               }
               Chrono.start("General");
               matchAlterations = new Array();
               searchWord = StringUtils.noAccent(args.join(" ").toLowerCase());
               Chrono.start("Query");
               ids = GameDataQuery.queryString(Alteration,"name",searchWord);
               Chrono.stop();
               Chrono.start("Instance");
               alterations = GameDataQuery.returnInstance(Alteration,ids);
               Chrono.stop();
               Chrono.start("Add");
               for each(currentAlteration in alterations)
               {
                  matchAlterations.push("\t" + currentAlteration.name + " ( id : " + currentAlteration.id + " )");
               }
               Chrono.stop();
               Chrono.stop();
               _log.debug("on " + alterations.length + " iterations");
               matchAlterations.sort(Array.CASEINSENSITIVE);
               console.output(matchAlterations.join("\n"));
               console.output("\tRESULT : " + matchAlterations.length + " alterations found");
               break;
         }
      }
      
      public function getArgs(cmd:String) : Array
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return [];
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "searchalteration":
               return "Search alteration name/id, param : [part of searched alteration name]";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getMan(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noMan",[cmd]);
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

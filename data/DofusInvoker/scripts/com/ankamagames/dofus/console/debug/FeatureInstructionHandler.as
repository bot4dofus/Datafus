package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.datacenter.feature.OptionalFeature;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class FeatureInstructionHandler implements ConsoleInstructionHandler
   {
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(FeatureInstructionHandler));
      
      public static const BASE_COMMAND:String = "featuremanager";
       
      
      private const ENABLE_COMMAND:String = "enable";
      
      private const DISABLE_COMMAND:String = "disable";
      
      private const CHECK_COMMAND:String = "check";
      
      private const LIST_COMMAND:String = "list";
      
      private const LIST_ENABLED_COMMAND:String = "enabled";
      
      private const LIST_DISABLED_COMMAND:String = "disabled";
      
      private const SEARCH_COMMAND:String = "search";
      
      private const HELP_COMMAND:String = "help";
      
      private const FEATURE_MANAGER_ERROR:String = "The feature manager is not available";
      
      private const UNKNOWN_ERROR:String = "Something went wrong. Please check logs if necessary";
      
      private const ARGUMENT_ERROR:String = "Wrong number of arguments";
      
      private const COMMAND_ABORTED_ERROR:String = "Aborting";
      
      private const NULL_FEATURE_ERROR:String = "At least one feature was null. Something <b>seriously wrong</b> has happened. Please check logs";
      
      public function FeatureInstructionHandler()
      {
         super();
      }
      
      public function handle(consoleHandler:ConsoleHandler, baseCommand:String, args:Array) : void
      {
         if(baseCommand !== BASE_COMMAND)
         {
            this.displayError(consoleHandler,"Wrong command provided: \'" + baseCommand + "\'.");
            return;
         }
         var command:String = null;
         if(args.length > 0)
         {
            command = args[0];
         }
         if(args.length <= 0 || command === this.HELP_COMMAND)
         {
            consoleHandler.output(this.getFullHelp(),ConsoleMessageTypeEnum.CONSOLE_TEXT_MESSAGE);
            return;
         }
         var isCommandSuccessful:Boolean = false;
         switch(command)
         {
            case this.LIST_COMMAND:
               isCommandSuccessful = this.handleListCommand(consoleHandler,args);
               break;
            case this.ENABLE_COMMAND:
            case this.DISABLE_COMMAND:
            case this.CHECK_COMMAND:
               isCommandSuccessful = this.handleActivationCommand(consoleHandler,command,args);
               break;
            case this.SEARCH_COMMAND:
               isCommandSuccessful = this.handleSearchCommand(consoleHandler,args);
               break;
            default:
               this.displayError(consoleHandler,"Unknown command: \'" + command + "\'.",true);
         }
         if(!isCommandSuccessful)
         {
            this.displayError(consoleHandler,this.COMMAND_ABORTED_ERROR);
         }
      }
      
      public function getHelp(baseCommand:String) : String
      {
         if(baseCommand === BASE_COMMAND)
         {
            return "<b>Manage features</b> via the <b>feature manager</b>. Please enter \'<b>/" + BASE_COMMAND + "</b>\' or \'<b>/" + BASE_COMMAND + " " + this.HELP_COMMAND + "</b>\' to get the full help.";
         }
         return "Unknown command for the feature instruction handler: \'" + baseCommand + "\'.";
      }
      
      public function getParamPossibilities(baseCommand:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var possibilities:Array = [];
         if(baseCommand === BASE_COMMAND)
         {
            if(paramIndex == 0)
            {
               possibilities.push(this.ENABLE_COMMAND);
               possibilities.push(this.DISABLE_COMMAND);
               possibilities.push(this.CHECK_COMMAND);
               possibilities.push(this.LIST_COMMAND);
               possibilities.push(this.SEARCH_COMMAND);
               possibilities.push(this.HELP_COMMAND);
            }
         }
         return possibilities;
      }
      
      private function getFullHelp() : String
      {
         return "<b>Manage features</b> via the <b>feature manager</b>.\n\n" + "<b>Display help:</b>\n" + "\t/" + BASE_COMMAND + "\n" + "\t/" + BASE_COMMAND + " <b>" + this.HELP_COMMAND + "</b>\n\n" + "<b>List features:</b>\n" + "\t/" + BASE_COMMAND + " <b>" + this.LIST_COMMAND + "</b> [<b>LIST COMMAND</b>]\n\n" + "\t- <b>LIST COMMAND</b> is either \'<b>" + this.LIST_ENABLED_COMMAND + "</b>\' or \'<b>" + this.LIST_DISABLED_COMMAND + "</b>\', depending on what you want to do.\n\n" + "<b>Search a feature by keyword:</b>\n" + "\t/" + BASE_COMMAND + " <b>" + this.SEARCH_COMMAND + "</b> [<b>SEARCH QUERY</b>]\n\n" + "\t- <b>SEARCH QUERY</b> should be a string <b>without spaces</b> (a feature keyword does not contain any).\n\n" + "<b>Enable/disable/check a feature (by its <b>keyword</b> or by its <b>ID</b>):</b>\n " + "\t/" + BASE_COMMAND + " [<b>COMMAND</b>] [<b>FEATURE</b>]\n\n" + "\t- <b>COMMAND</b> is either \'<b>" + this.ENABLE_COMMAND + "</b>\', \'<b>" + this.DISABLE_COMMAND + "</b>\' or \'<b>" + this.CHECK_COMMAND + "</b>\', depending on what you want to do.\n" + "\t- <b>FEATURE</b> is either a feature <b>keyword</b> or a feature <b>ID</b>.\n\n" + "\te.g.\t/" + BASE_COMMAND + " <b>" + this.ENABLE_COMMAND + "</b> <b>pvp.kis</b>\n\t\t\t/featuremanager <b>" + this.ENABLE_COMMAND + "</b> <b>12</b>\n\t\t\t/featuremanager <b>" + this.DISABLE_COMMAND + "</b> <b>pvp.kis</b>\n\t\t\t/featuremanager <b>" + this.DISABLE_COMMAND + "</b> <b>12</b>\n\t\t\t/featuremanager <b>" + this.CHECK_COMMAND + "</b> <b>pvp.kis</b>\n\t\t\t/featuremanager <b>" + this.CHECK_COMMAND + "</b> <b>12</b>";
      }
      
      private function displayError(consoleHandler:ConsoleHandler, errorMessage:String, isHelp:Boolean = false) : void
      {
         var result:String = errorMessage;
         if(isHelp)
         {
            result += "\n\n" + this.getFullHelp();
         }
         consoleHandler.output(result,ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
      }
      
      private function handleSearchCommand(consoleHandler:ConsoleHandler, args:Array) : Boolean
      {
         var sortedMatchedFeatureLabels:Vector.<String> = null;
         var feature:OptionalFeature = null;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager === null)
         {
            this.displayError(consoleHandler,this.FEATURE_MANAGER_ERROR);
            return false;
         }
         if(args.length !== 2)
         {
            this.displayError(consoleHandler,this.ARGUMENT_ERROR,true);
            return false;
         }
         var searchQuery:String = args[1];
         var matchedFeatureIds:Vector.<uint> = GameDataQuery.queryString(OptionalFeature,"keyword",searchQuery);
         var matchedFeatures:Vector.<Object> = GameDataQuery.returnInstance(OptionalFeature,matchedFeatureIds);
         if(matchedFeatures === null)
         {
            this.displayError(consoleHandler,"Matched feature list is null. Why?");
            return false;
         }
         var commandResult:* = "<b>" + matchedFeatures.length.toString() + " result(s):</b>\n\t";
         var areNullFeatures:Boolean = false;
         if(matchedFeatures.length <= 0)
         {
            commandResult += "\n\t<b>No results.</b>";
         }
         else
         {
            sortedMatchedFeatureLabels = new Vector.<String>();
            for each(feature in matchedFeatures)
            {
               if(feature === null)
               {
                  areNullFeatures = true;
               }
               else
               {
                  sortedMatchedFeatureLabels.push(feature.toString());
               }
            }
            sortedMatchedFeatureLabels.sort(Array.CASEINSENSITIVE);
            commandResult += sortedMatchedFeatureLabels.join("\n\t");
         }
         consoleHandler.output(commandResult);
         if(areNullFeatures)
         {
            this.displayError(consoleHandler,this.NULL_FEATURE_ERROR);
         }
         return true;
      }
      
      private function handleActivationCommand(consoleHandler:ConsoleHandler, command:String, args:Array) : Boolean
      {
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager === null)
         {
            this.displayError(consoleHandler,this.FEATURE_MANAGER_ERROR);
            return false;
         }
         if(args.length !== 2)
         {
            this.displayError(consoleHandler,this.ARGUMENT_ERROR,true);
            return false;
         }
         var featureArg:String = args[1];
         var featureId:Number = Number(featureArg);
         var feature:OptionalFeature = null;
         var isCommandSuccessful:Boolean = false;
         if(isNaN(featureId))
         {
            feature = OptionalFeature.getOptionalFeatureByKeyword(featureArg);
         }
         else
         {
            feature = OptionalFeature.getOptionalFeatureById(featureId);
         }
         if(feature === null)
         {
            this.displayError(consoleHandler,"Feature does not seem to exist with the parameter given: <b>" + featureArg + "</b>. " + "Please enter \'/" + BASE_COMMAND + " <b>" + this.HELP_COMMAND + "</b>\' to know how to use this command.");
            return false;
         }
         switch(command)
         {
            case this.ENABLE_COMMAND:
               if(featureManager.isFeatureEnabled(feature))
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> is already enabled.",ConsoleMessageTypeEnum.CONSOLE_TEXT_MESSAGE);
                  return false;
               }
               isCommandSuccessful = featureManager.enableFeature(feature,true);
               if(isCommandSuccessful)
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> was successfully enabled",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
                  return true;
               }
               break;
            case this.DISABLE_COMMAND:
               if(!featureManager.isFeatureEnabled(feature))
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> is already disabled.",ConsoleMessageTypeEnum.CONSOLE_TEXT_MESSAGE);
                  return false;
               }
               isCommandSuccessful = featureManager.disableFeature(feature);
               if(isCommandSuccessful)
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> was successfully disabled",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
                  return true;
               }
               break;
            case this.CHECK_COMMAND:
               if(featureManager.isFeatureEnabled(feature))
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> is enabled.",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
               }
               else
               {
                  consoleHandler.output("<b>" + feature.toString() + "</b> is disabled.",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
               }
               return true;
            default:
               this.displayError(consoleHandler,"Command should be \'" + this.ENABLE_COMMAND + "\', \'" + this.DISABLE_COMMAND + "\' or \'" + this.CHECK_COMMAND + "\'",true);
               return false;
         }
         this.displayError(consoleHandler,this.UNKNOWN_ERROR);
         return false;
      }
      
      private function handleListCommand(consoleHandler:ConsoleHandler, args:Array) : Boolean
      {
         var sortedFeatureLabels:Vector.<String> = null;
         var enabledFeature:OptionalFeature = null;
         var featureManager:FeatureManager = FeatureManager.getInstance();
         if(featureManager === null)
         {
            this.displayError(consoleHandler,this.FEATURE_MANAGER_ERROR);
            return false;
         }
         if(args.length !== 2)
         {
            this.displayError(consoleHandler,this.ARGUMENT_ERROR,true);
            return false;
         }
         var listCommand:String = args[1];
         var features:Vector.<OptionalFeature> = null;
         var result:* = null;
         if(listCommand === this.LIST_ENABLED_COMMAND)
         {
            features = featureManager.getEnabledFeatures();
            if(features === null)
            {
               this.displayError(consoleHandler,"Enabled feature list returned by the manager is null. Why?");
               return false;
            }
            result = "<b>" + features.length.toString() + " feature(s) enabled:</b>\n\t";
         }
         else
         {
            if(listCommand !== this.LIST_DISABLED_COMMAND)
            {
               this.displayError(consoleHandler,"Second parameter can either be \'" + this.LIST_ENABLED_COMMAND + "\' or \'" + this.LIST_DISABLED_COMMAND + "\'",true);
               return false;
            }
            features = featureManager.getDisabledFeatures();
            if(features === null)
            {
               this.displayError(consoleHandler,"Disabled feature list returned by the manager is null. Why?");
               return false;
            }
            result = "<b>" + features.length.toString() + " feature(s) disabled:</b>\n\t";
         }
         var areNullFeatures:Boolean = false;
         if(features.length <= 0)
         {
            result += "\n\tNo feature to display.";
         }
         else
         {
            sortedFeatureLabels = new Vector.<String>();
            for each(enabledFeature in features)
            {
               if(enabledFeature === null)
               {
                  areNullFeatures = true;
               }
               else
               {
                  sortedFeatureLabels.push(enabledFeature.toString());
               }
            }
            sortedFeatureLabels.sort(Array.CASEINSENSITIVE);
            result += sortedFeatureLabels.join("\n\t");
         }
         consoleHandler.output(result,ConsoleMessageTypeEnum.CONSOLE_TEXT_MESSAGE);
         if(areNullFeatures)
         {
            this.displayError(consoleHandler,this.NULL_FEATURE_ERROR);
         }
         return true;
      }
   }
}

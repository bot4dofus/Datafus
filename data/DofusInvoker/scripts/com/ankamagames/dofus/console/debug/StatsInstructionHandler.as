package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristic;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicDetailed;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicValue;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class StatsInstructionHandler implements ConsoleInstructionHandler
   {
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsInstructionHandler));
      
      public static const BASE_COMMAND:String = "statsmanager";
      
      private static const DUMP_COMMAND:String = "dump";
      
      private static const VERBOSE_COMMAND:String = "verbose";
      
      private static const HELP_COMMAND:String = "help";
      
      private static const STATS_MANAGER_ERROR:String = "The stats manager is not available";
      
      private static const UNKNOWN_ERROR:String = "Something went wrong. Please check logs if necessary";
      
      private static const ARGUMENT_ERROR:String = "Wrong number of arguments";
      
      private static const COMMAND_ABORTED_ERROR:String = "Aborting";
      
      private static const DUMP_STATS_ARGUMENT:String = "stats";
      
      private static const DUMP_STAT_ARGUMENT:String = "stat";
      
      private static const DIFF_ADD_COLOR:String = "#00ff00";
      
      private static const DIFF_NEUTRAL_COLOR:String = "#c0c0c0";
      
      private static const DIFF_REMOVE_COLOR:String = "#ff0000";
      
      private static const DIFF_WARNING_COLOR:String = "#ff8000";
      
      private static const DIFF_SERVER_STAT:String = "Server stat";
      
      private static const DIFF_SERVER_DETAILED_STAT:String = "Server detailed stat";
      
      private static const DIFF_STAT:String = "Stat";
      
      private static const DIFF_DETAILED_STAT:String = "Detailed stat";
      
      private static const DIFF_ADD:uint = 0;
      
      private static const DIFF_UPDATE:uint = 1;
      
      private static const DIFF_REMOVE:uint = 2;
      
      private static const DIFF_UNKNOWN:uint = 3;
       
      
      public function StatsInstructionHandler()
      {
         super();
      }
      
      public static function applyStatsDiff(consoleHandler:ConsoleHandler, entityId:Number, serverStats:Vector.<CharacterCharacteristic>) : void
      {
         var serverStat:CharacterCharacteristic = null;
         var stats:Dictionary = null;
         var statKey:* = null;
         var statsManager:StatsManager = StatsManager.getInstance();
         if(statsManager === null)
         {
            displayError(consoleHandler,STATS_MANAGER_ERROR);
            return;
         }
         var entityStats:EntityStats = statsManager.getStats(entityId);
         if((entityStats === null || entityStats !== null && entityStats.getStatsNumber() <= 0) && serverStats.length === 0)
         {
            consoleHandler.output("\t<b>Stats are identical (no stats were given for this entity).</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return;
         }
         var diffStats:Dictionary = new Dictionary();
         if(entityStats !== null)
         {
            stats = entityStats.stats;
            statKey = null;
            for(statKey in stats)
            {
               diffStats[statKey] = stats[statKey];
            }
         }
         var statId:Number = Number.NaN;
         var stat:Stat = null;
         var currentResult:String = null;
         var resultHeader:* = "Stats diff for entity with ID " + entityId.toString() + " (Client -> Server):\n";
         var result:String = "";
         var diffStatFormattedLines:Dictionary = new Dictionary();
         var diffStatIds:Vector.<Number> = new Vector.<Number>();
         for each(serverStat in serverStats)
         {
            statId = serverStat.characteristicId;
            statKey = statId.toString();
            if(statKey in diffStats)
            {
               stat = diffStats[statKey];
               delete diffStats[statKey];
            }
            else
            {
               stat = null;
            }
            currentResult = getFormattedStatDiffLine(stat,serverStat);
            if(currentResult !== null)
            {
               diffStatFormattedLines[serverStat.characteristicId.toString()] = currentResult;
               diffStatIds.push(serverStat.characteristicId);
            }
         }
         for each(stat in diffStats)
         {
            currentResult = getFormattedStatDiffLine(stat,null);
            if(currentResult !== null)
            {
               diffStatFormattedLines[stat.id.toString()] = currentResult;
               diffStatIds.push(stat.id);
            }
         }
         if(diffStatIds.length <= 0)
         {
            result = "\t<b>Stats are identical.<b>";
         }
         else
         {
            diffStatIds.sort(sortStatIds);
            for each(statId in diffStatIds)
            {
               result += diffStatFormattedLines[statId.toString()] + "\n";
            }
         }
         consoleHandler.output(resultHeader + result);
      }
      
      private static function getFullHelp() : String
      {
         return "<b>Manage stats</b> via the <b>stats manager</b>.\n\n" + "<b>Display help:</b>\n" + "\t/" + BASE_COMMAND + "\n" + "\t/" + BASE_COMMAND + "<b> " + HELP_COMMAND + "</b>\n\n" + "<b>Dump entity stats (or a specific one):</b>\n" + "\t/" + BASE_COMMAND + " <b>" + DUMP_COMMAND + "</b>" + " <b>" + DUMP_STATS_ARGUMENT + "</b> [<b>ENTITY ID</b>]\n\n" + "\t/" + BASE_COMMAND + " <b>" + DUMP_COMMAND + "</b>" + " <b>" + DUMP_STAT_ARGUMENT + "</b> [<b>ENTITY ID</b>] [<b>STAT ID</b>]\n\n" + "<b>Enable verbose mode:</b>\n" + "\t/" + BASE_COMMAND + " <b>" + VERBOSE_COMMAND + "</b> [<b>VALUE</b>]\n\n" + "\t- <b>VALUE</b> is either \'<b>true</b> or <b>false</b>, depending on what you want to do.\n\n";
      }
      
      private static function displayError(consoleHandler:ConsoleHandler, errorMessage:String, isHelp:Boolean = false) : void
      {
         var result:String = errorMessage;
         if(isHelp)
         {
            result += "\n\n" + getFullHelp();
         }
         consoleHandler.output(result,ConsoleMessageTypeEnum.CONSOLE_ERR_MESSAGE);
      }
      
      private static function handleDumpCommand(consoleHandler:ConsoleHandler, args:Array) : Boolean
      {
         var statId:Number = NaN;
         var stat:Stat = null;
         if(args.length < 3 || args.length > 4)
         {
            displayError(consoleHandler,ARGUMENT_ERROR,true);
            return false;
         }
         var dumpCommand:String = args[1];
         if(!dumpCommand)
         {
            displayError(consoleHandler,ARGUMENT_ERROR,true);
            return false;
         }
         dumpCommand = dumpCommand.toLowerCase();
         if(dumpCommand !== DUMP_STATS_ARGUMENT && dumpCommand !== DUMP_STAT_ARGUMENT)
         {
            displayError(consoleHandler,"The parameter should be either: \"" + DUMP_STATS_ARGUMENT + "\" or \"" + DUMP_STAT_ARGUMENT + "\".",true);
            return false;
         }
         var entityId:Number = Number(args[2]);
         if(isNaN(entityId))
         {
            displayError(consoleHandler,"The entity ID provided could not be parsed: \"" + args[2] + "\"",true);
            return false;
         }
         var statsManager:StatsManager = StatsManager.getInstance();
         if(statsManager === null)
         {
            displayError(consoleHandler,STATS_MANAGER_ERROR);
            return false;
         }
         var entityStats:EntityStats = statsManager.getStats(entityId);
         if(entityStats === null)
         {
            consoleHandler.output("<b>No stats were given to the entity.</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return true;
         }
         if(dumpCommand === DUMP_STATS_ARGUMENT)
         {
            if(args.length !== 3)
            {
               displayError(consoleHandler,"Only an entity ID should be given with the \"" + DUMP_STATS_ARGUMENT + "\" parameter",true);
               return false;
            }
            consoleHandler.output(entityStats.toString(),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
         }
         else
         {
            if(dumpCommand !== DUMP_STAT_ARGUMENT)
            {
               displayError(consoleHandler,"You must specify either \"" + DUMP_STATS_ARGUMENT + "\" or \"" + DUMP_STAT_ARGUMENT + "\"",true);
               return false;
            }
            if(args.length !== 4)
            {
               displayError(consoleHandler,"An entity ID and a stat ID should be given with the \"" + DUMP_STAT_ARGUMENT + "\" parameter",true);
               return false;
            }
            statId = Number(args[3]);
            if(isNaN(statId))
            {
               displayError(consoleHandler,"The stat ID provided could not be parsed: \"" + args[3] + "\"",true);
               return false;
            }
            stat = entityStats.getStat(statId);
            if(stat === null)
            {
               consoleHandler.output("<b>No stat was given with this ID.</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            }
            else
            {
               consoleHandler.output(stat.toString(),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            }
         }
         return true;
      }
      
      private static function handleVerboseCommand(consoleHandler:ConsoleHandler, args:Array) : Boolean
      {
         var isVerbose:Boolean = false;
         if(args.length !== 2)
         {
            displayError(consoleHandler,ARGUMENT_ERROR,true);
            return false;
         }
         var verboseCommand:String = args[1];
         if(!verboseCommand)
         {
            displayError(consoleHandler,ARGUMENT_ERROR,true);
            return false;
         }
         verboseCommand = verboseCommand.toLowerCase();
         if(verboseCommand === "true")
         {
            isVerbose = true;
         }
         else
         {
            if(verboseCommand !== "false")
            {
               displayError(consoleHandler,"You must specify either \"true\" or \"false\"",true);
               return false;
            }
            isVerbose = false;
         }
         var statsManager:StatsManager = StatsManager.getInstance();
         if(statsManager === null)
         {
            displayError(consoleHandler,STATS_MANAGER_ERROR);
            return false;
         }
         var verboseAction:String = !!isVerbose ? "enabled" : "disabled";
         if(statsManager.isVerbose === isVerbose)
         {
            displayError(consoleHandler,"Verbose mode is already " + verboseAction + ".");
            return false;
         }
         statsManager.isVerbose = isVerbose;
         consoleHandler.output("<b>Verbose mode has been " + verboseAction + ".</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
         return true;
      }
      
      private static function getFormattedStatDiff(statId:Number, statType:String, diffType:uint, statDiffValues:String) : String
      {
         var diffSymbol:String = null;
         var diffColor:String = null;
         if(diffType === DIFF_ADD)
         {
            diffSymbol = "+";
            diffColor = DIFF_ADD_COLOR;
         }
         else if(diffType === DIFF_UPDATE)
         {
            diffSymbol = "~";
            diffColor = DIFF_NEUTRAL_COLOR;
         }
         else if(diffType === DIFF_REMOVE)
         {
            diffSymbol = "-";
            diffColor = DIFF_REMOVE_COLOR;
         }
         else
         {
            if(diffType !== DIFF_UNKNOWN)
            {
               return null;
            }
            diffSymbol = "~";
            diffColor = DIFF_WARNING_COLOR;
         }
         var characteristic:Characteristic = Characteristic.getCharacteristicById(statId);
         var statName:String = null;
         if(characteristic !== null)
         {
            statName = characteristic.keyword;
         }
         if(statName === null)
         {
            statName = Stat.UNKNOWN_STAT_NAME;
         }
         return "<font color=\"" + diffColor + "\">" + diffSymbol + "\t" + statType + " " + statName + " (" + statId.toString() + "): " + statDiffValues;
      }
      
      private static function getFormattedValueDiff(valueName:String, oldValue:Number, newValue:Number) : String
      {
         if(oldValue === newValue)
         {
            return valueName + ": " + oldValue.toString();
         }
         var oldValueStringified:String = !!isNaN(oldValue) ? "???" : oldValue.toString();
         var newValueStringified:String = !!isNaN(newValue) ? "???" : newValue.toString();
         return valueName + ": <font color=\"" + DIFF_REMOVE_COLOR + "\" >" + oldValueStringified + "</font> -> " + "<font color=\"" + DIFF_ADD_COLOR + "\">" + newValueStringified + "</font>";
      }
      
      private static function getFormattedStatDiffLine(stat:Stat, serverBaseStat:CharacterCharacteristic) : String
      {
         var serverStat:CharacterCharacteristicValue = null;
         var serverDetailedStat:CharacterCharacteristicDetailed = null;
         var detailedStat:DetailedStat = null;
         if(stat === null && serverBaseStat === null)
         {
            return null;
         }
         var statDiffValues:String = "";
         var total:Number = Number.NaN;
         if(stat === null)
         {
            if(serverBaseStat is CharacterCharacteristicValue)
            {
               serverStat = serverBaseStat as CharacterCharacteristicValue;
               return getFormattedStatDiff(serverStat.characteristicId,DIFF_SERVER_STAT,DIFF_ADD,"total: " + serverStat.total);
            }
            if(serverBaseStat is CharacterCharacteristicDetailed)
            {
               serverDetailedStat = serverBaseStat as CharacterCharacteristicDetailed;
               return getFormattedStatDiff(serverDetailedStat.characteristicId,DIFF_SERVER_DETAILED_STAT,DIFF_ADD,"base: " + serverDetailedStat.base.toString() + " additional: " + serverDetailedStat.additional.toString() + " objectsAndMountBonus: " + serverDetailedStat.objectsAndMountBonus.toString() + " alignGiftBonus: " + serverDetailedStat.alignGiftBonus.toString() + " contextModif: " + serverDetailedStat.contextModif.toString() + " total: " + (serverDetailedStat.base + serverDetailedStat.additional + serverDetailedStat.objectsAndMountBonus + serverDetailedStat.alignGiftBonus + serverDetailedStat.contextModif).toString());
            }
            return null;
         }
         if(serverBaseStat === null)
         {
            if(stat is DetailedStat)
            {
               detailedStat = stat as DetailedStat;
               return getFormattedStatDiff(stat.id,DIFF_DETAILED_STAT,DIFF_REMOVE,"base: " + detailedStat.baseValue.toString() + " additional: " + detailedStat.additionalValue.toString() + " objectsAndMountBonus: " + detailedStat.objectsAndMountBonusValue.toString() + " alignGiftBonus: " + detailedStat.alignGiftBonusValue.toString() + " contextModif: " + detailedStat.contextModifValue.toString() + " total: " + detailedStat.totalValue.toString());
            }
            return getFormattedStatDiff(stat.id,DIFF_STAT,DIFF_REMOVE," total: " + stat.totalValue.toString());
         }
         if(stat is DetailedStat && serverBaseStat is CharacterCharacteristicValue)
         {
            detailedStat = stat as DetailedStat;
            serverStat = serverBaseStat as CharacterCharacteristicValue;
            if(stat.totalValue === serverStat.total)
            {
               return null;
            }
            statDiffValues = getFormattedValueDiff("base",detailedStat.baseValue,Number.NaN) + " " + getFormattedValueDiff("additional",detailedStat.additionalValue,Number.NaN) + " " + getFormattedValueDiff("objectsAndMountBonus",detailedStat.objectsAndMountBonusValue,Number.NaN) + " " + getFormattedValueDiff("alignGiftBonus",detailedStat.alignGiftBonusValue,Number.NaN) + " " + getFormattedValueDiff("contextModif",detailedStat.contextModifValue,Number.NaN) + " " + getFormattedValueDiff("total",detailedStat.totalValue,serverStat.total);
            return getFormattedStatDiff(stat.id,DIFF_DETAILED_STAT,DIFF_UNKNOWN,statDiffValues);
         }
         if(stat is DetailedStat && serverBaseStat is CharacterCharacteristicDetailed)
         {
            detailedStat = stat as DetailedStat;
            serverDetailedStat = serverBaseStat as CharacterCharacteristicDetailed;
            total = serverDetailedStat.base + serverDetailedStat.additional + serverDetailedStat.objectsAndMountBonus + serverDetailedStat.alignGiftBonus + serverDetailedStat.contextModif;
            if(detailedStat.totalValue === total && detailedStat.baseValue === serverDetailedStat.base && detailedStat.additionalValue === serverDetailedStat.additional && detailedStat.objectsAndMountBonusValue === serverDetailedStat.objectsAndMountBonus && detailedStat.alignGiftBonusValue === serverDetailedStat.alignGiftBonus && detailedStat.contextModifValue === serverDetailedStat.contextModif)
            {
               return null;
            }
            statDiffValues = getFormattedValueDiff("base",detailedStat.baseValue,serverDetailedStat.base) + " " + getFormattedValueDiff("additional",detailedStat.additionalValue,serverDetailedStat.additional) + " " + getFormattedValueDiff("objectsAndMountBonus",detailedStat.objectsAndMountBonusValue,serverDetailedStat.objectsAndMountBonus) + " " + getFormattedValueDiff("alignGiftBonus",detailedStat.alignGiftBonusValue,serverDetailedStat.alignGiftBonus) + " " + getFormattedValueDiff("contextModif",detailedStat.contextModifValue,serverDetailedStat.contextModif) + " " + getFormattedValueDiff("total",detailedStat.totalValue,total);
            return getFormattedStatDiff(stat.id,DIFF_DETAILED_STAT,DIFF_UPDATE,statDiffValues);
         }
         if(stat is Stat && serverBaseStat is CharacterCharacteristicValue)
         {
            serverStat = serverBaseStat as CharacterCharacteristicValue;
            if(stat.totalValue === serverStat.total)
            {
               return null;
            }
            statDiffValues = getFormattedValueDiff("total",stat.totalValue,serverStat.total);
            return getFormattedStatDiff(stat.id,DIFF_STAT,DIFF_UPDATE,statDiffValues);
         }
         if(stat is Stat && serverBaseStat is CharacterCharacteristicDetailed)
         {
            serverDetailedStat = serverBaseStat as CharacterCharacteristicDetailed;
            total = serverDetailedStat.base + serverDetailedStat.additional + serverDetailedStat.objectsAndMountBonus + serverDetailedStat.alignGiftBonus + serverDetailedStat.contextModif;
            if(stat.totalValue === total)
            {
               return null;
            }
            statDiffValues = getFormattedValueDiff("total",stat.totalValue,total);
            return getFormattedStatDiff(stat.id,DIFF_STAT,DIFF_UPDATE,statDiffValues);
         }
         return null;
      }
      
      private static function sortStatIds(statId1:Number, statId2:Number) : Number
      {
         return statId1 - statId2;
      }
      
      public function handle(consoleHandler:ConsoleHandler, baseCommand:String, args:Array) : void
      {
         if(baseCommand !== BASE_COMMAND)
         {
            displayError(consoleHandler,"Wrong command provided: \'" + baseCommand + "\'.");
            return;
         }
         var command:String = null;
         if(args.length > 0)
         {
            command = args[0];
         }
         if(args.length <= 0 || command === HELP_COMMAND)
         {
            consoleHandler.output(getFullHelp(),ConsoleMessageTypeEnum.CONSOLE_TEXT_MESSAGE);
            return;
         }
         var isCommandSuccessful:Boolean = false;
         switch(command)
         {
            case DUMP_COMMAND:
               isCommandSuccessful = handleDumpCommand(consoleHandler,args);
               break;
            case VERBOSE_COMMAND:
               isCommandSuccessful = handleVerboseCommand(consoleHandler,args);
               break;
            default:
               displayError(consoleHandler,"Unknown command: \'" + command + "\'.",true);
         }
         if(!isCommandSuccessful)
         {
            displayError(consoleHandler,COMMAND_ABORTED_ERROR);
         }
      }
      
      public function getHelp(baseCommand:String) : String
      {
         if(baseCommand === BASE_COMMAND)
         {
            return "<b>Manage stats</b> via the <b>stats manager</b>. Please enter \'<b>/" + BASE_COMMAND + "</b>\' or \'<b>/" + BASE_COMMAND + " " + HELP_COMMAND + "</b>\' to get the full help.";
         }
         return "Unknown command for the stats instruction handler: \'" + baseCommand + "\'.";
      }
      
      public function getParamPossibilities(baseCommand:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         var possibilities:Array = [];
         if(baseCommand === BASE_COMMAND)
         {
            if(paramIndex == 0)
            {
               possibilities.push(VERBOSE_COMMAND);
               possibilities.push(HELP_COMMAND);
            }
         }
         return possibilities;
      }
   }
}

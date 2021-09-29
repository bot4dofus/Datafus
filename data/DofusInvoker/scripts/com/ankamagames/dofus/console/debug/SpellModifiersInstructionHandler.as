package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifier;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.network.enums.ConsoleMessageTypeEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SpellModifiersInstructionHandler implements ConsoleInstructionHandler
   {
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellModifiersInstructionHandler));
      
      public static const BASE_COMMAND:String = "spellmodifiersmanager";
      
      private static const DUMP_COMMAND:String = "dump";
      
      private static const VERBOSE_COMMAND:String = "verbose";
      
      private static const HELP_COMMAND:String = "help";
      
      private static const SPELLS_MODIFIER_MANAGER_ERROR:String = "The spells modifier stats manager is not available";
      
      private static const UNKNOWN_ERROR:String = "Something went wrong. Please check logs if necessary";
      
      private static const ARGUMENT_ERROR:String = "Wrong number of arguments";
      
      private static const COMMAND_ABORTED_ERROR:String = "Aborting";
      
      private static const DUMP_MODIFIERS_ARGUMENT:String = "modifiers";
      
      private static const DUMP_MODIFIER_ARGUMENT:String = "modifier";
       
      
      public function SpellModifiersInstructionHandler()
      {
         super();
      }
      
      private static function getFullHelp() : String
      {
         return "<b>Manage spell modifiers</b> via the <b>spells modifier stats manager</b>.\n\n" + "<b>Display help:</b>\n" + "\t/" + BASE_COMMAND + "\n" + "\t/" + BASE_COMMAND + "<b> " + HELP_COMMAND + "</b>\n\n" + "<b>Dump entity stats (or a specific one):</b>\n" + "\t/" + BASE_COMMAND + " <b>" + DUMP_COMMAND + "</b>" + " <b>" + DUMP_MODIFIERS_ARGUMENT + "</b> [<b>ENTITY ID</b>] [<b>SPELL ID</b>]\n\n" + "\t/" + BASE_COMMAND + " <b>" + DUMP_COMMAND + "</b>" + " <b>" + DUMP_MODIFIER_ARGUMENT + "</b> [<b>ENTITY ID</b>] [<b>SPELL ID</b>] [<b>MODIFIER ID</b>]\n\n" + "<b>Enable verbose mode:</b>\n" + "\t/" + BASE_COMMAND + " <b>" + VERBOSE_COMMAND + "</b> [<b>VALUE</b>]\n\n" + "\t- <b>VALUE</b> is either \'<b>true</b> or <b>false</b>, depending on what you want to do.\n\n";
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
         var modifierId:Number = NaN;
         var stat:SpellModifier = null;
         if(args.length < 4 || args.length > 5)
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
         if(dumpCommand !== DUMP_MODIFIERS_ARGUMENT && dumpCommand !== DUMP_MODIFIER_ARGUMENT)
         {
            displayError(consoleHandler,"The parameter should be either: \"" + DUMP_MODIFIER_ARGUMENT + "\" or \"" + DUMP_MODIFIER_ARGUMENT + "\".",true);
            return false;
         }
         var entityId:Number = Number(args[2]);
         if(isNaN(entityId))
         {
            displayError(consoleHandler,"The entity ID provided could not be parsed: \"" + args[2] + "\"",true);
            return false;
         }
         var spellId:Number = Number(args[3]);
         if(isNaN(spellId))
         {
            displayError(consoleHandler,"The spell ID provided could not be parsed: \"" + args[3] + "\"",true);
            return false;
         }
         var spellModifiersManager:SpellModifiersManager = SpellModifiersManager.getInstance();
         if(spellModifiersManager === null)
         {
            displayError(consoleHandler,SPELLS_MODIFIER_MANAGER_ERROR);
            return false;
         }
         var spellModifiers:SpellModifiers = spellModifiersManager.getSpellModifiers(entityId,spellId);
         if(spellModifiers === null)
         {
            consoleHandler.output("<b>No modifiers were given to the entity.</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
            return true;
         }
         if(dumpCommand === DUMP_MODIFIERS_ARGUMENT)
         {
            if(args.length !== 4)
            {
               displayError(consoleHandler,"Only an entity ID and a spell ID should be given with the \"" + DUMP_MODIFIERS_ARGUMENT + "\" parameter",true);
               return false;
            }
            consoleHandler.output(spellModifiers.toString(),ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
         }
         else
         {
            if(dumpCommand !== DUMP_MODIFIER_ARGUMENT)
            {
               displayError(consoleHandler,"You must specify either \"" + DUMP_MODIFIER_ARGUMENT + "\" or \"" + DUMP_MODIFIER_ARGUMENT + "\"",true);
               return false;
            }
            if(args.length !== 5)
            {
               displayError(consoleHandler,"An entity ID, a spell ID and a modifier ID should be given with the \"" + DUMP_MODIFIER_ARGUMENT + "\" parameter",true);
               return false;
            }
            modifierId = Number(args[4]);
            if(isNaN(modifierId))
            {
               displayError(consoleHandler,"The modifier ID provided could not be parsed: \"" + args[4] + "\"",true);
               return false;
            }
            stat = spellModifiers.getModifier(modifierId);
            if(stat === null)
            {
               consoleHandler.output("<b>No modifier was given with this ID.</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
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
         var spellsModifierStatsManager:SpellModifiersManager = SpellModifiersManager.getInstance();
         if(spellsModifierStatsManager === null)
         {
            displayError(consoleHandler,SPELLS_MODIFIER_MANAGER_ERROR);
            return false;
         }
         var verboseAction:String = !!isVerbose ? "enabled" : "disabled";
         if(spellsModifierStatsManager.isVerbose === isVerbose)
         {
            displayError(consoleHandler,"Verbose mode is already " + verboseAction + ".");
            return false;
         }
         spellsModifierStatsManager.isVerbose = isVerbose;
         consoleHandler.output("<b>Verbose mode has been " + verboseAction + ".</b>",ConsoleMessageTypeEnum.CONSOLE_INFO_MESSAGE);
         return true;
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
            return "<b>Manage spell modifiers</b> via the <b>spells modifier stats manager</b>. Please enter \'<b>/" + BASE_COMMAND + "</b>\' or \'<b>/" + BASE_COMMAND + " " + HELP_COMMAND + "</b>\' to get the full help.";
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

package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextKickMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class FightInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      private var _cmd:String;
      
      public function FightInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var player:String = null;
         var option:uint = 0;
         var gfotmsg:GameFightOptionToggleMessage = null;
         var fighterId:Number = NaN;
         var gckmsg:GameContextKickMessage = null;
         this._cmd = cmd;
         switch(cmd)
         {
            case "s":
            case "spectator":
               if(PlayedCharacterManager.getInstance().isFighting)
               {
                  option = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
                  gfotmsg = new GameFightOptionToggleMessage();
                  gfotmsg.initGameFightOptionToggleMessage(option);
                  ConnectionsHandler.getConnection().send(gfotmsg);
               }
               break;
            case "list":
               this.listFighters(console);
               break;
            case "players":
               this.listFighters(console);
               break;
            case "kick":
               player = args[0];
               if(FightContextFrame.preFightIsActive)
               {
                  fighterId = this.getFighterId(player);
                  if(fighterId != 0 && fighterId != PlayedCharacterManager.getInstance().id)
                  {
                     gckmsg = new GameContextKickMessage();
                     gckmsg.initGameContextKickMessage(fighterId);
                     ConnectionsHandler.getConnection().send(gckmsg);
                  }
               }
         }
      }
      
      private function getFighterId(name:String) : Number
      {
         var fighterId:Number = NaN;
         var fightFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var fighters:Vector.<Number> = fightFrame.preparationFrame.fightersList;
         for each(fighterId in fighters)
         {
            if(fightFrame.getFighterName(fighterId) == name)
            {
               return fighterId;
            }
         }
         return 0;
      }
      
      private function listFighters(console:ConsoleHandler) : void
      {
         var fightFrame:FightContextFrame = null;
         var fighters:Vector.<Number> = null;
         var fighterId:Number = NaN;
         if(PlayedCharacterManager.getInstance().isFighting)
         {
            fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            if(FightContextFrame.preFightIsActive)
            {
               fighters = fightFrame.preparationFrame.fightersList;
            }
            else
            {
               fighters = fightFrame.battleFrame.fightersList;
            }
            for each(fighterId in fighters)
            {
               console.output(fightFrame.getFighterName(fighterId));
            }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "s":
            case "spectator":
               return I18n.getUiText("ui.chat.console.help.spectator");
            case "list":
               return I18n.getUiText("ui.chat.console.help.list");
            case "players":
               return I18n.getUiText("ui.chat.console.help.list");
            case "kick":
               return I18n.getUiText("ui.chat.console.help.kick");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}

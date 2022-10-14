package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.death.GameRolePlayFreeSoulRequestMessage;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class StatusInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function StatusInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var status:PlayerStatus = null;
         var grpfsrmmsg:GameRolePlayFreeSoulRequestMessage = null;
         var message:String = null;
         var s:String = null;
         var psurmsg:PlayerStatusUpdateRequestMessage = new PlayerStatusUpdateRequestMessage();
         switch(cmd)
         {
            case "away":
            case I18n.getUiText("ui.chat.status.away").toLocaleLowerCase():
               if(args.length > 0)
               {
                  message = "";
                  for each(s in args)
                  {
                     message += s + " ";
                  }
                  status = new PlayerStatusExtended();
                  PlayerStatusExtended(status).initPlayerStatusExtended(PlayerStatusEnum.PLAYER_STATUS_AFK,message);
                  KernelEventsManager.getInstance().processCallback(SocialHookList.NewAwayMessage,message);
               }
               else
               {
                  status = new PlayerStatus();
                  status.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_AFK);
               }
               psurmsg.initPlayerStatusUpdateRequestMessage(status);
               ConnectionsHandler.getConnection().send(psurmsg);
               break;
            case I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase():
               status = new PlayerStatus();
               status.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_SOLO);
               psurmsg.initPlayerStatusUpdateRequestMessage(status);
               ConnectionsHandler.getConnection().send(psurmsg);
               break;
            case I18n.getUiText("ui.chat.status.private").toLocaleLowerCase():
               status = new PlayerStatus();
               status.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_PRIVATE);
               psurmsg.initPlayerStatusUpdateRequestMessage(status);
               ConnectionsHandler.getConnection().send(psurmsg);
               break;
            case I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase():
               status = new PlayerStatus();
               status.initPlayerStatus(PlayerStatusEnum.PLAYER_STATUS_AVAILABLE);
               psurmsg.initPlayerStatusUpdateRequestMessage(status);
               ConnectionsHandler.getConnection().send(psurmsg);
               break;
            case "release":
               grpfsrmmsg = new GameRolePlayFreeSoulRequestMessage();
               ConnectionsHandler.getConnection().send(grpfsrmmsg);
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "away":
            case I18n.getUiText("ui.chat.status.away").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.away".toLocaleLowerCase()) + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.awaytooltip");
            case I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.solotooltip");
            case I18n.getUiText("ui.chat.status.private").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.private").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.privatetooltip");
            case I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase():
               return "- /" + I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase() + I18n.getUiText("ui.common.colon") + I18n.getUiText("ui.chat.status.availiabletooltip");
            case "release":
               return I18n.getUiText("ui.common.freeSoul");
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

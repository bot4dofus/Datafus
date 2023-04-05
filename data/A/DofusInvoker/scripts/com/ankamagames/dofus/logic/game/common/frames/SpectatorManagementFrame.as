package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.JoinAsSpectatorRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.MapRunningFightDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.spectator.StopToListenRunningFightAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatePlayerRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsExtendedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.StopToListenRunningFightRequestMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class SpectatorManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpectatorManagementFrame));
       
      
      public function SpectatorManagementFrame()
      {
         super();
      }
      
      private static function sortFights(a:FightExternalInformations, b:FightExternalInformations) : int
      {
         if(a.fightStart == b.fightStart)
         {
            return 0;
         }
         if(a.fightStart == 0)
         {
            return -1;
         }
         if(b.fightStart == 0)
         {
            return 1;
         }
         return b.fightStart - a.fightStart;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var mrflrmsg:MapRunningFightListRequestMessage = null;
         var mrflmsg:MapRunningFightListMessage = null;
         var fights:Vector.<FightExternalInformations> = null;
         var mrfdra:MapRunningFightDetailsRequestAction = null;
         var mrfdrmsg:MapRunningFightDetailsRequestMessage = null;
         var stlrfmsg:StopToListenRunningFightRequestMessage = null;
         var mrfdemsg:MapRunningFightDetailsExtendedMessage = null;
         var attackersName:String = null;
         var defendersName:String = null;
         var mrfdmsg:MapRunningFightDetailsMessage = null;
         var jasra:JoinAsSpectatorRequestAction = null;
         var gfjrmsg:GameFightJoinRequestMessage = null;
         var jfra:JoinFightRequestAction = null;
         var gfspra:GameFightSpectatePlayerRequestAction = null;
         var gfsprmsg:GameFightSpectatePlayerRequestMessage = null;
         var f:FightExternalInformations = null;
         var namedTeam:NamedPartyTeam = null;
         switch(true)
         {
            case msg is OpenCurrentFightAction:
               mrflrmsg = new MapRunningFightListRequestMessage();
               mrflrmsg.initMapRunningFightListRequestMessage();
               ConnectionsHandler.getConnection().send(mrflrmsg);
               return true;
            case msg is MapRunningFightListMessage:
               mrflmsg = msg as MapRunningFightListMessage;
               fights = new Vector.<FightExternalInformations>();
               for each(f in mrflmsg.fights)
               {
                  fights.push(f);
               }
               fights.sort(sortFights);
               KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightList,fights);
               return true;
            case msg is MapRunningFightDetailsRequestAction:
               mrfdra = msg as MapRunningFightDetailsRequestAction;
               mrfdrmsg = new MapRunningFightDetailsRequestMessage();
               mrfdrmsg.initMapRunningFightDetailsRequestMessage(mrfdra.fightId);
               ConnectionsHandler.getConnection().send(mrfdrmsg);
               return true;
            case msg is StopToListenRunningFightAction:
               stlrfmsg = new StopToListenRunningFightRequestMessage();
               stlrfmsg.initStopToListenRunningFightRequestMessage();
               ConnectionsHandler.getConnection().send(stlrfmsg);
               return true;
            case msg is MapRunningFightDetailsExtendedMessage:
               mrfdemsg = msg as MapRunningFightDetailsExtendedMessage;
               attackersName = "";
               defendersName = "";
               for each(namedTeam in mrfdemsg.namedPartyTeams)
               {
                  if(namedTeam.partyName && namedTeam.partyName != "")
                  {
                     if(namedTeam.teamId == TeamEnum.TEAM_CHALLENGER)
                     {
                        attackersName = namedTeam.partyName;
                     }
                     else if(namedTeam.teamId == TeamEnum.TEAM_DEFENDER)
                     {
                        defendersName = namedTeam.partyName;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails,mrfdemsg.fightId,mrfdemsg.attackers,mrfdemsg.defenders,attackersName,defendersName);
               return true;
            case msg is MapRunningFightDetailsMessage:
               mrfdmsg = msg as MapRunningFightDetailsMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails,mrfdmsg.fightId,mrfdmsg.attackers,mrfdmsg.defenders,"","");
               return true;
            case msg is JoinAsSpectatorRequestAction:
               jasra = msg as JoinAsSpectatorRequestAction;
               gfjrmsg = new GameFightJoinRequestMessage();
               gfjrmsg.initGameFightJoinRequestMessage(0,jasra.fightId);
               ConnectionsHandler.getConnection().send(gfjrmsg);
               return true;
            case msg is JoinFightRequestAction:
               jfra = msg as JoinFightRequestAction;
               gfjrmsg = new GameFightJoinRequestMessage();
               gfjrmsg.initGameFightJoinRequestMessage(jfra.teamLeaderId,jfra.fightId);
               ConnectionsHandler.getConnection().send(gfjrmsg);
               return true;
            case msg is GameFightSpectatePlayerRequestAction:
               gfspra = msg as GameFightSpectatePlayerRequestAction;
               gfsprmsg = new GameFightSpectatePlayerRequestMessage();
               gfsprmsg.initGameFightSpectatePlayerRequestMessage(gfspra.playerId);
               ConnectionsHandler.getConnection().send(gfsprmsg);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
   }
}

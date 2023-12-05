package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationTypeEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderInfoRequestAction;
   import com.ankamagames.dofus.logic.game.fight.actions.SurrenderVoteAction;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.surrender.SurrenderInfoRequestMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.SurrenderInfoResponseMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.SurrenderStateMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.vote.OpponentSurrenderMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.vote.SurrenderVoteCastMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.vote.SurrenderVoteEndMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.vote.SurrenderVoteStartMessage;
   import com.ankamagames.dofus.network.messages.game.surrender.vote.SurrenderVoteUpdateMessage;
   import com.ankamagames.dofus.network.types.game.surrender.SurrenderResponse;
   import com.ankamagames.dofus.network.types.game.surrender.vote.SurrenderVoteResponse;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class FightSurrenderFrame implements Frame
   {
      
      private static const SURRENDER_VOTE_NOTIF_NAME:String = "surrenderVote";
       
      
      private const MIN_VOTE_PENALTY_TIME:int = 0;
      
      private const MAX_VOTE_PENALTY_TIME:int = 10;
      
      private const MAX_SURRENDER_TURN:int = 6;
      
      private var _surrenderResponse:SurrenderResponse;
      
      private var _voteResponse:SurrenderVoteResponse;
      
      private var _hasVoted:Boolean = false;
      
      private var _refusalPopupName:String;
      
      private var _votePermitted:Boolean = true;
      
      private var _vote:Boolean;
      
      private var _numberOfParticipants:int;
      
      private var _castedVoteNumber:int;
      
      private var _voteDuration:int;
      
      public function FightSurrenderFrame()
      {
         super();
      }
      
      public function get maxSurrenderTurn() : int
      {
         return this.MAX_SURRENDER_TURN;
      }
      
      public function get refusalPopupName() : String
      {
         return this._refusalPopupName;
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sirmsg:SurrenderInfoRequestMessage = null;
         var surrenderInfoResponseMessage:SurrenderInfoResponseMessage = null;
         var sva:SurrenderVoteAction = null;
         var scvmsg:SurrenderVoteCastMessage = null;
         var svsmsg:SurrenderVoteStartMessage = null;
         var svem:SurrenderVoteEndMessage = null;
         switch(true)
         {
            case msg is SurrenderStateMessage:
               this._votePermitted = (msg as SurrenderStateMessage).permitVote;
               KernelEventsManager.getInstance().processCallback(FightHookList.UnlockSurrender,(msg as SurrenderStateMessage).canSurrender);
               return true;
            case msg is SurrenderInfoRequestAction:
               sirmsg = new SurrenderInfoRequestMessage();
               sirmsg.initSurrenderInfoRequestMessage();
               ConnectionsHandler.getConnection().send(sirmsg);
               return true;
            case msg is SurrenderInfoResponseMessage:
               surrenderInfoResponseMessage = msg as SurrenderInfoResponseMessage;
               this._surrenderResponse = surrenderInfoResponseMessage.surrenderResponse;
               this._voteResponse = surrenderInfoResponseMessage.surrenderVoteResponse;
               KernelEventsManager.getInstance().processCallback(FightHookList.SurrenderInfo,this._surrenderResponse,this._voteResponse,surrenderInfoResponseMessage.hasSanction);
               return true;
            case msg is SurrenderVoteAction:
               sva = msg as SurrenderVoteAction;
               scvmsg = new SurrenderVoteCastMessage();
               this._hasVoted = true;
               this._vote = sva.vote;
               scvmsg.initSurrenderVoteCastMessage(sva.vote);
               ConnectionsHandler.getConnection().send(scvmsg);
               return true;
            case msg is SurrenderVoteStartMessage:
               svsmsg = msg as SurrenderVoteStartMessage;
               this._numberOfParticipants = svsmsg.numberOfParticipants;
               this._castedVoteNumber = svsmsg.castedVoteNumber;
               this._voteDuration = svsmsg.voteDuration;
               this.voteNotification(this._numberOfParticipants,this._castedVoteNumber,this._voteDuration,this._hasVoted);
               KernelEventsManager.getInstance().processCallback(HookList.ArenaExternalNotification,ExternalNotificationTypeEnum.KOLO_SURRENDER_VOTE,svsmsg.voteDuration * 1000);
               return true;
            case msg is SurrenderVoteUpdateMessage:
               ++this._castedVoteNumber;
               this.voteNotification(this._numberOfParticipants,this._castedVoteNumber,this._voteDuration,this._hasVoted);
               return true;
            case msg is SurrenderVoteEndMessage:
               svem = msg as SurrenderVoteEndMessage;
               this.voteEndNotification(svem.voteResult);
               this._hasVoted = false;
               return true;
            case msg is OpponentSurrenderMessage:
               this.opponentSurrenderNotification();
               return true;
            default:
               return false;
         }
      }
      
      private function refuseVote(reasonText:String) : void
      {
         this._hasVoted = false;
         if(Berilia.getInstance().getUi(this._refusalPopupName))
         {
            Berilia.getInstance().unloadUi(this._refusalPopupName);
         }
         var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         this._refusalPopupName = commonMod.openPopup(I18n.getUiText("ui.common.doWait"),reasonText,[I18n.getUiText("ui.common.ok")]);
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get votePermitted() : Boolean
      {
         return this._votePermitted;
      }
      
      private function voteEndNotification(voteResult:Boolean) : void
      {
         var notificationTitleText:String = !!voteResult ? I18n.getUiText("ui.party.arena.endOfFight") : I18n.getUiText("ui.party.arena.surrenderVoteResult");
         var notificationText:String = !!voteResult ? I18n.getUiText("ui.party.arena.youSurrendered") : I18n.getUiText("ui.party.arena.youDidNotSurrender");
         NotificationManager.getInstance().closeNotification(SURRENDER_VOTE_NOTIF_NAME);
         var voteEndNid:uint = NotificationManager.getInstance().prepareNotification(notificationTitleText,notificationText,NotificationTypeEnum.PRIORITY_INVITATION,SURRENDER_VOTE_NOTIF_NAME);
         NotificationManager.getInstance().sendNotification(voteEndNid);
      }
      
      private function opponentSurrenderNotification() : void
      {
         NotificationManager.getInstance().closeNotification(SURRENDER_VOTE_NOTIF_NAME);
         var voteEndNid:uint = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.party.arena.endOfFight"),I18n.getUiText("ui.party.arena.otherTeamSurrendered"),NotificationTypeEnum.PRIORITY_INVITATION,SURRENDER_VOTE_NOTIF_NAME);
         NotificationManager.getInstance().sendNotification(voteEndNid);
      }
      
      private function voteNotification(numberOfParticipants:int, castedVoteNumber:int, voteDuration:int, hasVoted:Boolean) : void
      {
         var vsmsgNid:uint = 0;
         var notificationTitleText:* = I18n.getUiText("ui.fight.doConcede") + " (" + castedVoteNumber + "/" + numberOfParticipants + " " + PatternDecoder.combine(I18n.getUiText("ui.common.player"),"n",numberOfParticipants == 1) + ")";
         var notificationText:String = I18n.getUiText("ui.party.concedeNotificationText") + "\n" + I18n.getUiText("ui.party.votePenaltyTime",[this.MIN_VOTE_PENALTY_TIME,this.MAX_VOTE_PENALTY_TIME]);
         NotificationManager.getInstance().closeNotification(SURRENDER_VOTE_NOTIF_NAME);
         if(hasVoted)
         {
            if(this._vote)
            {
               notificationText += "\n\n" + I18n.getUiText("ui.party.votedToSurrender");
            }
            else
            {
               notificationText += "\n\n" + I18n.getUiText("ui.party.votedToContinue");
            }
            vsmsgNid = NotificationManager.getInstance().prepareNotification(notificationTitleText,notificationText,NotificationTypeEnum.PRIORITY_INVITATION,SURRENDER_VOTE_NOTIF_NAME);
         }
         else
         {
            vsmsgNid = NotificationManager.getInstance().prepareNotification(notificationTitleText,notificationText,NotificationTypeEnum.PRIORITY_INVITATION,SURRENDER_VOTE_NOTIF_NAME);
            NotificationManager.getInstance().addButtonToNotification(vsmsgNid,I18n.getUiText("ui.fight.doNotConcede"),"SurrenderVoteAction",[false]);
            NotificationManager.getInstance().addButtonToNotification(vsmsgNid,I18n.getUiText("ui.fight.doConcede"),"SurrenderVoteAction",[true]);
         }
         NotificationManager.getInstance().addTimerToNotification(vsmsgNid,voteDuration,false,true);
         NotificationManager.getInstance().sendNotification(vsmsgNid);
      }
   }
}

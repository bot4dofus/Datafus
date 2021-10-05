package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationValidMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationEmblemValidMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationNameAndTagValidMessage;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationValidMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceDialogFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceDialogFrame));
       
      
      private var allianceEmblem:GuildEmblem;
      
      public function AllianceDialogFrame()
      {
         super();
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
         var acva:AllianceCreationValidAction = null;
         var acvmsg:AllianceCreationValidMessage = null;
         var amva:AllianceModificationValidAction = null;
         var amvmsg:AllianceModificationValidMessage = null;
         var amnva:AllianceModificationNameAndTagValidAction = null;
         var amnvmsg:AllianceModificationNameAndTagValidMessage = null;
         var ameva:AllianceModificationEmblemValidAction = null;
         var amevmsg:AllianceModificationEmblemValidMessage = null;
         var aiaa:AllianceInvitationAnswerAction = null;
         var aiamsg:AllianceInvitationAnswerMessage = null;
         var ldm:LeaveDialogMessage = null;
         switch(true)
         {
            case msg is AllianceCreationValidAction:
               acva = msg as AllianceCreationValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = acva.upEmblemId;
               this.allianceEmblem.symbolColor = acva.upColorEmblem;
               this.allianceEmblem.backgroundShape = acva.backEmblemId;
               this.allianceEmblem.backgroundColor = acva.backColorEmblem;
               acvmsg = new AllianceCreationValidMessage();
               acvmsg.initAllianceCreationValidMessage(acva.allianceName,acva.allianceTag,this.allianceEmblem);
               ConnectionsHandler.getConnection().send(acvmsg);
               return true;
            case msg is AllianceModificationValidAction:
               amva = msg as AllianceModificationValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = amva.upEmblemId;
               this.allianceEmblem.symbolColor = amva.upColorEmblem;
               this.allianceEmblem.backgroundShape = amva.backEmblemId;
               this.allianceEmblem.backgroundColor = amva.backColorEmblem;
               amvmsg = new AllianceModificationValidMessage();
               amvmsg.initAllianceModificationValidMessage(amva.name,amva.tag,this.allianceEmblem);
               ConnectionsHandler.getConnection().send(amvmsg);
               return true;
            case msg is AllianceModificationNameAndTagValidAction:
               amnva = msg as AllianceModificationNameAndTagValidAction;
               amnvmsg = new AllianceModificationNameAndTagValidMessage();
               amnvmsg.initAllianceModificationNameAndTagValidMessage(amnva.name,amnva.tag);
               ConnectionsHandler.getConnection().send(amnvmsg);
               return true;
            case msg is AllianceModificationEmblemValidAction:
               ameva = msg as AllianceModificationEmblemValidAction;
               this.allianceEmblem = new GuildEmblem();
               this.allianceEmblem.symbolShape = ameva.upEmblemId;
               this.allianceEmblem.symbolColor = ameva.upColorEmblem;
               this.allianceEmblem.backgroundShape = ameva.backEmblemId;
               this.allianceEmblem.backgroundColor = ameva.backColorEmblem;
               amevmsg = new AllianceModificationEmblemValidMessage();
               amevmsg.initAllianceModificationEmblemValidMessage(this.allianceEmblem);
               ConnectionsHandler.getConnection().send(amevmsg);
               return true;
            case msg is AllianceInvitationAnswerAction:
               aiaa = msg as AllianceInvitationAnswerAction;
               aiamsg = new AllianceInvitationAnswerMessage();
               aiamsg.initAllianceInvitationAnswerMessage(aiaa.accept);
               ConnectionsHandler.getConnection().send(aiamsg);
               this.leaveDialog();
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_CREATE || ldm.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_INVITATION || ldm.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_RENAME)
               {
                  this.leaveDialog();
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
      
      private function leaveDialog() : void
      {
         Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
         Kernel.getWorker().removeFrame(this);
      }
   }
}

package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.frames.TeleportBuddiesDialogFrame;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogQuestionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.NpcDialogReplyMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class NpcDialogFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
       
      
      public function NpcDialogFrame()
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
         var ndcmsg:NpcDialogQuestionMessage = null;
         var ndra:NpcDialogReplyAction = null;
         var ndrmsg:NpcDialogReplyMessage = null;
         var ldm:LeaveDialogMessage = null;
         var teleportDFrame:TeleportBuddiesDialogFrame = null;
         switch(true)
         {
            case msg is NpcDialogQuestionMessage:
               ndcmsg = msg as NpcDialogQuestionMessage;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.NpcDialogQuestion,ndcmsg.messageId,ndcmsg.dialogParams,ndcmsg.visibleReplies);
               return true;
            case msg is NpcDialogReplyAction:
               ndra = msg as NpcDialogReplyAction;
               ndrmsg = new NpcDialogReplyMessage();
               ndrmsg.initNpcDialogReplyMessage(ndra.replyId);
               ConnectionsHandler.getConnection().send(ndrmsg);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_DIALOG || ldm.dialogType == DialogTypeEnum.DIALOG_MARRIAGE)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               else if(ldm.dialogType == DialogTypeEnum.DIALOG_DUNGEON_MEETING)
               {
                  teleportDFrame = Kernel.getWorker().getFrame(TeleportBuddiesDialogFrame) as TeleportBuddiesDialogFrame;
                  if(teleportDFrame)
                  {
                     teleportDFrame.process(ldm);
                  }
                  Kernel.getWorker().removeFrame(this);
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
   }
}

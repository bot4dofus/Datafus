package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildCreationValidMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationAnswerMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildModificationEmblemValidMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildModificationNameValidMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildModificationValidMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class GuildDialogFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildDialogFrame));
       
      
      private var guildEmblem:GuildEmblem;
      
      public function GuildDialogFrame()
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
         var gcva:GuildCreationValidAction = null;
         var gcvmsg:GuildCreationValidMessage = null;
         var gmva:GuildModificationValidAction = null;
         var gmvmsg:GuildModificationValidMessage = null;
         var gmnva:GuildModificationNameValidAction = null;
         var gmnvmsg:GuildModificationNameValidMessage = null;
         var gmeva:GuildModificationEmblemValidAction = null;
         var gmevmsg:GuildModificationEmblemValidMessage = null;
         var giaa:GuildInvitationAnswerAction = null;
         var giamsg:GuildInvitationAnswerMessage = null;
         var ldm:LeaveDialogMessage = null;
         switch(true)
         {
            case msg is GuildCreationValidAction:
               gcva = msg as GuildCreationValidAction;
               this.guildEmblem = new GuildEmblem();
               this.guildEmblem.symbolShape = gcva.upEmblemId;
               this.guildEmblem.symbolColor = gcva.upColorEmblem;
               this.guildEmblem.backgroundShape = gcva.backEmblemId;
               this.guildEmblem.backgroundColor = gcva.backColorEmblem;
               gcvmsg = new GuildCreationValidMessage();
               gcvmsg.initGuildCreationValidMessage(gcva.guildName,this.guildEmblem);
               ConnectionsHandler.getConnection().send(gcvmsg);
               return true;
            case msg is GuildModificationValidAction:
               gmva = msg as GuildModificationValidAction;
               this.guildEmblem = new GuildEmblem();
               this.guildEmblem.symbolShape = gmva.upEmblemId;
               this.guildEmblem.symbolColor = gmva.upColorEmblem;
               this.guildEmblem.backgroundShape = gmva.backEmblemId;
               this.guildEmblem.backgroundColor = gmva.backColorEmblem;
               gmvmsg = new GuildModificationValidMessage();
               gmvmsg.initGuildModificationValidMessage(gmva.guildName,this.guildEmblem);
               ConnectionsHandler.getConnection().send(gmvmsg);
               return true;
            case msg is GuildModificationNameValidAction:
               gmnva = msg as GuildModificationNameValidAction;
               gmnvmsg = new GuildModificationNameValidMessage();
               gmnvmsg.initGuildModificationNameValidMessage(gmnva.guildName);
               ConnectionsHandler.getConnection().send(gmnvmsg);
               return true;
            case msg is GuildModificationEmblemValidAction:
               gmeva = msg as GuildModificationEmblemValidAction;
               this.guildEmblem = new GuildEmblem();
               this.guildEmblem.symbolShape = gmeva.upEmblemId;
               this.guildEmblem.symbolColor = gmeva.upColorEmblem;
               this.guildEmblem.backgroundShape = gmeva.backEmblemId;
               this.guildEmblem.backgroundColor = gmeva.backColorEmblem;
               gmevmsg = new GuildModificationEmblemValidMessage();
               gmevmsg.initGuildModificationEmblemValidMessage(this.guildEmblem);
               ConnectionsHandler.getConnection().send(gmevmsg);
               return true;
            case msg is GuildInvitationAnswerAction:
               giaa = msg as GuildInvitationAnswerAction;
               giamsg = new GuildInvitationAnswerMessage();
               giamsg.initGuildInvitationAnswerMessage(giaa.accept);
               ConnectionsHandler.getConnection().send(giamsg);
               this.leaveDialog();
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_GUILD_CREATE || ldm.dialogType == DialogTypeEnum.DIALOG_GUILD_INVITATION || ldm.dialogType == DialogTypeEnum.DIALOG_GUILD_RENAME)
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

package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.internalDatacenter.jobs.CraftsmanWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterContactLookRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.enums.SocialContactCategoryEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryAddMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryEntryMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.job.JobCrafterDirectoryRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.social.ContactLookRequestByIdMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class JobCrafterDirectoryListDialogFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(JobsFrame));
       
      
      private var _crafterList:Array = null;
      
      public function JobCrafterDirectoryListDialogFrame()
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
         var jcdlra:JobCrafterDirectoryListRequestAction = null;
         var jcdlrmsg:JobCrafterDirectoryListRequestMessage = null;
         var jcclra:JobCrafterContactLookRequestAction = null;
         var jcdlmsg:JobCrafterDirectoryListMessage = null;
         var jcdrmsg:JobCrafterDirectoryRemoveMessage = null;
         var jcdamsg:JobCrafterDirectoryAddMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var clrbimsg:ContactLookRequestByIdMessage = null;
         var entry:JobCrafterDirectoryListEntry = null;
         var i:uint = 0;
         var jobInfo:CraftsmanWrapper = null;
         var iCrafter:* = null;
         switch(true)
         {
            case msg is JobCrafterDirectoryListRequestAction:
               jcdlra = msg as JobCrafterDirectoryListRequestAction;
               jcdlrmsg = new JobCrafterDirectoryListRequestMessage();
               jcdlrmsg.initJobCrafterDirectoryListRequestMessage(jcdlra.jobId);
               ConnectionsHandler.getConnection().send(jcdlrmsg);
               return true;
            case msg is JobCrafterContactLookRequestAction:
               jcclra = msg as JobCrafterContactLookRequestAction;
               if(jcclra.crafterId == PlayedCharacterManager.getInstance().id)
               {
                  KernelEventsManager.getInstance().processCallback(CraftHookList.JobCrafterContactLook,jcclra.crafterId,PlayedCharacterManager.getInstance().infos.name,EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook));
               }
               else
               {
                  clrbimsg = new ContactLookRequestByIdMessage();
                  clrbimsg.initContactLookRequestByIdMessage(0,SocialContactCategoryEnum.SOCIAL_CONTACT_CRAFTER,jcclra.crafterId);
                  ConnectionsHandler.getConnection().send(clrbimsg);
               }
               return true;
            case msg is JobCrafterDirectoryListMessage:
               jcdlmsg = msg as JobCrafterDirectoryListMessage;
               this._crafterList = new Array();
               for each(entry in jcdlmsg.listEntries)
               {
                  this._crafterList.push(CraftsmanWrapper.create(entry));
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case msg is JobCrafterDirectoryRemoveMessage:
               jcdrmsg = msg as JobCrafterDirectoryRemoveMessage;
               for(i = 0; i < this._crafterList.length; i++)
               {
                  jobInfo = this._crafterList[i];
                  if(jobInfo.jobId == jcdrmsg.jobId && jobInfo.playerId == jcdrmsg.playerId)
                  {
                     this._crafterList.splice(i,1);
                     break;
                  }
               }
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case msg is JobCrafterDirectoryAddMessage:
               jcdamsg = msg as JobCrafterDirectoryAddMessage;
               for(iCrafter in this._crafterList)
               {
                  if(jcdamsg.listEntry.playerInfo.playerId == this._crafterList[iCrafter].playerId)
                  {
                     this._crafterList.splice(iCrafter,1);
                  }
               }
               this._crafterList.push(CraftsmanWrapper.create(jcdamsg.listEntry));
               KernelEventsManager.getInstance().processCallback(CraftHookList.CrafterDirectoryListUpdate,this._crafterList);
               return true;
            case msg is JobCrafterDirectoryEntryMessage:
               return false;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is ExchangeLeaveMessage:
               elm = msg as ExchangeLeaveMessage;
               if(elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
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

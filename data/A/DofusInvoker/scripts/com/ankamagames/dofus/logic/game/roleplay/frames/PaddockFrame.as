package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockSellRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockBuyResultMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.PaddockSellRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class PaddockFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
       
      
      public function PaddockFrame()
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
         var pbra:PaddockBuyRequestAction = null;
         var pbrqm:PaddockBuyRequestMessage = null;
         var pbrm:PaddockBuyResultMessage = null;
         var psra:PaddockSellRequestAction = null;
         var psrmsg:PaddockSellRequestMessage = null;
         var ldm:LeaveDialogMessage = null;
         switch(true)
         {
            case msg is PaddockBuyRequestAction:
               pbra = msg as PaddockBuyRequestAction;
               pbrqm = new PaddockBuyRequestMessage();
               pbrqm.initPaddockBuyRequestMessage(pbra.proposedPrice);
               ConnectionsHandler.getConnection().send(pbrqm);
               return true;
            case msg is PaddockBuyResultMessage:
               pbrm = msg as PaddockBuyResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.PaddockBuyResult,pbrm.paddockId,pbrm.bought,pbrm.realPrice);
               return true;
            case msg is PaddockSellRequestAction:
               psra = msg as PaddockSellRequestAction;
               psrmsg = new PaddockSellRequestMessage();
               psrmsg.initPaddockSellRequestMessage(psra.price,psra.forSale);
               ConnectionsHandler.getConnection().send(psrmsg);
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_PURCHASABLE)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
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

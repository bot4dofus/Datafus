package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachExitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachKickRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRewardBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRoomUnlockAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachSaveBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachTeleportRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiBreachActionList
   {
      
      public static const BreachInvitationRequest:DofusApiAction = new DofusApiAction("BreachInvitationRequestAction",BreachInvitationRequestAction);
      
      public static const BreachInvitationAnswer:DofusApiAction = new DofusApiAction("BreachInvitationAnswerAction",BreachInvitationAnswerAction);
      
      public static const BreachKickRequest:DofusApiAction = new DofusApiAction("BreachKickRequestAction",BreachKickRequestAction);
      
      public static const BreachSaveBuy:DofusApiAction = new DofusApiAction("BreachSaveBuyAction",BreachSaveBuyAction);
      
      public static const BreachRewardBuy:DofusApiAction = new DofusApiAction("BreachRewardBuyAction",BreachRewardBuyAction);
      
      public static const BreachExitRequest:DofusApiAction = new DofusApiAction("BreachExitRequestAction",BreachExitRequestAction);
      
      public static const BreachTeleportRequest:DofusApiAction = new DofusApiAction("BreachTeleportRequestAction",BreachTeleportRequestAction);
      
      public static const BreachRoomUnlock:DofusApiAction = new DofusApiAction("BreachRoomUnlockAction",BreachRoomUnlockAction);
       
      
      public function ApiBreachActionList()
      {
         super();
      }
   }
}

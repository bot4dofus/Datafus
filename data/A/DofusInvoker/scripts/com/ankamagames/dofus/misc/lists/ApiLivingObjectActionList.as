package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectChangeSkinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectFeedAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.WrapperObjectDissociateRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiLivingObjectActionList
   {
      
      public static const LivingObjectDissociate:DofusApiAction = new DofusApiAction("LivingObjectDissociateAction",LivingObjectDissociateAction);
      
      public static const LivingObjectFeed:DofusApiAction = new DofusApiAction("LivingObjectFeedAction",LivingObjectFeedAction);
      
      public static const LivingObjectChangeSkinRequest:DofusApiAction = new DofusApiAction("LivingObjectChangeSkinRequestAction",LivingObjectChangeSkinRequestAction);
      
      public static const MimicryObjectFeedAndAssociateRequest:DofusApiAction = new DofusApiAction("MimicryObjectFeedAndAssociateRequestAction",MimicryObjectFeedAndAssociateRequestAction);
      
      public static const MimicryObjectEraseRequest:DofusApiAction = new DofusApiAction("MimicryObjectEraseRequestAction",MimicryObjectEraseRequestAction);
      
      public static const WrapperObjectDissociateRequest:DofusApiAction = new DofusApiAction("WrapperObjectDissociateRequestAction",WrapperObjectDissociateRequestAction);
       
      
      public function ApiLivingObjectActionList()
      {
         super();
      }
   }
}

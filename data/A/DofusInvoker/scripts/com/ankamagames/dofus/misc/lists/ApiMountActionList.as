package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessColorsUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessDissociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockMoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockRemoveItemRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.PaddockSellRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiMountActionList
   {
      
      public static const MountToggleRidingRequest:DofusApiAction = new DofusApiAction("MountToggleRidingRequestAction",MountToggleRidingRequestAction);
      
      public static const MountFeedRequest:DofusApiAction = new DofusApiAction("MountFeedRequestAction",MountFeedRequestAction);
      
      public static const MountReleaseRequest:DofusApiAction = new DofusApiAction("MountReleaseRequestAction",MountReleaseRequestAction);
      
      public static const MountSterilizeRequest:DofusApiAction = new DofusApiAction("MountSterilizeRequestAction",MountSterilizeRequestAction);
      
      public static const MountRenameRequest:DofusApiAction = new DofusApiAction("MountRenameRequestAction",MountRenameRequestAction);
      
      public static const MountSetXpRatioRequest:DofusApiAction = new DofusApiAction("MountSetXpRatioRequestAction",MountSetXpRatioRequestAction);
      
      public static const MountInfoRequest:DofusApiAction = new DofusApiAction("MountInfoRequestAction",MountInfoRequestAction);
      
      public static const MountHarnessDissociateRequest:DofusApiAction = new DofusApiAction("MountHarnessDissociateRequestAction",MountHarnessDissociateRequestAction);
      
      public static const MountHarnessColorsUpdateRequest:DofusApiAction = new DofusApiAction("MountHarnessColorsUpdateRequestAction",MountHarnessColorsUpdateRequestAction);
      
      public static const ExchangeRequestOnMountStock:DofusApiAction = new DofusApiAction("ExchangeRequestOnMountStockAction",ExchangeRequestOnMountStockAction);
      
      public static const ExchangeHandleMountStable:DofusApiAction = new DofusApiAction("ExchangeHandleMountStableAction",ExchangeHandleMountStableAction);
      
      public static const LeaveExchangeMount:DofusApiAction = new DofusApiAction("LeaveExchangeMountAction",LeaveExchangeMountAction);
      
      public static const PaddockRemoveItemRequest:DofusApiAction = new DofusApiAction("PaddockRemoveItemRequestAction",PaddockRemoveItemRequestAction);
      
      public static const PaddockMoveItemRequest:DofusApiAction = new DofusApiAction("PaddockMoveItemRequestAction",PaddockMoveItemRequestAction);
      
      public static const PaddockBuyRequest:DofusApiAction = new DofusApiAction("PaddockBuyRequestAction",PaddockBuyRequestAction);
      
      public static const PaddockSellRequest:DofusApiAction = new DofusApiAction("PaddockSellRequestAction",PaddockSellRequestAction);
      
      public static const MountInformationInPaddockRequest:DofusApiAction = new DofusApiAction("MountInformationInPaddockRequestAction",MountInformationInPaddockRequestAction);
       
      
      public function ApiMountActionList()
      {
         super();
      }
   }
}

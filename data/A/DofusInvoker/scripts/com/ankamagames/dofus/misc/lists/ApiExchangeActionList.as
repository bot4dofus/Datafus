package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidHouseStringSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToBuyerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.BidSwitchToSellerModeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseListAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHousePriceAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.ExchangeBidHouseTypeAction;
   import com.ankamagames.dofus.logic.game.common.actions.bid.LeaveBidHouseAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeCraftPaymentModificationAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeObjectUseInWorkshopAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangePlayerMultiCraftRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeAcceptAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectModifyPricedAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveToTabAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangePlayerRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyCrushAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRequestOnTaxCollectorAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.StartExchangeTaxCollectorEquipmentAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeSellAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeShopStockMouvmentRemoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.ExchangeShopStockMovementAddAction;
   import com.ankamagames.dofus.logic.game.common.actions.trade.LeaveShopStockAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiExchangeActionList
   {
      
      public static const ExchangeAccept:DofusApiAction = new DofusApiAction("ExchangeAcceptAction",ExchangeAcceptAction);
      
      public static const ExchangeRefuse:DofusApiAction = new DofusApiAction("ExchangeRefuseAction",ExchangeRefuseAction);
      
      public static const ExchangeObjectMove:DofusApiAction = new DofusApiAction("ExchangeObjectMoveAction",ExchangeObjectMoveAction);
      
      public static const ExchangeObjectMoveKama:DofusApiAction = new DofusApiAction("ExchangeObjectMoveKamaAction",ExchangeObjectMoveKamaAction);
      
      public static const ExchangeObjectTransfertAllToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertAllToInvAction",ExchangeObjectTransfertAllToInvAction);
      
      public static const ExchangeObjectTransfertListToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertListToInvAction",ExchangeObjectTransfertListToInvAction);
      
      public static const ExchangeObjectTransfertExistingToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertExistingToInvAction",ExchangeObjectTransfertExistingToInvAction);
      
      public static const ExchangeObjectTransfertListWithQuantityToInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertListWithQuantityToInvAction",ExchangeObjectTransfertListWithQuantityToInvAction);
      
      public static const ExchangeObjectTransfertAllFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertAllFromInvAction",ExchangeObjectTransfertAllFromInvAction);
      
      public static const ExchangeObjectTransfertListFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertListFromInvAction",ExchangeObjectTransfertListFromInvAction);
      
      public static const ExchangeObjectTransfertExistingFromInv:DofusApiAction = new DofusApiAction("ExchangeObjectTransfertExistingFromInvAction",ExchangeObjectTransfertExistingFromInvAction);
      
      public static const ExchangeReady:DofusApiAction = new DofusApiAction("ExchangeReadyAction",ExchangeReadyAction);
      
      public static const ExchangeReadyCrush:DofusApiAction = new DofusApiAction("ExchangeReadyCrushAction",ExchangeReadyCrushAction);
      
      public static const ExchangePlayerRequest:DofusApiAction = new DofusApiAction("ExchangePlayerRequestAction",ExchangePlayerRequestAction);
      
      public static const LeaveShopStock:DofusApiAction = new DofusApiAction("LeaveShopStockAction",LeaveShopStockAction);
      
      public static const ExchangeShopStockMovementAdd:DofusApiAction = new DofusApiAction("ExchangeShopStockMovementAddAction",ExchangeShopStockMovementAddAction);
      
      public static const ExchangeShopStockMouvmentRemove:DofusApiAction = new DofusApiAction("ExchangeShopStockMouvmentRemoveAction",ExchangeShopStockMouvmentRemoveAction);
      
      public static const ExchangeObjectModifyPriced:DofusApiAction = new DofusApiAction("ExchangeObjectModifyPricedAction",ExchangeObjectModifyPricedAction);
      
      public static const ExchangeBuy:DofusApiAction = new DofusApiAction("ExchangeBuyAction",ExchangeBuyAction);
      
      public static const ExchangeSell:DofusApiAction = new DofusApiAction("ExchangeSellAction",ExchangeSellAction);
      
      public static const ExchangeBidHouseSearch:DofusApiAction = new DofusApiAction("ExchangeBidHouseSearchAction",ExchangeBidHouseSearchAction);
      
      public static const ExchangeBidHouseList:DofusApiAction = new DofusApiAction("ExchangeBidHouseListAction",ExchangeBidHouseListAction);
      
      public static const ExchangeBidHouseType:DofusApiAction = new DofusApiAction("ExchangeBidHouseTypeAction",ExchangeBidHouseTypeAction);
      
      public static const ExchangeBidHouseBuy:DofusApiAction = new DofusApiAction("ExchangeBidHouseBuyAction",ExchangeBidHouseBuyAction);
      
      public static const ExchangeBidHousePrice:DofusApiAction = new DofusApiAction("ExchangeBidHousePriceAction",ExchangeBidHousePriceAction);
      
      public static const LeaveBidHouse:DofusApiAction = new DofusApiAction("LeaveBidHouseAction",LeaveBidHouseAction);
      
      public static const BidHouseStringSearch:DofusApiAction = new DofusApiAction("BidHouseStringSearchAction",BidHouseStringSearchAction);
      
      public static const BidSwitchToBuyerMode:DofusApiAction = new DofusApiAction("BidSwitchToBuyerModeAction",BidSwitchToBuyerModeAction);
      
      public static const BidSwitchToSellerMode:DofusApiAction = new DofusApiAction("BidSwitchToSellerModeAction",BidSwitchToSellerModeAction);
      
      public static const ExchangeCraftPaymentModification:DofusApiAction = new DofusApiAction("ExchangeCraftPaymentModificationAction",ExchangeCraftPaymentModificationAction);
      
      public static const ExchangePlayerMultiCraftRequest:DofusApiAction = new DofusApiAction("ExchangePlayerMultiCraftRequestAction",ExchangePlayerMultiCraftRequestAction);
      
      public static const ExchangeReplay:DofusApiAction = new DofusApiAction("ExchangeReplayAction",ExchangeReplayAction);
      
      public static const ExchangeReplayStop:DofusApiAction = new DofusApiAction("ExchangeReplayStopAction",ExchangeReplayStopAction);
      
      public static const ExchangeMultiCraftSetCrafterCanUseHisRessources:DofusApiAction = new DofusApiAction("ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction",ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction);
      
      public static const ExchangeObjectUseInWorkshop:DofusApiAction = new DofusApiAction("ExchangeObjectUseInWorkshopAction",ExchangeObjectUseInWorkshopAction);
      
      public static const ExchangeRequestOnTaxCollector:DofusApiAction = new DofusApiAction("ExchangeRequestOnTaxCollectorAction",ExchangeRequestOnTaxCollectorAction);
      
      public static const ExchangeObjectMoveToTab:DofusApiAction = new DofusApiAction("ExchangeObjectMoveToTabAction",ExchangeObjectMoveToTabAction);
      
      public static const StartExchangeTaxCollectorEquipment:DofusApiAction = new DofusApiAction("StartExchangeTaxCollectorEquipmentAction",StartExchangeTaxCollectorEquipmentAction);
       
      
      public function ApiExchangeActionList()
      {
         super();
      }
   }
}

package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class ExchangeHookList
   {
      
      public static const ExchangeError:String = "ExchangeError";
      
      public static const ExchangeLeave:String = "ExchangeLeave";
      
      public static const ExchangeObjectModified:String = "ExchangeObjectModified";
      
      public static const ExchangeObjectAdded:String = "ExchangeObjectAdded";
      
      public static const ExchangeObjectRemoved:String = "ExchangeObjectRemoved";
      
      public static const ExchangeObjectListModified:String = "ExchangeObjectListModified";
      
      public static const ExchangeObjectListAdded:String = "ExchangeObjectListAdded";
      
      public static const ExchangeObjectListRemoved:String = "ExchangeObjectListRemoved";
      
      public static const ExchangeKamaModified:String = "ExchangeKamaModified";
      
      public static const ExchangePodsModified:String = "ExchangePodsModified";
      
      public static const ExchangeStartOkNpcTrade:String = "ExchangeStartOkNpcTrade";
      
      public static const ExchangeRequestCharacterFromMe:String = "ExchangeRequestCharacterFromMe";
      
      public static const ExchangeRequestCharacterToMe:String = "ExchangeRequestCharacterToMe";
      
      public static const ExchangeStarted:String = "ExchangeStarted";
      
      public static const ExchangeBankStarted:String = "ExchangeBankStarted";
      
      public static const ExchangeBankStartedWithStorage:String = "ExchangeBankStartedWithStorage";
      
      public static const ExchangeStartedType:String = "ExchangeStartedType";
      
      public static const AskExchangeMoveObject:String = "AskExchangeMoveObject";
      
      public static const ExchangeIsReady:String = "ExchangeIsReady";
      
      public static const ExchangeWeight:String = "ExchangeWeight";
      
      public static const ExchangeStartOkHumanVendor:String = "ExchangeStartOkHumanVendor";
      
      public static const ExchangeShopStockStarted:String = "ExchangeShopStockStarted";
      
      public static const ExchangeShopStockMovementUpdated:String = "ExchangeShopStockMovementUpdated";
      
      public static const ExchangeShopStockMouvmentRemoveOk:String = "ExchangeShopStockMouvmentRemoveOk";
      
      public static const ExchangeShopStockUpdate:String = "ExchangeShopStockUpdate";
      
      public static const ExchangeShopStockAddQuantity:String = "ExchangeShopStockAddQuantity";
      
      public static const ExchangeShopStockRemoveQuantity:String = "ExchangeShopStockRemoveQuantity";
      
      public static const ClickItemInventory:String = "ClickItemInventory";
      
      public static const DisplayAssociatedRunes:String = "DisplayAssociatedRunes";
      
      public static const ClickItemShopHV:String = "ClickItemShopHV";
      
      public static const ExchangeReplyTaxVendor:String = "ExchangeReplyTaxVendor";
      
      public static const ExchangeShopStockMovementRemoved:String = "ExchangeShopStockMovementRemoved";
      
      public static const CloseStore:String = "CloseStore";
      
      public static const ClickItemStore:String = "ClickItemStore";
      
      public static const SellOk:String = "SellOk";
      
      public static const BuyOk:String = "BuyOk";
      
      public static const ExchangeStartedBidSeller:String = "ExchangeStartedBidSeller";
      
      public static const ExchangeStartedBidBuyer:String = "ExchangeStartedBidBuyer";
      
      public static const ExchangeBidPrice:String = "ExchangeBidPrice";
      
      public static const ExchangeBidPriceForSeller:String = "ExchangeBidPriceForSeller";
      
      public static const ExchangeBidSearchOk:String = "ExchangeBidSearchOk";
      
      public static const OpenBidHouse:String = "OpenBidHouse";
      
      public static const ExchangeBidHouseItemAddOk:String = "ExchangeBidHouseItemAddOk";
      
      public static const ExchangeBidHouseItemRemoveOk:String = "ExchangeBidHouseItemRemoveOk";
      
      public static const ExchangeBidHouseGenericItemAdded:String = "ExchangeBidHouseGenericItemAdded";
      
      public static const ExchangeBidHouseGenericItemRemoved:String = "ExchangeBidHouseGenericItemRemoved";
      
      public static const ExchangeTypesItemsExchangerDescriptionForUser:String = "ExchangeTypesItemsExchangerDescriptionForUser";
      
      public static const ExchangeTypesExchangerDescriptionForUser:String = "ExchangeTypesExchangerDescriptionForUser";
      
      public static const ExchangeBidHouseInListAdded:String = "ExchangeBidHouseInListAdded";
      
      public static const SellerObjectListUpdate:String = "SellerObjectListUpdate";
      
      public static const BidObjectTypeListUpdate:String = "BidObjectTypeListUpdate";
      
      public static const BidObjectListUpdate:String = "BidObjectListUpdate";
      
      public static const BidHouseBuyResult:String = "BidHouseBuyResult";
      
      public static const BidHouseSelectItemFromRecipe:String = "BidHouseSelectItemFromRecipe";
      
      public static const PricesUpdate:String = "PricesUpdate";
      
      public static const SwitchingBidMode:String = "SwitchingBidMode";
      
      public static const ExchangeStartOkNpcShop:String = "ExchangeStartOkNpcShop";
       
      
      public function ExchangeHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(ExchangeError);
         Hook.createHook(ExchangeLeave);
         Hook.createHook(ExchangeObjectModified);
         Hook.createHook(ExchangeObjectAdded);
         Hook.createHook(ExchangeObjectRemoved);
         Hook.createHook(ExchangeObjectListModified);
         Hook.createHook(ExchangeObjectListAdded);
         Hook.createHook(ExchangeObjectListRemoved);
         Hook.createHook(ExchangeKamaModified);
         Hook.createHook(ExchangePodsModified);
         Hook.createHook(ExchangeStartOkNpcTrade);
         Hook.createHook(ExchangeRequestCharacterFromMe);
         Hook.createHook(ExchangeRequestCharacterToMe);
         Hook.createHook(ExchangeStarted);
         Hook.createHook(ExchangeBankStarted);
         Hook.createHook(ExchangeBankStartedWithStorage);
         Hook.createHook(ExchangeStartedType);
         Hook.createHook(AskExchangeMoveObject);
         Hook.createHook(ExchangeIsReady);
         Hook.createHook(ExchangeWeight);
         Hook.createHook(ExchangeStartOkHumanVendor);
         Hook.createHook(ExchangeShopStockStarted);
         Hook.createHook(ExchangeShopStockMovementUpdated);
         Hook.createHook(ExchangeShopStockMouvmentRemoveOk);
         Hook.createHook(ExchangeShopStockUpdate);
         Hook.createHook(ExchangeShopStockAddQuantity);
         Hook.createHook(ExchangeShopStockRemoveQuantity);
         Hook.createHook(ClickItemInventory);
         Hook.createHook(DisplayAssociatedRunes);
         Hook.createHook(ClickItemShopHV);
         Hook.createHook(ExchangeReplyTaxVendor);
         Hook.createHook(ExchangeShopStockMovementRemoved);
         Hook.createHook(CloseStore);
         Hook.createHook(ClickItemStore);
         Hook.createHook(SellOk);
         Hook.createHook(BuyOk);
         Hook.createHook(ExchangeStartedBidSeller);
         Hook.createHook(ExchangeStartedBidBuyer);
         Hook.createHook(ExchangeBidPrice);
         Hook.createHook(ExchangeBidPriceForSeller);
         Hook.createHook(ExchangeBidSearchOk);
         Hook.createHook(OpenBidHouse);
         Hook.createHook(ExchangeBidHouseItemAddOk);
         Hook.createHook(ExchangeBidHouseItemRemoveOk);
         Hook.createHook(ExchangeBidHouseGenericItemAdded);
         Hook.createHook(ExchangeBidHouseGenericItemRemoved);
         Hook.createHook(ExchangeTypesItemsExchangerDescriptionForUser);
         Hook.createHook(ExchangeTypesExchangerDescriptionForUser);
         Hook.createHook(ExchangeBidHouseInListAdded);
         Hook.createHook(SellerObjectListUpdate);
         Hook.createHook(BidObjectTypeListUpdate);
         Hook.createHook(BidObjectListUpdate);
         Hook.createHook(BidHouseBuyResult);
         Hook.createHook(BidHouseSelectItemFromRecipe);
         Hook.createHook(PricesUpdate);
         Hook.createHook(SwitchingBidMode);
         Hook.createHook(ExchangeStartOkNpcShop);
      }
   }
}

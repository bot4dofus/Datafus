package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class ExternalGameHookList
   {
      
      public static const HaapiAuthError:String = "HaapiAuthError";
      
      public static const HaapiAuthToken:String = "HaapiAuthToken";
      
      public static const DofusShopMoney:String = "DofusShopMoney";
      
      public static const DofusShopHome:String = "DofusShopHome";
      
      public static const DofusShopArticlesList:String = "DofusShopArticlesList";
      
      public static const DofusShopArticlesSearchList:String = "DofusShopArticlesSearchList";
      
      public static const DofusShopCurrentSelectedArticle:String = "DofusShopCurrentSelectedArticle";
      
      public static const DofusShopDirectBuyClick:String = "DofusShopDirectBuyClick";
      
      public static const DofusShopIndirectBuyClick:String = "DofusShopIndirectBuyClick";
      
      public static const DofusShopValidBuy:String = "DofusShopValidBuy";
      
      public static const DofusShopSwitchTab:String = "DofusShopSwitchTab";
      
      public static const DofusShopWebRedirect:String = "DofusShopWebRedirect";
      
      public static const DofusShopError:String = "DofusShopError";
      
      public static const OpenWebService:String = "OpenWebService";
      
      public static const OpenSharePopup:String = "OpenSharePopup";
      
      public static const DofusShopDeleteArticle:String = "DofusShopDeleteArticle";
      
      public static const DofusShopBuySuccess:String = "DofusShopBuySuccess";
      
      public static const DofusShopCurrentArticle:String = "DofusShopCurrentArticle";
      
      public static const DofusShopOpenCategory:String = "DofusShopOpenCategory";
      
      public static const DofusBakAverageRate:String = "DofusBakAverageRate";
      
      public static const DofusBakKamasOffers:String = "DofusBakKamasOffers";
      
      public static const DofusBakOgrinesOffers:String = "DofusBakOgrinesOffers";
      
      public static const DofusBakAccountBids:String = "DofusBakAccountBids";
      
      public static const DofusBakLinkedOgrines:String = "DofusBakLinkedOgrines";
      
      public static const DofusBakKamasAmount:String = "DofusBakKamasAmount";
      
      public static const DofusBakKamasBufferList:String = "DofusBakKamasBufferList";
      
      public static const DofusBakBuyValidation:String = "DofusBakBuyValidation";
      
      public static const DofusBakConfirmation:String = "DofusBakConfirmation";
      
      public static const DofusBakError:String = "DofusBakError";
      
      public static const DofusBakCreateBidSuccess:String = "DofusBakCreateBidSuccess";
      
      public static const DofusBakTransferSuccess:String = "DofusBakTransferSuccess";
      
      public static const CodesAndGiftErrorCode:String = "CodesAndGiftErrorCode";
      
      public static const CodesAndGiftCodeSuccess:String = "CodesAndGiftCodeSuccess";
      
      public static const CodesAndGiftUpdatePurchaseList:String = "CodesAndGiftUpdatePurchaseList";
      
      public static const CodesAndGiftConsumeMultipleKardSuccess:String = "CodesAndGiftConsumeMultipleKardSuccess";
      
      public static const CodesAndGiftConsumeSimpleKardSuccess:String = "CodesAndGiftConsumeSimpleKardSuccess";
      
      public static const CodesAndGiftNoMoreMysteryBox:String = "CodesAndGiftNoMoreMysteryBox";
      
      public static const CodesAndGiftNotificationValue:String = "CodesAndGiftNotificationValue";
      
      public static const CodesAndGiftOpenBoxStats:String = "CodesAndGiftOpenBoxStats";
      
      public static const BakTabStats:String = "BakTabStats";
      
      public static const BakTimeout:String = "BakTimeout";
      
      public static const CodesAndGiftGetArticlesStats:String = "CodesAndGiftGetArticlesStats";
      
      public static const CodesAndGiftGiftAssigned:String = "CodesAndGiftGiftAssigned";
      
      public static const ReportResponse:String = "ReportResponse";
       
      
      public function ExternalGameHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(HaapiAuthError);
         Hook.createHook(HaapiAuthToken);
         Hook.createHook(DofusShopMoney);
         Hook.createHook(DofusShopHome);
         Hook.createHook(DofusShopArticlesList);
         Hook.createHook(DofusShopArticlesSearchList);
         Hook.createHook(DofusShopCurrentSelectedArticle);
         Hook.createHook(DofusShopDirectBuyClick);
         Hook.createHook(DofusShopIndirectBuyClick);
         Hook.createHook(DofusShopValidBuy);
         Hook.createHook(DofusShopSwitchTab);
         Hook.createHook(DofusShopWebRedirect);
         Hook.createHook(DofusShopError);
         Hook.createHook(OpenWebService);
         Hook.createHook(OpenSharePopup);
         Hook.createHook(DofusShopDeleteArticle);
         Hook.createHook(DofusShopBuySuccess);
         Hook.createHook(DofusShopCurrentArticle);
         Hook.createHook(DofusShopOpenCategory);
         Hook.createHook(DofusBakAverageRate);
         Hook.createHook(DofusBakKamasOffers);
         Hook.createHook(DofusBakOgrinesOffers);
         Hook.createHook(DofusBakAccountBids);
         Hook.createHook(DofusBakLinkedOgrines);
         Hook.createHook(DofusBakKamasAmount);
         Hook.createHook(DofusBakKamasBufferList);
         Hook.createHook(DofusBakBuyValidation);
         Hook.createHook(DofusBakConfirmation);
         Hook.createHook(DofusBakError);
         Hook.createHook(DofusBakCreateBidSuccess);
         Hook.createHook(DofusBakTransferSuccess);
         Hook.createHook(CodesAndGiftErrorCode);
         Hook.createHook(CodesAndGiftCodeSuccess);
         Hook.createHook(CodesAndGiftUpdatePurchaseList);
         Hook.createHook(CodesAndGiftConsumeMultipleKardSuccess);
         Hook.createHook(CodesAndGiftConsumeSimpleKardSuccess);
         Hook.createHook(CodesAndGiftNoMoreMysteryBox);
         Hook.createHook(CodesAndGiftNotificationValue);
         Hook.createHook(CodesAndGiftOpenBoxStats);
         Hook.createHook(BakTabStats);
         Hook.createHook(CodesAndGiftGetArticlesStats);
         Hook.createHook(CodesAndGiftGiftAssigned);
         Hook.createHook(BakTimeout);
         Hook.createHook(ReportResponse);
      }
   }
}

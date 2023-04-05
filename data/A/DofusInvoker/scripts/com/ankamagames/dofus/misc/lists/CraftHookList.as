package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class CraftHookList
   {
      
      public static const DoNothing:String = "DoNothing";
      
      public static const ExchangeStartOkMultiCraft:String = "ExchangeStartOkMultiCraft";
      
      public static const ExchangeStartOkCraft:String = "ExchangeStartOkCraft";
      
      public static const ExchangeCraftResult:String = "ExchangeCraftResult";
      
      public static const PlayerListUpdate:String = "PlayerListUpdate";
      
      public static const OtherPlayerListUpdate:String = "OtherPlayerListUpdate";
      
      public static const PaymentCraftList:String = "PaymentCraftList";
      
      public static const BagItemAdded:String = "BagItemAdded";
      
      public static const BagItemModified:String = "BagItemModified";
      
      public static const BagItemDeleted:String = "BagItemDeleted";
      
      public static const ExchangeItemAutoCraftStoped:String = "ExchangeItemAutoCraftStoped";
      
      public static const ExchangeMultiCraftCrafterCanUseHisRessources:String = "ExchangeMultiCraftCrafterCanUseHisRessources";
      
      public static const ExchangeMultiCraftRequest:String = "ExchangeMultiCraftRequest";
      
      public static const ExchangeReplayCountModified:String = "ExchangeReplayCountModified";
      
      public static const RecipeSelected:String = "RecipeSelected";
      
      public static const RecipesListRefreshed:String = "RecipesListRefreshed";
      
      public static const JobLevelUp:String = "JobLevelUp";
      
      public static const JobsExpUpdated:String = "JobsExpUpdated";
      
      public static const JobsExpOtherPlayerUpdated:String = "JobsExpOtherPlayerUpdated";
      
      public static const ExchangeStartOkJobIndex:String = "ExchangeStartOkJobIndex";
      
      public static const CrafterDirectoryListUpdate:String = "CrafterDirectoryListUpdate";
      
      public static const CrafterDirectorySettings:String = "CrafterDirectorySettings";
      
      public static const JobCrafterContactLook:String = "JobCrafterContactLook";
      
      public static const JobAllowMultiCraftRequest:String = "JobAllowMultiCraftRequest";
      
      public static const ExchangeStartOkRunesTrade:String = "ExchangeStartOkRunesTrade";
      
      public static const ExchangeStartOkRecycleTrade:String = "ExchangeStartOkRecycleTrade";
      
      public static const ItemMagedResult:String = "ItemMagedResult";
      
      public static const DecraftResult:String = "DecraftResult";
      
      public static const RecycleResult:String = "RecycleResult";
      
      public static const JobSelected:String = "JobSelected";
      
      public static const JobBookSubscription:String = "JobBookSubscription";
       
      
      public function CraftHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(DoNothing);
         Hook.createHook(ExchangeStartOkMultiCraft);
         Hook.createHook(ExchangeStartOkCraft);
         Hook.createHook(ExchangeCraftResult);
         Hook.createHook(PlayerListUpdate);
         Hook.createHook(OtherPlayerListUpdate);
         Hook.createHook(PaymentCraftList);
         Hook.createHook(BagItemAdded);
         Hook.createHook(BagItemModified);
         Hook.createHook(BagItemDeleted);
         Hook.createHook(ExchangeItemAutoCraftStoped);
         Hook.createHook(ExchangeMultiCraftCrafterCanUseHisRessources);
         Hook.createHook(ExchangeMultiCraftRequest);
         Hook.createHook(ExchangeReplayCountModified);
         Hook.createHook(RecipeSelected);
         Hook.createHook(RecipesListRefreshed);
         Hook.createHook(JobLevelUp);
         Hook.createHook(JobsExpUpdated);
         Hook.createHook(JobsExpOtherPlayerUpdated);
         Hook.createHook(ExchangeStartOkJobIndex);
         Hook.createHook(CrafterDirectoryListUpdate);
         Hook.createHook(CrafterDirectorySettings);
         Hook.createHook(JobCrafterContactLook);
         Hook.createHook(JobAllowMultiCraftRequest);
         Hook.createHook(ExchangeStartOkRunesTrade);
         Hook.createHook(ExchangeStartOkRecycleTrade);
         Hook.createHook(ItemMagedResult);
         Hook.createHook(DecraftResult);
         Hook.createHook(RecycleResult);
         Hook.createHook(JobSelected);
         Hook.createHook(JobBookSubscription);
      }
   }
}

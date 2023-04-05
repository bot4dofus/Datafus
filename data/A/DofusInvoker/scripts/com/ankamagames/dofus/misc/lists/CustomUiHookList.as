package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class CustomUiHookList
   {
      
      public static const FoldAll:String = "FoldAll";
      
      public static const SpellMovementAllowed:String = "SpellMovementAllowed";
      
      public static const ShortcutsMovementAllowed:String = "ShortcutsMovementAllowed";
      
      public static const FlagAdded:String = "FlagAdded";
      
      public static const FlagRemoved:String = "FlagRemoved";
      
      public static const MapHintsFilter:String = "MapHintsFilter";
      
      public static const InsertHyperlink:String = "InsertHyperlink";
      
      public static const OpeningContextMenu:String = "OpeningContextMenu";
      
      public static const OpenReport:String = "OpenReport";
      
      public static const RefreshTips:String = "RefreshTips";
      
      public static const SwitchBannerTab:String = "SwitchBannerTab";
      
      public static const StopCinematic:String = "StopCinematic";
      
      public static const ActivateSound:String = "ActivateSound";
      
      public static const StorageFilterUpdated:String = "StorageFilterUpdated";
      
      public static const ClosingInventory:String = "ClosingInventory";
      
      public static const AddBannerButton:String = "AddBannerButton";
      
      public static const ClientUIOpened:String = "ClientUIOpened";
      
      public static const PreviewBuildSpellBar:String = "PreviewBuildSpellBar";
      
      public static const ShowTheoreticalEffects:String = "ShowTheoreticalEffects";
       
      
      public function CustomUiHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(FoldAll);
         Hook.createHook(SpellMovementAllowed);
         Hook.createHook(ShortcutsMovementAllowed);
         Hook.createHook(FlagAdded);
         Hook.createHook(FlagRemoved);
         Hook.createHook(MapHintsFilter);
         Hook.createHook(InsertHyperlink);
         Hook.createHook(OpeningContextMenu);
         Hook.createHook(OpenReport);
         Hook.createHook(RefreshTips);
         Hook.createHook(SwitchBannerTab);
         Hook.createHook(StopCinematic);
         Hook.createHook(ActivateSound);
         Hook.createHook(StorageFilterUpdated);
         Hook.createHook(ClosingInventory);
         Hook.createHook(AddBannerButton);
         Hook.createHook(ClientUIOpened);
         Hook.createHook(PreviewBuildSpellBar);
         Hook.createHook(ShowTheoreticalEffects);
      }
   }
}

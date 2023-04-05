package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class MountHookList
   {
      
      public static const MountSterilized:String = "MountSterilized";
      
      public static const MountRenamed:String = "MountRenamed";
      
      public static const MountXpRatio:String = "MountXpRatio";
      
      public static const MountSet:String = "MountSet";
      
      public static const MountUnSet:String = "MountUnSet";
      
      public static const MountRiding:String = "MountRiding";
      
      public static const CertificateMountData:String = "CertificateMountData";
      
      public static const PaddockedMountData:String = "PaddockedMountData";
      
      public static const MountEquipedError:String = "MountEquipedError";
      
      public static const ExchangeStartOkMount:String = "ExchangeStartOkMount";
      
      public static const MountStableUpdate:String = "MountStableUpdate";
      
      public static const PaddockSellBuyDialog:String = "PaddockSellBuyDialog";
      
      public static const MountReleased:String = "MountReleased";
      
      public static const ViewMountAncestors:String = "ViewMountAncestors";
       
      
      public function MountHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(MountSterilized);
         Hook.createHook(MountRenamed);
         Hook.createHook(MountXpRatio);
         Hook.createHook(MountSet);
         Hook.createHook(MountUnSet);
         Hook.createHook(MountRiding);
         Hook.createHook(CertificateMountData);
         Hook.createHook(PaddockedMountData);
         Hook.createHook(MountEquipedError);
         Hook.createHook(ExchangeStartOkMount);
         Hook.createHook(MountStableUpdate);
         Hook.createHook(PaddockSellBuyDialog);
         Hook.createHook(MountReleased);
         Hook.createHook(ViewMountAncestors);
      }
   }
}

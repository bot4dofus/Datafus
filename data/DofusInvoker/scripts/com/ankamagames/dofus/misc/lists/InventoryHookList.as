package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class InventoryHookList
   {
      
      public static const StorageInventoryContent:String = "StorageInventoryContent";
      
      public static const StorageObjectUpdate:String = "StorageObjectUpdate";
      
      public static const StorageKamasUpdate:String = "StorageKamasUpdate";
      
      public static const StorageObjectRemove:String = "StorageObjectRemove";
      
      public static const EquipmentObjectMove:String = "EquipmentObjectMove";
      
      public static const SetUpdate:String = "SetUpdate";
      
      public static const InventoryWeight:String = "InventoryWeight";
      
      public static const ObjectAdded:String = "ObjectAdded";
      
      public static const ObjectDeleted:String = "ObjectDeleted";
      
      public static const ObjectQuantity:String = "ObjectQuantity";
      
      public static const ObjectModified:String = "ObjectModified";
      
      public static const ObjectSelected:String = "ObjectSelected";
      
      public static const StorageViewContent:String = "StorageViewContent";
      
      public static const BankViewContent:String = "BankViewContent";
      
      public static const EquipmentViewContent:String = "EquipmentViewContent";
      
      public static const RoleplayBuffViewContent:String = "RoleplayBuffViewContent";
      
      public static const ShortcutBarViewContent:String = "ShortcutBarViewContent";
      
      public static const InventoryContent:String = "InventoryContent";
      
      public static const KamasUpdate:String = "KamasUpdate";
      
      public static const OpenLivingObject:String = "OpenLivingObject";
      
      public static const WeaponUpdate:String = "WeaponUpdate";
      
      public static const PresetsUpdate:String = "PresetsUpdate";
      
      public static const PresetSelected:String = "PresetSelected";
      
      public static const PresetUsed:String = "PresetUsed";
      
      public static const PresetError:String = "PresetError";
      
      public static const AccessoryPreview:String = "AccessoryPreview";
      
      public static const SpellVariantActivated:String = "SpellVariantActivated";
       
      
      public function InventoryHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(StorageInventoryContent);
         Hook.createHook(StorageObjectUpdate);
         Hook.createHook(StorageKamasUpdate);
         Hook.createHook(StorageObjectRemove);
         Hook.createHook(EquipmentObjectMove);
         Hook.createHook(SetUpdate);
         Hook.createHook(InventoryWeight);
         Hook.createHook(ObjectAdded);
         Hook.createHook(ObjectDeleted);
         Hook.createHook(ObjectQuantity);
         Hook.createHook(ObjectModified);
         Hook.createHook(ObjectSelected);
         Hook.createHook(StorageViewContent);
         Hook.createHook(BankViewContent);
         Hook.createHook(EquipmentViewContent);
         Hook.createHook(RoleplayBuffViewContent);
         Hook.createHook(ShortcutBarViewContent);
         Hook.createHook(InventoryContent);
         Hook.createHook(KamasUpdate);
         Hook.createHook(OpenLivingObject);
         Hook.createHook(WeaponUpdate);
         Hook.createHook(PresetsUpdate);
         Hook.createHook(PresetSelected);
         Hook.createHook(PresetUsed);
         Hook.createHook(PresetError);
         Hook.createHook(AccessoryPreview);
         Hook.createHook(SpellVariantActivated);
      }
   }
}

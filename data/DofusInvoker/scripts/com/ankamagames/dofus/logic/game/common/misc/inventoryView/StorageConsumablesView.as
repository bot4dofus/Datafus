package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class StorageConsumablesView extends StorageGenericView
   {
       
      
      public function StorageConsumablesView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "storageConsumables";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return super.isListening(item) && item.category == ItemCategoryEnum.CONSUMABLES_CATEGORY;
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.kamas]);
         }
      }
   }
}

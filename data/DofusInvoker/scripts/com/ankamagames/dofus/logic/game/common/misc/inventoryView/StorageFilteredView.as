package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class StorageFilteredView extends StorageGenericView
   {
       
      
      public function StorageFilteredView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "storageFiltered";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return super.isListening(item) && StorageOptionManager.getInstance().hasFilter() && item.typeId == StorageOptionManager.getInstance().filter;
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

package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class BankCosmeticsView extends StorageGenericView
   {
       
      
      public function BankCosmeticsView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "bankCosmetics";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return super.isListening(item) && item.category == ItemCategoryEnum.COSMETICS_CATEGORY;
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().bankCategory == ItemCategoryEnum.COSMETICS_CATEGORY && !StorageOptionManager.getInstance().hasBankFilter())
         {
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.kamas]);
         }
      }
   }
}

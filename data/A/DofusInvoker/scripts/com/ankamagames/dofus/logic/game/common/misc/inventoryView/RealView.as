package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class RealView extends ListView
   {
       
      
      public function RealView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "real";
      }
      
      override public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         super.addItem(item,invisible,needUpdateView);
         _hookLock.addHook(InventoryHookList.ObjectAdded,[item]);
         if(needUpdateView)
         {
            this.updateView();
         }
      }
      
      override public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         super.removeItem(item,invisible);
         _hookLock.addHook(InventoryHookList.ObjectDeleted,[item]);
         this.updateView();
      }
      
      override public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         super.modifyItem(item,oldItem,invisible);
         _hookLock.addHook(InventoryHookList.ObjectModified,[item]);
         if(item.quantity != oldItem.quantity)
         {
            _hookLock.addHook(InventoryHookList.ObjectQuantity,[item,item.quantity,oldItem.quantity]);
         }
         this.updateView();
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return true;
      }
      
      override public function updateView() : void
      {
         _hookLock.addHook(InventoryHookList.InventoryContent,[content,InventoryManager.getInstance().inventory.kamas]);
      }
   }
}

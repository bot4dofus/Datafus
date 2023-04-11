package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class StorageBidHouseFilterView extends StorageGenericView
   {
       
      
      private var _allowedTypes:Vector.<uint>;
      
      private var _maxItemLevel:uint;
      
      private var _parent:IStorageView;
      
      public function StorageBidHouseFilterView(hookLock:HookLock, parentView:IStorageView, allowedTypes:Vector.<uint>, maxItemLevel:uint)
      {
         super(hookLock);
         this._allowedTypes = allowedTypes;
         this._maxItemLevel = maxItemLevel;
         this._parent = parentView;
      }
      
      override public function get name() : String
      {
         return "storageBidHouseFilter";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         var data:Item = Item.getItemById(item.objectGID);
         return this._parent.isListening(item) && super.isListening(item) && data.level <= this._maxItemLevel && this._allowedTypes.indexOf(data.typeId) != -1;
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView == this)
         {
            _hookLock.addHook(InventoryHookList.StorageViewContent,[content,InventoryManager.getInstance().inventory.kamas]);
         }
      }
      
      public function set parent(view:IStorageView) : void
      {
         this._parent = view;
      }
      
      public function get parent() : IStorageView
      {
         return this._parent;
      }
   }
}

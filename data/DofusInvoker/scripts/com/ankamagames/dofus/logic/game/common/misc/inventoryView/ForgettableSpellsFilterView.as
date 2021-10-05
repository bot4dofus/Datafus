package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.optionalFeatures.ForgettableSpell;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import flash.utils.Dictionary;
   
   public class ForgettableSpellsFilterView extends StorageGenericView
   {
       
      
      private var _allowedTypes:Vector.<uint>;
      
      private var _parent:IStorageView;
      
      private var _isHideLearnedSpells:Boolean = false;
      
      public function ForgettableSpellsFilterView(hookLock:HookLock, parentView:IStorageView, allowedTypes:Vector.<uint>, isHideLearnedSpells:Boolean)
      {
         super(hookLock);
         this._allowedTypes = allowedTypes;
         this._parent = parentView;
         this._isHideLearnedSpells = isHideLearnedSpells;
      }
      
      override public function get name() : String
      {
         return "forgettableSpellsFilter";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         if(this._parent === null)
         {
            return false;
         }
         var data:Item = Item.getItemById(item.objectGID);
         return Boolean(this._parent.isListening(item) && super.isListening(item) && this._allowedTypes.indexOf(data.typeId) !== -1);
      }
      
      override public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         if(item !== null && this.isItemFiltered(item.id))
         {
            return;
         }
         super.addItem(item,invisible,needUpdateView);
      }
      
      override public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         if(item !== null && this.isItemFiltered(item.id))
         {
            return;
         }
         super.modifyItem(item,oldItem,invisible);
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().currentStorageView === this)
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
      
      private function isItemFiltered(scrollId:int) : Boolean
      {
         var playerForgettableSpells:Dictionary = null;
         if(!this._isHideLearnedSpells)
         {
            return false;
         }
         var forgettableSpell:ForgettableSpell = ForgettableSpell.getForgettableSpellByScrollId(scrollId);
         if(forgettableSpell !== null)
         {
            playerForgettableSpells = PlayedCharacterManager.getInstance().playerForgettableSpellDictionary;
            if(forgettableSpell.id in playerForgettableSpells)
            {
               return true;
            }
         }
         return false;
      }
   }
}

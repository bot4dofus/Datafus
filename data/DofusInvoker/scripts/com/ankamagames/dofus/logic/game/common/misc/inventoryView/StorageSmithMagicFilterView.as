package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   
   public class StorageSmithMagicFilterView extends StorageGenericView
   {
       
      
      private var _skill:Skill;
      
      private var _parent:IStorageView;
      
      private var _listeningItemTypes:Array;
      
      public function StorageSmithMagicFilterView(hookLock:HookLock, parentView:IStorageView, skill:Skill)
      {
         this._listeningItemTypes = [DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE,DataEnum.ITEM_TYPE_SMITHMAGIC_POTION,DataEnum.ITEM_TYPE_SMITHMAGIC_ORB,DataEnum.ITEM_TYPE_SMITHMAGIC_TRANSCENDANCE_RUNE,DataEnum.ITEM_TYPE_SMITHMAGIC_CORRUPTION_RUNE];
         super(hookLock);
         this._skill = skill;
         this._parent = parentView;
      }
      
      override public function get name() : String
      {
         return "storageSmithMagicFilter";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return this._parent.isListening(item) && super.isListening(item) && (this._skill.modifiableItemTypeIds.indexOf(item.typeId) != -1 || this._listeningItemTypes.indexOf(item.typeId) != -1) || item.objectGID == DataEnum.ITEM_GID_SIGNATURE_RUNE;
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

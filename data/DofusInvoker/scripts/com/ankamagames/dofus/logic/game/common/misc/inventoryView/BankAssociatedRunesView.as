package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   
   public class BankAssociatedRunesView extends StorageGenericView
   {
       
      
      private var _item:ItemWrapper;
      
      public function BankAssociatedRunesView(hookLock:HookLock, item:ItemWrapper)
      {
         super(hookLock);
         this._item = item;
      }
      
      override public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         var tempContent:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         for each(item in items)
         {
            if(this.isListening(item))
            {
               tempContent.push(item);
            }
         }
         if(tempContent.length > 0)
         {
            _content = new Vector.<ItemWrapper>();
            _sortedContent = new Vector.<ItemWrapper>();
            for each(item in tempContent)
            {
               this.addItem(item,0,false);
            }
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.kamas]);
         }
      }
      
      override public function get name() : String
      {
         return "bankAssociatedRunes";
      }
      
      override public function isListening(rune:ItemWrapper) : Boolean
      {
         var itemEffect:EffectInstance = null;
         var runeEffect:EffectInstance = null;
         var runeEffects:Vector.<EffectInstance> = null;
         var itemEffects:Vector.<EffectInstance> = this._item.effects.concat(this._item.possibleEffects);
         if(rune.typeId != DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
         {
            return false;
         }
         runeEffects = rune.effects.concat(rune.possibleEffects);
         for each(itemEffect in itemEffects)
         {
            for each(runeEffect in runeEffects)
            {
               if(Effect.getEffectById(itemEffect.effectId).characteristic == Effect.getEffectById(runeEffect.effectId).characteristic)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         super.addItem(item,invisible,needUpdateView);
      }
      
      override public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         super.modifyItem(item,oldItem,invisible);
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().bankCategory == ItemCategoryEnum.RESOURCES_CATEGORY && StorageOptionManager.getInstance().bankFilter == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
         {
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.kamas],true);
         }
      }
      
      override public function sortFields() : Array
      {
         return StorageOptionManager.getInstance().sortBankFields;
      }
      
      override public function sortRevert() : Boolean
      {
         return StorageOptionManager.getInstance().sortBankRevert;
      }
   }
}

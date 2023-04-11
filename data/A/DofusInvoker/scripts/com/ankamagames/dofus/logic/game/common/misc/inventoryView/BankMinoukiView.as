package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.data.I18n;
   
   public class BankMinoukiView extends StorageGenericView
   {
       
      
      public function BankMinoukiView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "bankMinouki";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return super.isListening(item) && item.category == ItemCategoryEnum.RESOURCES_CATEGORY && item.typeId == ItemCategoryEnum.ECAFLIP_CARD_CATEGORY;
      }
      
      override public function updateView() : void
      {
         super.updateView();
         if(StorageOptionManager.getInstance().currentBankView == this)
         {
            _hookLock.addHook(InventoryHookList.BankViewContent,[content,InventoryManager.getInstance().bankInventory.kamas]);
         }
      }
      
      override public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         var type:int = 0;
         var clone:ItemWrapper = item.clone();
         clone.quantity -= invisible;
         _content.unshift(clone);
         if(_sortedContent)
         {
            _sortedContent.unshift(clone);
         }
         var cardTypes:Array = this.getMinoukiCardTypes(item);
         for each(type in cardTypes)
         {
            if(_typesQty[type] && _typesQty[type] > 0)
            {
               ++_typesQty[type];
            }
            else
            {
               _typesQty[type] = 1;
               _types[type] = {
                  "name":I18n.getUiText("ui.customEffect." + type),
                  "id":type
               };
            }
         }
         if(needUpdateView)
         {
            this.updateView();
         }
      }
      
      override public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         var effect:EffectInstance = null;
         var idx:int = getItemIndex(item);
         if(idx == -1)
         {
            return;
         }
         for each(effect in item.possibleEffects)
         {
            if(effect.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               if(_typesQty[effect.parameter2] && _typesQty[effect.parameter2] > 0)
               {
                  --_typesQty[effect.parameter2];
                  if(_typesQty[effect.parameter2] == 0)
                  {
                     delete _types[effect.parameter2];
                  }
               }
            }
         }
         _content.splice(idx,1);
         if(_sortedContent)
         {
            idx = getItemIndex(item,_sortedContent);
            if(idx != -1)
            {
               _sortedContent.splice(idx,1);
            }
         }
         this.updateView();
      }
      
      private function getMinoukiCardTypes(item:ItemWrapper) : Array
      {
         var effect:EffectInstance = null;
         var types:Array = [];
         for each(effect in item.possibleEffects)
         {
            if(effect.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               types.push(effect.parameter2);
            }
         }
         return types;
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

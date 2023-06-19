package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   
   public class BankMinoukiFilteredView extends BankMinoukiView
   {
       
      
      public function BankMinoukiFilteredView(hookLock:HookLock)
      {
         super(hookLock);
      }
      
      override public function get name() : String
      {
         return "bankMinoukiFiltered";
      }
      
      override public function isListening(item:ItemWrapper) : Boolean
      {
         return super.isListening(item) && StorageOptionManager.getInstance().hasBankFilter() && this.hasMinoukiEffect(item,StorageOptionManager.getInstance().bankFilter);
      }
      
      private function hasMinoukiEffect(item:ItemWrapper, filter:int) : Boolean
      {
         var effect:EffectInstance = null;
         for each(effect in item.possibleEffects)
         {
            if(effect.effectId == ActionIds.ACTION_ITEM_CUSTOM_EFFECT)
            {
               if(effect.parameter2 == filter)
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}

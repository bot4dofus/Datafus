package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   
   public class ForgettableModstersFilterView extends ForgettableSpellsFilterView
   {
       
      
      public function ForgettableModstersFilterView(hookLock:HookLock, parentView:IStorageView, allowedTypes:Vector.<uint>, isHideLearnedSpells:Boolean)
      {
         super(hookLock,parentView,allowedTypes,isHideLearnedSpells);
      }
      
      override public function get name() : String
      {
         return "forgettableModstersFilter";
      }
   }
}

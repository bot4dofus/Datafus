package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class BonusSetItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function BonusSetItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = I18n.getUiText("ui.criterion.setBonus");
         return readableCriterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function get isRespected() : Boolean
      {
         return _operator.compare(uint(this.getCriterion()),_criterionValue);
      }
      
      override public function clone() : IItemCriterion
      {
         return new BonusSetItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var iw:ItemWrapper = null;
         var bonusPerSet:int = 0;
         var nbBonus:int = 0;
         var sets:Dictionary = new Dictionary();
         for each(iw in InventoryManager.getInstance().inventory.getView("equipment").content)
         {
            if(iw)
            {
               if(iw.itemSetId > 0)
               {
                  if(sets[iw.itemSetId] > 0)
                  {
                     sets[iw.itemSetId] += 1;
                  }
                  if(sets[iw.itemSetId] == -1)
                  {
                     sets[iw.itemSetId] = 1;
                  }
                  if(!sets[iw.itemSetId])
                  {
                     sets[iw.itemSetId] = -1;
                  }
               }
            }
         }
         for each(bonusPerSet in sets)
         {
            if(bonusPerSet > 0)
            {
               nbBonus += bonusPerSet;
            }
         }
         return nbBonus;
      }
   }
}

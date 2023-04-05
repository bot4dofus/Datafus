package com.ankamagames.dofus.datacenter.bonus
{
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusQuestCategoryCriterion;
   
   public class QuestBonus extends Bonus
   {
       
      
      public function QuestBonus()
      {
         super();
      }
      
      override public function isRespected(... pArgs) : Boolean
      {
         var criterionId:int = 0;
         var criterion:BonusCriterion = null;
         for each(criterionId in criterionsIds)
         {
            criterion = BonusCriterion.getBonusCriterionById(criterionId);
            if(pArgs.length > 0 && criterion is BonusQuestCategoryCriterion && criterion.value == pArgs[0])
            {
               return true;
            }
         }
         return false;
      }
   }
}

package com.ankamagames.dofus.datacenter.bonus
{
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusAreaCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusMonsterCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusMonsterFamilyCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusSubAreaCriterion;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class MonsterLightBonus extends Bonus
   {
       
      
      public function MonsterLightBonus()
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
            if(pArgs.length > 0 && criterion is BonusMonsterCriterion && criterion.value == pArgs[0] || pArgs.length > 0 && criterion is BonusMonsterFamilyCriterion && criterion.value == pArgs[0] || criterion is BonusAreaCriterion && criterion.value == PlayedCharacterManager.getInstance().currentSubArea.areaId || criterion is BonusSubAreaCriterion && criterion.value == PlayedCharacterManager.getInstance().currentSubArea.id)
            {
               return true;
            }
         }
         return false;
      }
   }
}

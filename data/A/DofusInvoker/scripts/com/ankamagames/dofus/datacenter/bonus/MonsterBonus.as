package com.ankamagames.dofus.datacenter.bonus
{
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusCriterion;
   import com.ankamagames.dofus.datacenter.bonus.criterion.BonusEquippedItemCriterion;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   
   public class MonsterBonus extends MonsterLightBonus
   {
       
      
      public function MonsterBonus()
      {
         super();
      }
      
      override public function isRespected(... pArgs) : Boolean
      {
         var criterionId:int = 0;
         var criterion:BonusCriterion = null;
         var item:ItemWrapper = null;
         var result:Boolean = super.isRespected(pArgs);
         if(!result)
         {
            for each(criterionId in criterionsIds)
            {
               criterion = BonusCriterion.getBonusCriterionById(criterionId);
               if(criterion is BonusEquippedItemCriterion)
               {
                  for each(item in PlayedCharacterManager.getInstance().inventory)
                  {
                     if(item.position <= CharacterInventoryPositionEnum.ACCESSORY_POSITION_SHIELD && item.objectGID == criterion.value)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return result;
      }
   }
}

package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AllianceAvAItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AllianceAvAItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var aggressable:int = 0;
         var subArea:SubArea = null;
         var currentPrism:PrismSubAreaWrapper = null;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            aggressable = PlayedCharacterManager.getInstance().characteristics.alignmentInfos.aggressable;
            if(aggressable != AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE && aggressable != AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE)
            {
               return false;
            }
            subArea = PlayedCharacterManager.getInstance().currentSubArea;
            currentPrism = AllianceFrame.getInstance().getPrismSubAreaById(subArea.id);
            if(!currentPrism || currentPrism.mapId == -1)
            {
               return false;
            }
            if(currentPrism.state != PrismStateEnum.PRISM_STATE_VULNERABLE)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            readableCriterion = I18n.getUiText("ui.criterion.allianceAvA");
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new AllianceAvAItemCriterion(this.basicText);
      }
   }
}

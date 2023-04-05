package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubareaLevelItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function SubareaLevelItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
            case ItemCriterionOperator.DIFFERENT:
            case ItemCriterionOperator.SUPERIOR:
            case ItemCriterionOperator.INFERIOR:
               return super.isRespected;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         var subArea:SubArea = PlayedCharacterManager.getInstance().currentSubArea;
         if(!subArea)
         {
            return "error on subareaLevelItemCriterion";
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.subareaLevel",[_criterionValue]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.notSubareaLevel",[_criterionValue]);
               break;
            case ItemCriterionOperator.INFERIOR:
               readableCriterion = I18n.getUiText("ui.criterion.subareaLevelInferior",[_criterionValue]);
               break;
            case ItemCriterionOperator.SUPERIOR:
               readableCriterion = I18n.getUiText("ui.criterion.subareaLevelSuperior",[_criterionValue]);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new SubareaLevelItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return PlayedCharacterManager.getInstance().currentSubArea.level;
      }
   }
}

package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AlignmentItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function AlignmentItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionValue:String = AlignmentSide.getAlignmentSideById(int(_criterionValue)).name;
         var readableCriterionRef:String = I18n.getUiText("ui.common.alignment");
         var readableOperator:String = ":";
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableOperator = I18n.getUiText("ui.common.differentFrom") + I18n.getUiText("ui.common.colon");
         }
         return readableCriterionRef + " " + readableOperator + " " + readableCriterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new AlignmentItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
      }
   }
}

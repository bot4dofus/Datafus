package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class KamaItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function KamaItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = I18n.getUiText("ui.common.kamas");
         return readableCriterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function get isRespected() : Boolean
      {
         return _operator.compare(PlayedCharacterManager.getInstance().characteristics.kamas,_criterionValue);
      }
      
      override public function clone() : IItemCriterion
      {
         return new KamaItemCriterion(this.basicText);
      }
   }
}

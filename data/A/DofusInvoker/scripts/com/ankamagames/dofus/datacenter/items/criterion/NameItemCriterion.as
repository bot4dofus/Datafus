package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class NameItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function NameItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = I18n.getUiText("ui.common.name");
         return readableCriterionRef + " " + this.getReadableOperator();
      }
      
      override public function get isRespected() : Boolean
      {
         var name:String = PlayedCharacterManager.getInstance().infos.name;
         var respected:* = false;
         var criterionValue:String = _criterionValue.toString();
         switch(_operator.text)
         {
            case "=":
               respected = name == criterionValue;
               break;
            case "!":
               respected = name != criterionValue;
               break;
            case "~":
               respected = name.toLowerCase() == criterionValue.toLowerCase();
               break;
            case "S":
               respected = name.toLowerCase().indexOf(criterionValue.toLowerCase()) == 0;
               break;
            case "s":
               respected = name.indexOf(criterionValue) == 0;
               break;
            case "E":
               respected = name.toLowerCase().indexOf(criterionValue.toLowerCase()) == name.length - criterionValue.length;
               break;
            case "e":
               respected = name.indexOf(criterionValue) == name.length - criterionValue.length;
               break;
            case "v":
               break;
            case "i":
         }
         return respected;
      }
      
      override public function clone() : IItemCriterion
      {
         return new NameItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
      
      private function getReadableOperator() : String
      {
         var text:String = "";
         _log.debug("operator : " + _operator);
         switch(_operator.text)
         {
            case "!":
            case "=":
               text = _operator.text + " " + _criterionValueText;
               break;
            case "~":
               text = "= " + _criterionValueText;
               break;
            case "S":
            case "s":
               text = I18n.getUiText("ui.criterion.startWith",[_criterionValueText]);
               break;
            case "E":
            case "e":
               text = I18n.getUiText("ui.criterion.endWith",[_criterionValueText]);
               break;
            case "v":
               text = I18n.getUiText("ui.criterion.valid");
               break;
            case "i":
               text = I18n.getUiText("ui.criterion.invalid");
         }
         return text;
      }
   }
}

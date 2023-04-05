package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PrismOnMapStateItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function PrismOnMapStateItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var prism:PrismSubAreaWrapper = null;
         var isPrismOnSameMap:* = false;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
            case ItemCriterionOperator.DIFFERENT:
               prism = AllianceFrame.getInstance().getPrismSubAreaById(PlayedCharacterManager.getInstance().currentSubArea.id);
               if(!prism)
               {
                  return _operator.text == ItemCriterionOperator.DIFFERENT;
               }
               isPrismOnSameMap = prism.mapId == PlayedCharacterManager.getInstance().currentMap.mapId;
               if(!isPrismOnSameMap)
               {
                  return _operator.text == ItemCriterionOperator.DIFFERENT;
               }
               return _operator.text == ItemCriterionOperator.DIFFERENT ? !this.prismIsOnRequestedState(prism.state) : Boolean(this.prismIsOnRequestedState(prism.state));
               break;
            default:
               return false;
         }
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         if(!_criterionValue)
         {
            return "error on PrismOnMapStateItemCriterion";
         }
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.criterion.prismOnMapState.equal." + _criterionValue);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.criterion.prismOnMapState.different." + _criterionValue);
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion
      {
         return new PrismOnMapStateItemCriterion(this.basicText);
      }
      
      private function prismIsOnRequestedState(prismState:uint) : Boolean
      {
         switch(_criterionValue)
         {
            case 0:
               return true;
            case 1:
               return prismState == PrismStateEnum.PRISM_STATE_NORMAL;
            case 2:
               return prismState == PrismStateEnum.PRISM_STATE_WEAKENED;
            case 3:
               return prismState == PrismStateEnum.PRISM_STATE_VULNERABLE;
            case 4:
               return prismState == PrismStateEnum.PRISM_STATE_PROTECTED;
            case 5:
               return prismState == PrismStateEnum.PRISM_STATE_INHIBITED;
            default:
               return false;
         }
      }
   }
}

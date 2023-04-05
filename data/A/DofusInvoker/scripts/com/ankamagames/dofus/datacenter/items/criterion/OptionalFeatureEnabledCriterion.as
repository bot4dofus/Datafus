package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class OptionalFeatureEnabledCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function OptionalFeatureEnabledCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function clone() : IItemCriterion
      {
         return new OptionalFeatureEnabledCriterion(this.basicText);
      }
      
      override public function get isRespected() : Boolean
      {
         var featureEnabled:Boolean = FeatureManager.getInstance().isFeatureWithIdEnabled(_criterionValue);
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               return featureEnabled;
            case ItemCriterionOperator.DIFFERENT:
               return !featureEnabled;
            default:
               return false;
         }
      }
   }
}

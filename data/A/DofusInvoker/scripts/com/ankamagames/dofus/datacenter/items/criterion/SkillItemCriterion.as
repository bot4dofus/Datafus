package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SkillItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function SkillItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return _criterionRef + " " + _operator.text + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new SkillItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return 0;
      }
   }
}

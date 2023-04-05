package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   
   public class CriterionUtils implements IDataCenter
   {
       
      
      public function CriterionUtils()
      {
         super();
      }
      
      public static function getCriteriaFromString(pCriteriaStringForm:String) : Vector.<IItemCriterion>
      {
         var stringCriterion:String = null;
         var tabSingleCriteria:Array = null;
         var stringCriterion2:String = null;
         var newGroupCriterion:GroupItemCriterion = null;
         var criteriaStringForm:String = pCriteriaStringForm;
         var criteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         if(!criteriaStringForm || criteriaStringForm.length == 0)
         {
            return criteria;
         }
         var tabParenthesis:Vector.<String> = StringUtils.getDelimitedText(criteriaStringForm,"(",")",true);
         for each(stringCriterion in tabParenthesis)
         {
            newGroupCriterion = new GroupItemCriterion(stringCriterion);
            criteria.push(newGroupCriterion);
            criteriaStringForm = StringUtils.replace(criteriaStringForm,stringCriterion,"");
         }
         tabSingleCriteria = criteriaStringForm.split(/[&|]/);
         for each(stringCriterion2 in tabSingleCriteria)
         {
            if(stringCriterion2 != "")
            {
               criteria.push(ItemCriterionFactory.create(stringCriterion2));
            }
         }
         return criteria;
      }
   }
}

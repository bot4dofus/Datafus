package com.ankamagames.dofus.datacenter.items.criterion
{
   public interface IItemCriterion
   {
       
      
      function get inlineCriteria() : Vector.<IItemCriterion>;
      
      function get isRespected() : Boolean;
      
      function get text() : String;
      
      function get basicText() : String;
      
      function clone() : IItemCriterion;
   }
}

package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class IdolsEquippedCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function IdolsEquippedCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         return I18n.getUiText("ui.criterion.cannotBeEquippedWithOtherIdols");
      }
      
      override public function clone() : IItemCriterion
      {
         return new IdolsEquippedCriterion(this.basicText);
      }
      
      override public function get isRespected() : Boolean
      {
         var rawIdolId:String = null;
         var currentIdolId:uint = 0;
         var idolId:Number = NaN;
         if(!_criterionValueText || _operator.text !== ItemCriterionOperator.EQUAL)
         {
            return true;
         }
         var currentIdolIds:Vector.<uint> = PlayedCharacterManager.getInstance().soloIdols;
         if(currentIdolIds.length <= 0)
         {
            return true;
         }
         var rawIdolIds:Array = _criterionValueText.split(",");
         if(rawIdolIds.length <= 0)
         {
            return true;
         }
         if(rawIdolIds.length !== currentIdolIds.length)
         {
            return false;
         }
         var idolIds:Vector.<uint> = new Vector.<uint>(0);
         for each(rawIdolId in rawIdolIds)
         {
            idolId = Number(rawIdolId);
            if(!(isNaN(idolId) || idolId < 0))
            {
               idolIds.push(idolId);
            }
         }
         for each(currentIdolId in currentIdolIds)
         {
            if(idolIds.indexOf(currentIdolId) === -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}

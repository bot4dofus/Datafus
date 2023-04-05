package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.communication.SmileyPack;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SmileyPackItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function SmileyPackItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean
      {
         var pack:SmileyPack = null;
         var packList:Array = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).smileyPacks;
         for each(pack in packList)
         {
            if(pack.id == _criterionValue)
            {
               return false;
            }
         }
         return true;
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = null;
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontPossessSmileyPack");
         }
         else
         {
            readableCriterion = I18n.getUiText("ui.tooltip.possessSmileyPack");
         }
         return readableCriterion + " \'" + SmileyPack.getSmileyPackById(_criterionValue).name + "\'";
      }
      
      override public function clone() : IItemCriterion
      {
         return new SmileyPackItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var pack:SmileyPack = null;
         var packList:Array = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame).smileyPacks;
         for each(pack in packList)
         {
            if(pack.id == _criterionValue)
            {
               return 1;
            }
         }
         return 0;
      }
   }
}

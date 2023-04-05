package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FriendlistItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function FriendlistItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = I18n.getUiText("ui.tooltip.playerInFriendlist");
         var readableOperator:String = _operator.text;
         if(readableOperator == ItemCriterionOperator.EQUAL)
         {
            readableOperator = ":";
         }
         return readableCriterionRef + " " + readableOperator + " " + _criterionValue;
      }
      
      override public function clone() : IItemCriterion
      {
         return new FriendlistItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).friendsList.length;
      }
   }
}

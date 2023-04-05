package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.EmoticonFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class EmoteItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      public function EmoteItemCriterion(pCriterion:String)
      {
         super(pCriterion);
      }
      
      private function getEmotesList() : Array
      {
         var emoticonFrame:EmoticonFrame = Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame;
         if(emoticonFrame)
         {
            return emoticonFrame.emotesList;
         }
         return null;
      }
      
      override public function get isRespected() : Boolean
      {
         var emoteWrapper:EmoteWrapper = null;
         for each(emoteWrapper in this.getEmotesList())
         {
            if(emoteWrapper.emote.id == _criterionValue)
            {
               return false;
            }
         }
         return true;
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = I18n.getUiText("ui.tooltip.possessEmote");
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            readableCriterion = I18n.getUiText("ui.tooltip.dontPossessEmote");
         }
         return readableCriterion + " \'" + Emoticon.getEmoticonById(_criterionValue).name + "\'";
      }
      
      override public function clone() : IItemCriterion
      {
         return new EmoteItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var id:int = 0;
         for each(id in this.getEmotesList())
         {
            if(id == _criterionValue)
            {
               return 1;
            }
         }
         return 0;
      }
   }
}

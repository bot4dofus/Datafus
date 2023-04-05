package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class QuestObjectiveItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private var _objId:uint;
      
      public function QuestObjectiveItemCriterion(pCriterion:String)
      {
         super(pCriterion);
         this._objId = _criterionValue;
      }
      
      override public function get text() : String
      {
         return "";
      }
      
      override public function get isRespected() : Boolean
      {
         var obj:QuestObjective = QuestObjective.getQuestObjectiveById(this._objId);
         if(!obj)
         {
            return false;
         }
         var questFrame:QuestFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         var activeObjs:Vector.<uint> = questFrame.getActiveObjectives();
         var completedObjs:Vector.<uint> = questFrame.getCompletedObjectives();
         var s:String = _serverCriterionForm.slice(0,2);
         switch(s)
         {
            case "Qo":
               if(_operator.text == ItemCriterionOperator.EQUAL)
               {
                  return activeObjs.indexOf(this._objId) != -1;
               }
               if(_operator.text == ItemCriterionOperator.DIFFERENT)
               {
                  return activeObjs.indexOf(this._objId) == -1;
               }
               if(_operator.text == ItemCriterionOperator.INFERIOR)
               {
                  return completedObjs.indexOf(this._objId) == -1;
               }
               if(_operator.text == ItemCriterionOperator.SUPERIOR)
               {
                  return completedObjs.indexOf(this._objId) != -1;
               }
               break;
         }
         return false;
      }
      
      override public function clone() : IItemCriterion
      {
         return new QuestObjectiveItemCriterion(this.basicText);
      }
   }
}

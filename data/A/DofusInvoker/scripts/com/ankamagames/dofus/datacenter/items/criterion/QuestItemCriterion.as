package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class QuestItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private var _questId:uint;
      
      public function QuestItemCriterion(pCriterion:String)
      {
         super(pCriterion);
         this._questId = _criterionValue;
      }
      
      override public function get text() : String
      {
         var readableCriterion:String = "";
         var quest:Quest = Quest.getQuestById(this._questId);
         if(!quest)
         {
            return readableCriterion;
         }
         var readableCriterionValue:String = quest.name;
         var s:String = _serverCriterionForm.slice(0,2);
         switch(s)
         {
            case "Qa":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.active",[readableCriterionValue]);
               break;
            case "Qc":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.startable",[readableCriterionValue]);
               break;
            case "Qf":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.done",[readableCriterionValue]);
         }
         return readableCriterion;
      }
      
      override public function get isRespected() : Boolean
      {
         var questFrame:QuestFrame = null;
         var completedQuests:Vector.<uint> = null;
         var questA:QuestActiveInformations = null;
         var quest:Quest = Quest.getQuestById(this._questId);
         if(!quest)
         {
            return false;
         }
         questFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         var s:String = _serverCriterionForm.slice(0,2);
         switch(s)
         {
            case "Qa":
               for each(questA in questFrame.getActiveQuests())
               {
                  if(questA.questId == this._questId)
                  {
                     return true;
                  }
               }
               break;
            case "Qc":
               return true;
            case "Qf":
               completedQuests = questFrame.getCompletedQuests();
               return !!completedQuests ? completedQuests.indexOf(this._questId) != -1 : false;
         }
         return false;
      }
      
      override public function clone() : IItemCriterion
      {
         return new QuestItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         return PlayedCharacterManager.getInstance().infos.level;
      }
   }
}

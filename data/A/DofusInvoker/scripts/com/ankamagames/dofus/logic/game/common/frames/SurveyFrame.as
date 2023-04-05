package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.dofus.logic.game.common.actions.SurveyNotificationAnswerAction;
   import com.ankamagames.dofus.misc.utils.SurveyManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class SurveyFrame implements Frame
   {
       
      
      public function SurveyFrame()
      {
         super();
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var snaa:SurveyNotificationAnswerAction = null;
         switch(true)
         {
            case msg is SurveyNotificationAnswerAction:
               snaa = msg as SurveyNotificationAnswerAction;
               SurveyManager.getInstance().markSurveyAsDone(snaa.surveyId,snaa.accept);
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
   }
}

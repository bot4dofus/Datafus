package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SurveyNotificationAnswerAction extends AbstractAction implements Action
   {
       
      
      public var surveyId:uint;
      
      public var accept:Boolean;
      
      public function SurveyNotificationAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(surveyId:uint, accept:Boolean) : SurveyNotificationAnswerAction
      {
         var a:SurveyNotificationAnswerAction = new SurveyNotificationAnswerAction(arguments);
         a.surveyId = surveyId;
         a.accept = accept;
         return a;
      }
   }
}

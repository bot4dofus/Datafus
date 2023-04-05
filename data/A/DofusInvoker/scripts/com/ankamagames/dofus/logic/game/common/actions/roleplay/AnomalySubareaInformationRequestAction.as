package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AnomalySubareaInformationRequestAction extends AbstractAction implements Action
   {
       
      
      public var uiName:String;
      
      public function AnomalySubareaInformationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uiName:String) : AnomalySubareaInformationRequestAction
      {
         var action:AnomalySubareaInformationRequestAction = new AnomalySubareaInformationRequestAction(arguments);
         action.uiName = uiName;
         return action;
      }
   }
}

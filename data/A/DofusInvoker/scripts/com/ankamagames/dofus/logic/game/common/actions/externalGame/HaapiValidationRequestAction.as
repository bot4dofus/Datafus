package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HaapiValidationRequestAction extends AbstractAction implements Action
   {
       
      
      public var transactionId:String;
      
      public function HaapiValidationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(transactionId:String) : HaapiValidationRequestAction
      {
         var action:HaapiValidationRequestAction = new HaapiValidationRequestAction(arguments);
         action.transactionId = transactionId;
         return action;
      }
   }
}

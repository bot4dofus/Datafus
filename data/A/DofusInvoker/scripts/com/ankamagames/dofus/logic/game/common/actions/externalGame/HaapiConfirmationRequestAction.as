package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HaapiConfirmationRequestAction extends AbstractAction implements Action
   {
       
      
      public var kamas:Number;
      
      public var ogrines:Number;
      
      public var rate:uint;
      
      public var actionType:uint;
      
      public function HaapiConfirmationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(kamas:Number, ogrines:Number, rate:uint, actionType:uint) : HaapiConfirmationRequestAction
      {
         var action:HaapiConfirmationRequestAction = new HaapiConfirmationRequestAction(arguments);
         action.kamas = kamas;
         action.ogrines = ogrines;
         action.rate = rate;
         action.actionType = actionType;
         return action;
      }
   }
}

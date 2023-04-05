package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectDissociateAction extends AbstractAction implements Action
   {
       
      
      public var livingUID:uint;
      
      public var livingPosition:uint;
      
      public function LivingObjectDissociateAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(livingUID:uint, livingPosition:uint) : LivingObjectDissociateAction
      {
         var action:LivingObjectDissociateAction = new LivingObjectDissociateAction(arguments);
         action.livingUID = livingUID;
         action.livingPosition = livingPosition;
         return action;
      }
   }
}

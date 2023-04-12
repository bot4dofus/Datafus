package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GiftAssignCancelAction extends AbstractAction implements Action
   {
       
      
      public function GiftAssignCancelAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GiftAssignCancelAction
      {
         return new GiftAssignCancelAction(arguments);
      }
   }
}

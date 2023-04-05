package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FinishMoveListRequestAction extends AbstractAction implements Action
   {
       
      
      public function FinishMoveListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : FinishMoveListRequestAction
      {
         return new FinishMoveListRequestAction(arguments);
      }
   }
}

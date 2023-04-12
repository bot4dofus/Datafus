package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismAttackRequestAction extends AbstractAction implements Action
   {
       
      
      public function PrismAttackRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : PrismAttackRequestAction
      {
         return new PrismAttackRequestAction(arguments);
      }
   }
}

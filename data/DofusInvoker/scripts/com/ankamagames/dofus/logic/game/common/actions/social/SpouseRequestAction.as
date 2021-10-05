package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SpouseRequestAction extends AbstractAction implements Action
   {
       
      
      public function SpouseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : SpouseRequestAction
      {
         return new SpouseRequestAction(arguments);
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CloseIdolsAction extends AbstractAction implements Action
   {
       
      
      public function CloseIdolsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CloseIdolsAction
      {
         return new CloseIdolsAction(arguments);
      }
   }
}

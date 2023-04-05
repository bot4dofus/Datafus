package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuitGameAction extends AbstractAction implements Action
   {
       
      
      public function QuitGameAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : QuitGameAction
      {
         return new QuitGameAction(arguments);
      }
   }
}

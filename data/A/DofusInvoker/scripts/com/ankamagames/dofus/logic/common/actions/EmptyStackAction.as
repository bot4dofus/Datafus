package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class EmptyStackAction extends AbstractAction implements Action
   {
       
      
      public function EmptyStackAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : EmptyStackAction
      {
         return new EmptyStackAction(arguments);
      }
   }
}

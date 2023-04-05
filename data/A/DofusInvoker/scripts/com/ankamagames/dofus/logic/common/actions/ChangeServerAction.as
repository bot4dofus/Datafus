package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeServerAction extends AbstractAction implements Action
   {
       
      
      public function ChangeServerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ChangeServerAction
      {
         return new ChangeServerAction(arguments);
      }
   }
}

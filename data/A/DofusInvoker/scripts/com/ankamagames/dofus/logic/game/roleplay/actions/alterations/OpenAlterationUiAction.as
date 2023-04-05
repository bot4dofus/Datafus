package com.ankamagames.dofus.logic.game.roleplay.actions.alterations
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenAlterationUiAction extends AbstractAction implements Action
   {
       
      
      public function OpenAlterationUiAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenAlterationUiAction
      {
         return new OpenAlterationUiAction(arguments);
      }
   }
}

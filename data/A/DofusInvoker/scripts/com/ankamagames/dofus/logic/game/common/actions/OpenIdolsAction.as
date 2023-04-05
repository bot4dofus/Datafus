package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenIdolsAction extends AbstractAction implements Action
   {
       
      
      public function OpenIdolsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenIdolsAction
      {
         return new OpenIdolsAction(arguments);
      }
   }
}

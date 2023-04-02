package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartListenNuggetsAction extends AbstractAction implements Action
   {
       
      
      public function StartListenNuggetsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StartListenNuggetsAction
      {
         return new StartListenNuggetsAction(arguments);
      }
   }
}

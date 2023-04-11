package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopListenNuggetsAction extends AbstractAction implements Action
   {
       
      
      public function StopListenNuggetsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopListenNuggetsAction
      {
         return new StopListenNuggetsAction(arguments);
      }
   }
}

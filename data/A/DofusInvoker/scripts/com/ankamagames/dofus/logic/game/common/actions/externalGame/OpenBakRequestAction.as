package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenBakRequestAction extends AbstractAction implements Action
   {
       
      
      public function OpenBakRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenBakRequestAction
      {
         return new OpenBakRequestAction(arguments);
      }
   }
}

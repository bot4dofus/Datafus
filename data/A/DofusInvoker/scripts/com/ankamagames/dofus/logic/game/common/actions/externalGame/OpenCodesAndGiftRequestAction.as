package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenCodesAndGiftRequestAction extends AbstractAction implements Action
   {
       
      
      public function OpenCodesAndGiftRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenCodesAndGiftRequestAction
      {
         return new OpenCodesAndGiftRequestAction(arguments);
      }
   }
}

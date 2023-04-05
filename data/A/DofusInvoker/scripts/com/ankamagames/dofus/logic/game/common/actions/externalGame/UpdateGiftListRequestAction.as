package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateGiftListRequestAction extends AbstractAction implements Action
   {
       
      
      public function UpdateGiftListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : UpdateGiftListRequestAction
      {
         return new UpdateGiftListRequestAction(arguments);
      }
   }
}

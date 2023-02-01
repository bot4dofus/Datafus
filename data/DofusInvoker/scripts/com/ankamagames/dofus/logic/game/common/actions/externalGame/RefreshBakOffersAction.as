package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RefreshBakOffersAction extends AbstractAction implements Action
   {
       
      
      public function RefreshBakOffersAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : RefreshBakOffersAction
      {
         return new RefreshBakOffersAction(arguments);
      }
   }
}

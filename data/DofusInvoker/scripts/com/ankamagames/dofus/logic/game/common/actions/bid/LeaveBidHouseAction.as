package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LeaveBidHouseAction extends AbstractAction implements Action
   {
       
      
      public function LeaveBidHouseAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : LeaveBidHouseAction
      {
         return new LeaveBidHouseAction(arguments);
      }
   }
}

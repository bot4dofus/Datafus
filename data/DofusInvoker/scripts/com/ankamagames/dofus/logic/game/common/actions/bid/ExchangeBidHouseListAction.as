package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseListAction extends AbstractAction implements Action
   {
       
      
      public var id:uint;
      
      public var follow:Boolean;
      
      public function ExchangeBidHouseListAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pId:uint, pFollow:Boolean = false) : ExchangeBidHouseListAction
      {
         var a:ExchangeBidHouseListAction = new ExchangeBidHouseListAction(arguments);
         a.id = pId;
         a.follow = pFollow;
         return a;
      }
   }
}

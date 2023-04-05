package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseTypeAction extends AbstractAction implements Action
   {
       
      
      public var type:uint;
      
      public var follow:Boolean;
      
      public function ExchangeBidHouseTypeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pType:uint, pFollow:Boolean) : ExchangeBidHouseTypeAction
      {
         var a:ExchangeBidHouseTypeAction = new ExchangeBidHouseTypeAction(arguments);
         a.type = pType;
         a.follow = pFollow;
         return a;
      }
   }
}

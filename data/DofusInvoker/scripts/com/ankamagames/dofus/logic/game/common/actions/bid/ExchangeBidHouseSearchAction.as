package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseSearchAction extends AbstractAction implements Action
   {
       
      
      public var type:uint;
      
      public var follow:Boolean = false;
      
      public var genId:uint;
      
      public function ExchangeBidHouseSearchAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pType:uint, pGenId:uint, follow:Boolean = false) : ExchangeBidHouseSearchAction
      {
         var a:ExchangeBidHouseSearchAction = new ExchangeBidHouseSearchAction(arguments);
         a.type = pType;
         a.follow = follow;
         a.genId = pGenId;
         return a;
      }
   }
}

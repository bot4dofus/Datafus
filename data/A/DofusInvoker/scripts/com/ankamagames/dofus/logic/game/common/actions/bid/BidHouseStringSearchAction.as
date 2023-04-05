package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BidHouseStringSearchAction extends AbstractAction implements Action
   {
       
      
      public var searchString:String;
      
      public function BidHouseStringSearchAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pSearchString:String) : BidHouseStringSearchAction
      {
         var a:BidHouseStringSearchAction = new BidHouseStringSearchAction(arguments);
         a.searchString = pSearchString;
         return a;
      }
   }
}

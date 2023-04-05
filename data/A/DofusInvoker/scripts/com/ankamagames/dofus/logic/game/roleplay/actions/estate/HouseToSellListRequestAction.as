package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseToSellListRequestAction extends AbstractAction implements Action
   {
       
      
      public var pageIndex:uint;
      
      public function HouseToSellListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pageIndex:uint) : HouseToSellListRequestAction
      {
         var a:HouseToSellListRequestAction = new HouseToSellListRequestAction(arguments);
         a.pageIndex = pageIndex;
         return a;
      }
   }
}

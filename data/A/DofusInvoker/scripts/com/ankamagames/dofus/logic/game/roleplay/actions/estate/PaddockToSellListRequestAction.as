package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockToSellListRequestAction extends AbstractAction implements Action
   {
       
      
      public var pageIndex:uint;
      
      public function PaddockToSellListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pageIndex:uint) : PaddockToSellListRequestAction
      {
         var a:PaddockToSellListRequestAction = new PaddockToSellListRequestAction(arguments);
         a.pageIndex = pageIndex;
         return a;
      }
   }
}

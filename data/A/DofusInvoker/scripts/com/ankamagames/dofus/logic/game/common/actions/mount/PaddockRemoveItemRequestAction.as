package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockRemoveItemRequestAction extends AbstractAction implements Action
   {
       
      
      public var cellId:uint;
      
      public function PaddockRemoveItemRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(cellId:uint) : PaddockRemoveItemRequestAction
      {
         var o:PaddockRemoveItemRequestAction = new PaddockRemoveItemRequestAction(arguments);
         o.cellId = cellId;
         return o;
      }
   }
}

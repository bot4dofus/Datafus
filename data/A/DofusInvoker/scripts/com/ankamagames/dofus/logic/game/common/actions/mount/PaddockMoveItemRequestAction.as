package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockMoveItemRequestAction extends AbstractAction implements Action
   {
       
      
      public var object:Object;
      
      public function PaddockMoveItemRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(object:Object) : PaddockMoveItemRequestAction
      {
         var o:PaddockMoveItemRequestAction = new PaddockMoveItemRequestAction(arguments);
         o.object = object;
         return o;
      }
   }
}

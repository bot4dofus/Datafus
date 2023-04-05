package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeHandleMountStableAction extends AbstractAction implements Action
   {
       
      
      public var ridesId:Array;
      
      public var actionType:int;
      
      public function ExchangeHandleMountStableAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(actionType:uint, mountsId:Array) : ExchangeHandleMountStableAction
      {
         var act:ExchangeHandleMountStableAction = new ExchangeHandleMountStableAction(arguments);
         act.actionType = actionType;
         act.ridesId = mountsId;
         return act;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReplayAction extends AbstractAction implements Action
   {
       
      
      public var count:int;
      
      public function ExchangeReplayAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pCount:int) : ExchangeReplayAction
      {
         var action:ExchangeReplayAction = new ExchangeReplayAction(arguments);
         action.count = pCount;
         return action;
      }
   }
}

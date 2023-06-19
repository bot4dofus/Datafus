package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReplayStopAction extends AbstractAction implements Action
   {
       
      
      public function ExchangeReplayStopAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ExchangeReplayStopAction
      {
         return new ExchangeReplayStopAction(arguments);
      }
   }
}

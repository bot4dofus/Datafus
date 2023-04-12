package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopListenTaxCollectorUpdatesAction extends AbstractAction implements Action
   {
       
      
      public var uId:Number;
      
      public function StopListenTaxCollectorUpdatesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uId:Number) : StopListenTaxCollectorUpdatesAction
      {
         var a:StopListenTaxCollectorUpdatesAction = new StopListenTaxCollectorUpdatesAction(arguments);
         a.uId = uId;
         return a;
      }
   }
}

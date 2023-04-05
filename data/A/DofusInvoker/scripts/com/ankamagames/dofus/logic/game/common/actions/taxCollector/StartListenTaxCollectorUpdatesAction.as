package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartListenTaxCollectorUpdatesAction extends AbstractAction implements Action
   {
       
      
      public var uId:Number;
      
      public function StartListenTaxCollectorUpdatesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uId:Number) : StartListenTaxCollectorUpdatesAction
      {
         var a:StartListenTaxCollectorUpdatesAction = new StartListenTaxCollectorUpdatesAction(arguments);
         a.uId = uId;
         return a;
      }
   }
}

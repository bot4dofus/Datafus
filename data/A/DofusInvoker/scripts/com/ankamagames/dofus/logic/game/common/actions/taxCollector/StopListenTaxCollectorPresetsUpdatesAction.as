package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopListenTaxCollectorPresetsUpdatesAction extends AbstractAction implements Action
   {
       
      
      public function StopListenTaxCollectorPresetsUpdatesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopListenTaxCollectorPresetsUpdatesAction
      {
         return new StopListenTaxCollectorPresetsUpdatesAction(arguments);
      }
   }
}

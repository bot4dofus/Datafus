package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartListenTaxCollectorPresetsUpdatesAction extends AbstractAction implements Action
   {
       
      
      public function StartListenTaxCollectorPresetsUpdatesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StartListenTaxCollectorPresetsUpdatesAction
      {
         return new StartListenTaxCollectorPresetsUpdatesAction(arguments);
      }
   }
}

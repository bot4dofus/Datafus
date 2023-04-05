package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartExchangeTaxCollectorEquipmentAction extends AbstractAction implements Action
   {
       
      
      public var uid:Number;
      
      public function StartExchangeTaxCollectorEquipmentAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uid:Number) : StartExchangeTaxCollectorEquipmentAction
      {
         var a:StartExchangeTaxCollectorEquipmentAction = new StartExchangeTaxCollectorEquipmentAction(arguments);
         a.uid = uid;
         return a;
      }
   }
}

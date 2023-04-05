package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveTaxCollectorOrderedSpellAction extends AbstractAction implements Action
   {
       
      
      public var taxCollectorId:Number;
      
      public var slotId:uint;
      
      public function RemoveTaxCollectorOrderedSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(taxCollectorId:Number, slotId:uint) : RemoveTaxCollectorOrderedSpellAction
      {
         var a:RemoveTaxCollectorOrderedSpellAction = new RemoveTaxCollectorOrderedSpellAction(arguments);
         a.taxCollectorId = taxCollectorId;
         a.slotId = slotId;
         return a;
      }
   }
}

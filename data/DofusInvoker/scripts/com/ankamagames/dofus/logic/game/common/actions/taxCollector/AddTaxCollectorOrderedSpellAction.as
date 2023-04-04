package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddTaxCollectorOrderedSpellAction extends AbstractAction implements Action
   {
       
      
      public var taxCollectorId:Number;
      
      public var orderedSpell:TaxCollectorOrderedSpell;
      
      public function AddTaxCollectorOrderedSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(taxCollectorId:Number, orderedSpell:TaxCollectorOrderedSpell) : AddTaxCollectorOrderedSpellAction
      {
         var a:AddTaxCollectorOrderedSpellAction = new AddTaxCollectorOrderedSpellAction(arguments);
         a.taxCollectorId = taxCollectorId;
         a.orderedSpell = orderedSpell;
         return a;
      }
   }
}

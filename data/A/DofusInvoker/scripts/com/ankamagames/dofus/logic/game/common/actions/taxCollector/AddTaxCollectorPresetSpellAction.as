package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.dofus.network.types.game.uuid;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddTaxCollectorPresetSpellAction extends AbstractAction implements Action
   {
       
      
      public var presetId:uuid;
      
      public var orderedSpell:TaxCollectorOrderedSpell;
      
      public function AddTaxCollectorPresetSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:uuid, orderedSpell:TaxCollectorOrderedSpell) : AddTaxCollectorPresetSpellAction
      {
         var action:AddTaxCollectorPresetSpellAction = new AddTaxCollectorPresetSpellAction(arguments);
         action.presetId = presetId;
         action.orderedSpell = orderedSpell;
         return action;
      }
   }
}

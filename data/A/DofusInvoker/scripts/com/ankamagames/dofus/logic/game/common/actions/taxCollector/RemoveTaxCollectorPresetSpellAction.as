package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveTaxCollectorPresetSpellAction extends AbstractAction implements Action
   {
       
      
      public var presetId:Uuid;
      
      public var slotId:uint;
      
      public function RemoveTaxCollectorPresetSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:Uuid, slotId:uint) : RemoveTaxCollectorPresetSpellAction
      {
         var action:RemoveTaxCollectorPresetSpellAction = new RemoveTaxCollectorPresetSpellAction(arguments);
         action.presetId = presetId;
         action.slotId = slotId;
         return action;
      }
   }
}

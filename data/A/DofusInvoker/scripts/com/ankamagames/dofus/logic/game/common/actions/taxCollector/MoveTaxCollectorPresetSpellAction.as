package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.uuid;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoveTaxCollectorPresetSpellAction extends AbstractAction implements Action
   {
       
      
      public var presetId:uuid;
      
      public var moveFrom:uint;
      
      public var moveTo:uint;
      
      public function MoveTaxCollectorPresetSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:uuid, moveFrom:uint, moveTo:uint) : MoveTaxCollectorPresetSpellAction
      {
         var a:MoveTaxCollectorPresetSpellAction = new MoveTaxCollectorPresetSpellAction(arguments);
         a.presetId = presetId;
         a.moveFrom = moveFrom;
         a.moveTo = moveTo;
         return a;
      }
   }
}

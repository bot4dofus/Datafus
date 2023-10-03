package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoveTaxCollectorPresetSpellAction extends AbstractAction implements Action
   {
       
      
      public var presetId:Uuid;
      
      public var moveFrom:uint;
      
      public var moveTo:uint;
      
      public function MoveTaxCollectorPresetSpellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:Uuid, moveFrom:uint, moveTo:uint) : MoveTaxCollectorPresetSpellAction
      {
         var a:MoveTaxCollectorPresetSpellAction = new MoveTaxCollectorPresetSpellAction(arguments);
         a.presetId = presetId;
         a.moveFrom = moveFrom;
         a.moveTo = moveTo;
         return a;
      }
   }
}

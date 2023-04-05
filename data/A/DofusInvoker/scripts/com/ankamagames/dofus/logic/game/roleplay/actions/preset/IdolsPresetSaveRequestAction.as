package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class IdolsPresetSaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var presetId:int;
      
      public var symbolId:uint;
      
      public function IdolsPresetSaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:int, symbolId:uint) : IdolsPresetSaveRequestAction
      {
         var a:IdolsPresetSaveRequestAction = new IdolsPresetSaveRequestAction(arguments);
         a.presetId = presetId;
         a.symbolId = symbolId;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PresetDeleteRequestAction extends AbstractAction implements Action
   {
       
      
      public var presetId:uint;
      
      public function PresetDeleteRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:uint) : PresetDeleteRequestAction
      {
         var a:PresetDeleteRequestAction = new PresetDeleteRequestAction(arguments);
         a.presetId = presetId;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PresetUseRequestAction extends AbstractAction implements Action
   {
       
      
      public var presetId:uint;
      
      public function PresetUseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:uint) : PresetUseRequestAction
      {
         var a:PresetUseRequestAction = new PresetUseRequestAction(arguments);
         a.presetId = presetId;
         return a;
      }
   }
}

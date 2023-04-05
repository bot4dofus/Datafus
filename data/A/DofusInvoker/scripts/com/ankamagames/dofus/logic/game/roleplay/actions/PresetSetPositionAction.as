package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PresetSetPositionAction extends AbstractAction implements Action
   {
       
      
      public var presetId:uint;
      
      public var position:uint;
      
      public function PresetSetPositionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(presetId:uint, position:uint) : PresetSetPositionAction
      {
         var a:PresetSetPositionAction = new PresetSetPositionAction(arguments);
         a.presetId = presetId;
         a.position = position;
         return a;
      }
   }
}

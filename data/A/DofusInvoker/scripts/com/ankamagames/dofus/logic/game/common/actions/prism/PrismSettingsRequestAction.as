package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismSettingsRequestAction extends AbstractAction implements Action
   {
       
      
      public var subAreaId:uint;
      
      public var startDefenseTime:uint;
      
      public function PrismSettingsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(subAreaId:uint, startDefenseTime:uint) : PrismSettingsRequestAction
      {
         var action:PrismSettingsRequestAction = new PrismSettingsRequestAction(arguments);
         action.subAreaId = subAreaId;
         action.startDefenseTime = startDefenseTime;
         return action;
      }
   }
}

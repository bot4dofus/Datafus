package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountToggleRidingRequestAction extends AbstractAction implements Action
   {
       
      
      public var isToggle:Boolean;
      
      public function MountToggleRidingRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(isToggle:Boolean = false) : MountToggleRidingRequestAction
      {
         var result:MountToggleRidingRequestAction = new MountToggleRidingRequestAction(arguments);
         result.isToggle = isToggle;
         return result;
      }
   }
}

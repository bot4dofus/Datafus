package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SetEnablePVPRequestAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function SetEnablePVPRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : SetEnablePVPRequestAction
      {
         var action:SetEnablePVPRequestAction = new SetEnablePVPRequestAction(arguments);
         action.enable = enable;
         return action;
      }
   }
}

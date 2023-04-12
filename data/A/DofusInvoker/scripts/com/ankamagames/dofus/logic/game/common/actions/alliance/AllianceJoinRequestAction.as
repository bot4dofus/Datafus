package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceJoinRequestAction extends AbstractAction implements Action
   {
       
      
      public var allianceId:uint;
      
      public function AllianceJoinRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pTargetId:Number) : AllianceJoinRequestAction
      {
         var action:AllianceJoinRequestAction = new AllianceJoinRequestAction(arguments);
         action.allianceId = pTargetId;
         return action;
      }
   }
}

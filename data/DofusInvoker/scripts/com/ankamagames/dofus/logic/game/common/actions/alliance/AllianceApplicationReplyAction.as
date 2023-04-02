package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceApplicationReplyAction extends AbstractAction implements Action
   {
       
      
      public var playerId:Number = 0;
      
      public var isAccepted:Boolean = false;
      
      public function AllianceApplicationReplyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerId:Number, isAccepted:Boolean) : AllianceApplicationReplyAction
      {
         var action:AllianceApplicationReplyAction = new AllianceApplicationReplyAction(arguments);
         action.isAccepted = isAccepted;
         action.playerId = playerId;
         return action;
      }
   }
}

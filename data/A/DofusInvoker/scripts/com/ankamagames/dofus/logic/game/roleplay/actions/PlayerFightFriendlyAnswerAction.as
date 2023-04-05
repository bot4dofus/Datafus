package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerFightFriendlyAnswerAction extends AbstractAction implements Action
   {
       
      
      public var accept:Boolean;
      
      public function PlayerFightFriendlyAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accept:Boolean = true) : PlayerFightFriendlyAnswerAction
      {
         var o:PlayerFightFriendlyAnswerAction = new PlayerFightFriendlyAnswerAction(arguments);
         o.accept = accept;
         return o;
      }
   }
}

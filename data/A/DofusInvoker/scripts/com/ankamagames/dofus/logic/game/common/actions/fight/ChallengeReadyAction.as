package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeReadyAction extends AbstractAction implements Action
   {
       
      
      public function ChallengeReadyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ChallengeReadyAction
      {
         return new ChallengeReadyAction(arguments);
      }
   }
}

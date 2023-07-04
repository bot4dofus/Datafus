package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeSelectionAction extends AbstractAction implements Action
   {
       
      
      public var challengeId:uint;
      
      public function ChallengeSelectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(challId:uint) : ChallengeSelectionAction
      {
         var a:ChallengeSelectionAction = new ChallengeSelectionAction(arguments);
         a.challengeId = challId;
         return a;
      }
   }
}

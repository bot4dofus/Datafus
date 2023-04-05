package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeTargetsListRequestAction extends AbstractAction implements Action
   {
       
      
      public var challengeId:uint;
      
      public function ChallengeTargetsListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(challengeId:uint) : ChallengeTargetsListRequestAction
      {
         var a:ChallengeTargetsListRequestAction = new ChallengeTargetsListRequestAction(arguments);
         a.challengeId = challengeId;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeTargetsRequestAction extends AbstractAction implements Action
   {
       
      
      public var challengeId:uint;
      
      public function ChallengeTargetsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(challengeId:uint) : ChallengeTargetsRequestAction
      {
         var a:ChallengeTargetsRequestAction = new ChallengeTargetsRequestAction(arguments);
         a.challengeId = challengeId;
         return a;
      }
   }
}

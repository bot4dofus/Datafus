package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeValidateAction extends AbstractAction implements Action
   {
       
      
      public var challengeId:uint;
      
      public function ChallengeValidateAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(challId:uint) : ChallengeValidateAction
      {
         var a:ChallengeValidateAction = new ChallengeValidateAction(arguments);
         a.challengeId = challId;
         return a;
      }
   }
}

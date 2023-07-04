package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeModSelectAction extends AbstractAction implements Action
   {
       
      
      public var mod:uint;
      
      public function ChallengeModSelectAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(mod:uint) : ChallengeModSelectAction
      {
         var a:ChallengeModSelectAction = new ChallengeModSelectAction(arguments);
         a.mod = mod;
         return a;
      }
   }
}

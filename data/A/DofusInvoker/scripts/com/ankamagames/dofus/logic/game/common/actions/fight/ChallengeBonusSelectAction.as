package com.ankamagames.dofus.logic.game.common.actions.fight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChallengeBonusSelectAction extends AbstractAction implements Action
   {
       
      
      public var bonus:uint;
      
      public function ChallengeBonusSelectAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(mod:uint) : ChallengeBonusSelectAction
      {
         var a:ChallengeBonusSelectAction = new ChallengeBonusSelectAction(arguments);
         a.bonus = mod;
         return a;
      }
   }
}

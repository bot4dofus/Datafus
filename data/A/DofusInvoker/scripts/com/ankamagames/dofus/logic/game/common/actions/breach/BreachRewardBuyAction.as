package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachRewardBuyAction extends AbstractAction implements Action
   {
       
      
      public var id:uint;
      
      public function BreachRewardBuyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rewardId:uint) : BreachRewardBuyAction
      {
         var a:BreachRewardBuyAction = new BreachRewardBuyAction(arguments);
         a.id = rewardId;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveEnemyAction extends AbstractAction implements Action
   {
       
      
      public var accountId:int;
      
      public function RemoveEnemyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accountId:int) : RemoveEnemyAction
      {
         var a:RemoveEnemyAction = new RemoveEnemyAction(arguments);
         a.accountId = accountId;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveFriendAction extends AbstractAction implements Action
   {
       
      
      public var accountId:int;
      
      public function RemoveFriendAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accountId:int) : RemoveFriendAction
      {
         var a:RemoveFriendAction = new RemoveFriendAction(arguments);
         a.accountId = accountId;
         return a;
      }
   }
}

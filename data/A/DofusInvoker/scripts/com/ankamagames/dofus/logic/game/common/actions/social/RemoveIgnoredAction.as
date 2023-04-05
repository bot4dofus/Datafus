package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveIgnoredAction extends AbstractAction implements Action
   {
       
      
      public var accountId:int;
      
      public function RemoveIgnoredAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accountId:int) : RemoveIgnoredAction
      {
         var a:RemoveIgnoredAction = new RemoveIgnoredAction(arguments);
         a.accountId = accountId;
         return a;
      }
   }
}

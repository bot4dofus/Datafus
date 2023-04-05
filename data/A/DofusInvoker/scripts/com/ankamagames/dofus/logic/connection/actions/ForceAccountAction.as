package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ForceAccountAction extends AbstractAction implements Action
   {
       
      
      public var accountId:uint;
      
      public function ForceAccountAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(accountId:uint) : ForceAccountAction
      {
         var a:ForceAccountAction = new ForceAccountAction(arguments);
         a.accountId = accountId;
         return a;
      }
   }
}

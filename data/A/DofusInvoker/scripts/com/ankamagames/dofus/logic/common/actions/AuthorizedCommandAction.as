package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AuthorizedCommandAction extends AbstractAction implements Action
   {
       
      
      public var command:String;
      
      public function AuthorizedCommandAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(command:String) : AuthorizedCommandAction
      {
         var a:AuthorizedCommandAction = new AuthorizedCommandAction(arguments);
         a.command = command;
         return a;
      }
   }
}

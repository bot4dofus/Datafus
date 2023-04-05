package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LockableChangeCodeAction extends AbstractAction implements Action
   {
       
      
      public var code:String;
      
      public function LockableChangeCodeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(code:String) : LockableChangeCodeAction
      {
         var action:LockableChangeCodeAction = new LockableChangeCodeAction(arguments);
         action.code = code;
         return action;
      }
   }
}

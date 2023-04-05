package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LockableUseCodeAction extends AbstractAction implements Action
   {
       
      
      public var code:String;
      
      public function LockableUseCodeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(code:String) : LockableUseCodeAction
      {
         var action:LockableUseCodeAction = new LockableUseCodeAction(arguments);
         action.code = code;
         return action;
      }
   }
}

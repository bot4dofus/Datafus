package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseLockFromInsideAction extends AbstractAction implements Action
   {
       
      
      public var code:String;
      
      public function HouseLockFromInsideAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(code:String) : HouseLockFromInsideAction
      {
         var action:HouseLockFromInsideAction = new HouseLockFromInsideAction(arguments);
         action.code = code;
         return action;
      }
   }
}

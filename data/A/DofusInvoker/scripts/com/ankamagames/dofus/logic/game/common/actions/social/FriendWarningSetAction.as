package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendWarningSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function FriendWarningSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : FriendWarningSetAction
      {
         var a:FriendWarningSetAction = new FriendWarningSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}

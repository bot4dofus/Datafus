package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendSpouseFollowAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function FriendSpouseFollowAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : FriendSpouseFollowAction
      {
         var a:FriendSpouseFollowAction = new FriendSpouseFollowAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}

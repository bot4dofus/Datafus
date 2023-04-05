package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendOrGuildMemberLevelUpWarningSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function FriendOrGuildMemberLevelUpWarningSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : FriendOrGuildMemberLevelUpWarningSetAction
      {
         var a:FriendOrGuildMemberLevelUpWarningSetAction = new FriendOrGuildMemberLevelUpWarningSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendGuildSetWarnOnAchievementCompleteAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function FriendGuildSetWarnOnAchievementCompleteAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : FriendGuildSetWarnOnAchievementCompleteAction
      {
         var a:FriendGuildSetWarnOnAchievementCompleteAction = new FriendGuildSetWarnOnAchievementCompleteAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}

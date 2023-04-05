package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFriendAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public function JoinFriendAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(name:String) : JoinFriendAction
      {
         var a:JoinFriendAction = new JoinFriendAction(arguments);
         a.name = name;
         return a;
      }
   }
}

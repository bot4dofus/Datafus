package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildBulletinSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public var notifyMembers:Boolean;
      
      public function GuildBulletinSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(content:String, notifyMembers:Boolean = true) : GuildBulletinSetRequestAction
      {
         var action:GuildBulletinSetRequestAction = new GuildBulletinSetRequestAction(arguments);
         action.content = content;
         action.notifyMembers = notifyMembers;
         return action;
      }
   }
}

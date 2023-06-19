package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildMemberWarningSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function GuildMemberWarningSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : GuildMemberWarningSetAction
      {
         var a:GuildMemberWarningSetAction = new GuildMemberWarningSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}

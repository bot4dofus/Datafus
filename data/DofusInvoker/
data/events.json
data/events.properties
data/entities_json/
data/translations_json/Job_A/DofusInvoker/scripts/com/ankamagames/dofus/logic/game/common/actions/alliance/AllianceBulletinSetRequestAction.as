package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceBulletinSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public var notifyMembers:Boolean;
      
      public function AllianceBulletinSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(content:String, notifyMembers:Boolean = true) : AllianceBulletinSetRequestAction
      {
         var action:AllianceBulletinSetRequestAction = new AllianceBulletinSetRequestAction(arguments);
         action.content = content;
         action.notifyMembers = notifyMembers;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceMotdSetRequestAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public function AllianceMotdSetRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(content:String) : AllianceMotdSetRequestAction
      {
         var action:AllianceMotdSetRequestAction = new AllianceMotdSetRequestAction(arguments);
         action.content = content;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceUpdateApplicationAction extends AbstractAction implements Action
   {
       
      
      public var applyText:String;
      
      public var allianceId:uint;
      
      public function AllianceUpdateApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(applyText:String, allianceId:uint) : AllianceUpdateApplicationAction
      {
         var action:AllianceUpdateApplicationAction = new AllianceUpdateApplicationAction(arguments);
         action.applyText = applyText;
         action.allianceId = allianceId;
         return action;
      }
   }
}

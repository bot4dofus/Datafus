package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceFactsRequestAction extends AbstractAction implements Action
   {
       
      
      public var allianceId:uint;
      
      public function AllianceFactsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(allianceId:uint) : AllianceFactsRequestAction
      {
         var action:AllianceFactsRequestAction = new AllianceFactsRequestAction(arguments);
         action.allianceId = allianceId;
         return action;
      }
   }
}

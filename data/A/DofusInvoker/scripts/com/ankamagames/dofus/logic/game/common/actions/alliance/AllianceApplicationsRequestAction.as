package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceApplicationsRequestAction extends AbstractAction implements Action
   {
      
      public static const DEFAULT_LIMIT:uint = 10;
       
      
      public var timestamp:Number = 0;
      
      public var limit:uint = 10;
      
      public function AllianceApplicationsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(timestamp:Number, limit:uint = 10) : AllianceApplicationsRequestAction
      {
         var action:AllianceApplicationsRequestAction = new AllianceApplicationsRequestAction(arguments);
         action.timestamp = timestamp;
         action.limit = limit;
         return action;
      }
   }
}

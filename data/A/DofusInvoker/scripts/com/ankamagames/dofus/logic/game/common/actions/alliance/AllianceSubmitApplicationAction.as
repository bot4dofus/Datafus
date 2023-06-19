package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.internalDatacenter.social.AllianceDirectoryFiltersWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceSubmitApplicationAction extends AbstractAction implements Action
   {
       
      
      public var applyText:String;
      
      public var allianceId:uint;
      
      public var filters:AllianceDirectoryFiltersWrapper;
      
      public var timeSpent:int;
      
      public function AllianceSubmitApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(applyText:String, allianceId:uint, timeSpent:int, filters:AllianceDirectoryFiltersWrapper = null) : AllianceSubmitApplicationAction
      {
         var action:AllianceSubmitApplicationAction = new AllianceSubmitApplicationAction(arguments);
         action.applyText = applyText;
         action.allianceId = allianceId;
         action.timeSpent = timeSpent;
         action.filters = filters;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.internalDatacenter.social.AllianceDirectoryFiltersWrapper;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceSummaryRequestAction extends AbstractAction implements Action
   {
       
      
      public var filters:AllianceDirectoryFiltersWrapper;
      
      public var offset:uint;
      
      public var count:uint;
      
      public function AllianceSummaryRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(filters:AllianceDirectoryFiltersWrapper, offset:uint, count:uint, sortType:uint = 0, sortDescending:Boolean = false) : AllianceSummaryRequestAction
      {
         var action:AllianceSummaryRequestAction = new AllianceSummaryRequestAction(arguments);
         action.filters = filters;
         action.offset = offset;
         action.count = count;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceSummaryRequestAction extends AbstractAction implements Action
   {
       
      
      public var nameFilter:String;
      
      public var tagFilter:String;
      
      public var playerNameFilter:String;
      
      public var sortType:uint;
      
      public var sortDescending:Boolean;
      
      public var offset:uint;
      
      public var count:uint;
      
      public function AllianceSummaryRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(offset:uint, count:uint, nameFilter:String = "", tagFilter:String = "", playerNameFilter:String = "", sortType:uint = 0, sortDescending:Boolean = false) : AllianceSummaryRequestAction
      {
         var action:AllianceSummaryRequestAction = new AllianceSummaryRequestAction(arguments);
         action.nameFilter = nameFilter;
         action.tagFilter = tagFilter;
         action.playerNameFilter = playerNameFilter;
         action.sortType = sortType;
         action.sortDescending = sortDescending;
         action.offset = offset;
         action.count = count;
         return action;
      }
   }
}

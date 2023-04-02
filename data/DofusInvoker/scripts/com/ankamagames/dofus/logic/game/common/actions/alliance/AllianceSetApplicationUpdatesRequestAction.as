package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceSetApplicationUpdatesRequestAction extends AbstractAction implements Action
   {
       
      
      public var areEnabled:Boolean = false;
      
      public function AllianceSetApplicationUpdatesRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(areEnabled:Boolean) : AllianceSetApplicationUpdatesRequestAction
      {
         var action:AllianceSetApplicationUpdatesRequestAction = new AllianceSetApplicationUpdatesRequestAction(arguments);
         action.areEnabled = areEnabled;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ActivityHideRequestAction extends AbstractAction implements Action
   {
       
      
      public var activityId:int;
      
      public function ActivityHideRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(activityId:int) : ActivityHideRequestAction
      {
         var a:ActivityHideRequestAction = new ActivityHideRequestAction(arguments);
         a.activityId = activityId;
         return a;
      }
   }
}

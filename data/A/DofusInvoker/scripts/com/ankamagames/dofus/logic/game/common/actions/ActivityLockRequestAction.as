package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ActivityLockRequestAction extends AbstractAction implements Action
   {
       
      
      public var activityId:int;
      
      public var lock:Boolean;
      
      public function ActivityLockRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(activityId:int, lock:Boolean) : ActivityLockRequestAction
      {
         var a:ActivityLockRequestAction = new ActivityLockRequestAction(arguments);
         a.activityId = activityId;
         a.lock = lock;
         return a;
      }
   }
}

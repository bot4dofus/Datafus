package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectFeedAction extends AbstractAction implements Action
   {
       
      
      public var objectUID:uint;
      
      public var meal:Vector.<Object>;
      
      public function LivingObjectFeedAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(objectUID:uint, meal:Vector.<Object>) : LivingObjectFeedAction
      {
         var action:LivingObjectFeedAction = new LivingObjectFeedAction(arguments);
         action.objectUID = objectUID;
         action.meal = meal;
         return action;
      }
   }
}

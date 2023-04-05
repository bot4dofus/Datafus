package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterContactLookRequestAction extends AbstractAction implements Action
   {
       
      
      public var crafterId:Number;
      
      public function JobCrafterContactLookRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(crafterId:Number) : JobCrafterContactLookRequestAction
      {
         var act:JobCrafterContactLookRequestAction = new JobCrafterContactLookRequestAction(arguments);
         act.crafterId = crafterId;
         return act;
      }
   }
}

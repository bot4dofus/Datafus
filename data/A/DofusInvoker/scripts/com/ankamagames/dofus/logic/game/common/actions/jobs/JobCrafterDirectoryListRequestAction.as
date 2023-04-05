package com.ankamagames.dofus.logic.game.common.actions.jobs
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobCrafterDirectoryListRequestAction extends AbstractAction implements Action
   {
       
      
      public var jobId:uint;
      
      public function JobCrafterDirectoryListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(jobId:uint) : JobCrafterDirectoryListRequestAction
      {
         var act:JobCrafterDirectoryListRequestAction = new JobCrafterDirectoryListRequestAction(arguments);
         act.jobId = jobId;
         return act;
      }
   }
}

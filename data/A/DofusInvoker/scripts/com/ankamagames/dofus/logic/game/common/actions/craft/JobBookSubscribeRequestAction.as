package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JobBookSubscribeRequestAction extends AbstractAction implements Action
   {
       
      
      public var jobIds:Vector.<uint>;
      
      public function JobBookSubscribeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(jobIds:Vector.<uint>) : JobBookSubscribeRequestAction
      {
         var action:JobBookSubscribeRequestAction = new JobBookSubscribeRequestAction(arguments);
         action.jobIds = jobIds;
         return action;
      }
   }
}

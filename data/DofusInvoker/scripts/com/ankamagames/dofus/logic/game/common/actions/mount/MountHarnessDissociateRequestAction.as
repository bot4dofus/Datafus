package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountHarnessDissociateRequestAction extends AbstractAction implements Action
   {
       
      
      public function MountHarnessDissociateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : MountHarnessDissociateRequestAction
      {
         return new MountHarnessDissociateRequestAction(arguments);
      }
   }
}

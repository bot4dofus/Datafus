package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountReleaseRequestAction extends AbstractAction implements Action
   {
       
      
      public function MountReleaseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : MountReleaseRequestAction
      {
         return new MountReleaseRequestAction(arguments);
      }
   }
}

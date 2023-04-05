package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountSterilizeRequestAction extends AbstractAction implements Action
   {
       
      
      public function MountSterilizeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : MountSterilizeRequestAction
      {
         return new MountSterilizeRequestAction(arguments);
      }
   }
}

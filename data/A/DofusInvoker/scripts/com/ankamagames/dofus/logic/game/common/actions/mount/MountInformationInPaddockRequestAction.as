package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountInformationInPaddockRequestAction extends AbstractAction implements Action
   {
       
      
      public var mountId:uint;
      
      public function MountInformationInPaddockRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(mountId:uint) : MountInformationInPaddockRequestAction
      {
         var act:MountInformationInPaddockRequestAction = new MountInformationInPaddockRequestAction(arguments);
         act.mountId = mountId;
         return act;
      }
   }
}

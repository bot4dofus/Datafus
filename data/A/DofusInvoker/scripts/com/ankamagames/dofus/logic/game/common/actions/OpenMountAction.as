package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenMountAction extends AbstractAction implements Action
   {
       
      
      public function OpenMountAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenMountAction
      {
         return new OpenMountAction(arguments);
      }
   }
}

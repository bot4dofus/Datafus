package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeScreenshotsDirectoryAction extends AbstractAction implements Action
   {
       
      
      public function ChangeScreenshotsDirectoryAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ChangeScreenshotsDirectoryAction
      {
         return new ChangeScreenshotsDirectoryAction(arguments);
      }
   }
}

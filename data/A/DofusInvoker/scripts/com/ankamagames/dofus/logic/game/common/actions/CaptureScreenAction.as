package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CaptureScreenAction extends AbstractAction implements Action
   {
       
      
      public function CaptureScreenAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CaptureScreenAction
      {
         return new CaptureScreenAction(arguments);
      }
   }
}

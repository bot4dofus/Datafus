package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CaptureScreenWithoutUIAction extends AbstractAction implements Action
   {
       
      
      public function CaptureScreenWithoutUIAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CaptureScreenWithoutUIAction
      {
         return new CaptureScreenWithoutUIAction(arguments);
      }
   }
}

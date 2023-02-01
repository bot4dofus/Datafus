package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HaapiConsumeBufferKamasRequestAction extends AbstractAction implements Action
   {
       
      
      public function HaapiConsumeBufferKamasRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HaapiConsumeBufferKamasRequestAction
      {
         return new HaapiConsumeBufferKamasRequestAction(arguments);
      }
   }
}

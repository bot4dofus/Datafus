package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HaapiBufferKamasListRequestAction extends AbstractAction implements Action
   {
       
      
      public function HaapiBufferKamasListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : HaapiBufferKamasListRequestAction
      {
         return new HaapiBufferKamasListRequestAction(arguments);
      }
   }
}

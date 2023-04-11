package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ZaapRespawnSaveRequestAction extends AbstractAction implements Action
   {
       
      
      public function ZaapRespawnSaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ZaapRespawnSaveRequestAction
      {
         return new ZaapRespawnSaveRequestAction(arguments);
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenHousesAction extends AbstractAction implements Action
   {
       
      
      public function OpenHousesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenHousesAction
      {
         return new OpenHousesAction(arguments);
      }
   }
}

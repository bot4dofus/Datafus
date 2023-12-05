package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SurrenderInfoRequestAction extends AbstractAction implements Action
   {
       
      
      public function SurrenderInfoRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : SurrenderInfoRequestAction
      {
         return new SurrenderInfoRequestAction(arguments);
      }
   }
}

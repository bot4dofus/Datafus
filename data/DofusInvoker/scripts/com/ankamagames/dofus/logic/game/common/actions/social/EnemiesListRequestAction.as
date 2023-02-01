package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class EnemiesListRequestAction extends AbstractAction implements Action
   {
       
      
      public function EnemiesListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : EnemiesListRequestAction
      {
         return new EnemiesListRequestAction(arguments);
      }
   }
}

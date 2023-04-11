package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenStatsAction extends AbstractAction implements Action
   {
       
      
      public function OpenStatsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenStatsAction
      {
         return new OpenStatsAction(arguments);
      }
   }
}

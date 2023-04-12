package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopListenAllianceFightAction extends AbstractAction implements Action
   {
       
      
      public function StopListenAllianceFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopListenAllianceFightAction
      {
         return new StopListenAllianceFightAction(arguments);
      }
   }
}

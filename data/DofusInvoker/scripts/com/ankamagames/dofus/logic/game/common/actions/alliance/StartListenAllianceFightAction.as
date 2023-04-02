package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartListenAllianceFightAction extends AbstractAction implements Action
   {
       
      
      public function StartListenAllianceFightAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StartListenAllianceFightAction
      {
         return new StartListenAllianceFightAction(arguments);
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaXpSwitchModeAction extends AbstractAction implements Action
   {
       
      
      public var xpActivated:Boolean;
      
      public function ArenaXpSwitchModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(xpActivated:Boolean) : ArenaXpSwitchModeAction
      {
         var a:ArenaXpSwitchModeAction = new ArenaXpSwitchModeAction(arguments);
         a.xpActivated = xpActivated;
         return a;
      }
   }
}

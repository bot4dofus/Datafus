package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderAvailableDungeonsAction extends AbstractAction implements Action
   {
       
      
      public function DungeonPartyFinderAvailableDungeonsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : DungeonPartyFinderAvailableDungeonsAction
      {
         return new DungeonPartyFinderAvailableDungeonsAction(arguments);
      }
   }
}

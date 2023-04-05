package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderListenAction extends AbstractAction implements Action
   {
       
      
      public var dungeonId:uint;
      
      public function DungeonPartyFinderListenAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(dungeonId:uint) : DungeonPartyFinderListenAction
      {
         var a:DungeonPartyFinderListenAction = new DungeonPartyFinderListenAction(arguments);
         a.dungeonId = dungeonId;
         return a;
      }
   }
}

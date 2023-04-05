package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class DungeonPartyFinderRegisterAction extends AbstractAction implements Action
   {
       
      
      public var dungeons:Array;
      
      public function DungeonPartyFinderRegisterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(dungeons:Array) : DungeonPartyFinderRegisterAction
      {
         var a:DungeonPartyFinderRegisterAction = new DungeonPartyFinderRegisterAction();
         a.dungeons = dungeons;
         return a;
      }
   }
}

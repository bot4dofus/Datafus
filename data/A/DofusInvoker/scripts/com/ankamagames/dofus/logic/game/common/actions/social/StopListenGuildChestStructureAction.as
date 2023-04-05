package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StopListenGuildChestStructureAction extends AbstractAction implements Action
   {
       
      
      public function StopListenGuildChestStructureAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StopListenGuildChestStructureAction
      {
         return new StopListenGuildChestStructureAction(arguments);
      }
   }
}

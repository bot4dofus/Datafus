package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StartListenGuildChestStructureAction extends AbstractAction implements Action
   {
       
      
      public function StartListenGuildChestStructureAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : StartListenGuildChestStructureAction
      {
         return new StartListenGuildChestStructureAction(arguments);
      }
   }
}

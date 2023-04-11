package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismTeleportRequestAction extends AbstractAction implements Action
   {
       
      
      public var moduleType:int;
      
      public function PrismTeleportRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(moduleType:int) : PrismTeleportRequestAction
      {
         var action:PrismTeleportRequestAction = new PrismTeleportRequestAction(arguments);
         action.moduleType = moduleType;
         return action;
      }
   }
}

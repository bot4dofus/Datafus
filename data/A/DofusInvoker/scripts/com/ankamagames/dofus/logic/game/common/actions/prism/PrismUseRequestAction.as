package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismUseRequestAction extends AbstractAction implements Action
   {
       
      
      public var moduleType:int;
      
      public function PrismUseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(moduleType:int) : PrismUseRequestAction
      {
         var action:PrismUseRequestAction = new PrismUseRequestAction(arguments);
         action.moduleType = moduleType;
         return action;
      }
   }
}

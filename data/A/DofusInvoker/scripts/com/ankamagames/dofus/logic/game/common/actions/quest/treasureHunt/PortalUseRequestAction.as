package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PortalUseRequestAction extends AbstractAction implements Action
   {
       
      
      public var portalId:int;
      
      public function PortalUseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(portalId:int) : PortalUseRequestAction
      {
         var action:PortalUseRequestAction = new PortalUseRequestAction(arguments);
         action.portalId = portalId;
         return action;
      }
   }
}

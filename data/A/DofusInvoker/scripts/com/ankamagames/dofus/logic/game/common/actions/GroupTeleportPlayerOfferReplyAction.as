package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GroupTeleportPlayerOfferReplyAction extends AbstractAction implements Action
   {
       
      
      public var requesterId:Number = NaN;
      
      public var isTeleport:Boolean = false;
      
      public function GroupTeleportPlayerOfferReplyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(requesterId:Number, isTeleport:Boolean) : GroupTeleportPlayerOfferReplyAction
      {
         var action:GroupTeleportPlayerOfferReplyAction = new GroupTeleportPlayerOfferReplyAction(arguments);
         action.requesterId = requesterId;
         action.isTeleport = isTeleport;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportPlayerOfferReplyAction extends AbstractAction implements Action
   {
       
      
      public var requesterId:Number = NaN;
      
      public var isTeleport:Boolean = false;
      
      public function TeleportPlayerOfferReplyAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(requesterId:Number, isTeleport:Boolean) : TeleportPlayerOfferReplyAction
      {
         var action:TeleportPlayerOfferReplyAction = new TeleportPlayerOfferReplyAction(arguments);
         action.requesterId = requesterId;
         action.isTeleport = isTeleport;
         return action;
      }
   }
}

package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachInvitationRequestAction extends AbstractAction implements Action
   {
       
      
      public var guests:Vector.<Number>;
      
      public function BreachInvitationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(guests:Vector.<Number>) : BreachInvitationRequestAction
      {
         var a:BreachInvitationRequestAction = new BreachInvitationRequestAction(arguments);
         a.guests = guests;
         return a;
      }
   }
}

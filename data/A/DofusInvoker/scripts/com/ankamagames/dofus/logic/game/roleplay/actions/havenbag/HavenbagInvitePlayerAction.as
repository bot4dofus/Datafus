package com.ankamagames.dofus.logic.game.roleplay.actions.havenbag
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HavenbagInvitePlayerAction extends AbstractAction implements Action
   {
       
      
      public var guestId:Number;
      
      public var invite:Boolean;
      
      public function HavenbagInvitePlayerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(guestId:Number, invite:Boolean) : HavenbagInvitePlayerAction
      {
         var a:HavenbagInvitePlayerAction = new HavenbagInvitePlayerAction(arguments);
         a.guestId = guestId;
         a.invite = invite;
         return a;
      }
   }
}

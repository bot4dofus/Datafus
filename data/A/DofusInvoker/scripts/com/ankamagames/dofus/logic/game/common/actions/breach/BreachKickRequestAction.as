package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachKickRequestAction extends AbstractAction implements Action
   {
       
      
      public var guestId:Number;
      
      public function BreachKickRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(guestId:Number) : BreachKickRequestAction
      {
         var a:BreachKickRequestAction = new BreachKickRequestAction(arguments);
         a.guestId = guestId;
         return a;
      }
   }
}

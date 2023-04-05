package com.ankamagames.dofus.logic.game.common.actions.breach
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BreachRoomUnlockAction extends AbstractAction implements Action
   {
       
      
      public var roomId:uint;
      
      public function BreachRoomUnlockAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(room:uint) : BreachRoomUnlockAction
      {
         var a:BreachRoomUnlockAction = new BreachRoomUnlockAction(arguments);
         a.roomId = room;
         return a;
      }
   }
}

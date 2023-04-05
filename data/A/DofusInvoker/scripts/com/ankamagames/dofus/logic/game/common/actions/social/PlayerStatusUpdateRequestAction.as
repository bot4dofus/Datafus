package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlayerStatusUpdateRequestAction extends AbstractAction implements Action
   {
       
      
      public var status:int;
      
      public var message:String;
      
      public function PlayerStatusUpdateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(statusNumber:uint, msg:String = "") : PlayerStatusUpdateRequestAction
      {
         var a:PlayerStatusUpdateRequestAction = new PlayerStatusUpdateRequestAction(arguments);
         a.status = statusNumber;
         a.message = msg;
         return a;
      }
   }
}

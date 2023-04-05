package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class LivingObjectMessageRequestAction extends AbstractAction implements Action
   {
       
      
      public var msgId:uint;
      
      public var livingObjectUID:uint;
      
      public function LivingObjectMessageRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(msgId:uint, livingObjectUID:uint) : LivingObjectMessageRequestAction
      {
         var a:LivingObjectMessageRequestAction = new LivingObjectMessageRequestAction(arguments);
         a.msgId = msgId;
         a.livingObjectUID = livingObjectUID;
         return a;
      }
   }
}

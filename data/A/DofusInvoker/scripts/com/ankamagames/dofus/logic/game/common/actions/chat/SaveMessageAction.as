package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SaveMessageAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public var channel:uint;
      
      public var timestamp:Number;
      
      public function SaveMessageAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(msg:String, channel:uint, timestamp:Number) : SaveMessageAction
      {
         var a:SaveMessageAction = new SaveMessageAction(arguments);
         a.content = msg;
         a.channel = channel;
         a.timestamp = timestamp;
         return a;
      }
   }
}

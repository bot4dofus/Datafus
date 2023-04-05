package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FightOutputAction extends AbstractAction implements Action
   {
       
      
      public var content:String;
      
      public var channel:uint;
      
      public function FightOutputAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(msg:String, channel:uint = 0) : FightOutputAction
      {
         var a:FightOutputAction = new FightOutputAction(arguments);
         a.content = msg;
         a.channel = channel;
         return a;
      }
   }
}

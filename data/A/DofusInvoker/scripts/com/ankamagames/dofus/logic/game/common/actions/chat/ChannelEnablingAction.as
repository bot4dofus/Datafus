package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChannelEnablingAction extends AbstractAction implements Action
   {
       
      
      public var channel:uint;
      
      public var enable:Boolean;
      
      public function ChannelEnablingAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(channel:uint, enable:Boolean = true) : ChannelEnablingAction
      {
         var a:ChannelEnablingAction = new ChannelEnablingAction(arguments);
         a.channel = channel;
         a.enable = enable;
         return a;
      }
   }
}

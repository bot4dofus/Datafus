package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatReportAction extends AbstractAction implements Action
   {
       
      
      public var reportedId:Number;
      
      public var reason:uint;
      
      public var channel:uint;
      
      public var timestamp:Number;
      
      public var fingerprint:String;
      
      public var message:String;
      
      public var name:String;
      
      public function ChatReportAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(reportedId:Number, reason:uint, name:String, channel:uint, fingerprint:String, message:String, timestamp:Number) : ChatReportAction
      {
         var a:ChatReportAction = new ChatReportAction(arguments);
         a.reportedId = reportedId;
         a.reason = reason;
         a.channel = channel;
         a.timestamp = timestamp;
         a.fingerprint = fingerprint;
         a.message = message;
         a.name = name;
         return a;
      }
   }
}

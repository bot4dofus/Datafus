package com.ankamagames.jerakine.messages
{
   public class MessageDispatcher implements IMessageDispatcher
   {
       
      
      public function MessageDispatcher()
      {
         super();
      }
      
      public function dispatchMessage(handler:MessageHandler, message:Message) : void
      {
         handler.process(message);
      }
   }
}

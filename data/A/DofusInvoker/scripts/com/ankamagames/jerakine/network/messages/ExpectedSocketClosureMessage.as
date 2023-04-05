package com.ankamagames.jerakine.network.messages
{
   import com.ankamagames.jerakine.messages.ILogableMessage;
   import com.ankamagames.jerakine.messages.Message;
   
   public class ExpectedSocketClosureMessage implements Message, ILogableMessage
   {
       
      
      public var reason:uint;
      
      public function ExpectedSocketClosureMessage(reason:uint = 0)
      {
         super();
         this.reason = reason;
      }
   }
}

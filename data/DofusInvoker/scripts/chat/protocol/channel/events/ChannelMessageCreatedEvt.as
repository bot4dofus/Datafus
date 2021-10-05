package chat.protocol.channel.events
{
   import chat.protocol.channel.data.ChannelMessage;
   import chat.protocol.common.JsonifiedMessage;
   
   public class ChannelMessageCreatedEvt extends JsonifiedMessage
   {
       
      
      public var message:ChannelMessage;
      
      public function ChannelMessageCreatedEvt(message:ChannelMessage)
      {
         super();
         this.message = message;
      }
   }
}

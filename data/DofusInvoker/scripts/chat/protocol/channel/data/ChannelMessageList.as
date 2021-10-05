package chat.protocol.channel.data
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class ChannelMessageList extends JsonifiedMessage
   {
       
      
      public var values:Vector.<ChannelMessage>;
      
      public function ChannelMessageList(values:Array)
      {
         super();
         this.values = Vector.<ChannelMessage>(values);
      }
   }
}

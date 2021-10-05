package chat.protocol.channel.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class CreateChannelMessageCmd extends JsonifiedMessage
   {
       
      
      public var channelId:String;
      
      public var authorUserId:String;
      
      public var content:String;
      
      public function CreateChannelMessageCmd(channelId:String, authorId:String, content:String)
      {
         super();
         this.channelId = channelId;
         this.authorUserId = authorId;
         this.content = content;
      }
   }
}

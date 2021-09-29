package chat.protocol.channel.data
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.User;
   
   public class ChannelMessage extends JsonifiedMessage
   {
       
      
      public var messageId:String;
      
      public var channelId:String;
      
      public var createdTimestamp:String;
      
      public var content:String;
      
      public var author:User;
      
      public function ChannelMessage(messageId:String, channelId:String, createdTimestamp:String, content:String, author:User)
      {
         super();
         this.messageId = messageId;
         this.channelId = channelId;
         this.createdTimestamp = createdTimestamp;
         this.content = content;
         this.author = author;
      }
      
      public function toString() : String
      {
         return "ChannelMessage{messageId=" + this.messageId + ",channelId=" + this.channelId + ",createdTimestamp=" + this.createdTimestamp + ",content=" + this.content + ",author=" + this.author.toString() + "}";
      }
   }
}

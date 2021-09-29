package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.FriendGroup;
   
   public class CreateUserFriendGroupCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var group:FriendGroup;
      
      public function CreateUserFriendGroupCmd(userId:String, group:FriendGroup)
      {
         super();
         this.userId = userId;
         this.group = group;
      }
   }
}

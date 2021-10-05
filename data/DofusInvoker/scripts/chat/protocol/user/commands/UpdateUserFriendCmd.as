package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.Friend;
   
   public class UpdateUserFriendCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var friend:Friend;
      
      public function UpdateUserFriendCmd(userId:String, friend:Friend)
      {
         super();
         this.userId = userId;
         this.friend = friend;
      }
   }
}

package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class DeleteUserFriendCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var friendUserId:String;
      
      public function DeleteUserFriendCmd(userId:String, friendUserId:String)
      {
         super();
         this.userId = userId;
         this.friendUserId = friendUserId;
      }
   }
}

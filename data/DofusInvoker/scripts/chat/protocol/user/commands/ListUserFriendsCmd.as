package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class ListUserFriendsCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public function ListUserFriendsCmd(userId:String)
      {
         super();
         this.userId = userId;
      }
   }
}

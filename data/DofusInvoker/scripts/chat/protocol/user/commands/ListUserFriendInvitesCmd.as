package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class ListUserFriendInvitesCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public function ListUserFriendInvitesCmd(userId:String)
      {
         super();
         this.userId = userId;
      }
   }
}

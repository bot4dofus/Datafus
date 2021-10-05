package chat.protocol.user.commands
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class ListUserFriendGroupsCmd extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public function ListUserFriendGroupsCmd(userId:String)
      {
         super();
         this.userId = userId;
      }
   }
}

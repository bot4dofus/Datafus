package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.FriendGroup;
   
   public class UserFriendGroupCreatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var group:FriendGroup;
      
      public function UserFriendGroupCreatedEvt(userId:String, group:FriendGroup)
      {
         super();
         this.userId = userId;
         this.group = group;
      }
   }
}

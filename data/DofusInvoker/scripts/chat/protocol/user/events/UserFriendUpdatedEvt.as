package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.Friend;
   
   public class UserFriendUpdatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var friend:Friend;
      
      public function UserFriendUpdatedEvt(userId:String, friend:Friend)
      {
         super();
         this.userId = userId;
         this.friend = friend;
      }
   }
}

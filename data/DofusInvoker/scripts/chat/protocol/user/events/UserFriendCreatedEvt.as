package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   import chat.protocol.user.data.Friend;
   
   public class UserFriendCreatedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var friend:Friend;
      
      public function UserFriendCreatedEvt(userId:String, friend:Friend)
      {
         super();
         this.userId = userId;
         this.friend = friend;
      }
   }
}

package chat.protocol.user.events
{
   import chat.protocol.common.JsonifiedMessage;
   
   public class UserFriendDeletedEvt extends JsonifiedMessage
   {
       
      
      public var userId:String;
      
      public var friendUserId:String;
      
      public function UserFriendDeletedEvt(userId:String, friendUserId:String)
      {
         super();
         this.userId = userId;
         this.friendUserId = friendUserId;
      }
   }
}
